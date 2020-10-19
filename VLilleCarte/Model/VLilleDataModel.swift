//
//  Station.swift
//  VLilleCarte
//
//  Created by Valentin Scheldeman on 04/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//
import Foundation

// MARK: - VLilleData
struct VLilleData: Codable, Identifiable {
    let id = UUID()
    let nhits: Int
    let parameters: Parameters
    let records: [Record]
//    let facetGroups: [FacetGroup]

    enum CodingKeys: String, CodingKey {
        case nhits = "nhits"
        case parameters = "parameters"
        case records = "records"
//        case facetGroups = "facet_groups"
    }
}

// MARK: - Parameters
struct Parameters: Codable {
//    let dataset: Dataset
    let timezone: String
    let rows: Int
    let start: Int
    let format: String
//    let facet: [String]

    enum CodingKeys: String, CodingKey {
//        case dataset = "dataset"
        case timezone = "timezone"
        case rows = "rows"
        case start = "start"
        case format = "format"
//        case facet = "facet"
    }
}
//
//enum Dataset: String, Codable {
//    case vlilleRealtime = "vlille-realtime"
//}
//
// MARK: - Record
struct Record: Codable, Identifiable {
    let id = UUID()
    let recordid: String
    let fields: Fields
    let geometry: Geometry

    enum CodingKeys: String, CodingKey {
        case recordid = "recordid"
        case fields = "fields"
        case geometry = "geometry"
    }
}

// MARK: - Fields
struct Fields: Codable {
    let etat: Etat
    let etatconnexion: Etatconnexion
    let nbvelosdispo: Int
    let nbplacesdispo: Int
    let commune: String
    let type: FieldsType
    let libelle: Int
//    let datemiseajour: Date
    let localisation: [Double]
    let nom: String
    let adresse: String
    let geo: [Double]

    enum CodingKeys: String, CodingKey {
        case etat = "etat"
        case etatconnexion = "etatconnexion"
        case nbvelosdispo = "nbvelosdispo"
        case nbplacesdispo = "nbplacesdispo"
        case commune = "commune"
        case type = "type"
        case libelle = "libelle"
//        case datemiseajour = "datemiseajour"
        case localisation = "localisation"
        case nom = "nom"
        case adresse = "adresse"
        case geo = "geo"
    }
}

enum Etat: String, Codable {
    case enService = "EN SERVICE"
    case horsService = "HORS SERVICE"
}

enum Etatconnexion: String, Codable {
    case connected = "CONNECTED"
    case disconnected = "DISCONNECTED"
}

enum FieldsType: String, Codable {
    case avecTpe = "AVEC TPE"
    case sansTpe = "SANS TPE"
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [Double]

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case coordinates = "coordinates"
    }
}

enum GeometryType: String, Codable {
    case point = "Point"
}
