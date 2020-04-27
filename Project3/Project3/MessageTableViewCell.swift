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
        likeVotes.text = String(Int(likeVotes.text!)! + 1)
        //send like
        voteMessage(_id, true)
    }
    @IBAction func voteDislike(_ sender: Any) {
        likeView.isEnabled = false
        dislikeView.isEnabled = false
        dislikeView.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: UIControl.State.disabled)
        dislikeVotes.text = String(Int(dislikeVotes.text!)! + 1)
        //send dislike
        voteMessage(_id, false)
    }
    //todo: upvote and downvote buttons
}
