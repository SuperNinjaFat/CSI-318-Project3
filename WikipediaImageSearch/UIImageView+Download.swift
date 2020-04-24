//
//  UIImageView+Download.swift
//  WikipediaImageSearch
//
//  Created by David Kopec on 4/11/19.
//  Copyright © 2019 David Kopec. All rights reserved.
//

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
