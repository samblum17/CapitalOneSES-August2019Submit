//
//  Park.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 5/21/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import Foundation

//Different structs created below to handle nested JSON return

//Images object for the array of images returned in each Park
struct Images: Codable {
    var caption: String?
    var urlString: String?
    
    //Enum used because url key has different name in JSON return
    enum CodingKeys: String, CodingKey {
        case caption
        case urlString = "url"
    }
    //Initializer used because not all JSON returned values are used
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
                                                    CodingKeys.self)
        self.caption = try valueContainer.decode(String.self, forKey: CodingKeys.caption)
        self.urlString = try valueContainer.decode(String.self, forKey: CodingKeys.urlString)
    }
}

//ParkData object for park information returned in each Park object
struct ParkData: Codable, Equatable {
    static func == (lhs: ParkData, rhs: ParkData) -> Bool {
        if lhs.fullName == rhs.fullName {
            return true
        } else {
            return false
        }
    }
    
    var fullName: String?
    var description: String?
    var name: String?
    var states: String?
    var images: [Images]?
    var parkCode: String?
    var latLong: String?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case fullName
        case description
        case name
        case states
        case images
        case parkCode
        case latLong
    }
    //Initializer used because not all JSON returned values are used
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
                                                    CodingKeys.self)
        self.fullName = try valueContainer.decode(String.self, forKey:CodingKeys.fullName)
        self.states = try valueContainer.decode(String.self, forKey: CodingKeys.states)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.images = try valueContainer.decode([Images].self, forKey: CodingKeys.images)
        self.parkCode = try valueContainer.decode(String.self, forKey: CodingKeys.parkCode)
        self.latLong = try valueContainer.decode(String.self, forKey: CodingKeys.latLong)
        
    }
}

//Park object for parent array returned in JSON that holds other objects creted above
struct Parks: Decodable {
    var total: String?
    //Data array nests objects created above
    var data: [ParkData]?
}


