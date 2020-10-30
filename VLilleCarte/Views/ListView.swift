//
//  ListView.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 23/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import SwiftUI
import MapKit

struct ListView: View {
    @ObservedObject private(set) var vLilleData: VLilleViewModel
    
    /* Solution pour le problème d'image dans la navigationBar qui ne suit pas le largeTitle  https://www.hackingwithswift.com/forums/swiftui/icons-in-navigationview-title-apple-messages-style/592
     */
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vLilleData.filteredRecords ?? []) { station in
                    NavigationLink(destination: StationDetailView(station: station)) {
                        StationView(station: station, currentLocation: vLilleData.locationManager.lastKnownLocationCLLocation)
                    }
                }
            }
            .navigationTitle("Liste des stations")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        vLilleData.fetchVLilleData()
                                    }) {
                                        Image(systemName: "arrow.clockwise")
                                            .foregroundColor(.beautifulPink)
                                            .font(.title2)
                                    })
            .navigationBarBackButtonHidden(true)
        }
    }
}


struct StationView: View {
    @State private(set) var station: Record
    @State private(set) var currentLocation: CLLocation?
    
    var body: some View {
        LazyVStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(station.fields.nom).font(.title3)
                    HStack {
                        if station.fields.type.rawValue == "AVEC TPE" {
                            Image("credit-card")
                                .resizable()
                                .foregroundColor(Color.beautifulPink)
                                .frame(width: 20, height: 20)
                                .aspectRatio(contentMode: ContentMode.fit)
                                .font(.title)
                            Text("\(Int(currentLocation?.customDistance(from: station.location) ?? 0) ) m")
                        } else {
                            Text("\(Int(currentLocation?.customDistance(from: station.location) ?? 0) ) m")
                        }
                    }
                }
                Spacer()
                VStack(spacing: 5) {
                    Text("\(station.fields.nbvelosdispo) vélos")
                        .frame(maxWidth: 86, alignment: .center)
                        .background(returnColorForAvailableQuantity(for: station.fields.nbvelosdispo))
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                    Text("\(station.fields.nbplacesdispo) places")
                        .frame(maxWidth: 86, alignment: .center)
                        .background(returnColorForAvailableQuantity(for: station.fields.nbplacesdispo))
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
            }
        }
        .frame(minHeight: 64)
    }
}

extension View {
    func returnColorForAvailableQuantity(for quantity: Int) -> Color {
        if quantity >=  5 {
            return .green
        } else if quantity < 5 && quantity > 0 {
            return .orange
        } else {
            return .beautifulPink
        }
    }
}


