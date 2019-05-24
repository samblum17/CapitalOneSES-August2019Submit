//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct Park: Codable {
    var fullName: String
    var stateCode: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case fullName
        case stateCode
        case imageURL = "url"
    }
    
    init?(json: [String: Any]) {
        
        guard let fullName = json["fullName"] as? String,
            let stateCode = json["stateCode"] as? String,
            let imageURLString = json["url"] as? String,
            let imageURL = URL(string: imageURLString) else { return nil }
        
        self.fullName = fullName
        self.stateCode = stateCode
        self.imageURL = imageURL
        
    }
}


extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
let query: [String: String] = [
    "q" : "yellowstone",
    "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
]
let baseURL = URL(string: "https://developer.nps.gov/api/v1/parks?")!

let url = baseURL.withQueries(query)!


    let task = URLSession.shared.dataTask(with: url) { (data, response, error)  in
    if let data = data,

        let rawJSON = try? JSONSerialization.jsonObject(with: data),
        let json = rawJSON as? [String: Any],

        let resultsArray = json["data"] as? [[String: Any]]{

        print(resultsArray)
                
        
    } else {
        print("Either no data was returned, or data was not serialized.")
        
    }

}
task.resume()


