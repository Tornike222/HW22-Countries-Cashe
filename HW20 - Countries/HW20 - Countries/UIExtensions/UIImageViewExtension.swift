//
//  UIImageViewExtension.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 26.04.24.
//

import UIKit

//MARK: - Extension for Load Image
extension UIImageView {
    func loadImageWith(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
}
