//
//  MapUIView.swift
//  VLilleCarte
//
//  Created by Valentin Scheldeman on 15/09/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import SwiftUI
import MapKit

struct City: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapUIView: View {
    @ObservedObject var vLilleData: VLilleViewModel
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude:  50.6333,
            longitude: 3.0667
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.2,
            longitudeDelta: 0.2
        )
    )
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: vLilleData.pins) { city in
                MapPin(coordinate: city.location, tint: .green)
                
            }
            //            Map(coordinateRegion: $region, annotationItems: vLilleData.pins) { city in
            //                MapAnnotation(
            //                    coordinate: city.location,
            //                    anchorPoint: CGPoint(x: 0.5, y: 0.5)
            //                ) {
            //                    Perform {  debugPrint("This is a toast", city) }
            //                }
            //            }
            //                Map(coordinateRegion: $region, annotationItems: vLilleData.pins ?? [], annotationContent: { pin in
            //                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: 50.6333, longitude: 3.0667), tint: .green)
            //                })
            
        }        
        .navigationBarItems(trailing:
                                
                                Button("toast", action: {
                                    vLilleData.fetchVLilleData()
                                }))
        
        
        
    }
}

extension View {
    func Perform(_ block: () -> Void) -> some View {
        block()
        return EmptyView()
    }
}
