//
//  GetPhotosResponse.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 24.10.2021.
//

import Foundation

import Foundation

struct GetPhotosResponse {
    let totalItems: Int
    let itemsPerPage: Int
    let countOfPages: Int
    var data: [Photo]
    
    init?(json: Any) throws {
        guard let json = json as? [String: Any] else { throw Errors.unableToParseData }
        
        let totalItems = json["totalItems"] as! Int
        let itemsPerPage = json["itemsPerPage"] as! Int
        let countOfPages = json["countOfPages"] as! Int
        let data = Photo.getArray(from: json["data"] as Any)!
        
        self.totalItems = totalItems
        self.itemsPerPage = itemsPerPage
        self.countOfPages = countOfPages
        self.data = data
    }
}
