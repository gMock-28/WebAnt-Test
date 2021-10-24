//
//  NewPhotosPresenter.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 24.10.2021.
//

import Foundation
import UIKit
import Alamofire

protocol NewPhotosPresenterDelegate: AnyObject {
    func presentPhotos(photos: [Photo]?, error: Errors?)
    func presentDetails()
}

typealias NewPresenterDelegate = NewPhotosPresenterDelegate & UIViewController

class NewPhotosPresenter {
    
    private var page = 0
    
    weak var delegate: NewPresenterDelegate?
    
    public func setViewDelegate(delegate: NewPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getNewPhotos() {
        self.page += 1
        if page <= 23 {
            let url = "http://gallery.dev.webant.ru/api/photos?page=\(page)"
            
            getNewPage(url: url) { (response) in
                if response != nil {
                    var photos = response?.data
                    photos?.removeAll(where: { $0.new == false })
                    self.delegate?.presentPhotos(photos: photos!, error: nil)
                } else {
                    self.delegate?.presentPhotos(photos: nil, error: Errors.noInternetConnection)
                }
            }
        } else {
            self.delegate?.presentPhotos(photos: nil, error: Errors.lastPage)
        }
        
        
    }
    
    // MARK: - Network
    
    private func getNewPage(url: String, completion: @escaping (GetPhotosResponse?) -> ()){
        guard let url = URL(string: url) else { return }
        
        AF.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let json):
                do {
                    let response = try GetPhotosResponse(json: json)
                    completion(response)
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    public func fetchImage(name: String, completion: @escaping (UIImage?)->()) {
        guard let url = URL(string: "http://gallery.dev.webant.ru/media/\(name)") else { return }
        
        AF.request(url).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(image)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
