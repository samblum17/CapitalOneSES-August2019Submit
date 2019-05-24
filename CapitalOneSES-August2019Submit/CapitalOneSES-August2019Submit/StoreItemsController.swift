//
//  StoreItemsController.swift
//  CoverCollection
//
//  Created by Sam Blum on 11/3/18.
//  Copyright © 2018 Sam Blum. All rights reserved.
//

import Foundation
struct StoreItemController {
    func fetchItems(matching query: [String: String], completion: @escaping ([Park]?) -> Void) {
        
        let baseURL = URL(string: "https://developer.nps.gov/api/v1/parks?")!

        guard let url = baseURL.withQueries(query) else {
            
            completion(nil)
            print("Unable to build URL with supplied queries. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data,
                let rawJSON = try? JSONSerialization.jsonObject(with: data),
                let json = rawJSON as? [String: Any],
                let resultsArray = json["data"] as? [[String: Any]] {
                
                let parkResults = resultsArray.compactMap { Park(json: $0) }
                completion(parkResults)
                
            } else {
                print("Either no data was returned, or data was not serialized.")
                
                completion(nil)
                return
            }
        }
        
        task.resume()
    }
}
