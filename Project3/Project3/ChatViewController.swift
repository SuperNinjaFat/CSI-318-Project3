//
//  ChatViewController.swift
//  Project3
//
//  Created by user167012 on 4/26/20.
//  Copyright © 2020 user167012. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
private let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userTextView: UITextView!
    var dataSource = GenericDataSource()

    //Adapted from Wikipedia Lab
    //grab messages
    func refresh() {
        getMessageURLs() { [unowned self] (error, chatMessages) in
            if error != nil {
                print(error.debugDescription)
            }
            if let goodMessages = chatMessages {
                self.dataSource.messageArray = goodMessages
                self.tableView.reloadData()
            }
        }
        self.tableView.delegate = self.dataSource
        self.tableView.dataSource = self.dataSource
    }
    @objc func refreshSub(_ refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Refresh Control to Table View
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshSub(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        //grab messages
        refresh()
        
    }
    
    @IBAction func sendButton(_ sender: Any) {
        guard let text = userTextView.text else { return }
        sendMessage(text)
        refresh()
    }
}
