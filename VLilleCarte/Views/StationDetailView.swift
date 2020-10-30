//
//  StationDetailView.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 27/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import SwiftUI
import MapKit

struct StationDetailView: View {
    @State private(set) var station: Record
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
            ZStack {
            Map(coordinateRegion: $region)
                .frame(width: .infinity, height: 200, alignment: .center)
                .disabled(true)
                .onAppear(perform: {
                    region.center = CLLocationCoordinate2D(latitude: station.location.coordinate.latitude, longitude: station.location.coordinate.longitude)
                    region.span = MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)
                    
                })
                Image("pin")
                    .resizable()
                    .frame(width: 48, height: 48, alignment: .center)
                    .foregroundColor(Color.beautifulPink)
            }
            Text(station.fields.adresse)
                .padding(.all, 50)
                .font(.title2)
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text(station.fields.nom)
                    if station.fields.type.rawValue == "AVEC TPE" {
                        Image("credit-card")
                            .resizable()
                            .foregroundColor(Color.beautifulPink)
                            .frame(width: 20, height: 20)
                            .aspectRatio(contentMode: ContentMode.fit)
                            .font(.title)
                    }
                }
                .padding(.leading, 15)
                
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
                .padding(.trailing, 15)
            }
            Spacer(minLength: 50)
            Button("Lancer un itinéraire") {
                let url = URL(string: "http://maps.apple.com/maps?saddr=&daddr=\(station.location.coordinate.latitude),\(station.location.coordinate.longitude)")
                UIApplication.shared.open(url!)
            }
            .frame(width: 200, height: 54, alignment: .center)
            .foregroundColor(.white)
            .background(Color.beautifulPink)
            .cornerRadius(16)
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
