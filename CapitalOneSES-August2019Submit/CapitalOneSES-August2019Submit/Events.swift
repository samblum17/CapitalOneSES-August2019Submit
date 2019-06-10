//
//  Events.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/10/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import Foundation

//Events
struct Events: Codable {
    var total: String?
    var data: [EventData]?
}

//Event data
struct EventData: Codable {
    var title: String?
    var description: String?
    var isFree: String?
    var dateStart: String?
    var dateEnd: String?
    var times: [TimeInfo]?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case isFree = "isfree"
        case dateStart = "datestart"
        case dateEnd = "dateend"
        case times
    }
    
    //Initializer used because not all JSON returned values are used
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
            CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.isFree = try valueContainer.decode(String.self, forKey: CodingKeys.isFree)
        self.dateStart = try valueContainer.decode(String.self, forKey: CodingKeys.dateStart)
        self.dateEnd = try valueContainer.decode(String.self, forKey: CodingKeys.dateEnd)
        self.times = try valueContainer.decode([TimeInfo].self, forKey: CodingKeys.times)
        
    }
}

//Nested times
struct TimeInfo: Codable {
    var timeStart: String?
    var timeEnd: String?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case timeStart = "timestart"
        case timeEnd = "timeend"
    }
    
    //Initializer used because not all JSON returned values are used
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
            CodingKeys.self)
        self.timeStart = try valueContainer.decode(String.self, forKey: CodingKeys.timeStart)
        self.timeEnd = try valueContainer.decode(String.self, forKey: CodingKeys.timeEnd)
        
    }
    
}
