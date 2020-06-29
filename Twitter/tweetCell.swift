//
//  tweetCell.swift
//  Twitter
//
//  Created by Andrés Aguilar on 6/25/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var liked: Bool = false
    var tweetID: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setLiked(_ isLiked: Bool) {
        
        liked = isLiked
        if liked {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        if isRetweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func likeTweet(_ sender: Any) {
        if !liked {
            TwitterAPICaller.client?.likeTweet(tweetID: tweetID, success: {
                self.setLiked(true)
            }, failure: { (error) in
                print("Like did not succeed: \(error)")
            })
        }
        else {
            TwitterAPICaller.client?.unlikeTweet(tweetID: tweetID, success: {
                self.setLiked(false)
            }, failure: { (error) in
                print("Un-Like did not succeed: \(error)")
            })
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Retweeting did not succeed: \(error)")
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
