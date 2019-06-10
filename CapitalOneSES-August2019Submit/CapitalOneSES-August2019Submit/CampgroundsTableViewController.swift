//
//  CampgroundsTableViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/9/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

class CampgroundsTableViewController: UITableViewController {

//Variable set up to hold objects used throughout controller
    var activityIndicatorView: UIActivityIndicatorView!
    var abbreviation: String?
    let campgroundItemController = StoreCampgroundsController()
    var returnedCampgroundData = [CampgroundData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//Allow cell to have dynamic height
        tableView.estimatedRowHeight = 260.0
        tableView.rowHeight = UITableView.automaticDimension
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    
    }

//Show network indicator before data loads and then load data
    override func viewWillAppear(_ animated: Bool) {
        activityIndicatorView.startAnimating()
        tableView.separatorStyle = .none
        fetchMatchingCampgrounds()

    }

//Load network indicator in background
    override func loadView() {
        super.loadView()
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        
        tableView.backgroundView = activityIndicatorView
    }
    
//Pull campground data from NPS API and load into respective variables
    func fetchMatchingCampgrounds() {
        
        self.returnedCampgroundData = []
        self.tableView.reloadData()

        //Set up query dictionary to search any park
        let query: [String: String] = [
            "parkCode" : abbreviation!,
            "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
        ]
        //Call the itemController to fetch items
        campgroundItemController.fetchItems(matching: query, completion: { (returnedCampgroundData) in
            
            //Load in returned data and update views
            DispatchQueue.main.async {
                if let returnedCampgroundData = returnedCampgroundData {
                    self.returnedCampgroundData = returnedCampgroundData
                    self.activityIndicatorView.stopAnimating()
                    self.tableView.separatorStyle = .singleLine
                    self.tableView.reloadData()
            //When no results, show alert message
                    if self.returnedCampgroundData.count == 0 {
                        let alertController = UIAlertController(title: "No results", message: "No campgrounds to display. Either the park you selected does not have campground information to display or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
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

//Number of rows equals number of campgrounds returned
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return returnedCampgroundData.count
    }
//Height of cells is dynamic
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//Configure cell with respective variables for labels
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: "campgroundCell", for: indexPath) as! CampgroundsTableViewCell
         //Configure the cell...
        //When campgroundData is returned
        if !(returnedCampgroundData.count == 0){
            cell.titleLabel.text = returnedCampgroundData[indexPath.row].name
            cell.descriptionLabel.text = returnedCampgroundData[indexPath.row].description
            cell.weatherLabel.text = returnedCampgroundData[indexPath.row].weather
            cell.directionsLabel.text = returnedCampgroundData[indexPath.row].directions
            cell.rvSites.text = returnedCampgroundData[indexPath.row].campsites?.rv
            cell.tentSites.text = returnedCampgroundData[indexPath.row].campsites?.tent
            cell.totalSites.text = returnedCampgroundData[indexPath.row].campsites?.total

        }
        
        return cell
    }
    
    
                                //MARK:- Unused overrides
   

    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }

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
//
//public extension UIAlertController {
//    func show() {
//        let win = UIWindow(frame: UIScreen.main.bounds)
//        let vc = UIViewController()
//        vc.view.backgroundColor = .clear
//        win.rootViewController = vc
//        win.windowLevel = UIWindow.Level.alert + 1
//        win.makeKeyAndVisible()
//        vc.present(self, animated: true, completion: nil)
//    }
//}
