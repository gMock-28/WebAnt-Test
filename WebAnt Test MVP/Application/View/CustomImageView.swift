//
//  CustomImageView.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 25.10.2021.
//

import Foundation
import UIKit
import Kingfisher

class CustomImageView: UIImageView {
    
    private var task: DownloadTask?
    
    func loadImage(url: URL?, completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        task?.cancel()
        task = KF.url(url)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .onSuccess { (result) in
                completion?(.success(result))
            }
            .onFailure({ (error) in
                completion?(.failure(error))
            })
            .set(to: self)
    }
    
    
    override var intrinsicContentSize: CGSize {
        
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        
        return CGSize(width: -1.0, height: -1.0)
    }
}
