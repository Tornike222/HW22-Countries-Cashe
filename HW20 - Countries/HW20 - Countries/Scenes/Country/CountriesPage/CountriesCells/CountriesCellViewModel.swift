//
//  CountriesCellViewModel.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 29.04.24.
//

import Foundation

class CountriesCellViewModel {
    private var country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var flagUrl: URL? {
        URL(string: country.flags.png ?? "")
    }
    
    var countryName: String {
        country.name.common ?? ""
    }
}
