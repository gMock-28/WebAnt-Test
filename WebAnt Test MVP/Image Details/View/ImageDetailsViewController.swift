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
        
        label.font = UIFont(name: "Kailasa", size: CGFloat(40.0))
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        
        label.font = UIFont(name: "Kailasa", size: CGFloat(20.0))
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        
        view.backgroundColor = .darkGray
        navigationItem.largeTitleDisplayMode = .never

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
                                            constant: 24),
            nameLabel.topAnchor.constraint(equalTo: detailsImageView.bottomAnchor,
                                           constant: 24),
            
            // Description Label
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                   constant: 28),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                    constant: -28),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                                  constant: 8)
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
