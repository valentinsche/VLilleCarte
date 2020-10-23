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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vLilleData.records ?? []) { station in
                    StationView(station: station)
                }
            }
            .navigationTitle("Liste des stations")
        }
    }
}

struct StationView: View {
    @State private(set) var station: Record
    @State private(set) var currentLocation: CLLocation?
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(station.fields.nom)
                    Text(station.fields.type.rawValue)
                }
                Spacer()
                VStack(spacing: 5) {
                    Text("\(station.fields.nbvelosdispo)")
                        .frame(maxWidth: 64, alignment: .center)
                        .background(returnColorForAvailableQuantity(for: station.fields.nbvelosdispo))
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                    Text("\(station.fields.nbplacesdispo)")
                        .frame(maxWidth: 64, alignment: .center)
                        .background(returnColorForAvailableQuantity(for: station.fields.nbplacesdispo))
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                    
                }
            }
        }
        .frame(minHeight: 64)
    }
    
    private func returnColorForAvailableQuantity(for quantity: Int) -> Color {
        if quantity > 5 {
            return .green
        } else if quantity < 5 && quantity > 0 {
            return .orange
        } else {
            return .red
        }
    }
}


