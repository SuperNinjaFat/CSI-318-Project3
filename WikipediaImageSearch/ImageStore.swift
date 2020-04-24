//
//  ImageStore.swift
//  WikipediaImageSearch
//
//  Created by David Kopec on 4/11/19.
//  Copyright © 2019 David Kopec. All rights reserved.
//

import Foundation

let baseURL = "https://en.wikipedia.org/w/api.php?action=query&format=json&list=allimages&ailimit=100&aifrom="

func getImageURLs(_ query: String, completion: @escaping (Error?, [String]?) -> Void) {
    let searchURL = baseURL + query
    
    guard let refreshURL = URL(string: searchURL) else { return }
    URLSession.shared.dataTask(with: refreshURL) { (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error { // error is nil if there was none
            print("Refresh Error: \(error.localizedDescription)")
            DispatchQueue.main.async {
                completion(error, nil)
            }
            return
        }
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                struct ImageService: Decodable {
                    
                    enum CodingKeys : String, CodingKey {
                        case batchcomplete
                        case cont = "continue"
                        case query
                    }
                    
                    struct ImageInfo: Decodable {
                        let name: String
                        let timestamp: String
                        let url: String
                        let descriptionurl: String
                        let descriptionshorturl: String
                        let ns: Int
                        let title: String
                    }
                    
                    struct Query: Decodable {
                        let allimages: [ImageInfo]
                    }
                    
                    let batchcomplete: String
                    let cont: [String: String]
                    let query: Query
                }
                let imageService = try decoder.decode(ImageService.self, from: data)
                //print(messageService)
                DispatchQueue.main.async {
                    completion(nil, imageService.query.allimages.map {$0.url})
                }
            } catch let err {
                print("Error decoding JSON: ", err)
                DispatchQueue.main.async {
                    completion(err, nil)
                }
            }
        }
        
        }.resume()
}
