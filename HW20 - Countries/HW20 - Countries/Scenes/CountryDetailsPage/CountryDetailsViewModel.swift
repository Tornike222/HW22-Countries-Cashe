//
//  CountryDetailsView.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 26.04.24.
//

import UIKit
import SafariServices

class CountryDetailsViewModel {
    //MARK: - Properties
    private var country: Country?
    
    init(country: Country?) {
        self.country = country
    }
    
    //MARK: - Set Labels and flag
    func updateViewDetails(countryDetailsView: CountryDetailsView , presentingViewController: UIViewController) {
        guard let country = country else { return }
        
        var neighborsList = ""
        
        if let flagUrlString = country.flags.png,
           let flagUrl = URL(string: flagUrlString) {
            countryDetailsView.countryImage.loadImageWith(url: flagUrl)
        }
        
        countryDetailsView.aboutFlagBodyLabel.text = country.flags.alt ?? "We don't have any information about this flag to show"
        
        if let population = country.population {
            countryDetailsView.populationValueLabel.text = "\(Int(population))"
        } else {
            countryDetailsView.populationValueLabel.text = "Unknown"
        }
        
        if let spelling = country.altSpellings?.last {
            countryDetailsView.spellingValueLabel.text = spelling
        } else {
            countryDetailsView.spellingValueLabel.text = "Unknown"
        }
        
        if let capital = country.capital?.last {
            countryDetailsView.capitalValueLabel.text = capital
        } else {
            countryDetailsView.capitalValueLabel.text = "Unknown"
        }
        
        if let area = country.area {
            countryDetailsView.areaValueLabel.text = String(Int(area))
        } else {
            countryDetailsView.areaValueLabel.text = "Unknown"
        }
        
        if let region = country.region {
            if country.name.common?.lowercased() == "Georgia".lowercased() {
                countryDetailsView.regionValueLabel.text = "Europe"
            } else {
                countryDetailsView.regionValueLabel.text = region
            }
        } else {
            countryDetailsView.regionValueLabel.text = "Unknown"
        }
        
        
        //sets neighbors
        if let neighbors = country.borders {
            let lastIndexOfNeighborsArray = neighbors.count - 1
            if lastIndexOfNeighborsArray > 4 {
                for i in 0..<5 {
                    if let neighbor = neighbors[i] {
                        neighborsList += neighbor + " "
                    }
                }
            } else {
                for i in 0...lastIndexOfNeighborsArray {
                    if let neighbor = neighbors[i] {
                        neighborsList += neighbor + " "
                    }
                }
            }
            countryDetailsView.neighborValueLabel.text = neighborsList
        } else {
            countryDetailsView.neighborValueLabel.text = "Unknown"
        }
        
        if let streetMapUrlString = country.maps.openStreetMaps,
           let googleMapUrlString = country.maps.googleMaps{
            countryDetailsView.streetMapButton.addAction(UIAction(handler: { _ in
                openSafariForstreetMap()
            }), for: .touchUpInside)
            
            countryDetailsView.googleMapButton.addAction(UIAction(handler: { _ in
                openSafariForGoogleMap()
            }), for: .touchUpInside)
            
            func openSafariForstreetMap(){
                if let url = URL(string: streetMapUrlString) {
                    let safariViewController = SFSafariViewController(url: url)
                    presentingViewController.present(safariViewController, animated: true)
                }
            }
            
            func openSafariForGoogleMap(){
                if let url = URL(string: googleMapUrlString) {
                    let safariViewController = SFSafariViewController(url: url)
                    presentingViewController.present(safariViewController, animated: true)
                }
            }
        }
    }
}
