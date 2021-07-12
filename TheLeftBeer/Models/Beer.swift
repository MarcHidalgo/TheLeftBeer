//
//  Beer.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import Foundation

public enum Unit: String, Codable {
    case kilograms = "kilograms"
    case celsius = "celsius"
    case grams = "grams"
    case litres = "litres"
}

public struct Beer: Codable, Identifiable {
    public let id: Int
    let name, description: String
    let imageUrl: String?
    let ibu: Double?
    let ingredients: Ingredients
    let foodPairing: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case name, description
        case imageUrl
        case ibu
        case ingredients
        case foodPairing
    }
}

public struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String
}

public struct Malt: Codable {
    let name: String
    let amount: Measure
}

public struct Hop: Codable {
    let name: String
    let amount: Measure
}

public struct Measure: Codable {
    let value: Double
    let unit: Unit
}

