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
            
            if let selected = selectedPin?.first {
                parent.selectedStation = selected
                parent.vLilleData.selectedStation = selected
                if self.parent.selectedStation != nil {
                parent.showingStationDetailView = true
                }
            }
        }
    }
}

