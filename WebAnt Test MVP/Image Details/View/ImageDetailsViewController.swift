//
//  ImageDetailsViewController.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 26.10.2021.
//

import UIKit
//import MapKit
import SwiftUI

class ImageDetailsViewController: UIViewController {
    
    let model: CellModel
    
    private let detailsImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black.withAlphaComponent(CGFloat(0.5))

        return imageView
        
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .purple
        label.textAlignment = .left
        
        label.font = UIFont(name: "SFCompactDisplay-Semibold", size: 20)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        
        label.font = UIFont(name: "SFCompactDisplay-Regular", size: 12)
         
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        
        view.backgroundColor = .white
        
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController!.navigationBar.tintColor = UIColor(red: 47/255.0, green: 23/255.0, blue: 103/255.0, alpha: 1/1.0)

        view.addSubview(detailsImageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        
        configureConstraints()
        
        // Filling image and labels with content
        detailsImageView.loadImage(url: model.url) { (result) in }
        nameLabel.text = model.name
        descriptionLabel.text = model.description
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            // Image
            detailsImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailsImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsImageView.heightAnchor.constraint(equalTo: detailsImageView.widthAnchor,
                                                     multiplier: 3/4),
            
            // Name Label
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor,
                                            constant: 20),
            nameLabel.topAnchor.constraint(equalTo: detailsImageView.bottomAnchor,
                                           constant: 20),
            
            // Description Label
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                   constant: 20),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                    constant: -57),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                                  constant: 20)
        ])
    }
    
    init(model: CellModel) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
