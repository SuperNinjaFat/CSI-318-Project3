//
//  ChatViewController.swift
//  Project3
//
//  Created by user167012 on 4/26/20.
//  Copyright © 2020 user167012. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userTextView: UITextView!
    var dataSource = GenericDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Adapted from Wikipedia Lab
        //grab messages
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
    
    @IBAction func sendButton(_ sender: Any) {
        guard let text = userTextView.text else { return }
        sendMessage(text)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
