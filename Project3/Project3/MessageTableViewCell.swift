//
//  MessageTableViewCell.swift
//  Project3
//
//  Created by user167012 on 4/25/20.
//  Copyright © 2020 user167012. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    //@IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var likeVotes: UILabel!
    @IBOutlet weak var dislikeVotes: UILabel!
    @IBOutlet weak var likeView: UIButton!
    @IBOutlet weak var dislikeView: UIButton!
    @IBOutlet weak var userView: UILabel!
    @IBOutlet weak var textView: UITextView!
    var _id = ""
    
    @IBAction func voteLike(_ sender: Any) {
        likeView.isEnabled = false
        dislikeView.isEnabled = false
        likeView.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: UIControl.State.disabled)
        //send like (true)
        voteMessage(_id, true)
        voteThing() { [unowned self] (error, chatMessages) in
                   if error != nil {
                       print(error.debugDescription)
                   }
//                   if let goodMessages = chatMessages {
//                       self.dataSource.messageArray = goodMessages
//                       self.tableView.reloadData()
//                   }
               }
    }
    @IBAction func voteDislike(_ sender: Any) {
        likeView.isEnabled = false
        dislikeView.isEnabled = false
        dislikeView.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: UIControl.State.disabled)
        //send dislike (false)
        voteMessage(_id, false)
        voteThing() { [unowned self] (error, chatMessages) in
            if error != nil {
                print(error.debugDescription)
            }
//            if let goodMessages = chatMessages {
//                self.dataSource.messageArray = goodMessages
//                self.tableView.reloadData()
//            }
        }
    }
    //todo: upvote and downvote buttons
}
