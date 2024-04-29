//
//  LoginViewModel.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 27.04.24.
//

import Foundation
import Security

//MARK: - Protocols
protocol LoginViewModelDelegate: AnyObject {
    func loginDidFail(withError error: String)
}

//MARK: - ViewModel
class LoginViewModel {
    
    //MARK: - Properties
    weak var delegate: LoginViewModelDelegate?
    
    //MARK: - Functions
    func addPhoto(image: Data){
        let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentDirectoryPath?.appendingPathComponent("userImage.png")
        
        DispatchQueue.global().async {
            do {
                try image.write(to: fileURL!)
                print("ფოტო აიტვირთა ფაილის მისამართია \(fileURL!)")
            } catch {
                print("მოხდა შეცდომა: \(error)")
            }
        }
    }
    
    func isLoginSucceed(username: String?, password: String?, repeatPassword: String?) -> Bool {
        guard let username = username,
              let password = password?.data(using: .utf8),
              let repeatPassword = repeatPassword?.data(using: .utf8)
        else {
            delegate?.loginDidFail(withError: "იუზერნეიმის ან პაროლების ფილდები არის ცარიელი")
            return false
        }
        if password == repeatPassword, username.count != 0, password.count != 0 {
            let attributes: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: username,
                kSecValueData as String: password,
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
            ]
            
            let status = SecItemAdd(attributes as CFDictionary, nil)
            if status == errSecSuccess {
                return true
            } else {
                if status == -25299 {
                    delegate?.loginDidFail(withError: "ასეთი იუზერი უკვე არსებობს")
                }
                delegate?.loginDidFail(withError: "Key Chain ში ინფორმაციის დამახსოვრებისას მოხდა შეცდომა. Status: \(status)")
            }
        } else {
            delegate?.loginDidFail(withError: "შეყვანილი პაროლები არ ემთხვევა ერთმანეთს ან ყველა ინფორმაცია არ არის  შევსებული")
        }
        return false
    }
    
    func determineRootViewController() -> AnyObject {
        if UserDefaults.standard.bool(forKey: "isLogged") {//ეს შეცვალე და პირველი გვერდიდან დაგაწყებინებს. თუ ქეშიდან გინდა წააკითხო ინფო isLogged ჩაუწერე ქიში
            let countriesVC = CountriesViewController()
            countriesVC.navigationItem.title = "Countries"
            countriesVC.modalPresentationStyle = .fullScreen
            countriesVC.navigationItem.hidesBackButton = true
            return countriesVC
        } else {
            return LoginViewController()
        }
    }
    
}
