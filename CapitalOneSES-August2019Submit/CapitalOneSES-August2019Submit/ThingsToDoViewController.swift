//
//  ThingsToDoViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 1/6/22.
//  Copyright © 2022 Sam Blum. All rights reserved.
//

import UIKit
import SwiftUI

class ThingsToDoViewController: UIViewController {
    var abbreviation: String?
    var parkName: String?
    let ItemController = StoreThingsToDoController()
    var returnedData = [ThingsData]()
    var activityIndicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicatorView.startAnimating()
        fetchMatchingThingstodo()
    }
    
    //Load network indicator on background view
    override func loadView() {
        super.loadView()
        
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.view.addSubview(activityIndicatorView)
    }
    
    
    //Pull things data from NPS API and load into respective variables
    func fetchMatchingThingstodo() {
        self.returnedData = []
        
        //Set up query dictionary to search any park
        let query: [String: String] = [
            "parkCode" : abbreviation!,
            "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
        ]
        //Call the itemController to fetch items
        ItemController.fetchItems(matching: query, completion: { (returnedData) in
            
            //Load in returned data and update views
            DispatchQueue.main.async {
                if let returnedData = returnedData {
                    self.returnedData = returnedData
                    self.activityIndicatorView.stopAnimating()
                    let dataToPass = ParkDataToPass()
                    dataToPass.abbreviation = self.abbreviation!
                    dataToPass.data = returnedData
                    
                    //Add SwiftUI view into hierarchy
                    let thingsView = ThingsToDoView(dataToPass: dataToPass)
                    let hostingController = UIHostingController(rootView: thingsView)
                    self.addChild(hostingController)
                    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(hostingController.view)
                    hostingController.didMove(toParent: self)
                    NSLayoutConstraint.activate([
                        hostingController.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0),
                        hostingController.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0),
                        hostingController.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                        hostingController.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
                    ])
                    
                    //When no results, show alert message
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        if self.returnedData.count == 0 {
                            let alertController = UIAlertController(title: "No results", message: "No activities found. Either the park you selected does not have activity information to display or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in
                                self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                } else {
                    //Accounts for API load error
                    print("Unable to reload")
                }
            }
        }
        )
    }
    
    
}
