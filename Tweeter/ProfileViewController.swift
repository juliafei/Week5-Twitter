//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Julia Lau on 3/26/16.
//  Copyright © 2016 Julia Lau. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var profileTweet: Tweet!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.setImageWithURL(profileTweet.profileImageUrl!)
        nameLabel.text = profileTweet.name as String?
        handleLabel.text = "@\(profileTweet.handle!)"
        tweetsCountLabel.text = "\(profileTweet.tweetCount!)"
        followingCountLabel.text = "\(profileTweet.followingCount!)"
        followersCountLabel.text = "\(profileTweet.followersCount!)"
        headerImage.setImageWithURL(profileTweet.profileBannerURL!)
    

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
