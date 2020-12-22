//
//  MapViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/14/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit
import MapKit

/*Implementation of bonus feature: "Utilize latitude and longitude data for map visualization or distance calculations." This view controller displays the selected park on a map with a pin at the returned latitude and longitude*/
class MapViewController: UIViewController {
    
    //Storyboard outlets and variables for data passing
    @IBOutlet var parkMapView: MKMapView!
    var abbreviation: String?
    var parkName: String?
    var latLong: String?
    var mutatedLatLong: String?
    var mutatedArray: [String]?
    var latitude: String?
    var longitude: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSeparateLatlong()
        centerView()
        
        
        // Do any additional setup after loading the view.
    }
    
    /*Takes JSON returned latitude and longitude and mutates to separate variables for use in coordinate objects in MapKit*/
    func getSeparateLatlong(){
        //Takes off uneccesary labels
        var mutateSubstring = latLong?.replacingOccurrences(of: "lat:", with: "")
        mutateSubstring = mutateSubstring?.replacingOccurrences(of: "long:", with: "")
        
        //Separates lat and long values
        mutatedLatLong = String(mutateSubstring ?? "0.0")
        mutatedArray = mutatedLatLong?.split(separator: ",").map(String.init)
        
        //Assign to variables
        latitude = mutatedArray?[0]
        longitude = mutatedArray?[1].replacingOccurrences(of: " ", with: "")
        
    }
    
    //Centers mapview on park and drops pin with park name
    func centerView(){
        let coordinate = CLLocationCoordinate2DMake(latitude?.toDouble() ?? 0.0, longitude?.toDouble() ?? 0.0)
        parkMapView.setCenter(coordinate, animated: true)
        
        //Span values used were best zoom level for five parks tested
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        parkMapView.setRegion(parkMapView.regionThatFits(region), animated: true)
        
        //Drop pin on park
        let park = MKPointAnnotation()
        park.coordinate = coordinate
        park.title = parkName
        parkMapView.addAnnotation(park)
        
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

//Implement delegate
extension MapViewController: MKMapViewDelegate {
}


//Convert lat, long strings to doubles to use in coordinate
extension String
{
    public func toDouble() -> Double?
    {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
}
