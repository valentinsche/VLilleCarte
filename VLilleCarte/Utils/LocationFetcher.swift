//
//  LocationFetcher.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 27/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import Foundation
import CoreLocation


class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    var lastKnownLocationCLLocation: CLLocation?
    
    override init() {
        super.init()
        
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        
        if let coor = lastKnownLocation {
            let lastCoor = CLLocation(latitude: coor.latitude, longitude: coor.longitude)
            
            lastKnownLocationCLLocation = lastCoor
        }
    }
}
