//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

/*
This playground used to test pulling data from NPS API before implementing each model object into final project. Remember to use enum CodingKeys when variable doesnt match JSON key and use initializer when model object does not use all returned keys. Adjust baseURL when testing each model. Models are copied and pasted once successfully pulling and displaying data.
 */


PlaygroundPage.current.needsIndefiniteExecution = true

//Related News
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

//Releases
struct NewsReleases: Codable {
    var total: String?
    var data: [NewsReleaseData]?
}

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



//Education
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
struct Questions: Codable {
    var total: String?
    var data: [QuestionData]?
}

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

//Events
struct Events: Codable {
    var total: String?
    var data: [EventData]?
}

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


//Campgrounds
struct Campgrounds: Codable {
    var total: String?
    var data: [CampgroundData]?
    
}

struct CampgroundData: Codable {
    var weather: String?
    var name: String?
    var description: String?
    var directions: String?
    var campsites: CampsiteData?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case weather = "weatheroverview"
        case name
        case description
        case directions = "directionsoverview"
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
struct CampsiteData: Codable {
    var total: String?
    var tent: String?
    var rv: String?
    
    //Enum used because not all JSON returned values are used
    enum CodingKeys: String, CodingKey {
        case total = "totalsites"
        case tent = "tentonly"
        case rv = "rvonly"
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
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
            CodingKeys.self)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
}
}

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
    var states: String?
    var description: String?
    var name: String?
    var images: [Images]?
    var parkCode: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName
        case states
        case description
        case name
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







extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
let query: [String: String] = [
    "parkCode" : "yell",
    "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
]
let baseURL = URL(string: "https://developer.nps.gov/api/v1/articles?")!

let url = baseURL.withQueries(query)!
let task = URLSession.shared.dataTask(with: url) { (data,
    response, error) in
    let jsonDecoder = JSONDecoder()
    if let data = data,
        let articleDecoded = try? jsonDecoder.decode(Articles.self, from: data){
        print(articleDecoded.data)
    } else {
        print("error")
    }
    
   
}
task.resume()

    //Old Swift decoding- not used in Swift 4
//    let task = URLSession.shared.dataTask(with: url) { (data, response, error)  in

//    if let data = data,
//
//        let rawJSON = try? JSONSerialization.jsonObject(with: data),
//        let json = rawJSON as? [String: Any],
//
//        let resultsArray = json["data"] as? [[String: Any]]{
//
//        print(resultsArray)
//
//
//    } else {
//        print("Either no data was returned, or data was not serialized.")
//
//    }


//task.resume()


//Swift 2 and 3 only
//    init?(json: [String: Any]) {
//
//        guard let fullName = json["fullName"] as? String,
//            let stateCode = json["stateCode"] as? String,
//            let imageURLString = json["url"] as? String,
//            let imageURL = URL(string: imageURLString) else { return nil }
//
//        self.fullName = fullName
//        self.stateCode = stateCode
//        self.imageURL = imageURL


