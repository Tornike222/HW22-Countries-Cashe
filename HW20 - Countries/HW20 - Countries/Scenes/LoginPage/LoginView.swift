//
//  LoginView.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 26.04.24.
//

import UIKit
import Security

protocol ImagePickerAndCacherDelegate: AnyObject {
    func addPhoto(image: UIImage)

}


//MARK: - LoginView
class LoginView: UIView {
    
    let personImage: UIButton = {
        let personImage = UIButton()
        personImage.translatesAutoresizingMaskIntoConstraints = false
        personImage.layer.cornerRadius =  65
        personImage.layer.masksToBounds = true

        return personImage
    }()
    
    let userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.text = "მომხმარებლის სახელი"
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return userNameLabel
    }()
    
    let userNameInputField: CustomUITextField = {
       let userNameInputField = CustomUITextField()
        userNameInputField.placeholder = "შეიყვანეთ მომხმარებლის სახელი"
        return userNameInputField
    }()
    
    let passwordLabel: UILabel = {
        let passwordLabel = UILabel()
        passwordLabel.text = "პაროლი"
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return passwordLabel
    }()
    
    let passwordInputField: CustomUITextField = {
       let passwordInputField = CustomUITextField()
        passwordInputField.placeholder = "შეიყვანეთ პაროლი"
        passwordInputField.isSecureTextEntry = true
        return passwordInputField
    }()
    
    let repeatPasswordLabel: UILabel = {
        let repeatPasswordLabel = UILabel()
        repeatPasswordLabel.text = "გაიმეორეთ პაროლი"
        repeatPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return repeatPasswordLabel
    }()
    
    let repeatPasswordInputField: CustomUITextField = {
       let repeatPasswordInputField = CustomUITextField()
        repeatPasswordInputField.placeholder = "განმეორებით შეიყვანეთ პაროლი"
        repeatPasswordInputField.isSecureTextEntry = true
        return repeatPasswordInputField
    }()
    
    let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("შესვლა", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = #colorLiteral(red: 0.2199608386, green: 0.5323753953, blue: 1, alpha: 1)
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 20
        return loginButton
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addPersonImageToView()
        supportDarkMode()
        addUsernameUIComponents()
        addPasswordToView()
        addRepeatPasswordToView()
        addLoginButton()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) { // darkmodes live rejimshi  chveneba
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            supportDarkMode()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPersonImageToView(){
        addSubview(personImage)
        
        NSLayoutConstraint.activate([
            personImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            personImage.topAnchor.constraint(equalTo: topAnchor, constant: 110),
            personImage.heightAnchor.constraint(equalToConstant: 132),
            personImage.widthAnchor.constraint(equalToConstant: 132)
        ])
    }
    
    
    
    func supportDarkMode(){
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        
        personImage.setImage(isDarkMode ? UIImage(named: "DarkPerson") : UIImage(named: "LightPerson"), for: .normal)
        backgroundColor = UIColor.dynamicColor(light: .white, dark: #colorLiteral(red: 0.2392157018, green: 0.2392157018, blue: 0.2392157018, alpha: 1))
    }
    
    func addUsernameUIComponents() {
        addSubview(userNameLabel)
        addSubview(userNameInputField)
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            userNameLabel.topAnchor.constraint(equalTo: personImage.bottomAnchor, constant: 47),
            userNameInputField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 6),
            userNameInputField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            userNameInputField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            userNameInputField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func addPasswordToView() {
        addSubview(passwordLabel)
        addSubview(passwordInputField)
        NSLayoutConstraint.activate([
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            passwordLabel.topAnchor.constraint(equalTo: userNameInputField.bottomAnchor, constant: 31),
            passwordInputField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 6),
            passwordInputField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            passwordInputField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            passwordInputField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func addRepeatPasswordToView() {
        addSubview(repeatPasswordLabel)
        addSubview(repeatPasswordInputField)
        NSLayoutConstraint.activate([
            repeatPasswordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            repeatPasswordLabel.topAnchor.constraint(equalTo: passwordInputField.bottomAnchor, constant: 31),
            repeatPasswordInputField.topAnchor.constraint(equalTo: repeatPasswordLabel.bottomAnchor, constant: 6),
            repeatPasswordInputField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            repeatPasswordInputField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            repeatPasswordInputField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func addLoginButton() {
        addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            loginButton.topAnchor.constraint(equalTo: repeatPasswordInputField.bottomAnchor, constant: 50),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
}

class LoginViewController: UIViewController {
    let loginView = LoginView()
    let viewModel = LoginViewModel()
    let defaults = UserDefaults.standard
    

    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        addLoginView()
        photoPicker()
        loginButtonTapped()
        viewModel.delegate = self
    }
    
    //MARK: - Functions
    func addLoginView(){
        view.addSubview(loginView)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func photoPicker(){
        loginView.personImage.addAction(UIAction(handler: { _ in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
        }), for: .touchUpInside)
    }
    
    
    func loginButtonTapped() {
        loginView.loginButton.addAction(UIAction(handler: { _ in
            if
                (self.viewModel.login(username: self.loginView.userNameInputField.text,
                            password: self.loginView.passwordInputField.text,
                            repeatPassword: self.loginView.repeatPasswordInputField.text)
            ) {
                let countriesVC = CountriesViewController()
                self.navigationController?.navigationBar.prefersLargeTitles = true
                countriesVC.navigationItem.title = "Countries"
                countriesVC.modalPresentationStyle = .fullScreen
                countriesVC.navigationItem.hidesBackButton = true
                self.navigationController?.pushViewController(countriesVC, animated: true)
                countriesVC.loginDidSuccess()
                self.defaults.set(true, forKey: "isLogged")
                self.defaults.synchronize()
            }
        }), for: .touchUpInside)
    }

    func addPhoto(image: UIImage){
        let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentDirectoryPath?.appendingPathComponent("userImage.png")
        
        DispatchQueue.global().async {
           if let imageData = image.pngData() {
            do {
                try imageData.write(to: fileURL!)
            } catch {
                print("Error saving image: \(error)")
            }
        } else {
            print("Error converting UIImage to Data")
        }
        }
    }
    
}

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            loginView.personImage.setImage(image, for: .normal)
            addPhoto(image: image)
        } else if let image = info[.originalImage] as? UIImage {
            loginView.personImage.setImage(image, for: .normal)
            addPhoto(image: image)
        }
        dismiss(animated: true)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func loginDidFail(withError error: String) {
        let alertController = UIAlertController(title: "დაფიქსირდა შეცდომა", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "გასაგებია", style: .default))
        present(alertController, animated: true)
    }
}
