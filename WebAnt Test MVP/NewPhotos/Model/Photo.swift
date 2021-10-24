//
//  Photo.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 24.10.2021.
//

import Foundation

struct Photo {
    let id: Int
    let name: String
    let dateCreate: String
    let description: String
    let new: Bool
    let popular: Bool
    let image: Image
    let user: Any
    
    init?(json: [String: Any]) {
        let id = json["id"] as! Int
        let name = json["name"] as! String
        let dateCreate = json["dateCreate"] as! String
        let description = json ["description"] as! String
        let new = json["new"] as! Bool
        let popular = json["popular"] as! Bool
        let image = Image(json: json["image"] as Any)!
        let user = json["user"]!
        
        self.id = id
        self.name = name
        self.dateCreate = dateCreate
        self.description = description
        self.new = new
        self.popular = popular
        self.image = image
        self.user = user
    }
    
    static func getArray(from jsonArray: Any) -> [Photo]?  {
        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
        
        return jsonArray.compactMap { Photo(json: $0) }
    }
}
