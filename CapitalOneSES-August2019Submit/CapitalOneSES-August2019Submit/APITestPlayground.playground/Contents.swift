//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

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
//struct Park: Decodable {
//    var fullName: String?
//    var states: String?
//    var imageURLString: String?
//
//    init(from decoder: Decoder) throws {
//        let rawPark = try ParkData(from: decoder)
//
//        fullName = rawPark.fullName
//        states = rawPark.states
//        imageURLString = rawPark.imageURLString
//    }
//}


   
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
    




extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
let query: [String: String] = [
    "q" : "yellowstone",
    "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1",
    "fields" : "images"
]
let baseURL = URL(string: "https://developer.nps.gov/api/v1/parks?")!

let url = baseURL.withQueries(query)!

let task = URLSession.shared.dataTask(with: url) { (data,
    response, error) in
    let jsonDecoder = JSONDecoder()
    if let data = data,
        let parkDecoded = try? jsonDecoder.decode(Parks.self, from: data){
        print([parkDecoded.data?.description])
       
    } else {
        print("error")
    }
    
   
}
task.resume()
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


