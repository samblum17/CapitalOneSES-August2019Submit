//
//  StoreItemsController.swift
//  CoverCollection
//
//  Created by Sam Blum on 11/3/18.
//  Copyright © 2018 Sam Blum. All rights reserved.
//

import Foundation

//Controller for fetching items from server
struct StoreItemController {
    
   //Fetches items from NPS API- called from search tableView controller
    func fetchItems(matching query: [String: String], completion: @escaping ([ParkData]?) -> Void) {
    
        let baseURL = URL(string: "https://developer.nps.gov/api/v1/parks?")!

        guard let url = baseURL.withQueries(query) else {
         //Accounts for bad query call
            completion(nil)
            print("Unable to build URL with supplied queries. Please try again.")
            return
        }
    //Decodes JSON returned from API into active Park objects
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
