//
//  MoreInfoViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/7/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {
    
    @IBOutlet var topSectionHeader: UILabel!
    @IBOutlet var topSectionText: UILabel!
    @IBOutlet var bottomSectionHeader: UILabel!
    @IBOutlet var bottomSectionText: UILabel!
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let VCItemController = StoreVCController()
    var returnedData = [VCData]()
    var abbreviation: String?

    //Pull park data from NPS API and load into respective variables
    func fetchMatchingItems() {
        
        self.returnedData = []
        
            //Set up query dictionary to search any park
            let query: [String: String] = [
                "parkCode" : abbreviation!,
                "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
            ]
            //Call the itemController to fetch items
            VCItemController.fetchItems(matching: query, completion: { (returnedData) in
                
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
   
    func updateVCView(){
        if !returnedData.isEmpty{
        topSectionHeader.text = returnedData[0].name
        topSectionText.text = returnedData[0].description
        bottomSectionHeader.text = "Directions"
        bottomSectionText.text = returnedData[0].directions
        } else {
            topSectionHeader.text = "No Results"
            topSectionText.text = "There was an error with your selection. Either the park you selected does not have visitor center information to display or network connection was lost. Please try again or check the NPS website for more info."
            bottomSectionHeader.text = ""
            bottomSectionText.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchMatchingItems()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
