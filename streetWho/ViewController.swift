//
//  ViewController.swift
//  streetWho
//
//  Created by Anuar Zhukenov on 7/28/16.
//  Copyright © 2016 Anuar Zhukenov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var infoText: UITextField!
  
    let locationMangaer = CLLocationManager()
    
    let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    let apikey = "AIzaSyD3gA_RxafLYdWpCv7Av8cDeqMGA9QkYBQ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationMangaer.delegate = self
        
        self.locationMangaer.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationMangaer.requestWhenInUseAuthorization()
        
        self.locationMangaer.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){

        
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        
        let latitude: String = String(format:"%f", location!.coordinate.latitude)
        let longitude: String = String(format:"%f", location!.coordinate.longitude)
        
        getAddressForLatLng(latitude, longitude: longitude)
        
    }
    

    
    func getAddressForLatLng(latitude: String, longitude: String) {

        let url = NSURL(string: "\(baseUrl)latlng=\(latitude),\(longitude)&key=\(apikey)")
        let data = NSData(contentsOfURL: url!)
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        if let result = json["results"] as? NSArray {
            if let address = result[0]["address_components"] as? NSArray {
                
                let street = address[1]["short_name"] as! String

                self.adress.text = street

                getStreetInfo(street)
                
                
            }
        }
    }
    
    func getStreetInfo(street: String){

        let request = NSMutableURLRequest(URL: NSURL(string: "http://138.68.14.223:7777/streets")!)
        request.HTTPMethod = "POST"
        let postString = "name=\(street)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
//                    print(jsonResult["info"])
                    
                    if let description = jsonResult["info"] {
                        self.infoText.text = description as! String
                    } else {
                        print("Unable to retrieve the number of rooms.")
                    }

                    
                }
            } catch {
                print("Something went wrong")
            }
        }
        task.resume()
        
    }

    

}

