//
//  TableViewCell.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 21.04.24.
//

import UIKit

class CountriesCell: UITableViewCell {
    //MARK: - UI Components
    let flag: UIImageView = {
        let flag = UIImageView()
        flag.translatesAutoresizingMaskIntoConstraints = false
        flag.layer.cornerRadius = 2
        flag.clipsToBounds = true
        return flag
    }()
    
    let countryLabel: UILabel = {
        let countryLabel = UILabel()
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.textAlignment = .right
        countryLabel.font = UIFont(name: "FiraGO-Regular", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return countryLabel
    }()
    
    //MARK: -  Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
        setSelectionStyle(selected: selected)
        
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.size.height -= 10
            super.frame = frame
        }
    }
    
    //MARK: - Functions
    func setSelectionStyle(selected: Bool){
        selectionStyle = .none
    }
    
    func setupUI() {
        addFlag()
        addCountryLabel()
    }

    
    func addFlag() {
        contentView.addSubview(flag)
        
        NSLayoutConstraint.activate([
            flag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            flag.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            flag.widthAnchor.constraint(equalToConstant: 30),
            flag.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func addCountryLabel() {
        contentView.addSubview(countryLabel)
        
        NSLayoutConstraint.activate([
            countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            countryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
