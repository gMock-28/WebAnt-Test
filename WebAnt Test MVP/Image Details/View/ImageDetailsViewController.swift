//
//  ImageDetailsViewController.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 26.10.2021.
//

import UIKit
import MapKit
import SwiftUI

class ImageDetailsViewController: UIViewController {
    
    private let detailsImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
//        imageView.backgroundColor = .darkGray.withAlphaComponent(CGFloat(0.5))
//        imageView.clipsToBounds = true
        
        imageView.layer.cornerRadius = 7
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black.withAlphaComponent(CGFloat(0.9))

        view.addSubview(detailsImageView)
        
        detailsImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width/20).isActive = true
        detailsImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.frame.width/20).isActive = true
        
        detailsImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(view.frame.height/10)).isActive = true
        detailsImageView.heightAnchor.constraint(lessThanOrEqualToConstant: CGFloat(view.frame.height/3)).isActive = true
        
    }
    
    init(_ model: CellModel) {
        super.init(nibName: nil, bundle: nil)
        
        detailsImageView.loadImage(url: model.url) { (result) in }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
