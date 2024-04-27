//
//  CountriesResponseModel.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 21.04.24.
//

import Foundation
//MARK: - Models
struct Flag: Codable {
    let png: String?
    let alt: String?
}


struct CountryName: Codable {
    let common: String?
}

struct Map: Codable {
    let googleMaps: String?
    let openStreetMaps: String?
}

struct Country: Codable {
    let flags: Flag
    let name: CountryName
    let population: Double? //Population instead of Native Name
    let altSpellings: [String?]?  //spelling is last index in the array
    let capital: [String?]?
    let area: Double? // Instead of Currency
    let region: String?
    let borders: [String?]?
    let maps: Map
}

//MARK: - Object
var countriesArray = [Country]()
var filteredCountries = [Country]()



