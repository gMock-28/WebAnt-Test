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
    func presentPhotos(photos: [CellModel], refresh: Bool)
    func performErrors(error: Errors)
}

typealias NewPresenterDelegate = NewPhotosPresenterDelegate & UIViewController

class NewPhotosPresenter {
    
    private var totalPages = 1
    private var page = 0
    
    weak var delegate: NewPresenterDelegate?
    
    public func setViewDelegate(delegate: NewPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getNewPhotos(refresh: Bool) {
        
        print("GetNewPhotos")
        
        if refresh {
            self.page = 1
        } else {
            self.page += 1
        }
        
        if page <= totalPages {
            
            let url = "http://gallery.dev.webant.ru/api/photos?page=\(page)"
            
            getNewPage(url: url) { [weak self] (response) in
                
                self?.totalPages = response!.countOfPages
                let items: [CellModel] = response!.data
                    .filter({ $0.new == true })
                    .map {
                        CellModel(name: $0.name ?? "",
                                  description: $0.description ?? "",
                                  url: URL(string: "http://gallery.dev.webant.ru/media/\($0.image.name)"))
                    }
                
                self?.delegate?.presentPhotos(photos: items, refresh: refresh)
            }
            
        } else {
            self.delegate?.performErrors(error: Errors.lastPage)
        }
    }
    
    // MARK: - Network
    
    private func getNewPage(url: String, completion: @escaping (GetPhotosResponse?) -> ()){
//        guard let url = URL(string: url) else { return }
        print("GetNewPage")
        AF.request(url).validate().responseJSON { (response) in
            print("Request was made")
            switch response.result {
            case .success(let json):
                print("success")
                do {
                    let response = try GetPhotosResponse(json: json)
                    completion(response)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print("Failure")
                self.delegate?.performErrors(error: Errors.noInternetConnection)
                
//                if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet {
//                    print(error)
//                    self.delegate?.performErrors(error: Errors.noInternetConnection)
//                }
            }
        }
    }
}
