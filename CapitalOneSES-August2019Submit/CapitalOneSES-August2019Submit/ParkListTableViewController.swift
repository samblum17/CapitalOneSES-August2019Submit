//
//  ParkListTableViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 5/21/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

class ParkListTableViewController: UITableViewController, UINavigationControllerDelegate {
    @IBOutlet var parkSearchBar: UISearchBar!
    let itemController = StoreItemController()
    var searchItems = [Park]()
    
    
    func fetchMatchingItems() {
    
        self.searchItems = []
        self.tableView.reloadData()
    
        let parkName = parkSearchBar.text ?? ""
    
        if !parkName.isEmpty {
    
            // set up query dictionary
            let query: [String: String] = [
                "q" : parkName,
                "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
            ]
    
    // use the item controller to fetch items
    itemController.fetchItems(matching: query, completion: { (searchItems) in
    
    
        DispatchQueue.main.async {
            if let searchItems = searchItems {
                self.searchItems = searchItems
                self.tableView.reloadData()
            } else {
        print("Unable to reload")
        }
       }
     }
        )
     }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .interactive
    
    }

    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
        let item = searchItems[indexPath.row]
        
        cell.textLabel?.text = item.fullName
        cell.detailTextLabel?.text = item.stateCode
        cell.imageView?.image = #imageLiteral(resourceName: "Solid_gray")
        
        let task = URLSession.shared.dataTask(with: item.imageURL) { (data,response, error) in
            
            guard let imageData = data else {
                return
            }
            
            DispatchQueue.main.async {
                
                let image = UIImage(data: imageData)
                cell.imageView?.image = image
            }
            
        }
        task.resume()
        
        
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)
    
    // Configure the cell...
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
}
    
    extension ParkListTableViewController: UISearchBarDelegate {
        
        func searchBarSearchButtonClicked(_ parkSearchBar: UISearchBar) {
            
            fetchMatchingItems()
            parkSearchBar.resignFirstResponder()
        }
    }

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


