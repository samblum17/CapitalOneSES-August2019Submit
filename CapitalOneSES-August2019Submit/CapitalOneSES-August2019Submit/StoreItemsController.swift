//
//  StoreItemsController.swift
//  CoverCollection
//
//  Created by Sam Blum on 11/3/18.
//  Copyright © 2018 Sam Blum. All rights reserved.
//

import Foundation

//Controller for fetching parks from server
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


//Controller for fetching visitor centers from server
struct StoreVCController {
    //Fetches items from NPS API- called from MoreInfo controller
    func fetchItems(matching query: [String: String], completion: @escaping ([VCData]?) -> Void) {
        
        let baseURL = URL(string: "https://developer.nps.gov/api/v1/visitorcenters?")!

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
                let VCDecoded = try? jsonDecoder.decode(VisitorCenter.self, from: data){
                completion(VCDecoded.data)
            } else {
                completion(nil)
            }
        }
        task.resume()
        
    }
        
}

//Controller for fetching alerts from server
struct StoreAlertsController {
    //Fetches items from NPS API- called from MoreInfo controller
    func fetchItems(matching query: [String: String], completion: @escaping ([AlertData]?) -> Void) {
        
        let baseURL = URL(string: "https://developer.nps.gov/api/v1/alerts?")!
        
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
                let alertDecoded = try? jsonDecoder.decode(Alerts.self, from: data){
                completion(alertDecoded.data)
            } else {
                completion(nil)
            }
        }
        task.resume()
        
    }
}

//Controller for fetching campgrounds from server
struct StoreCampgroundsController {
    //Fetches items from NPS API- called from campground controller
    func fetchItems(matching query: [String: String], completion: @escaping ([CampgroundData]?) -> Void) {
        
        let baseURL = URL(string: "https://developer.nps.gov/api/v1/campgrounds?")!
        
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
                let campgroundDecoded = try? jsonDecoder.decode(Campgrounds.self, from: data){
                completion(campgroundDecoded.data)
            } else {
                completion(nil)
            }
        }
        task.resume()
        
}
}
