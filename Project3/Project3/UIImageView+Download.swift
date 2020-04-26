//
//  UIImageView+Download.swift
//  Project3
//
//  Created by user167012 on 4/26/20.
//  Copyright © 2020 user167012. All rights reserved.
//

//Adapted from Wikipedia Lab
import UIKit

extension UIImageView {
    func download(_ url: String) {
        guard let imageURL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error { // error is nil if there was none
                print("Image Download Error: \(error.localizedDescription)")
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            
        }.resume()
    }
}
