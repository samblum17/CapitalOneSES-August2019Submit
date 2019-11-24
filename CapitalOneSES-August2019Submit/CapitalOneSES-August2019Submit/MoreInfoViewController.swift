//
//  MoreInfoViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/7/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

//VC for visitor center, alerts
class MoreInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//Variable set up to hold objects used throughout controller for each VC
    var activityIndicatorView: UIActivityIndicatorView!
    var abbreviation: String?
    @IBOutlet var moreInfoTableView: UITableView!
    
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Allow cell to have dynamic height
        moreInfoTableView.estimatedRowHeight = 260.0
        moreInfoTableView.rowHeight = UITableView.automaticDimension

        super.viewDidLoad()
    }

    
//Pull data before view loads for fastest results
    override func viewWillAppear(_ animated: Bool) {
        //Show network indicator before data loads and then load data for each segment
        activityIndicatorView.startAnimating()
        moreInfoTableView.separatorStyle = .none

        if self.title == "Visitor Centers" {
            fetchMatchingVC()
        } else if self.title == "Alerts" {
            fetchMatchingAlerts()
        }
    }
    
//Load network indicator on background view
    override func loadView() {
        super.loadView()

        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        moreInfoTableView.backgroundView = activityIndicatorView
    }
    
 
                        //MARK: - Visitor Center View
    
    
//Main variables to hold VCs returned
    let VCItemController = StoreVCController()
    var returnedData = [VCData]()

//Pull VC data from NPS API and load into respective variables
    func fetchMatchingVC() {
        
        self.returnedData = []
        moreInfoTableView.reloadData()
        
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
                        self.activityIndicatorView.stopAnimating()
                        self.moreInfoTableView.separatorStyle = .singleLine
                        self.moreInfoTableView.reloadData()
                       
                        //When no results, show alert message
                        if self.returnedData.count == 0 {
                            let alertController = UIAlertController(title: "No results", message: "No visitor centers to display. Either the park you selected does not have visitor center information to display or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                        }
                    } else {
                        //Accounts for API load error
                        print("Unable to reload")
                    }
                }
        }
        )
    }
 
                        //MARK: - Alerts View
    
    
    //Main variables to hold alerts returned
    let alertsItemController = StoreAlertsController()
    var returnedAlertsData = [AlertData]()
    
//Pull alert data from NPS API and load into respective variables
    func fetchMatchingAlerts() {
        
        self.returnedAlertsData = []
        moreInfoTableView.reloadData()
        
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
                    self.activityIndicatorView.stopAnimating()
                    self.moreInfoTableView.separatorStyle = .singleLine
                    self.moreInfoTableView.reloadData()
                    //When no results, show alert message
                    if self.returnedAlertsData.count == 0 {
                        let alertController = UIAlertController(title: "No results", message: "No alerts to display. Either the park you selected does not have alert information to display or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    }
                } else {
                    //Accounts for API load error
                    print("Unable to reload")
                }
            }
        }
        )
    }

    
                        //Mark:- Table view data source
    
    
//Load data into cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moreInfoTableView.dequeueReusableCell(withIdentifier: "moreInfoCell", for: indexPath) as! MoreInfoTableViewCell
        
        
        //Visitor Centers shown
        if self.title == "Visitor Centers" {
            //When data returned
            if !(returnedData.count == 0){
                var VCItem = returnedData[indexPath.row]
                
                //Load in attributes
                cell.topSectionHeaderLabel.text = VCItem.name
                cell.topSectionTextLabel.text = VCItem.description
                cell.bottomSectionHeaderLabel.text = "Directions"
                cell.bottomSectionTextLabel.text = VCItem.directions
                
            }
            
            //Alerts shown
        } else if self.title == "Alerts" {
            //When data returned
            if !(returnedAlertsData.count == 0){
                var alertItem = returnedAlertsData[indexPath.row]
                
                //Load in attributes
                cell.topSectionHeaderLabel.textColor = .red
                cell.topSectionHeaderLabel.text = alertItem.title
                cell.topSectionTextLabel.text = alertItem.description
                cell.bottomSectionHeaderLabel.isHidden = true
                cell.bottomSectionTextLabel.isHidden = true
            
            }
        }
        return cell
    }
    

//Number of rows corresponds to array item count in each segment
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.title == "Visitor Centers" {
            return returnedData.count
            
        } else if self.title == "Alerts" {
            return returnedAlertsData.count
        } else {
            return 0
        }
        
    }
    
    
    
    
//Height of cells is dynamic
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
