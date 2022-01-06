//
//  ThingsToDo.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 1/6/22.
//  Copyright © 2022 Sam Blum. All rights reserved.
//

import Foundation

struct Things: Decodable {
    var total: String?
    var data: [ThingsData]?
}

struct ThingsData: Codable, Hashable {
    static func == (lhs: ThingsData, rhs: ThingsData) -> Bool {
        return rhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id = UUID()
    var title: String?
    var longDescription: String?
    var shortDescription: String?
    var images: [Images]?
    var location: String?
    var isReservationRequired: String?
    var doFeesApply: String?
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case longDescription
        case shortDescription
        case images
        case location
        case isReservationRequired
        case doFeesApply
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
                                                    CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey:CodingKeys.title)
        self.longDescription = try valueContainer.decode(String.self, forKey: CodingKeys.longDescription)
        self.shortDescription = try valueContainer.decode(String.self, forKey: CodingKeys.shortDescription)
        self.images = try valueContainer.decode([Images].self, forKey: CodingKeys.images)
        self.location = try valueContainer.decode(String.self, forKey: CodingKeys.location)
        self.isReservationRequired = try valueContainer.decode(String.self, forKey: CodingKeys.isReservationRequired)
        self.doFeesApply = try valueContainer.decode(String.self, forKey: CodingKeys.doFeesApply)
    }
}

