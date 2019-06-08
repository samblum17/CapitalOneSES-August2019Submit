//
//  VisitorCenter.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/7/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import Foundation


//VCData object for VC information returned in each VisitorCenter object
struct VCData: Codable {
    var description: String?
    var name: String?
    var directions: String?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case description
        case name
        case directions = "directionsInfo"
    }
    //Initializer used because not all JSON returned values are used
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
            CodingKeys.self)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.directions = try valueContainer.decode(String.self, forKey: CodingKeys.directions)
        
    }
}

//VisitorCenter object for parent array returned in JSON that holds other objects creted above
struct VisitorCenter: Decodable {
    var total: String?
    //Data array nests objects created above
    var data: [VCData]?
}


