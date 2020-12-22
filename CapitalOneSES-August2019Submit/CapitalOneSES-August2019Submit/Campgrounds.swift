//
//  Campgrounds.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/9/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import Foundation

//Campgrounds
struct Campgrounds: Codable {
    var total: String?
    var data: [CampgroundData]?
}

//Campground specific data
struct CampgroundData: Codable {
    var weather: String?
    var name: String?
    var description: String?
    var directions: String?
    var campsites: CampsiteData?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case weather = "weatherOverview"
        case name
        case description
        case directions = "directionsOverview"
        case campsites
    }
    
    //Initializer used because not all JSON returned values are used
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
                                                    CodingKeys.self)
        self.weather = try valueContainer.decode(String.self, forKey: CodingKeys.weather)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.directions = try valueContainer.decode(String.self, forKey: CodingKeys.directions)
        self.campsites = try valueContainer.decode(CampsiteData.self, forKey: CodingKeys.campsites)
        
    }
    
}

//Number of each campsites available is nested
struct CampsiteData: Codable {
    var total: String?
    var tent: String?
    var rv: String?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case total = "totalSites"
        case tent = "tentOnly"
        case rv = "rvOnly"
    }
    //Initializer used because not all JSON returned values are used
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
                                                    CodingKeys.self)
        self.total = try valueContainer.decode(String.self, forKey: CodingKeys.total)
        self.tent = try valueContainer.decode(String.self, forKey: CodingKeys.tent)
        self.rv = try valueContainer.decode(String.self, forKey: CodingKeys.rv)
    }
}
