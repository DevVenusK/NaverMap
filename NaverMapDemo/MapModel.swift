//
//  MapModel.swift
//  NaverMapDemo
//
//  Created by 김효성 on 2021/07/09.
//

struct MapModel: Codable {
    let features: [Feature]
}

struct Feature: Codable {
    let type: String
    let properties: Property
    let geometry: GeoMetry
}

struct Property: Codable {
//    let A0: Double
//    let A1: String
//    let A2: String
//    let A3: String
//    let A4: String
//    let A5: String
//    let A6: String
//    let A7: String
//    let A8: String
//    let A9: String
//    let A10: String
//    let A11: String
//    let A12: Double
//    let A13: String
}

struct GeoMetry: Codable {
    let type: String
    let coordinates: [[[Double]]]
}
