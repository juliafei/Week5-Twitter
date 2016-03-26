//
//  TwitterClient.swift
//  Tweeter
//
//  Created by Julia Lau on 3/12/16.
//  Copyright © 2016 Julia Lau. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "5zY5nmHX0mCswMkVCZWOkzAF8", consumerSecret: "I5yFovhPtypHROBtvsAHmaRV5gubQRjl4DskfyeE53OGEc0aNS")
    var loginSuccess: (()-> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: ()-> (), failure: (NSError) -> ()){
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "tweeter://oauth"), scope: nil, success:{ (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
        
        
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success:{ (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAcccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure:{(error: NSError) -> () in
                    self.loginFailure?(error)
            })
            }) { (error: NSError!) -> Void in print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
        
        
    }
    
    

    func homeTimeLine(success: ([Tweet])-> (), failure: (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as? [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries!)
            
            success(tweets)
            },failure:{ (task: NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
        })
        
    }
    
    func tweetContent(tweet: String, replyID: Int?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        
        var params = ["status": tweet]
        if replyID != nil {
            params["in_reply_to_status_id"] = String(replyID)
            
        }
        POST("1.1/statuses/update.json", parameters: params, success: {(operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let tweet = Tweet(dictionary: response as! NSDictionary)
            completion(tweet: tweet, error: nil)
            }) {(operation: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(tweet: nil, error: error)
        }
    }
    
        
    func currentAcccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary!)
            
            success(user)
            
            },failure:{ (task: NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
        })
        
        
    }
    
    func Retweet(num: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/retweet/\(num).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            completion(error: nil)
            print ("RT")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                completion(error: error)
            }
        )
    }
    
    func Favorite(num: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/favorites/create.json?id=\(num)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            completion(error: nil)
            print ("Fav")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                completion(error: error)
            }
            
    
        )}
    
  
    /*
    var loginSuccess: (()-> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: ()-> (), failure: (NSError) -> ()){
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "tweeter://oauth"), scope: nil, success:{ (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
        
        
    }

    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success:{ (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAcccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure:{(error: NSError) -> () in
                    self.loginFailure?(error)
            })
            }) { (error: NSError!) -> Void in print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
        
        
    }

    
    
    func homeTimeLine(success: ([Tweet])-> (), failure: (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as? [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries!)
            
            success(tweets)
            },failure:{ (task: NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
        })
        
    }
    
    func currentAcccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary!)
            
            success(user)
            
            },failure:{ (task: NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
        })
        
        
    }
    
    */
}


