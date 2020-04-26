//
//  MessageStore.swift
//  Project3
//
//  Created by user167012 on 4/26/20.
//  Copyright © 2020 user167012. All rights reserved.
//

//Code Adapted from Wikipedia Lab
import Foundation

let baseURL = "https://www.stepoutnyc.com/chitchat?key=7ea3e3a4-3380-4484-bf39-81b1390a27e7&client=paul.lindberg@mymail.champlain.edu&limit=20"//.php?action=query&format=json&list=allimages&ailimit=100&aifrom="

//Adapted from Wikipedia Lab
//transform into get messages
func getMessageURLs(completion: @escaping (Error?, [ChatMessage]?) -> Void) {
    let fullURL = baseURL
    
    guard let refreshURL = URL(string: fullURL) else { return }
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
                struct MessageService: Decodable {
                    
                    enum CodingKeys : String, CodingKey {
                        case count
                        case date
                        case messages
                    }
                    
                    struct MessageInfo: Decodable {
                        let _id: String
                        let client: String
                        let date: String
                        let dislikes: Int
                        let ip: String
                        let likes: Int
                        let loc: [String?]
                        let message: String
                    }
                    
                    struct Query: Decodable {
                        let allmessages: [MessageInfo]//let allimages: [ImageInfo]
                    }
//
                    let count: Int
                    let date: String
                    let messages: [MessageInfo]//let messages: Query
                }
                let messageService = try decoder.decode(MessageService.self, from: data)
                //print(messageService)
                DispatchQueue.main.async {
                    completion(nil, messageService.messages.map {ChatMessage(_id: $0._id, client: $0.client, date: $0.date, dislikes: $0.dislikes, ip: $0.ip, likes: $0.likes, loc: $0.loc, message: $0.message)})//allmessages.map {$0.message})
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

//send message
func sendMessage(_ message: String) {
    return
}
