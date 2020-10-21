//
//  VLilleViewModel.swift
//  VLilleCarte
//
//  Created by Valentin Scheldeman on 17/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import Foundation
import MapKit

struct Pin: Identifiable {
    var id = UUID()
    var title: String?
    var location: CLLocationCoordinate2D
}

class VLilleViewModel: ObservableObject {
    @Published var stations: VLilleData?
    @Published var records: [Record]?
    @Published var pins: [Pin] = []

    init() {
        stations = nil
        
        fetchVLilleData()
    }
    
    func fetchVLilleData() {
        
        if let url = URL(string: "https://opendata.lillemetropole.fr/api/records/1.0/search/?dataset=vlille-realtime&q=&facet=libelle&facet=nom&facet=commune&facet=etat&facet=type&facet=etatconnexion") {
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(VLilleData.self, from: data)
                    DispatchQueue.main.async {
                        self.stations = response
                        self.records = self.stations?.records
                        response.records.forEach({ station in
                            self.pins.append(Pin(id: UUID(), title: station.fields.nom, location: CLLocationCoordinate2D(latitude: station.geometry.coordinates[1], longitude: station.geometry.coordinates[0])))
                        })
                    }
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
    }
}
