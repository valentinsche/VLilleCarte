//
//  MapView.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 23/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject var vLilleData: VLilleViewModel
    @State private var centerCoordinate = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude:  50.6333,
            longitude: 3.0667
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.25,
            longitudeDelta: 0.25
        )
    )
    
    @Binding var selectedStation: Record?
    @Binding var showingStationDetail: Bool
    @Binding var showingStationDetailView: Bool
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = centerCoordinate
        mapView.mapType = .satelliteFlyover
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        if vLilleData.pins.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(vLilleData.pins)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            let selectedPin = parent.vLilleData.records?.filter({ $0.fields.nom == view.annotation?.title })
            
            self.parent.selectedStation = selectedPin?.first
        }
    }
}

//
//extension MKPointAnnotation {
//    static var example: MKPointAnnotation {
//        let annotation = MKPointAnnotation()
//        annotation.title = "London"
//        annotation.subtitle = "Home to the 2012 Summer Olympics."
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
//        return annotation
//    }
//}

//struct City: Identifiable {
//    let id = UUID()
//    let coordinate: CLLocationCoordinate2D
//}
//
//struct MapView: UIViewRepresentable {
//    @ObservedObject var vLilleData: VLilleViewModel
//    @Binding var selectPlace: Record?
//    @Binding var showingStationDetail: Bool
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(
//            latitude:  50.6333,
//            longitude: 3.0667
//        ),
//        span: MKCoordinateSpan(
//            latitudeDelta: 0.25,
//            longitudeDelta: 0.25
//        )
//    )
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let identifier = "Stationmark"
//
//        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//
//        annotationView.canShowCallout = true
//        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//
//        return annotationView
//    }
//
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        guard let placemark = view.annotation as? MKMarkerAnnotationView else { return }
//
////        self.selectPlace =
//        self.showingStationDetail = true
//    }
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//
//        vLilleData.setupManager()
//
//        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow
//        mapView.mapType = .satelliteFlyover
//        mapView.setRegion(region, animated: true)
//
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        uiView.addAnnotations(vLilleData.pins)
//    }
//}
