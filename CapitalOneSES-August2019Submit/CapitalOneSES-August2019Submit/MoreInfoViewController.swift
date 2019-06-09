//
//  MoreInfoViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/7/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

//VC for visitor center, alerts
class MoreInfoViewController: UIViewController {
    
//Outlets from storyboard
    @IBOutlet var topSectionHeader: UILabel!
    @IBOutlet var topSectionText: UILabel!
    @IBOutlet var bottomSectionHeader: UILabel!
    @IBOutlet var bottomSectionText: UILabel!
    @IBOutlet var topSectionH2: UILabel!
    @IBOutlet var topSectionT2: UILabel!
    @IBOutlet var bottomSectionH2: UILabel!
    @IBOutlet var bottomSectionT2: UILabel!
    @IBOutlet var topSectionH3: UILabel!
    @IBOutlet var topSectionT3: UILabel!
    @IBOutlet var bottomSectionH3: UILabel!
    @IBOutlet var bottomSectionT3: UILabel!
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
    }
    
    //Pull data before view loads for fastest results
    override func viewWillAppear(_ animated: Bool) {
        if self.title == "Visitor Centers" {
            fetchMatchingVC()
        } else if self.title == "Alerts" {
            fetchMatchingAlerts()
        }
    }
 
                        //MARK: - Visitor Center View
//Main variables to hold VCs returned
    let VCItemController = StoreVCController()
    var returnedData = [VCData]()
    var abbreviation: String?

    //Pull park data from NPS API and load into respective variables
    func fetchMatchingVC() {
        
        self.returnedData = []
        
            //Set up query dictionary to search any park
            let query: [String: String] = [
                "parkCode" : abbreviation!,
                "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
            ]
            //Call the itemController to fetch items
            VCItemController.fetchItems(matching: query, completion: { (returnedData) in
            
            //Load in returned data and update views
                DispatchQueue.main.async {
                    if let returnedData = returnedData {
                        self.returnedData = returnedData
                        self.updateVCView()
                    } else {
                        //Accounts for API load error
                        print("Unable to reload")
                    }
                }
        }
        )
    }
    
 //Handle updates to VC labels in each case
    func updateVCView(){
//When VC data is returned
        if !returnedData.isEmpty{
        topSectionHeader.text = returnedData[0].name
        topSectionText.text = returnedData[0].description
        bottomSectionHeader.text = "Directions"
        bottomSectionText.text = returnedData[0].directions
    //Two VCs are returned
            if returnedData.indices.contains(1){
                topSectionH2.text = returnedData[1].name
                topSectionT2.text = returnedData[1].description
                bottomSectionH2.text = "Directions"
                bottomSectionT2.text = returnedData[1].directions
            } else {
                topSectionH2.isHidden = true
                topSectionT2.isHidden = true
                bottomSectionH2.isHidden = true
                bottomSectionT2.isHidden = true
            }
    //Three VCs are returned
            if returnedData.indices.contains(2) {
                topSectionH3.text = returnedData[2].name
                topSectionT3.text = returnedData[2].description
                bottomSectionH3.text = "Directions"
                bottomSectionT3.text = returnedData[2].directions
            } else {
                topSectionH3.isHidden = true
                topSectionT3.isHidden = true
                bottomSectionH3.isHidden = true
                bottomSectionT3.isHidden = true
            }
    //No VCs returned or API doesnt load in properly
        } else {
            topSectionHeader.text = "No Results"
            topSectionText.text = "There was an error with your selection. Either the park you selected does not have visitor center information to display or network connection was lost. Please try again or check the NPS website for more info."
            bottomSectionHeader.text = ""
            bottomSectionText.text = ""
            topSectionH2.isHidden = true
            topSectionT2.isHidden = true
            bottomSectionH2.isHidden = true
            bottomSectionT2.isHidden = true
            topSectionH3.isHidden = true
            topSectionT3.isHidden = true
            bottomSectionH3.isHidden = true
            bottomSectionT3.isHidden = true
        }
    }
    
                        //MARK: - Alerts View
    
    
    //Main variables to hold alerts returned
    let alertsItemController = StoreAlertsController()
    var returnedAlertsData = [AlertData]()
    
    //Pull park data from NPS API and load into respective variables
    func fetchMatchingAlerts() {
        
        self.returnedAlertsData = []
        
        //Set up query dictionary to search any park
        let query: [String: String] = [
            "parkCode" : abbreviation!,
            "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
        ]
        //Call the itemController to fetch items
        alertsItemController.fetchItems(matching: query, completion: { (returnedAlertsData) in
            
            //Load in returned data and update views
            DispatchQueue.main.async {
                if let returnedAlertsData = returnedAlertsData {
                    self.returnedAlertsData = returnedAlertsData
                    self.updateAlertsView()
                } else {
                    //Accounts for API load error
                    print("Unable to reload")
                }
            }
        }
        )
    }
    
    //Handle updates to alert labels in each case
    func updateAlertsView(){
        bottomSectionHeader.isHidden = true
        bottomSectionText.isHidden = true
        bottomSectionH2.isHidden = true
        bottomSectionT2.isHidden = true
        bottomSectionH3.isHidden = true
        bottomSectionT3.isHidden = true
        //When alertsData is returned
        if !returnedAlertsData.isEmpty{
            topSectionHeader.textColor = .red
            topSectionHeader.text = returnedAlertsData[0].title
            topSectionText.text = returnedAlertsData[0].description
            //Two alerts are returned
            if returnedAlertsData.indices.contains(1){
                topSectionH2.textColor = .red
                topSectionH2.text = returnedAlertsData[1].title
                topSectionT2.text = returnedAlertsData[1].description
            } else {
                topSectionH2.isHidden = true
                topSectionT2.isHidden = true
            }
            //Three alerts are returned
            if returnedAlertsData.indices.contains(2) {
                topSectionH3.textColor = .red
                topSectionH3.text = returnedAlertsData[2].title
                topSectionT3.text = returnedAlertsData[2].description
            } else {
                topSectionH3.isHidden = true
                topSectionT3.isHidden = true
            }
            //No alerts returned or API doesnt load in properly
        } else {
            topSectionHeader.textColor = .red
            topSectionHeader.text = "No Results"
            topSectionText.text = "No alerts to display. Either the park you selected does not have alert information to display or network connection was lost. Please try again or check the NPS website for more info."
            topSectionH2.isHidden = true
            topSectionT2.isHidden = true
           
            topSectionH3.isHidden = true
            topSectionT3.isHidden = true
          
        }
    }


    
    
    
    
    
    
    
    
            //MARK: - Unused overrides
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
