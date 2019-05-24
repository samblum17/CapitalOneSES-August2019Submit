//
//  Park.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 5/21/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import Foundation

struct Park: Codable {
    var fullName: String
    var stateCode: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case fullName
        case stateCode
        case imageURL = "url"
    }
    
  
    init?(json: [String: Any]) {
        
        guard let fullName = json["fullName"] as? String,
            let stateCode = json["stateCode"] as? String,
            let imageURLString = json["url"] as? String,
            let imageURL = URL(string: imageURLString) else { return nil }
        
        self.fullName = fullName
        self.stateCode = stateCode
        self.imageURL = imageURL
        
    }
}
