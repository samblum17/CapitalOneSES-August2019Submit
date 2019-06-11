//
//  EventsTableViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/10/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    //Variable set up to hold objects used throughout controller
    var activityIndicatorView: UIActivityIndicatorView!
    var abbreviation: String?
    let eventItemController = StoreEventsController()
    var returnedEventsData = [EventData]()

    override func viewDidLoad() {
        super.viewDidLoad()
    //Allow cell to have dynamic height
        tableView.estimatedRowHeight = 260.0
        tableView.rowHeight = UITableView.automaticDimension
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //Show network indicator before data loads and then load data
    override func viewWillAppear(_ animated: Bool) {
        activityIndicatorView.startAnimating()
        tableView.separatorStyle = .none
        fetchMatchingEvents()
        
    }

    //Load network indicator in background
    override func loadView() {
        super.loadView()
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        
        tableView.backgroundView = activityIndicatorView
    }
    
    //Pull event data from NPS API and load into respective variables
    func fetchMatchingEvents() {
        
        self.returnedEventsData = []
        self.tableView.reloadData()
        
        //Set up query dictionary to search any park
        let query: [String: String] = [
            "parkCode" : abbreviation!,
            "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
        ]
        //Call the itemController to fetch items
        eventItemController.fetchItems(matching: query, completion: { (returnedEventsData) in
            
            //Load in returned data and update views
            DispatchQueue.main.async {
                if let returnedEventsData = returnedEventsData {
                    self.returnedEventsData = returnedEventsData
                    self.activityIndicatorView.stopAnimating()
                    self.tableView.separatorStyle = .singleLine
                    self.tableView.reloadData()
            //When no results, show alert message
                    if self.returnedEventsData.count == 0 {
                        let alertController = UIAlertController(title: "No results", message: "No events to display. Either the park you selected does not have event information to display or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
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
    
    
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return returnedEventsData.count
    }
    
//Height of cells is dynamic
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//Load respective information into each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsCell", for: indexPath) as! EventsTableViewCell

        //Configure the cell...
        var price = ""
        if returnedEventsData[indexPath.row].isFree == "false" {
            price = "Price: Additional fee. See NPS site for info"
        } else {
            price = "Price: Free"
        }
    //When eventData is returned
        if !(returnedEventsData.count == 0){
            
    //Remove unecessary text in description return from JSON
           var newDescription =  returnedEventsData[indexPath.row].description?.replacingOccurrences(of: "<p>", with: "")
            newDescription = newDescription?.replacingOccurrences(of: "</p>", with: "")
            newDescription = newDescription?.replacingOccurrences(of: "<em>", with: "")
            newDescription = newDescription?.replacingOccurrences(of: "</em>", with: "")
            
    //Reformat date return from JSON
            let dateString = returnedEventsData[indexPath.row].dateStart
            let dateFormatterSet = DateFormatter()
            dateFormatterSet.dateFormat = "yyyy-MM-dd"
            dateFormatterSet.locale = Locale.init(identifier: "en_GB")
            
            let dateObj = dateFormatterSet.date(from: dateString!)
            dateFormatterSet.dateFormat = "MMM dd, yyyy"
            let dateStartString = dateFormatterSet.string(from: dateObj!)
        //End date
            let dateString2 = returnedEventsData[indexPath.row].dateEnd
            let dateFormatterSet2 = DateFormatter()
            dateFormatterSet2.dateFormat = "yyyy-MM-dd"
            dateFormatterSet2.locale = Locale.init(identifier: "en_GB")
            
            let dateObj2 = dateFormatterSet2.date(from: dateString2!)
            dateFormatterSet2.dateFormat = "MMM dd, yyyy"
            let dateEndString = dateFormatterSet2.string(from: dateObj2!)

//Load information into cell attributes
            cell.titleLabel.text = returnedEventsData[indexPath.row].title
            cell.descriptionLabel.text = newDescription
            cell.endDateLabel.text = dateEndString
            cell.startDateLabel.text = dateStartString
            cell.timeStartLabel.text = returnedEventsData[indexPath.row].times?[0].timeStart
            cell.endTimeLabel.text = returnedEventsData[indexPath.row].times?[0].timeEnd
            cell.feeLabel.text = price
            
        }
        
        return cell
    }
 
    
                                //MARK:- Unused overrides


    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
     
     //    override func numberOfSections(in tableView: UITableView) -> Int {
     //        // #warning Incomplete implementation, return the number of sections
     //        return 0
     //    }

    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
