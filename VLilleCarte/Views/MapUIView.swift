//
//  MapUIView.swift
//  VLilleCarte
//
//  Created by Valentin Scheldeman on 15/09/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import SwiftUI
import MapKit

struct MapUIView: View {
    @ObservedObject var vLilleData: VLilleViewModel
    @State private var region = MKCoordinateRegion(
           center: CLLocationCoordinate2D(
               latitude:  50.6333,
               longitude: 3.0667
           ),
           span: MKCoordinateSpan(
               latitudeDelta: 10,
               longitudeDelta: 10
           )
       )
    
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $region, annotationItems: vLilleData.) { 
                }
//            List {
//                ForEach(vLilleData.stations?.records ?? []) { station in
//                    VStack {
//                        Text(station.fields.nom)
//                        HStack {
//                            Text("\(station.geometry.coordinates[0]) \(station.geometry.coordinates[1])")
//                        }
//                    }
//                }
//            }
            }
            .navigationBarItems(trailing:
                                    Button("Help") {
                                        vLilleData.fetchVLilleData()
                                    })
        }
    }
}

