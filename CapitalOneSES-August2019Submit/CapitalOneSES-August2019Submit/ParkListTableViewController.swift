//
//  ParkListTableViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 5/21/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ParkListTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var activityIndicatorView: UIActivityIndicatorView!
    var bannerView: GADBannerView! //Admob banner for iphone
    let imageCache = NSCache<AnyObject, AnyObject>() //Cache images for faster loading
    static let initialDefaultImageURL = "https://www.nps.gov/common/commonspot/templates/images/logos/nps_social_image_02.jpg"
    
    
    override func viewDidLoad() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            navigationController?.navigationBar.prefersLargeTitles = true
            bannerView = GADBannerView()
            let viewWidth = UIScreen.main.bounds.width
            bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        }
        super.viewDidLoad()
        //Keyboard can be swiped down
        tableView.keyboardDismissMode = .interactive
        
        //Init admob banner for iPhone
        if UIDevice.current.userInterfaceIdiom == .phone {
            addBannerViewToView(bannerView)
//            let testID = "ca-app-pub-3940256099942544/2934735716"
            let prodID = "ca-app-pub-3264342285166813/1748959151"
            bannerView.adUnitID = prodID
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
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
        var parkName = parkSearchBar.text ?? ""
        
        //only search on term before spaces to show most relevant parks
        if parkName.contains(" ") {
            let indexOfSpace = parkName.firstIndex(of: " ")!
            let substring = parkName[...indexOfSpace]
            parkName = String(substring)
        }
        
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
                        let unsortedArray: [ParkData] = searchItems
                        self.searchItems = self.sortFoundParks(key: parkName, unsortedArray: unsortedArray)
                        self.activityIndicatorView.stopAnimating()
                        self.tableView.separatorStyle = .singleLine
                        self.tableView.reloadData()
                        
                        //When no results, show alert message
                        if self.searchItems.count == 0 {
                            let alertController = UIAlertController(title: "No results", message: "No parks to display. Either the park you searched for was spelled incorrectly or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in
                                self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                        
                    } else {
                        //Accounts for API load error
                        print("Unable to reload")
                    }
                }
            }
            )
            
            //Empty search term
        } else {
            self.activityIndicatorView.stopAnimating()
            let alertController = UIAlertController(title: "Invalid Search", message: "Please check your network connection and enter a valid park to try searching again.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //Sets attributes of cell
    func configure(cell: searchResultsTableViewCell, forItemAt indexPath: IndexPath) {
        
        let item = searchItems[indexPath.row]
        cell.titleLabel.text = item.fullName
        cell.stateCodeLabel.text = item.states
        
        //Placeholder image for loading
        cell.cellImage.image = #imageLiteral(resourceName: "Solid_gray")
        
        //Set actual cell image from cache (default to NPS logo)
        var currentImageURLString = ParkListTableViewController.initialDefaultImageURL
        if !(item.images?.isEmpty)! {
            currentImageURLString = item.images?[0].urlString ?? ""
        }
        
        let imageURL = URL(string: currentImageURLString) ?? URL(string: ParkListTableViewController.initialDefaultImageURL)!
        if let imageFromCache = imageCache.object(forKey: currentImageURLString as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                cell.cellImage.image = imageFromCache
            }
            //If not found in cache, pull from web, cache, and load into cell
        } else {
            let task = URLSession.shared.dataTask(with: imageURL) { (data,response, error) in
                
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
    
    //Helper function to sort found parks by park name relevance
    func sortFoundParks(key: String, unsortedArray: [ParkData]) -> [ParkData] {
        let sorted = unsortedArray.sorted(by: {
            
            //Remove all spaces and focus on first term
            var firstParkName: String  = $0.name?.lowercased() ?? "1"
            var secondParkName: String = $1.name?.lowercased() ?? "2"
            let lowerKey = key.lowercased().replacingOccurrences(of: " ", with: "")
            if firstParkName.contains(" ") {
                let indexOfSpace = firstParkName.firstIndex(of: " ")!
                let substring = firstParkName[...indexOfSpace]
                firstParkName = String(substring)
            }
            if secondParkName.contains(" ") {
                let indexOfSpace = secondParkName.firstIndex(of: " ")!
                let substring = secondParkName[...indexOfSpace]
                secondParkName = String(substring)
            }
            
            //Sort by relevance
            if firstParkName == lowerKey && secondParkName != lowerKey {
                return true
            }
            else if firstParkName.hasPrefix(lowerKey) && !secondParkName.hasPrefix(lowerKey)  {
                return true
            }
            else if firstParkName.hasPrefix(lowerKey) && secondParkName.hasPrefix(lowerKey)
                        && firstParkName.count < secondParkName.count  {
                return true
            }
            else if firstParkName.contains(lowerKey) && !secondParkName.contains(lowerKey) {
                return true
            }
            else if firstParkName.contains(lowerKey) && secondParkName.contains(lowerKey)
                        && firstParkName.count < secondParkName.count {
                return true
            }
            return false
        })
        return sorted
    }
    
    //Admob banner ad
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
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
    var parkShortName: String?
    var parkDescription: String?
    var parkImageURLString: String? = ParkListTableViewController.initialDefaultImageURL
    var parkImageURL: URL?
    var parkImageCaption: String? = "Error loading content"
    var selectedItemDescription: String?
    var selectedCode: String?
    var latLong: String?
    
    
    
    //Send data to next viewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = self.searchItems[indexPath.row]
            selectedItemDescription = item.description
            parkShortName = item.name
            if !(item.images?.isEmpty)! {
                parkImageURLString = item.images?[0].urlString ?? ""
                parkImageCaption = item.images?[0].caption ?? "Error loading content"
            }
            selectedCode = item.parkCode
            latLong = item.latLong
            parkName = item.fullName
        }
        //Segue when park is selected
        if(segue.identifier == "parkSelectedSegue") {
            let vc = segue.destination as! SelectedParkViewController
            vc.title = parkShortName
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
        
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        if (UIDevice.current.userInterfaceIdiom != .pad){
            self.tableView.backgroundView = activityIndicatorView
        }
    }
    
    @IBAction func unwind(segue : UIStoryboardSegue) {
    }
}

//Extends controller to load items using UISearchBar
extension ParkListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ parkSearchBar: UISearchBar) {
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            parkSearchBar.addSubview(activityIndicatorView)
            activityIndicatorView.center = CGPoint(x: parkSearchBar.bounds.maxX - 50, y: parkSearchBar.bounds.midY)
        }
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


