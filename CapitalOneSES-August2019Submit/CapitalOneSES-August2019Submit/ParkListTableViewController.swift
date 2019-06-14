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
    let imageCache = NSCache<AnyObject, AnyObject>() //Cache images for faster loading


    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
        
        //Keyboard can be swiped down
        tableView.keyboardDismissMode = .interactive

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
    
        //When user enters a search term
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
    
    //Searches for items on highest priority queue
        DispatchQueue.main.async {
            if let searchItems = searchItems {
                self.searchItems = searchItems
                self.activityIndicatorView.stopAnimating()
                self.tableView.separatorStyle = .singleLine
                self.tableView.reloadData()
                
                //When no results, show alert message
                if self.searchItems.count == 0 {
                    let alertController = UIAlertController(title: "No results", message: "No parks to display. Either the park you searched for was spelled incorrectly or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
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
          }

//Sets attributes of cell
    func configure(cell: searchResultsTableViewCell, forItemAt indexPath: IndexPath) {
        
            let item = searchItems[indexPath.row]
            cell.titleLabel.text = item.fullName
            cell.stateCodeLabel.text = item.states
        
        //Placeholder image for loading
            cell.cellImage.image = #imageLiteral(resourceName: "NewSolid_gray")
        
        //Set actual cell image from cache
            let currentImageURLString = item.images?[0].urlString ?? ""
        
            var imageURL = URL(string: currentImageURLString)
            if let imageFromCache = imageCache.object(forKey: currentImageURLString as AnyObject) as? UIImage {
                DispatchQueue.main.async {
                    cell.cellImage.image = imageFromCache
            }
        //If not found in cache, pull from web, cache, and load into cell
        } else {
            let task = URLSession.shared.dataTask(with: imageURL!) { (data,response, error) in

            guard let imageData = data else {
                return
            }
                
            //Highest priority queue
            DispatchQueue.main.async {

                let imageToCache = UIImage(data: imageData)
                self.imageCache.setObject(imageToCache!, forKey: currentImageURLString as AnyObject)
                cell.cellImage.image = imageToCache
            }
        }
        task.resume()
        
    }
    }
    
    
                //MARK: - Table view data source


//Sets number of tableView rows to number of parks loaded
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchItems.count
    }

//Loads cell with proper attributes
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! searchResultsTableViewCell
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
//Prepare data to be passed to proper viewController
        var parkName: String?
        var parkDescription: String?
        var parkImageURLString: String?
        var parkImageURL: URL?
        var parkImageCaption: String?
        var selectedItemDescription: String?
        var selectedCode: String?
        var latLong: String?

    
//Send data to next viewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = self.searchItems[indexPath.row]
            selectedItemDescription = item.description
            parkName = item.name
            parkImageURLString = item.images?[0].urlString ?? ""
            parkImageCaption = item.images?[0].caption ?? "Error loading content"
            selectedCode = item.parkCode
            latLong = item.latLong
            parkName = item.fullName
        }
    //Segue when park is selected
        if(segue.identifier == "parkSelectedSegue") {
            let vc = segue.destination as! SelectedParkViewController
            vc.title = parkName
            vc.descriptionLabelText = selectedItemDescription
            vc.imageURLString = parkImageURLString ?? " "
            vc.abbreviation = selectedCode
            vc.latLong = latLong
            vc.parkName = parkName
            
        }
    
    }
    
//Load network indicator on background view
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




            //MARK: - Unused overrides below




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


