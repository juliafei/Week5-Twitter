//
//  NewTweetViewController.swift
//  Tweeter
//
//  Created by Julia Lau on 3/26/16.
//  Copyright © 2016 Julia Lau. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var newTweet: UITextView!
    
    var comTweet: Tweet?
    var replyID: Int?
    var replying: String?
    var profileUrl: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        newTweet.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.tweetContent(newTweet!.text, replyID: replyID, completion: {(success, error) -> () in
            if success != nil {
                
            }
        })
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
