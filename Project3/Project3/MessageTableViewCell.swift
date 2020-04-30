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
    
    //part of voteLike
    func stateLike() {
        likeView.isEnabled = false
        dislikeView.isEnabled = false
        likeView.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: UIControl.State.disabled)
    }
    //part of voteDislike
    func stateDislike() {
        likeView.isEnabled = false
        dislikeView.isEnabled = false
        dislikeView.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: UIControl.State.disabled)
    }
    
    private func writeToVotesFile(_ vote: String) {
        do {
            try vote.write(to: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("votes"), atomically: true, encoding: String.Encoding.utf8)
        } catch let err {
            print("Error saving vote: ", err)
        }
    }
    
    @IBAction func voteLike(_ sender: Any) {
        //send like
        if voteMessage(_id, true)
        {
            stateLike()
            writeToVotesFile("," + _id + ",like")
            likeVotes.text = String(Int(likeVotes.text!)! + 1)
        }
    }
    @IBAction func voteDislike(_ sender: Any) {
        //send dislike
        if voteMessage(_id, false)
        {
            stateDislike()
            writeToVotesFile("," + _id + ",dislike")
            dislikeVotes.text = String(Int(dislikeVotes.text!)! + 1)
        }
    }
}
