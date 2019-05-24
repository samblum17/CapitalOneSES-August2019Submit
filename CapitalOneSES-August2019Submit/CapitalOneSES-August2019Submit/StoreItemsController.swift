//
//  StoreItemsController.swift
//  CoverCollection
//
//  Created by Sam Blum on 11/3/18.
//  Copyright © 2018 Sam Blum. All rights reserved.
//

import Foundation
struct StoreItemController {
    func fetchItems(matching query: [String: String], completion: @escaping ([ParkData]?) -> Void) {
        
        let baseURL = URL(string: "https://developer.nps.gov/api/v1/parks?")!

        guard let url = baseURL.withQueries(query) else {
            
            completion(nil)
            print("Unable to build URL with supplied queries. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let parkDecoded = try? jsonDecoder.decode(Parks.self, from: data){
                completion(parkDecoded.data)
                
            } else {
                completion(nil)
            }
            
            
        }
        task.resume()
        
    }
}
