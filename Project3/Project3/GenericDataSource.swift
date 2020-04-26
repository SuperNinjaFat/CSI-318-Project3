//
//  GenericDataSource.swift
//  Project3TableViewSplit
//
//  Created by user167012 on 4/26/20.
//  Copyright © 2020 user167012. All rights reserved.
//
import UIKit

//Code Adapted from https://stackoverflow.com/questions/43319029/what-is-the-best-way-to-make-a-reusable-tableview-for-different-screens-in-the-s
class GenericDataSource: NSObject {

let reuseIdentifier = "messageCell"
var messageArray: [ChatMessage] = []

func registerCells(forTableView tableView: UITableView) {
    tableView.register(UINib(nibName: "", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
  }

func loadCell(atIndexPath indexPath: IndexPath, forTableView tableView: UITableView) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    return cell
  }
}

// UITableViewDataSource
extension GenericDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageTableViewCell
        
        // Configure the cell
        cell.textView.text = messageArray[indexPath.row].message//cell.picView.download(imageURLs[indexPath.row])
        cell.userView.text = messageArray[indexPath.row].client
        cell.likeVotes.text = String(messageArray[indexPath.row].likes)
        cell.dislikeVotes.text = String(messageArray[indexPath.row].dislikes)
        return cell//return self.loadCell(atIndexPath: indexPath, forTableView: tableView)
    }

}
// UITableViewDelegate
extension GenericDataSource: UITableViewDelegate {

        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)      {
//            return UITableView.automaticDimension
        }
}
protocol GenericDataSourceDelegate: class {
            // Delegate callbacks methods
}
