//
//  Alerts.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/9/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import Foundation

//Alert object to hold nested arrays for alerts
struct Alerts: Decodable {
    var total: String?
    //Data array nests objects created above
    var data: [AlertData]?
}

//AlertData object for data relevant to each alert
struct AlertData: Codable {
    var title: String?
    var description: String?
    
    //Initializer because not all JSON returned values are used
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
                                                    CodingKeys.self)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
    }
}
