//
//  TweetCell.swift
//  Tweeter
//
//  Created by Julia Lau on 3/13/16.
//  Copyright © 2016 Julia Lau. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    //Label
    @IBOutlet weak var pictureLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    //Button
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var id: String = ""
    
    var tweet: Tweet!
        {
        didSet{
            pictureLabel.setImageWithURL(tweet.profileImageUrl!)
            nameLabel.text = tweet.name as? String
            handleLabel.text = "@\(tweet.handle as! String)"
            bodyLabel.text = tweet.text as? String
            retweetCountLabel.text = "\(tweet.retweetCount)"
            favoriteCountLabel.text = "\(tweet.favoriteCount)"
            
            id = tweet.number
            
        }
    }
    
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.Retweet(Int(id)!, params: nil, completion: {(error) -> () in
            self.retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
            self.retweetCountLabel.text = String(self.tweet.retweetCount + 1)
        })
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.Favorite(Int(id)!, params: nil, completion: {(error) -> () in
            self.favoriteButton.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            self.favoriteCountLabel.text = String(self.tweet.favoriteCount + 1)
        })
        
    }
    
    func getTime(time: NSTimeInterval) -> String
    {
        var givenT = -Int(time)
        var calculatedT: Int = 0
        
        print("timegiven: \(givenT)")
        
        if givenT == 0{
            return "Now"
        }
        else if givenT <= 60{
            return "\(givenT)s"
        }
        else if (givenT/60 <= 60){
            calculatedT = givenT/60
            return "\(calculatedT)m"
        }
        else if (givenT/3600 <= 24){
            calculatedT = givenT/3600
            return "\(calculatedT)h"
        }
        else if (givenT/(3600*24) <= 365){
            calculatedT = givenT/(3600*24)
            return "\(calculatedT)d"
        }
        else{
            calculatedT = givenT/(3600*24*365)
            return "\(calculatedT)y"
        }
        return "\(calculatedT)"
    }
    
    
    override func awakeFromNib() {
        //  weak var usernameLabel: UILabel!
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}