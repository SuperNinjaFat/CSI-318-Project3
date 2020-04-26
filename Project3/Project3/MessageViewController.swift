//
//  MessageViewController.swift
//  Project3
//
//  Created by user167012 on 4/25/20.
//  Copyright © 2020 user167012. All rights reserved.
//

import UIKit

private let reuseIdentifier = "imageCell"

class MessageViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {
    var messageURLs: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageTableViewCell
        
            // Configure the cell
            //cell.picView.download(imageURLs[indexPath.row])
        
            return cell
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
