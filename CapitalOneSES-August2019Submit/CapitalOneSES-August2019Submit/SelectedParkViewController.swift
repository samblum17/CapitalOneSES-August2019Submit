//
//  SelectedParkViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 5/24/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit
import SafariServices

class SelectedParkViewController: UIViewController, UIScrollViewDelegate {
  
//Outlets for UIStoryboard objects
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var parkImage: UIImageView!
    @IBOutlet var imageCaption: UILabel!
    @IBOutlet var visitorCentersButton: UIButton!
    @IBOutlet var campgroundButton: UIButton!
    @IBOutlet var calendarButton: UIButton!
    @IBOutlet var funInfoButton: UIButton!
    @IBOutlet var alertsButton: UIButton!
    
//Variables for segue to pass data into from table view
    var descriptionLabelText: String?
    var imageURLString: String = ""
    var abbreviation: String?
   
    override func viewDidLoad() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
    //Load primary image of selected park
        var imageURL = URL(string: imageURLString)
        let task = URLSession.shared.dataTask(with: imageURL!) { (data,response, error) in

            guard let imageData = data else {
                return
            }

            DispatchQueue.main.async {

                let image = UIImage(data: imageData)
                self.parkImage.image = image
            }

        }
        task.resume()
        descriptionLabel.text = descriptionLabelText
        super.viewDidLoad()
    }
    

////Use safariViewControllers to load respective information for each button press
//    @IBAction func visitorButtonPressed(_ sender: Any) {
//        if let url = URL(string: "https://www.nps.gov/" + abbreviation! + "/planyourvisit/visitorcenters.htm") {
//            let safariViewController = SFSafariViewController(url: url)
//            present(safariViewController,animated: true, completion: nil)
//        }
//    }
//
//    @IBAction func campgroundPressed(_ sender: Any) {
//        if let url = URL(string: "https://www.nps.gov/" + abbreviation! + "/planyourvisit/campgrounds.htm") {
//            let safariViewController = SFSafariViewController(url: url)
//            present(safariViewController,animated: true, completion: nil)
//        }
//
//    }
//    @IBAction func calendarPressed(_ sender: Any) {
//        if let url = URL(string: "https://www.nps.gov/" + abbreviation! + "/planyourvisit/calendar.htm") {
//            let safariViewController = SFSafariViewController(url: url)
//            present(safariViewController,animated: true, completion: nil)
//        }
//
//    }
//
//    @IBAction func funInfoPressed(_ sender: Any) {
//        if let url = URL(string: "https://www.nps.gov/" + abbreviation! + "/planyourvisit/parkfacts.htm") {
//            let safariViewController = SFSafariViewController(url: url)
//            present(safariViewController,animated: true, completion: nil)
//        }
//
//    }
//    @IBAction func alertsPressed(_ sender: Any) {
//        if let url = URL(string: "https://www.nps.gov/" + abbreviation! + "/planyourvisit/conditions.htm") {
//            let safariViewController = SFSafariViewController(url: url)
//            present(safariViewController,animated: true, completion: nil)
//        }
//
//    }
    
    //Prepares data to be passed to next viewController by creating variables
    var parkName: String?
    var parkCode: String?
    
    //Sends data to next viewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Segue called
        if(segue.identifier == "VCSegue") {
            let vc = segue.destination as! MoreInfoViewController
            vc.title = "Visitor Centers"
            vc.abbreviation = abbreviation
        }
        if(segue.identifier == "calendarSegue") {
            let vc = segue.destination as! MoreInfoViewController
            vc.title = "Events"
            vc.abbreviation = abbreviation
        }
        //Segue called
        if(segue.identifier == "factsSegue") {
            let vc = segue.destination as! MoreInfoViewController
            vc.title = "Park Facts"
            vc.abbreviation = abbreviation
        }
        //Segue called
        if(segue.identifier == "alertsSegue") {
            let vc = segue.destination as! MoreInfoViewController
            vc.title = "Alerts"
            vc.abbreviation = abbreviation
        }
        //Segue called
        if(segue.identifier == "campgroundSegue") {
            let vc = segue.destination as! MoreInfoViewController
            vc.title = "Campgroundss"
            vc.abbreviation = abbreviation
        }
        
    }


    

    /*
     // MARK: -  Unused overrides below for future implementation to extend capabilities


    // Pass information to another view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
