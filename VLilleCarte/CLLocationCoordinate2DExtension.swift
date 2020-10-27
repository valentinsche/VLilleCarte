//
//  CLLocationCoordinate2DExtension.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 27/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    /// Returns distance from coordianate in meters.
    /// - Parameter from: coordinate which will be used as end point.
    /// - Returns: Returns distance in meters.
    func customDistance(from: CLLocation) -> CLLocationDistance {
//        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
        
        let distance = from.distance(from: to)
        
        return distance.rounded(.awayFromZero)
//        return from.distance(from: to)
    }
}

extension CLLocationCoordinate2D {
    /// Returns distance from coordianate in meters.
    /// - Parameter from: coordinate which will be used as end point.
    /// - Returns: Returns distance in meters.
    func customDistance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
        
        let distance = from.distance(from: to)
        
        return distance
    }
}

extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
    
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
