//
//  ViewController.swift
//  MapSearching
//
//  Created by Tian Qiu on 7/26/15.
//  Copyright (c) 2015 Tian Qiu. All rights reserved.
//

import UIKit      // for botton
import MapKit     // for map

class MapViewController: UIViewController {
    
    func Reset(){
        // click menu, make hotel and market show (transparent and transform)
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            // menu rotate back
            self.btnMenu.transform = CGAffineTransformMakeRotation(0)
            
            // concat = double, 1.5 scale and x y movement
            self.btnHotel.alpha = 0
            self.btnHotel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5), CGAffineTransformMakeTranslation(-80, -25))
            
            self.btnMarket.alpha = 0
            self.btnMarket.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5), CGAffineTransformMakeTranslation(80, -25))
            
            }, completion: nil)
    }
    
    
    @IBOutlet weak var btnHotel: UIButton!
    
    @IBOutlet weak var btnMarket: UIButton!
    
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBAction func btnHotelClick(sender: AnyObject) {
        mapReview.removeAnnotations(mapReview.annotations)    // remove already shown pin
        searchMap("hotel")
        Reset()
    }
    
    @IBAction func btnMarketClick(sender: AnyObject) {
        mapReview.removeAnnotations(mapReview.annotations)      // remove already shown pin
        searchMap("market");
        Reset()
    }
    
    @IBAction func btnMenuClick(sender: AnyObject) {
        // click menu, make hotel and market show (transparent and transform)
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            // menu rotate back
            self.btnMenu.transform = CGAffineTransformMakeRotation(0)
            
            // concat = double, 1.5 scale and x y movement
            self.btnHotel.alpha = 1
            self.btnHotel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformMakeTranslation(0, -25))
            
            self.btnMarket.alpha = 1
            self.btnMarket.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformMakeTranslation(0, 0))
            
            }, completion: nil)
    }
    
    
    
    // start map
    @IBOutlet weak var mapReview: MKMapView!

    
    // initial location
    let initialLocation = CLLocation(latitude:30.5816460000,longitude:114.2931260000)
    
    // set search area
    let searchRadius:CLLocationDistance = 4000
    
    
    

    // add pin point
    func addLocation(title:String,latitude:CLLocationDegrees, longtitude:CLLocationDegrees){
        //let location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        //let annotation = MyAnnotation(coordinate: location, title: title)
        //mapReview.addAnnotation(annotation)
    }
    
    // Search
    func searchMap(place:String){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = place
        
        
        // search current area span
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: initialLocation.coordinate, span: span)
        
        // Start Search, save the return reults to array
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response:MKLocalSearchResponse?, error:NSError?) -> Void in
            for item in response!.mapItems {
                self.addLocation(item.name!, latitude: item.placemark.location!.coordinate.latitude, longtitude:  item.placemark.location!.coordinate.longitude)
            }
        }
    }
    
    
    
    
    // original
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnMenu.alpha = 0
        self.btnHotel.alpha = 0
        self.btnMarket.alpha = 0
        
        // make corner smooth
        self.btnHotel.layer.cornerRadius = 10
        self.btnMarket.layer.cornerRadius = 10
        
        // animate showing menu and rotate menu
        UIView.animateWithDuration(1, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.btnMenu.alpha = 1
            self.btnMenu.transform = CGAffineTransformMakeRotation(0.25*3.1415927)
            }, completion: nil)
        
        
        // create a area, coordinate and radius
        let region = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, searchRadius, searchRadius)
        // set show
        mapReview.setRegion(region, animated: true)
        
        searchMap("place");
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}

