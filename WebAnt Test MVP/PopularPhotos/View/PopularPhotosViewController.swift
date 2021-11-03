//
//  PopularPhotosViewController.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 28.10.2021.
//

import Foundation
import UIKit

class PopularPhotosViewController: UIViewController {
    
    private let presenter = PopularPhotosPresenter()
    private var popularPhotos = [CellModel]()
    
    // MARK: - Subviews
    
    let noInternetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        
        imageView.image = UIImage(named: "NoInternetPic")
        
        return imageView
    }()
    
    let noInternetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        
        label.font = UIFont(name: "Kailasa", size: CGFloat(12.0))
        label.text = "Slow or no internet connection.\nPlease check your internet settings."
        
        return label
    }()
    
    var spinner: UIActivityIndicatorView
    
    private let refreshControl = UIRefreshControl()
    
    @objc private func refreshPhotosList(_ sender: Any) {
        presenter.getNewPhotos(refresh: true)
    }

    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: (self.view.frame.width - 60)/2, height: (self.view.frame.height - 100)/6)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.backgroundColor = .white
        
        collection.dataSource = self
        collection.delegate = self
        
        // Register the CustomCell
        collection.register(CustomCell.self, forCellWithReuseIdentifier: "MyCell")
        
        // Register the FooterView
        collection.register(FooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "MyFooterView")
        
        (collection.collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = CGSize(width: collection.bounds.width, height: 50)
        
        collection.refreshControl = refreshControl
        
        return collection
    }()
    
    //MARK: - viewDidLoad
    
    init() {
        if #available(iOS 13.0, *) {
            spinner = UIActivityIndicatorView(style: .large)
        } else {
            spinner = UIActivityIndicatorView()
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        // Collection
        view.addSubview(collectionView)
        
        // No Internet Image
        view.addSubview(noInternetImage)
        view.addSubview(noInternetLabel)
        noInternetConstraints()
        
        // Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshPhotosList(_:)), for: .valueChanged)
        
        // Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getNewPhotos(refresh: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func noInternetConstraints() {
        NSLayoutConstraint.activate([
            // Image
            noInternetImage.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                   constant: 115),
            noInternetImage.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                    constant: -115),
            noInternetImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noInternetImage.heightAnchor.constraint(equalTo: noInternetImage.widthAnchor),
            
            // Label
            noInternetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noInternetLabel.topAnchor.constraint(equalTo: noInternetImage.bottomAnchor,
                                                 constant: 16)
        ])
    }
    
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension PopularPhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.popularPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCell
        cell.configure(model: popularPhotos[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyFooterView", for: indexPath)
            footer.addSubview(spinner)
            spinner.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == popularPhotos.count - 1 {
            self.spinner.startAnimating()
            presenter.getNewPhotos(refresh: false)
        }
    }
    
}

extension PopularPhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageDetails = ImageDetailsViewController(model: popularPhotos[indexPath.row])
        self.navigationController?.pushViewController(imageDetails, animated: true)
    }
    
}

// MARK: - NewPhotosPresenterDelegate

extension PopularPhotosViewController: PopularPhotosPresenterDelegate {
    func presentPhotos(photos: [CellModel], refresh: Bool) {
        if refresh {
            self.popularPhotos = photos
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            
            noInternetImage.isHidden = true
            noInternetLabel.isHidden = true
        } else {
            self.popularPhotos.append(contentsOf: photos)

            spinner.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    func performErrors(error: Errors) {
        switch error {
        case .noInternetConnection:
            popularPhotos.removeAll()
            spinner.stopAnimating()
            collectionView.reloadData()
            
            noInternetImage.isHidden = false
            noInternetLabel.isHidden = false
            self.refreshControl.endRefreshing()

        case .unableToParseData:
            print("Unable to parse data!")
        case .lastPage:
            spinner.stopAnimating()
        }
    }
}
