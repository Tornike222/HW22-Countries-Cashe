//
//  CountriesViewController.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 21.04.24.
//

import UIKit

class CountriesViewController: UIViewController {
    //MARK: - Loading state
    var isLoading = true
    var filteredCountries: [Country] = []
    let searchController = UISearchController(searchResultsController: nil)
    var countriesViewModel = CountriesViewModel()
    
    //MARK: - UI Component
    let countriesTableView: UITableView = {
        let countriesTableView = UITableView()
        countriesTableView.translatesAutoresizingMaskIntoConstraints = false
        countriesTableView.backgroundColor = UIColor.dynamicColor(light: .white, dark: #colorLiteral(red: 0.2392157018, green: 0.2392157018, blue: 0.2392157018, alpha: 1))
        countriesTableView.separatorStyle = .none
        
        return countriesTableView
    }()
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        countriesViewModel.delegate = self
        countriesViewModel.didViewModelSet()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "mic.fill"), for: .bookmark, state: .normal)
        navigationItem.searchController = searchController

        definesPresentationContext = true
    }
    
    func setupUI() {
        addBackgroundColor()
        addCountriesTableView()
    }
    
    func addBackgroundColor() {
        view.backgroundColor = UIColor.dynamicColor(light: .white, dark: #colorLiteral(red: 0.2392157018, green: 0.2392157018, blue: 0.2392157018, alpha: 1))
    }
    
    func addCountriesTableView() {
        view.addSubview(countriesTableView)
        
        NSLayoutConstraint.activate([
            countriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            countriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            countriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            countriesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
        countriesTableView.register(CountriesCell.self, forCellReuseIdentifier: "CountriesCell")
        
    }
    
}

extension CountriesViewController: CountriesViewModelDelegate {
    func navigationToDetailsCV(country: Country) {
        let detailsVC = CountryDetailsViewController()
        detailsVC.modalPresentationStyle = .fullScreen
        detailsVC.country = country
        
        
        navigationController!.navigationBar.prefersLargeTitles = false
        detailsVC.navigationItem.title = country.name.common
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.dynamicColor(light: #colorLiteral(red: 0.2392157018, green: 0.2392157018, blue: 0.2392157018, alpha: 1), dark: .white)]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.dynamicColor(light: #colorLiteral(red: 0.2392157018, green: 0.2392157018, blue: 0.2392157018, alpha: 1), dark: .white)
        
        self.navigationController?.pushViewController(detailsVC, animated: false)
    }
    
    func countriesFetched() {
        countriesTableView.reloadData()
        isLoading = false
    }
    
    func updateFilteredCountries() {
        countriesTableView.reloadData()
    }
}

//MARK: - DataSource Extension and functions
extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  countriesViewModel.countryNumber()

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesCell", for: indexPath) as? CountriesCell
        
        let countryCellViewModel = countriesViewModel.countryTableViewCellViewModel[indexPath.row]

        cell?.flag.loadImageWith(url: countryCellViewModel.flagUrl ?? URL(fileURLWithPath: ""))
        cell?.setNeedsLayout()
        cell?.countryLabel.text = countryCellViewModel.countryName
        cell?.accessoryType = .disclosureIndicator
        cell?.backgroundColor = UIColor.dynamicColor(light: .white, dark:  #colorLiteral(red: 0.2941174507, green: 0.2941178083, blue: 0.3027183115, alpha: 1))
        
        getBorderedLayer(cell: cell!)

        return cell ?? CountriesCell()
    }

    func getBorderedLayer(cell: UITableViewCell) {
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        cell.layer.borderColor = UIColor.lightGray.cgColor
    }
    func loginDidSuccess() {
        let alertController = UIAlertController(title: "გილოცავ 🚀", message: "შენ წარმატებით დალოგინდი, ახლა უკვე შეგიძლია ქვეყნების შესახებ ინფორმაციები შეიმეცნო", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ქო ბატონი", style: .default))
        present(alertController, animated: true)
    }
}

//MARK: - Delegate Extension and functions
extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        !isLoading ? 60 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        countriesViewModel.didSelectRowAt(indexPath: indexPath)
    }
}

extension CountriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        countriesViewModel.filterContentForSearchText(searchText)
    }
}
