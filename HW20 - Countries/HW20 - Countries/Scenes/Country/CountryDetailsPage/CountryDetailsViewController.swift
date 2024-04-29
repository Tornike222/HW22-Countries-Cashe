//
//  CountryDetailsViewController.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 22.04.24.
//

import UIKit

class CountryDetailsViewController: UIViewController, CountryDetailsViewDelegate {
    //MARK: - Properties
    var country: Country?
    let countryDetailsView = CountryDetailsView()

    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        supportDarkMode()
        countryDetailsView.delegate = self
        addCountryDetailsViewToView()
        countryDetailsView.fetchData()
    }
    
    func addCountryDetailsViewToView() {
        view.addSubview(countryDetailsView)
        setupConstraints()
        countryDetailsView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            countryDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            countryDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countryDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countryDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            supportDarkMode()
        }
    }
    
    //MARK: - Functions
    func supportDarkMode() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        
        countryDetailsView.streetMapButton.setImage(isDarkMode ? UIImage(named: "Group 19") : UIImage(named: "OpenStreetMap"), for: .normal)
        countryDetailsView.googleMapButton.setImage(isDarkMode ? UIImage(named: "Group 18") : UIImage(named: "GoogleMap"), for: .normal)
        
        view.backgroundColor = UIColor.dynamicColor(light: .white, dark: #colorLiteral(red: 0.2392157018, green: 0.2392157018, blue: 0.2392157018, alpha: 1))
    }

    //MARK: - Fetch Data from urls
    func didFetchData() { //გამტარის როლს თამაშობს
        let viewModel = CountryDetailsViewModel(country: country)
        viewModel.updateViewDetails(countryDetailsView: countryDetailsView, presentingViewController: self)
    }
}
