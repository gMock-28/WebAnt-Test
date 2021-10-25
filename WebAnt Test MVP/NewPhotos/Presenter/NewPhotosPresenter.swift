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
    func presentPhotos(photos: [CustomCell.Model])
    func performErrors(error: Errors)
    func presentDetails()
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
        
        if refresh {
            self.page = 1
        } else {
            self.page += 1
        }
        
        if page <= totalPages {
            
            print("PAGE NUMBER: \(page)")
            
            let url = "http://gallery.dev.webant.ru/api/photos?page=\(page)"
            
            getNewPage(url: url) { [weak self] (response) in
                if let response = response {
                    
                    self?.totalPages = response.countOfPages

                    let items: [CustomCell.Model] = response.data
                        .filter({ $0.new == true })
                        .map {
                            CustomCell.Model(url: URL(string: "http://gallery.dev.webant.ru/media/\($0.image.name)"))
                        }
                    
                    self?.delegate?.presentPhotos(photos: items)
                } else {
                    self?.delegate?.performErrors(error: Errors.noInternetConnection)
                }
            }
            
        } else {
            self.delegate?.performErrors(error: Errors.lastPage)
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
            }
        }
    }
}
