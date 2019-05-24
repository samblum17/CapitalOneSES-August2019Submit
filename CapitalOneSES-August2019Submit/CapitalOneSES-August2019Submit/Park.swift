//
//  Park.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 5/21/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import Foundation

struct Images: Codable {
    var caption: String?
    var urlString: String?
    
    enum CodingKeys: String, CodingKey {
        case caption
        case urlString = "url"
    }
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
            CodingKeys.self)
        self.caption = try valueContainer.decode(String.self, forKey: CodingKeys.caption)
        self.urlString = try valueContainer.decode(String.self, forKey: CodingKeys.urlString)
    }
}

struct ParkData: Codable {
    var fullName: String?
    var description: String?
    var name: String?
    var states: String?
    var images: [Images]?
    var parkCode: String?

    enum CodingKeys: String, CodingKey {
        case fullName
        case description
        case name
        case states
        case images
        case parkCode
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
            CodingKeys.self)
        self.fullName = try valueContainer.decode(String.self, forKey:CodingKeys.fullName)
        self.states = try valueContainer.decode(String.self, forKey: CodingKeys.states)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.images = try valueContainer.decode([Images].self, forKey: CodingKeys.images)
        self.parkCode = try valueContainer.decode(String.self, forKey: CodingKeys.parkCode)


    }
}

    struct Parks: Decodable {
        var total: String?
        var data: [ParkData]?
}


