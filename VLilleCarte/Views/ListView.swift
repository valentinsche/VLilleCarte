//
//  ListView.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 23/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import SwiftUI

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
    
    var body: some View {
        VStack {
            HStack {
                Text(station.fields.nom)
                Spacer()
                VStack(spacing: 5) {
                    Text("\(station.fields.nbvelosdispo)")
                        .frame(maxWidth: 64, alignment: .center)
                        .background(station.fields.nbvelosdispo > 0 ? Color.green : Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                    Text("\(station.fields.nbplacesdispo)")
                        .frame(maxWidth: 64, alignment: .center)
                        .background(station.fields.nbplacesdispo > 0 ? Color.green : Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)

                }
            }
        }
        .frame(minHeight: 64)
    }
}
