//
//  SelectedParkViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 5/24/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit
import SafariServices
import SwiftUI

class SelectedParkViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //Outlets for UIStoryboard objects
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var parkImage: UIImageView!
    @IBOutlet var imageCaption: UILabel!
    @IBOutlet var visitorCentersButton: UIButton!
    @IBOutlet var campgroundButton: UIButton!
    @IBOutlet var calendarButton: UIButton! //Renamed to events
    @IBOutlet var funInfoButton: UIButton! //Renamed to education
    @IBOutlet var alertsButton: UIButton!
    @IBOutlet var moreButton: UIButton!
    @IBOutlet var thingstodoButton: UIButton!
    
    
    /*Collection View is used to show UIImageView rather than just a UIImageView on top of the scroll view for possible implementation of a slideshow feature in the future. The API data pulling coupled with standard loading images from URL resulted in laggy, unattractive implementation of a slide show throughout testing. For now, a single park image will highlight the selectionViewController but implementation in future should be looked into.
     */
    @IBOutlet var slideshowCollectionView: UICollectionView!
    var activityIndicatorView: UIActivityIndicatorView!
    
    
    //Variables for segue to pass data into from table view
    var descriptionLabelText: String?
    var imageURLString: String = ""
    var imageArray: [Images] = []
    var abbreviation: String?
    var latLong: String?
    let imageCache = NSCache<AnyObject, AnyObject>() //Cache image for faster loading
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        descriptionLabel.text = descriptionLabelText
        
        //Allow images in slideshowView to adapt to screen size
        var width = view.frame.size.width
        var height = view.frame.size.height
        if (UIDevice.current.userInterfaceIdiom == .pad){
            width = view.frame.size.width/3
            height = UIScreen.main.bounds.height/3
            slideshowCollectionView.isScrollEnabled = false
        }
        let layout = slideshowCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
        
        super.viewDidLoad()
        
    }
    
    //1 photo returned to collection view. For future slideshow implementation, return array count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    //Configure collectionView cell and load in data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "slideshowCell", for: indexPath) as! slideshowCollectionViewCell
        //Hide image and display activity indicator while loading
        cell.myImage.isHidden = true
        activityIndicatorView.startAnimating()
            if #available(iOS 16.0, *) {
                let imagesToPass = ImagesToPass()
                imagesToPass.images = self.imageArray
//                let imageCarouselView = ImageCarouselView(imagesPassed: imagesToPass)
//                let hostingController = UIHostingController(rootView: imageCarouselView)
//                cell.addSubview(hostingController.view)
                cell.contentConfiguration = UIHostingConfiguration {
                    ImageCarouselView(imagesPassed: imagesToPass)
                }
//                hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            } else {
                //Check if image is cached, load in if so
                let imageURL = URL(string: self.imageURLString) ?? URL(string: ParkListTableViewController.initialDefaultImageURL)!
                if let imageFromCache = self.imageCache.object(forKey: self.imageURLString as AnyObject) as? UIImage {
                    //Highest priority queue
                    DispatchQueue.main.async {
                        cell.myImage.image = imageFromCache
                        cell.myImage.isHidden = false
                        self.activityIndicatorView.stopAnimating()
                    }
                    //Image not cached, so pull from web, cache, and display
                } else {
                    let task = URLSession.shared.dataTask(with: imageURL) { (data,response, error) in
                        
                        guard let imageData = data else {
                            return
                        }
                        //Highest priority queue
                        DispatchQueue.main.async {
                            let imageToCache = UIImage(data: imageData)
                            self.imageCache.setObject(imageToCache!, forKey: self.imageURLString as AnyObject)
                            cell.myImage.image = imageToCache
                            cell.myImage.isHidden = false
                            self.activityIndicatorView.stopAnimating()
                        }
                        
                        
                    }
                    task.resume()
                }
            }
            
            cell.myImage.isHidden = false
            self.activityIndicatorView.stopAnimating()
        return cell
    }
    
    //Load network indicator on background view
    override func loadView() {
        super.loadView()
        
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        slideshowCollectionView.backgroundView = activityIndicatorView
    }
    
    
    //Prepares data to be passed to next viewController by creating variables
    var parkName: String?
    var parkCode: String?
    
    //Sends data to next viewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Segue to visitor centers
        if(segue.identifier == "VCSegue") {
            let vc = segue.destination as! MoreInfoViewController
            vc.title = "Visitor Centers"
            vc.abbreviation = abbreviation
        }
        //Segue to events
        if(segue.identifier == "eventSegue") {
            let vc = segue.destination as! EventsTableViewController
            vc.title = "Upcoming Events"
            vc.abbreviation = abbreviation
        }
        //Segue to education
        if(segue.identifier == "educationSegue") {
            let vc = segue.destination as! EducationViewController
            vc.title = "Education"
            vc.abbreviation = abbreviation
        }
        //Segue to alerts
        if(segue.identifier == "alertsSegue") {
            let vc = segue.destination as! MoreInfoViewController
            vc.title = "Alerts"
            vc.abbreviation = abbreviation
        }
        //Segue to campgrounds
        if(segue.identifier == "campgroundSegue") {
            let vc = segue.destination as! CampgroundsTableViewController
            vc.title = "Campgrounds"
            vc.abbreviation = abbreviation
        }
        
        //Segue to news
        if(segue.identifier == "newsSegue") {
            let vc = segue.destination as! NewsViewController
            vc.title = "News"
            vc.abbreviation = abbreviation
        }
        
        //Segue to map
        if (segue.identifier == "mapSegue") {
            let vc = segue.destination as! MapViewController
            vc.title = "Map"
            vc.abbreviation = abbreviation
            vc.latLong = latLong
            vc.parkName = parkName
        }
        
        //Segue to thingstodo
        if (segue.identifier == "thingstodoSegue") {
            let vc = segue.destination as! ThingsToDoViewController
            vc.title = "Things To Do"
            vc.abbreviation = abbreviation
            vc.parkName = parkName
        }
        
        
        
    }
    
    //More buttons
    @IBAction func moreButtonTapped(_ sender: Any) {
        let base = "https://www.nps.gov/"
        let fullURLString = base + (abbreviation ?? "yose")
        if let url = URL(string: fullURLString) {
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController,animated: true, completion: nil)
        }
        
    }
    
    @IBAction func moreButtonTapped_PadIdiom(_ sender: Any) {
        let base = "https://www.nps.gov/"
        let fullURLString = base + (abbreviation ?? "yose")
        if let url = URL(string: fullURLString) {
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    
    // MARK: -  Unused overrides below
    
    /*
     // Pass information to another view controller
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
