//
//  CountryDetailsView.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 29.04.24.
//

import UIKit

//MARK: - Protocols
protocol CountryDetailsViewDelegate: AnyObject {
    func didFetchData()
}

class CountryDetailsView: UIView {
    //MARK: - delegates
    weak var delegate: CountryDetailsViewDelegate?
    private var viewModel: CountryDetailsViewModel?

    //MARK: - UI Components
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.dynamicColor(light: .white, dark: #colorLiteral(red: 0.2392157018, green: 0.2392157018, blue: 0.2392157018, alpha: 1))
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.dynamicColor(light: .white, dark: #colorLiteral(red: 0.2392157018, green: 0.2392157018, blue: 0.2392157018, alpha: 1))
        return contentView
    }()
    
    let imageContainerView: UIView = {
        let imageContainerView = UIView()
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.layer.cornerRadius = 15
        imageContainerView.layer.shadowColor = UIColor.black.cgColor
        imageContainerView.layer.shadowRadius = 2.0
        imageContainerView.layer.shadowOpacity = 0.5
        imageContainerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        imageContainerView.layer.masksToBounds = false
        return imageContainerView
    }()
    
    let countryImage: UIImageView = {
        let countryImage = UIImageView()
        countryImage.translatesAutoresizingMaskIntoConstraints = false
        countryImage.layer.cornerRadius = 15
        countryImage.clipsToBounds = true
        return countryImage
    }()
    
    let aboutFlagHeaderLabel: UILabel = {
        let aboutFlagHeaderLabel = UILabel()
        aboutFlagHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutFlagHeaderLabel.font = UIFont(name: "FiraGO-Bold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        aboutFlagHeaderLabel.text =  "About the flag:"
        return aboutFlagHeaderLabel
    }()
    
    let aboutFlagBodyLabel: UILabel = {
        let aboutFlagBodyLabel = UILabel()
        aboutFlagBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutFlagBodyLabel.font = UIFont(name: "FiraGO-Regular", size: 13) ?? UIFont.systemFont(ofSize: 13)
        aboutFlagBodyLabel.numberOfLines = 0
        return aboutFlagBodyLabel
    }()
    
    let lineBetweenFlagAndInfo: UIView = {
        let lineBetweenFlagAndInfo = UIView()
        lineBetweenFlagAndInfo.translatesAutoresizingMaskIntoConstraints = false
        lineBetweenFlagAndInfo.backgroundColor = .lightGray
        return lineBetweenFlagAndInfo
    }()
    
    let basicInfoLabel: UILabel = {
        let basicInfoLabel = UILabel()
        basicInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        basicInfoLabel.font = UIFont(name: "FiraGO-Bold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        basicInfoLabel.text =  "Basic information:"
        return basicInfoLabel
    }()
    
    let populationTitleLabel: UILabel = {
        let populationTitleLabel = UILabel()
        populationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        populationTitleLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        populationTitleLabel.text =  "Population:"
        return populationTitleLabel
    }()
    
    let populationValueLabel: UILabel = {
        let populationValueLabel = UILabel()
        populationValueLabel.translatesAutoresizingMaskIntoConstraints = false
        populationValueLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return populationValueLabel
    }()
    
    let spellingTitleLabel: UILabel = {
        let spellingTitleLabel = UILabel()
        spellingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        spellingTitleLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        spellingTitleLabel.text =  "Spelling:"
        return spellingTitleLabel
    }()
    
    let spellingValueLabel: UILabel = {
        let spellingValueLabel = UILabel()
        spellingValueLabel.translatesAutoresizingMaskIntoConstraints = false
        spellingValueLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return spellingValueLabel
    }()
    
    let capitalTitleLabel: UILabel = {
        let capitalTitleLabel = UILabel()
        capitalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalTitleLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        capitalTitleLabel.text =  "Capital:"
        return capitalTitleLabel
    }()
    
    let capitalValueLabel: UILabel = {
        let capitalValueLabel = UILabel()
        capitalValueLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalValueLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return capitalValueLabel
    }()
    
    let areaTitleLabel: UILabel = {
        let areaTitleLabel = UILabel()
        areaTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        areaTitleLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        areaTitleLabel.text =  "Area:"
        return areaTitleLabel
    }()
    
    let areaValueLabel: UILabel = {
        let areaValueLabel = UILabel()
        areaValueLabel.translatesAutoresizingMaskIntoConstraints = false
        areaValueLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return areaValueLabel
    }()
    
    let regionTitleLabel: UILabel = {
        let regionTitleLabel = UILabel()
        regionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        regionTitleLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        regionTitleLabel.text =  "Region:"
        return regionTitleLabel
    }()
    
    let regionValueLabel: UILabel = {
        let regionValueLabel = UILabel()
        regionValueLabel.translatesAutoresizingMaskIntoConstraints = false
        regionValueLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return regionValueLabel
    }()
    let neighborTitleLabel: UILabel = {
        let neighborTitleLabel = UILabel()
        neighborTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        neighborTitleLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        neighborTitleLabel.text =  "Neighbors:"
        return neighborTitleLabel
    }()
    
    let neighborValueLabel: UILabel = {
        let neighborValueLabel = UILabel()
        neighborValueLabel.translatesAutoresizingMaskIntoConstraints = false
        neighborValueLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return neighborValueLabel
    }()
    
    let lineBetweenNeighborsAndLinks: UIView = {
        let lineBetweenNeighborsAndLinks = UIView()
        lineBetweenNeighborsAndLinks.translatesAutoresizingMaskIntoConstraints = false
        lineBetweenNeighborsAndLinks.backgroundColor = .lightGray
        return lineBetweenNeighborsAndLinks
    }()
    
    let usefulLinksLabel: UILabel = {
        let usefulLinksLabel = UILabel()
        usefulLinksLabel.translatesAutoresizingMaskIntoConstraints = false
        usefulLinksLabel.font = UIFont(name: "FiraGO-Bold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        usefulLinksLabel.text =  "Useful links:"
        return usefulLinksLabel
    }()
    
    let mapsStackView: UIStackView = {
        let mapsStackView = UIStackView()
        mapsStackView.translatesAutoresizingMaskIntoConstraints = false
        mapsStackView.axis = .horizontal
        mapsStackView.alignment = .center
        mapsStackView.distribution = .equalSpacing
        return mapsStackView
    }()
    
    let streetMapButton: UIButton = {
        let streetMapButton = UIButton()
        streetMapButton.translatesAutoresizingMaskIntoConstraints = false
        streetMapButton.setImage(UIImage(named: "OpenStreetMap"), for: .normal)
        return streetMapButton
    }()
    
    let googleMapButton: UIButton = {
        let googleMapButton = UIButton()
        googleMapButton.translatesAutoresizingMaskIntoConstraints = false
        googleMapButton.setImage(UIImage(named: "GoogleMap"), for: .normal)
        return googleMapButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI Functions
    func setupUI() {
        addScrollView()
        addCountryImage()
        addFlagDetailLabels()
        addLineBetweenFlagAndInfo()
        addBasicInfoLabel()
        addPopulationLabels()
        addSpellingLabels()
        addCapitalLabels()
        addAreaLabels()
        addRegionLabels()
        addNeighborsLabels()
        addLineBetweenNeighborsAndLinks()
        addUsefulLinksLabel()
        addMapsStackView()
        addMapsToSV()
    }
    
    func addScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, multiplier: 1.1)
            
        ])
    }
    
    func addCountryImage() {
        contentView.addSubview(imageContainerView)
        imageContainerView.addSubview(countryImage)
        
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.22),
            
            countryImage.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            countryImage.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            countryImage.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            countryImage.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor)
        ])
    }
    
    func addFlagDetailLabels() {
        contentView.addSubview(aboutFlagHeaderLabel)
        contentView.addSubview(aboutFlagBodyLabel)
        
        NSLayoutConstraint.activate([
            aboutFlagHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            aboutFlagHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            aboutFlagHeaderLabel.topAnchor.constraint(equalTo: countryImage.bottomAnchor, constant: 25),
            
            aboutFlagBodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            aboutFlagBodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            aboutFlagBodyLabel.topAnchor.constraint(equalTo: aboutFlagHeaderLabel.bottomAnchor, constant: 15)
        ])
    }
    
    func addLineBetweenFlagAndInfo() {
        contentView.addSubview(lineBetweenFlagAndInfo)
        
        NSLayoutConstraint.activate([
            lineBetweenFlagAndInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            lineBetweenFlagAndInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            lineBetweenFlagAndInfo.topAnchor.constraint(equalTo: aboutFlagBodyLabel.bottomAnchor, constant: 20),
            lineBetweenFlagAndInfo.heightAnchor.constraint(equalToConstant: 1)
            
        ])
    }
    
    func addBasicInfoLabel() {
        contentView.addSubview(basicInfoLabel)
        
        NSLayoutConstraint.activate([
            basicInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            basicInfoLabel.topAnchor.constraint(equalTo: lineBetweenFlagAndInfo.bottomAnchor, constant: 24)
        ])
        
    }
    
    func addPopulationLabels() {
        contentView.addSubview(populationTitleLabel)
        contentView.addSubview(populationValueLabel)
        NSLayoutConstraint.activate([
            populationTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            populationTitleLabel.topAnchor.constraint(equalTo: basicInfoLabel.bottomAnchor, constant: 15),
            populationValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            populationValueLabel.topAnchor.constraint(equalTo: basicInfoLabel.bottomAnchor, constant: 15)
        ])
    }
    
    func addSpellingLabels() {
        contentView.addSubview(spellingTitleLabel)
        contentView.addSubview(spellingValueLabel)
        NSLayoutConstraint.activate([
            spellingTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spellingTitleLabel.topAnchor.constraint(equalTo: populationValueLabel.bottomAnchor, constant: 15),
            spellingValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            spellingValueLabel.topAnchor.constraint(equalTo: populationValueLabel.bottomAnchor, constant: 15)
        ])
    }
    
    func addCapitalLabels() {
        contentView.addSubview(capitalTitleLabel)
        contentView.addSubview(capitalValueLabel)
        NSLayoutConstraint.activate([
            capitalTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            capitalTitleLabel.topAnchor.constraint(equalTo: spellingValueLabel.bottomAnchor, constant: 15),
            capitalValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            capitalValueLabel.topAnchor.constraint(equalTo: spellingValueLabel.bottomAnchor, constant: 15)
        ])
    }
    
    func addAreaLabels() {
        contentView.addSubview(areaTitleLabel)
        contentView.addSubview(areaValueLabel)
        NSLayoutConstraint.activate([
            areaTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            areaTitleLabel.topAnchor.constraint(equalTo: capitalValueLabel.bottomAnchor, constant: 15),
            areaValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            areaValueLabel.topAnchor.constraint(equalTo: capitalValueLabel.bottomAnchor, constant: 15)
        ])
    }
    
    func addRegionLabels() {
        contentView.addSubview(regionTitleLabel)
        contentView.addSubview(regionValueLabel)
        NSLayoutConstraint.activate([
            regionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            regionTitleLabel.topAnchor.constraint(equalTo: areaValueLabel.bottomAnchor, constant: 15),
            regionValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            regionValueLabel.topAnchor.constraint(equalTo: areaValueLabel.bottomAnchor, constant: 15)
        ])
    }
    
    func addNeighborsLabels() {
        contentView.addSubview(neighborTitleLabel)
        contentView.addSubview(neighborValueLabel)
        NSLayoutConstraint.activate([
            neighborTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            neighborTitleLabel.topAnchor.constraint(equalTo: regionValueLabel.bottomAnchor, constant: 15),
            neighborValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            neighborValueLabel.topAnchor.constraint(equalTo: regionValueLabel.bottomAnchor, constant: 15)
        ])
    }
    
    func addLineBetweenNeighborsAndLinks() {
        contentView.addSubview(lineBetweenNeighborsAndLinks)
        
        NSLayoutConstraint.activate([
            lineBetweenNeighborsAndLinks.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            lineBetweenNeighborsAndLinks.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            lineBetweenNeighborsAndLinks.topAnchor.constraint(equalTo: neighborValueLabel.bottomAnchor, constant: 20),
            lineBetweenNeighborsAndLinks.heightAnchor.constraint(equalToConstant: 1)
            
        ])
    }
    
    func addUsefulLinksLabel() {
        contentView.addSubview(usefulLinksLabel)
        NSLayoutConstraint.activate([
            usefulLinksLabel.topAnchor.constraint(equalTo: lineBetweenNeighborsAndLinks.bottomAnchor, constant: 24),
            usefulLinksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            usefulLinksLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func addMapsStackView() {
        contentView.addSubview(mapsStackView)
        NSLayoutConstraint.activate([
            mapsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 69),
            mapsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -69),
            mapsStackView.topAnchor.constraint(equalTo: usefulLinksLabel.bottomAnchor, constant: 15)
            
        ])
    }
    
    func addMapsToSV() {
        mapsStackView.addArrangedSubview(streetMapButton)
        mapsStackView.addArrangedSubview(googleMapButton)
        
        NSLayoutConstraint.activate([
            streetMapButton.heightAnchor.constraint(equalToConstant: 50),
            streetMapButton.widthAnchor.constraint(equalToConstant: 50),
            googleMapButton.heightAnchor.constraint(equalToConstant: 50),
            googleMapButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func fetchData() {
        delegate?.didFetchData()
    }
    
    private func setupViewModel() {
        viewModel = CountryDetailsViewModel(country: nil)
    }
    
}
