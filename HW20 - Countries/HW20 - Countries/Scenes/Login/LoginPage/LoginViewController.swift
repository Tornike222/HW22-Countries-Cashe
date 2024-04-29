//
//  LoginViewController.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 26.04.24.
//

import UIKit
import Security


//MARK: - ViewController
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
    func addLoginView() {
        view.addSubview(loginView)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func photoPicker() {
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
            //ეს იფი ამოწმებს ინფუთ ფილდებში შეყვანილი მნიშვნელობების ვალიდურობას, შესაბამისად ფიზიკურად ვერგავიტანდი ამ ლოგიკას ვიუმოდელში
            if self.viewModel.isLoginSucceed(username: self.loginView.userNameInputField.text,
                                             password: self.loginView.passwordInputField.text,
                                             repeatPassword: self.loginView.repeatPasswordInputField.text) {
                
                let countriesVC = CountriesViewController()
                countriesVC.navigationItem.title = "Countries"
                countriesVC.navigationItem.hidesBackButton = true
                self.defaults.set(true, forKey: "isLogged")
                self.defaults.synchronize()
                if let navigationController = self.navigationController { //ნავიგაციის ვარნინგის დასაჰენდლად დამჭირდა
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        countriesVC.loginDidSuccess()
                    }
                    navigationController.navigationBar.prefersLargeTitles = true
                    navigationController.pushViewController(countriesVC, animated: true)
                    navigationController.setViewControllers([countriesVC], animated: true)
                    navigationController.modalPresentationStyle = .fullScreen
                }
            }
        }), for: .touchUpInside)
    }
}

//MARK: - Extensions
extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            loginView.personImage.setImage(image, for: .normal)
            viewModel.addPhoto(image: image.pngData() ?? Data())
        } else if let image = info[.originalImage] as? UIImage {
            loginView.personImage.setImage(image, for: .normal)
            viewModel.addPhoto(image: image.pngData() ?? Data())
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
