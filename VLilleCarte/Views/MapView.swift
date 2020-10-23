//
//  MapView.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 23/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import SwiftUI
import MapKit

struct City: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapView: UIViewRepresentable {
    @ObservedObject var vLilleData: VLilleViewModel
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude:  50.6333,
            longitude: 3.0667
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.25,
            longitudeDelta: 0.25
        )
    )
    
    var locationManager = CLLocationManager()
    
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        annotationView.canShowCallout = false
        annotationView.subtitleVisibility = .adaptive
        return annotationView
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        setupManager()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.mapType = .satelliteFlyover
        mapView.setRegion(region, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.addAnnotations(vLilleData.pins)
    }
}
