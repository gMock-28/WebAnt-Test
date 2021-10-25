//
//  CoverImageView.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 25.10.2021.
//

import Foundation
import UIKit
import Kingfisher

class CoverImageView: UIImageView {
 
    private var task: DownloadTask?
    
    private func image(url: URL?, completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
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
}
