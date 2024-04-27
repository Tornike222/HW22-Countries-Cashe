//
//  CustomUITextField.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 27.04.24.
//

import UIKit

class CustomUITextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    func setupTextField(){
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        
        
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "FiraGO-Medium", size: 13)
        //        textColor = .white
        supportDarkMode()
        layer.masksToBounds = true
        layer.cornerRadius = 20
        leftView = paddingView
        leftViewMode = .always
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            supportDarkMode()
        }
    }
    
    func supportDarkMode(){
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        backgroundColor = isDarkMode ? #colorLiteral(red: 0.2941174507, green: 0.2941178083, blue: 0.3027183115, alpha: 1) :  #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9372549057, alpha: 1)
        
    }
}
