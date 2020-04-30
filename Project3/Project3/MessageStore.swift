//
//  MessageStore.swift
//  Project3
//
//  Created by user167012 on 4/26/20.
//  Copyright © 2020 user167012. All rights reserved.
//

//Code Adapted from Wikipedia Lab
import Foundation

private let file = "votes"
private let key = "7ea3e3a4-3380-4484-bf39-81b1390a27e7"
private let client = "paul.lindberg@mymail.champlain.edu"
private let baseURL = "https://www.stepoutnyc.com/chitchat"//?key=7ea3e3a4-3380-4484-bf39-81b1390a27e7&client=paul.lindberg@mymail.champlain.edu"
var votes: [Vote] = []

//load voted messages from a file
//sub function from getMessageURLs
func getVoteIDs() {
    var wordList = [""]
    do {
        let wordString = try String(contentsOfFile: Bundle.main.path(forResource: file, ofType: "")!)
        wordList = wordString.components(separatedBy: ",")
        wordList.removeFirst()
        for (index, element) in wordList.enumerated() {
            if index % 2 == 0 { //even
                votes.append(Vote(_id: element, vote: nil))
            }
            else { //odd
                let voteBool = String(element.filter { !"\n".contains($0) })
                votes[index-1].vote = voteBool == "like" //OOOh so satisfying
            }
        }
    }
    catch let err {
        print("Error grabbing votes: ", err)
    }
}

//get the vote object of a specific message
//true = like, false = dislike, nil = error
extension Array where Element == Vote {
    func obtainVote(_ _id: String) -> Vote? {
        for index in 0..<votes.count {
            let vote = votes[index]
            if vote._id == _id {
                return vote
            }
        }
        return nil
//        if let vote: Vote = votes[votes.firstIndex(where: { $0._id == _id})!] {
//            return vote
//        }
    }
}

//Adapted from Wikipedia Lab
//transform into get messages
func getMessageURLs(completion: @escaping (Error?, [ChatMessage]?) -> Void) {
    let fullURL = baseURL + "?key=" + key + "&client=" + client + "&limit=20"
    
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
                        let allmessages: [MessageInfo]
                    }
                    
                    let count: Int
                    let date: String
                    let messages: [MessageInfo]
                }
                let messageService = try decoder.decode(MessageService.self, from: data)
                //print(messageService)
                getVoteIDs()
                DispatchQueue.main.async {
                    completion(nil, messageService.messages.map {ChatMessage(_id: $0._id, client: $0.client, date: $0.date, dislikes: $0.dislikes, ip: $0.ip, likes: $0.likes, loc: $0.loc, message: $0.message, vote: votes.obtainVote($0._id)?.vote)})
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

//Code Adapted from https://gist.github.com/dmathewwws/63064a4114fba3769448602208f66c0d
//and https://stackoverflow.com/questions/32064754/how-to-use-stringbyaddingpercentencodingwithallowedcharacters-for-a-url-in-swi
//send message
func sendMessage(_ message: String) -> Bool {
    guard let endpointUrl = URL(string: baseURL) else {
        return false
    }
    //Make JSON to send to send to server
    var request = URLRequest(url: endpointUrl)
    request.httpMethod = "POST"
    let postString = "key=" + key + "&client=" + client + "&message=" + message.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
    request.httpBody = postString.data(using: .utf8)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                return
            }
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    task.resume()
    return true
}

func voteMessage(_ _id: String, _ voteBool: Bool) -> Bool {
    var vote = ""
    if voteBool { vote = "like"} else { vote = "dislike" }
    let fullURL = baseURL + "/" + vote + "/" + _id + "?key=" + key + "&client=" + client
    guard let refreshURL = URL(string: fullURL) else { return false }
    let task = URLSession.shared.dataTask(with: refreshURL)
    task.resume()
    return true
}
