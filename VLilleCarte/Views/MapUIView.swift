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
    @State var selectedStation: Record? = nil
    @State var showingStationDetail = false
    @State var showingStationDetailView = false
    
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
        NavigationView {
            VStack {
                MapView(vLilleData: vLilleData, selectedStation: $selectedStation, showingStationDetail: $showingStationDetail, showingStationDetailView: $showingStationDetailView)
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        vLilleData.fetchVLilleData()
                                    }) {
                                        Image(systemName: "arrow.clockwise")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    })
            .sheet(isPresented: $showingStationDetailView) {
                if let data = vLilleData.selectedStation {
                    StationDetailView(station: data)
                }
            }
        }
    }
}

extension View {
    func Perform(_ block: () -> Void) -> some View {
        block()
        return EmptyView()
    }
}
