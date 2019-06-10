//
//  ParkListTableViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 5/21/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

class ParkListTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
//Keyboard can be swiped down
        tableView.keyboardDismissMode = .interactive
        //When no results after 8 seconds, show alert message
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            if self.searchItems.count == 0 {
                let alertController = UIAlertController(title: "No results", message: "No parks to display. Either the park you searched for does not have available information to display or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }

    }
        
//Set variables for objects and controllers
    @IBOutlet var parkSearchBar: UISearchBar!
    let itemController = StoreItemController()
//Array that will hold fetched parks
    var searchItems = [ParkData]()
    
//Pull park data from NPS API and load into respective variables
    func fetchMatchingItems() {
    
        self.searchItems = []
        self.tableView.reloadData()
    
        let parkName = parkSearchBar.text ?? ""
    
        if !parkName.isEmpty {
    
        //Set up query dictionary to search any park
            let query: [String: String] = [
                "q" : parkName,
                "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1",
                "fields" : "images",
                "limit" : "100"
            ]
    
//Call the itemController to fetch items
    itemController.fetchItems(matching: query, completion: { (searchItems) in
    
    //Searches for items on highest priority queue of Grand Central Dispatch for faster results
        DispatchQueue.main.async {
            if let searchItems = searchItems {
                self.searchItems = searchItems
                self.activityIndicatorView.stopAnimating()
                self.tableView.separatorStyle = .singleLine
                self.tableView.reloadData()
           
            } else {
            //Accounts for API load error
                print("Unable to reload")
                }
               }
             }
            )
           }
          }

//Sets properties of cell
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
            let item = searchItems[indexPath.row]
            cell.textLabel?.text = item.fullName
            cell.detailTextLabel?.text = item.states
        //Placeholder image for loading
            cell.imageView?.image = #imageLiteral(resourceName: "NewSolid_gray")
        //Sets actual cell image
            let currentImageURLString = item.images?[0].urlString ?? ""
        
            let imageURL = URL(string: currentImageURLString)!
            let task = URLSession.shared.dataTask(with: imageURL) { (data,response, error) in

            guard let imageData = data else {
                return
            }
                
        //Loads image on highest priority queue of Grand Central Dispatch for faster results
            DispatchQueue.main.async {

                let image = UIImage(data: imageData)
                cell.imageView?.image = image
                cell.setNeedsLayout()
                cell.reloadInputViews()
            }
                

        }
        task.resume()
        
    }
    
    
    //MARK: - Table view data source


//Sets number of tableView rows to number of parks loaded
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchItems.count
    }

//Loads cell with proper detail
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    //Prepares data to be passed to next viewController by creating variables
        var parkName: String?
        var parkDescription: String?
        var parkImageURLString: String?
        var parkImageURL: URL?
        var parkImageCaption: String?
        var selectedItemDescription: String?
        var selectedCode: String?
    
//Sends data to next viewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            selectedItemDescription = self.searchItems[indexPath.row].description
            parkName = self.searchItems[indexPath.row].name
            parkImageURLString = self.searchItems[indexPath.row].images?[0].urlString ?? ""
            parkImageCaption = self.searchItems[indexPath.row].images?[0].caption ?? "Error loading content"
            selectedCode = self.searchItems[indexPath.row].parkCode
        }
    //Segue called
        if(segue.identifier == "parkSelectedSegue") {
            let vc = segue.destination as! SelectedParkViewController
            vc.title = parkName
            vc.descriptionLabelText = selectedItemDescription
            vc.imageURLString = parkImageURLString ?? " "
            vc.abbreviation = selectedCode
        }
    
    }
    
    //Load network indicator in background
    override func loadView() {
        super.loadView()
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        
        tableView.backgroundView = activityIndicatorView
    }
    
}

//Extends controller to load items using UISearchBar
    extension ParkListTableViewController: UISearchBarDelegate {
        
        func searchBarSearchButtonClicked(_ parkSearchBar: UISearchBar) {
            activityIndicatorView.startAnimating()
            tableView.separatorStyle = .none
            fetchMatchingItems()
            parkSearchBar.resignFirstResponder()
        }
    }

        //MARK: - Unused overrides below for future implementation to extend capabilities




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
    */


