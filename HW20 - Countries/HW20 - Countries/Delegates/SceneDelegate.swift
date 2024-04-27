//
//  SceneDelegate.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 21.04.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var viewModel = LoginViewModel()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navigationController = viewModel.determineRootViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
