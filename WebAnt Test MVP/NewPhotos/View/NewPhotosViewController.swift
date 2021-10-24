//
//  NewPhotosViewController.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 24.10.2021.
//

import UIKit

class NewPhotosViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: (self.view.frame.width - 60)/2, height: (self.view.frame.height - 100)/6)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.register(CustomCell.self, forCellWithReuseIdentifier: "MyCell")
        collection.backgroundColor = .darkGray
        
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    private let presenter = NewPhotosPresenter()
    private var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Collection
        view.addSubview(collectionView)
        
        // Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getNewPhotos()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension NewPhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCell
        presenter.fetchImage(name: photos[indexPath.item].image.name,
                                                    completion: { (image) in
            cell.activityIndicator.stopAnimating()
            cell.imageView.image = image!
        })
        
        return cell
    }
    
}

extension NewPhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User Tapped!")
    }
    
}

// MARK: - NewPhotosPresenterDelegate

extension NewPhotosViewController: NewPhotosPresenterDelegate {
    func presentPhotos(photos: [Photo]?, error: Errors?) {
        switch error {
        case nil:
            self.photos = photos!
            self.collectionView.reloadData()
            
            print(photos!.count)
            print("Everything is well!")
        case .lastPage:
            print("This is the las page!")
        case .noInternetConnection:
            print("There NoInternetConnectionPicture should be shown...")
        default:
            break
        }
    }
    
    func presentDetails() {
        print("Detail of the pic should shown!")
    }
    
    
}
