//
//  CustomCell.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 24.10.2021.
//

import Foundation
import UIKit
import SwiftUI



class CustomCell: UICollectionViewCell {
    
    private let customImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        // Background
        contentView.backgroundColor = .secondaryLabel
        contentView.layer.cornerRadius = customImageView.layer.cornerRadius

        // Image View
        contentView.addSubview(customImageView)
        
        customImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        customImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        customImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.customImageView.image = nil
    }
    
    func configure(model: CellModel) {
        
        // Activity Indicator
        contentView.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
        
        // Loading image
        customImageView.loadImage(url: model.url) { [weak self] (result) in
            self?.activityIndicator.stopAnimating()
        }
    
    }
}
