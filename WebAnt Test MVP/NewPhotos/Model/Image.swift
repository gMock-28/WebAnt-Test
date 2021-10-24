//
//  Image.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 24.10.2021.
//

import Foundation

import Foundation

struct Image {
    let id: Int
    let name: String
    
    init?(json: Any) {
        guard let json = json as? [String: Any] else { return nil }
        
        let id = json["id"] as! Int
        let name = json["name"] as! String
        
        self.id = id
        self.name = name
    }
}
