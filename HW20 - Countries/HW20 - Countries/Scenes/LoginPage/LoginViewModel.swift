//
//  LoginViewModel.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 27.04.24.
//

import UIKit
import Security

protocol LoginViewModelDelegate: AnyObject {
    func loginDidFail(withError error: String)
}

class LoginViewModel: ImagePickerAndCacherDelegate {
    
    func addPhoto(image: UIImage){
        let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentDirectoryPath?.appendingPathComponent("userImage.png")
        
        DispatchQueue.global().async {
           if let imageData = image.pngData() {
                do {
                    try imageData.write(to: fileURL!)
                    print("ფოტო აიტვირთა ფაილის მისამართია \(fileURL!)")
                } catch {
                    print("მოხდა შეცდომა: \(error)")
                }
            }
        }
    }
    
    weak var delegate: LoginViewModelDelegate?
    
    
    func login(username: String?, password: String?, repeatPassword: String?) -> Bool {
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
    
    func determineRootViewController() -> UIViewController {
           if UserDefaults.standard.bool(forKey: "isLogged") {
               let countriesVC = CountriesViewController()
               let navigationController = UINavigationController(rootViewController: countriesVC)
               countriesVC.navigationItem.title = "Countries"
               countriesVC.modalPresentationStyle = .fullScreen
               countriesVC.navigationItem.hidesBackButton = true
               return navigationController
           } else {
               return UINavigationController(rootViewController: LoginViewController())
           }
       }
    
}
