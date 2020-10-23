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
    @State var selectedStation: Pin?
    @State var showingStationDetail = false
    
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
            MapView(vLilleData: vLilleData)
        }
        .edgesIgnoringSafeArea(.all)
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



//            Map(coordinateRegion: $region,
//                interactionModes: MapInteractionModes.all,
//                showsUserLocation: true,
//                userTrackingMode: $userTrackingMode,
//                annotationItems: vLilleData.pins) { city in
//                MapAnnotation(coordinate: city.location) {
//                Image(systemName: "refresh")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 25)
//                            .clipShape(Circle())
//                            .overlay(
//                                Circle().stroke(Color.white, lineWidth: 25/10))
//                            .shadow(radius: 10)
//                    .onTapGesture {
//                        print("city")
//                    }
//                }
