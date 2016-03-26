//
//  Tweet.swift
//  Tweeter
//
//  Created by Julia Lau on 3/12/16.
//  Copyright © 2016 Julia Lau. All rights reserved.
//
import UIKit

class Tweet: NSObject {
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var profileImageUrl: NSURL?
    var name: NSString?
    var handle: NSString?
    var tweetID: String
    var profileBannerURL: NSURL?
    var retweeted: Bool
    var favorited: Bool
    var tweetCount: Int?
    var followingCount: Int?
    var followersCount: Int?
    var number: String
    //var number = String?
    
    init(dictionary: NSDictionary) {
        let user = dictionary["user"] as? NSDictionary
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
        tweetID = dictionary["id_str"] as! String
        name = user!["name"] as? String
        number = String(dictionary["id"]!)
        handle = user!["screen_name"] as? String
        retweeted = dictionary["retweeted"] as! Bool
        favorited = dictionary["favorited"] as! Bool
        tweetCount = user!["statuses_count"] as? Int
        followingCount = user!["friends_count"] as? Int
        followersCount = user!["followers_count"] as? Int
        
        let profileImageUrlString = user!["profile_image_url_https"] as? String
        if profileImageUrlString != nil {
            profileImageUrl = NSURL(string: profileImageUrlString!)!
        } else {
            profileImageUrl = nil
        }
        
        let banner = user!["profile_background_image_url_https"] as? String
        if banner != nil {
            profileBannerURL = NSURL(string: banner!)!
        }
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
            
        }
    }
    
    class func tweetsWithArray (dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}



