//
//  TweetsDetailViewController.swift
//  Tweeter
//
//  Created by Julia Lau on 3/26/16.
//  Copyright © 2016 Julia Lau. All rights reserved.
//

import UIKit

class TweetsDetailViewController: UIViewController {
    
    
    //Labels
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    //Buttons
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    
    var detailedTweet: Tweet!
    var id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.setImageWithURL(detailedTweet.profileImageUrl!)
        handleLabel.text = String(detailedTweet.handle!)
        nameLabel.text = String(detailedTweet.name!)
        bodyLabel.text = String(detailedTweet.text)
        retweetCountLabel.text = String(detailedTweet.retweetCount)
        favoriteCountLabel.text = String(detailedTweet.favoriteCount)
        // Do any additional setup after loading the view.
        
        id = detailedTweet.number
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.Retweet(Int(id)!, params: nil, completion: {(error) -> () in
            self.retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
            self.retweetCountLabel.text = String(self.detailedTweet.retweetCount + 1)
        })
        
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.Favorite(Int(id)!, params: nil, completion: {(error) -> () in
            self.favoriteButton.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            self.favoriteCountLabel.text = String(self.detailedTweet.favoriteCount + 1)
        })
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "profileSegue" {
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.profileTweet = detailedTweet
            
            print("Profile segue preparation called")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
