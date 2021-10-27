//
//  NewPhotosViewController.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 24.10.2021.
//

import UIKit

class NewPhotosViewController: UIViewController {
    
    private let presenter = NewPhotosPresenter()
    private var photos = [CellModel]()
    
    // MARK: - Subviews
    
    let noInternetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        
        imageView.image = UIImage(named: "NoInternetPic")
        
        return imageView
    }()
    
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
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
        collection.backgroundColor = .darkGray
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray

        // Collection
        view.addSubview(collectionView)
        
        // No Internet Image
        view.addSubview(noInternetImage)
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
            noInternetImage.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                   constant: 24),
            noInternetImage.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                    constant: -24),
            noInternetImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noInternetImage.heightAnchor.constraint(equalTo: noInternetImage.widthAnchor)
        ])
    }
    
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension NewPhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCell
        cell.configure(model: photos[indexPath.row])
        
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
        if indexPath.row == photos.count - 1 {
            self.spinner.startAnimating()
            presenter.getNewPhotos(refresh: false)
        }
    }
    
}

extension NewPhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User Tapped!")
        let imageDetails = ImageDetailsViewController(model: photos[indexPath.row])
        self.present(imageDetails, animated: true, completion: nil)
    }
    
}

// MARK: - NewPhotosPresenterDelegate

extension NewPhotosViewController: NewPhotosPresenterDelegate {
    func presentPhotos(photos: [CellModel], refresh: Bool) {
        if refresh {
            self.photos = photos
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            
            noInternetImage.isHidden = true
        } else {
            let indexPath = IndexPath(row: self.photos.count, section: 0)
            self.photos.append(contentsOf: photos)
            spinner.stopAnimating()
            self.collectionView.insertItems(at: [indexPath])
        }
    }
    
    func performErrors(error: Errors) {
        switch error {
        case .noInternetConnection:
            photos.removeAll()
            spinner.stopAnimating()
            collectionView.reloadData()
            
            noInternetImage.isHidden = false
            self.refreshControl.endRefreshing()

            print("No internet connection!")
        case .unableToParseData:
            print("Unable to parse data!")
        case .lastPage:
            print("Last page!!!")
            spinner.stopAnimating()
        }
    }
}

