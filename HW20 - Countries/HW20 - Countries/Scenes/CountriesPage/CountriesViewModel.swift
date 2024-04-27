//
//  CountriesView.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 25.04.24.
//

import UIKit

//MARK: - Protocols
protocol CountriesViewModelDelegate: AnyObject{
    func countriesFetched()
    func navigationToDetailsCV(country: Country)
    func updateFilteredCountries()
}

class CountriesViewModel {
    //MARK: - Properties & delegate
    var filteredCountries: [Country] = []
    var isFilterActive = false
    weak var delegate: CountriesViewModelDelegate?
    
    //MARK: - Functions
    func didViewModelSet() {
        fetchData()
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        delegate?.navigationToDetailsCV(country: countriesArray[indexPath.row])
    }
    
    func countryNumber() -> Int {
        return isFilterActive ? filteredCountries.count : countriesArray.count
    }
    
    func country(on index: IndexPath) -> Country {
        return isFilterActive ? filteredCountries[index.row] : countriesArray[index.row]
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countriesArray
        } else {
            filteredCountries = countriesArray.filter { (country: Country) -> Bool in
                guard let countryName = country.name.common else { return false }
                return countryName.lowercased().hasPrefix(searchText.lowercased())
            }
        }
        delegate?.updateFilteredCountries()
        isFilterActive = true
    }
    
    private func fetchData() {
        let urlString = "https://restcountries.com/v3.1/all"
        NetworkService().getData(urlString: urlString) { (result: [Country]?, Error) in
            countriesArray = result ?? countriesArray
            self.delegate?.countriesFetched()
        }
    }
    
}


