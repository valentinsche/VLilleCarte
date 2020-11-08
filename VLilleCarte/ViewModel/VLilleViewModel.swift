//
//  VLilleViewModel.swift
//  VLilleCarte
//
//  Created by Valentin Scheldeman on 17/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import Foundation
import MapKit
import StoreKit

class Pin: NSObject, Identifiable, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

class VLilleViewModel: ObservableObject {
    @Published private var stations: VLilleData?
    @Published var records: [Record]?
    @Published var pins: [Pin] = []
    @Published var currentLocation: CLLocation?
    @Published var locationManager = LocationFetcher()
    @Published var filteredRecords: [Record]?
    @Published var selectedStation: Record?
    
    init() {
        stations = nil
        
        setupManager()
        checkUserSettings()
        fetchVLilleData()
    }
    
    private func checkUserSettings() {
        if UserDefaults.standard.object(forKey: "ratingCode") != nil {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            UserDefaults.standard.set("rating", forKey: "ratingCode")
        }
    }
    
    func setupManager() {
        locationManager.start()
    }
    
    func fetchVLilleData() {
        if let url = URL(string: "https://opendata.lillemetropole.fr/api/records/1.0/search/?dataset=vlille-realtime&q=&rows=10000&facet=libelle&facet=nom&facet=commune&facet=etat&facet=type&facet=etatconnexion") {
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
                            self.pins.append(Pin(title: station.fields.nom, subtitle: "vélo dispo: \(station.fields.nbvelosdispo) places dispo: \(station.fields.nbplacesdispo)", coordinate: CLLocationCoordinate2D(latitude: station.geometry.coordinates[1], longitude: station.geometry.coordinates[0])))
                        })
                        self.filteredRecords = self.records?.sorted(by: self.locationManager.lastKnownLocationCLLocation ?? CLLocation(latitude: 50.6333, longitude: 3.0667))
                    }
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
    }
}

class HouseAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        configureImage()
        configureView()
        configureAnnotationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HouseAnnotationView {
    func configureImage() {
        let radius: CGFloat = 25
        let center = CGPoint(x: radius, y: radius)
        let rect = CGRect(origin: .zero, size: CGSize(width: 50, height: 60))
        let angle: CGFloat = .pi / 16
        
        let image = UIGraphicsImageRenderer(bounds: rect).image { _ in
            UIColor.white.setFill()
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: .pi / 2 - angle, endAngle: .pi / 2 + angle, clockwise: false)
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.close()
            path.fill()
            
            let configuration = UIImage.SymbolConfiguration(pointSize: 24)
            let house = UIImage(systemName: "bicycle", withConfiguration: configuration)!
                .withTintColor(.blue)
            house.draw(at: CGPoint(x: center.x - house.size.width / 2, y: center.y - house.size.height / 2))
        }
        
        self.image = image
        centerOffset = CGPoint(x: 0, y: -image.size.height / 2) // i.e. bottom center of image is where the point is
    }
    
    func configureView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.5
    }
    
    func configureAnnotationView() {
        canShowCallout = true
    }
}

final class LocationDataMapClusterView: MKAnnotationView {
    
    // MARK: Initialization
    private let countLabel = UILabel()
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let annotation = annotation as? MKClusterAnnotation else {
                assertionFailure("Using LocationDataMapClusterView with wrong annotation type")
                return
            }
            
            countLabel.text = annotation.memberAnnotations.count < 100 ? "\(annotation.memberAnnotations.count)" : "99+"
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        displayPriority = .defaultHigh
        collisionMode = .circle
        
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupUI() {
        
    }
}
