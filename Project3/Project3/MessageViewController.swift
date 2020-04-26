//
//  MessageViewController.swift
//  Project3
//
//  Created by user167012 on 4/25/20.
//  Copyright © 2020 user167012. All rights reserved.
//

import UIKit

private let reuseIdentifier = "messageCell"

class MessageViewController: UITableViewController, UISearchBarDelegate {
    var messageURLs: [String] = []
    var imageURLs: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageURLs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageTableViewCell
        
            // Configure the cell
            //cell.picView.download(imageURLs[indexPath.row])
        
            return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        guard let text = searchBar.text else { return }
        getMessageURLs(text) { [unowned self] (error, urls) in
            if error != nil {
                print(error.debugDescription)
            }
            if let goodUrls = urls {
                self.imageURLs = goodUrls
                self.tableView.reloadData()
            }
        }
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
