//
//  News.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/11/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import Foundation

//Related News
struct NewsReleases: Codable {
    var total: String?
    var data: [NewsReleaseData]?
}

//Nested news release data
struct NewsReleaseData: Codable {
    var title: String?
    var description: String?
    var url: String?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case title
        case description = "abstract"
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

//Articles
struct Articles: Codable {
    var total: String?
    var data: [ArticleData]?
}

struct ArticleData: Codable {
    var title: String?
    var description: String?
    var url: String?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case title
        case description = "listingDescription"
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
