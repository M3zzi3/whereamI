//
//  ViewController.swift
//  Where Am I
//
//  Created by remy on 6/7/15.
//  Copyright (c) 2015 LiquidGroup. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //location services
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        self.longitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                println(error)
                
            } else {
                
                if let p = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark){
                    
                    var subThoroughfare:String = ""
                    
                    if p.subThoroughfare != nil {
                        
                        subThoroughfare = p.subThoroughfare
                    }
                    
                    self.addressLabel.text = " \(subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \(p.subAdministrativeArea) \n \(p.postalCode) \(p.country)"
                    
                }
                
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

