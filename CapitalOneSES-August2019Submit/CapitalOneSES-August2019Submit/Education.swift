//
//  Education.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/11/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import Foundation

//3 Education structs for segmented control table view

//Questions
struct Questions: Codable {
    var total: String?
    var data: [QuestionData]?
}

//Nested question data
struct QuestionData: Codable {
    var title: String?
    var question: String?
    var gradeLevel: String?
    var url: String?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case title
        case question = "questionobjective"
        case gradeLevel = "gradelevel"
        case url
    }
    
    //Initializer used because not all JSON returned values are used
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
            CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.question = try valueContainer.decode(String.self, forKey: CodingKeys.question)
        self.gradeLevel = try valueContainer.decode(String.self, forKey: CodingKeys.gradeLevel)
        self.url = try valueContainer.decode(String.self, forKey: CodingKeys.url)
        
    }
    
}

struct People: Codable {
    var total: String?
    var data: [PeopleData]?
}

struct PeopleData: Codable {
    var title: String?
    var description: String?
    var url: String?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case title
        case description = "listingdescription"
        case url
    }
    
    //Initializer used because not all JSON returned values are used
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
            CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(String.self, forKey: CodingKeys.url)
        
}
}


struct Places: Codable {
    var total: String?
    var data: [PlacesData]?
}

struct PlacesData: Codable {
    var title: String?
    var description: String?
    var url: String?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case title
        case description = "listingdescription"
        case url
    }
    
    //Initializer used because not all JSON returned values are used
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
            CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(String.self, forKey: CodingKeys.url)
        
    }
}
