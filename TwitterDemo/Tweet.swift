//
//  Tweet.swift
//  Chirpy
//
//  Created by David Melvin on 6/27/16.
//  Copyright © 2016 David Melvin. All rights reserved.
//

import UIKit
import SwiftDate

class Tweet : NSObject {
    static let TextKey = "text"
    static let RetweetCountKey = "retweet_count"
    static let FavoritesKey = "favourites_count"
    static let TimestampKey = "created_at"
    static let TimestapDateFormat = "EEE MMM d HH:mm:ss Z y"
    static let UserKey = "user"
    static let IDKey = "id_str"
    static let isRetweetedKey = "retweeted"
    static let isFavoritedKey = "favorited"
    
    
    private var tweetDictionary: NSMutableDictionary!
    
    init(dictionary: NSDictionary) {
        super.init()
        tweetDictionary = NSMutableDictionary(dictionary: dictionary)
        //tweetDictionary = dictionary as! NSMutableDictionary
    }
    
    //What is this and should I use an empty NSDictionary here?
    convenience override init() {
        self.init( dictionary: NSDictionary() )
    }
    
    class func tweetsFromArray( tweetsDictionaries: [NSDictionary]) -> [Tweet] {
        return tweetsDictionaries.map( { Tweet(dictionary: $0) } )
    }

    var user : User? {
        get {
            return User(dictionary: tweetDictionary[Tweet.UserKey] as! NSDictionary)
        }
        set(arg) {
            tweetDictionary[Tweet.UserKey] = arg
        }
    }
    var text : String? {
        get {
            return tweetDictionary[Tweet.TextKey] as? String
        }
        set(arg) {
            tweetDictionary[Tweet.TextKey] = arg
        }
    }
    
    var retweetsCount : Int? {
        get {
            return (tweetDictionary[Tweet.RetweetCountKey] as? Int) ?? 0
        }
        set(arg) {
            tweetDictionary[Tweet.RetweetCountKey] = arg
        }
    }
    
    
    var favoritesCount : Int? {
        get {
            return (tweetDictionary[Tweet.FavoritesKey] as? Int) ?? 0
        }
        set(arg) {
            tweetDictionary[Tweet.FavoritesKey] = arg
        }
    }
    
    var timestamp : String? {
        get {
            let timestampUnformatted = tweetDictionary[Tweet.TimestampKey] as? String
            let date: NSDate
            if let timestampUnformatted = timestampUnformatted {
                let formatter = NSDateFormatter()
                formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
                date = formatter.dateFromString(timestampUnformatted)!
                return date.toRelativeString(abbreviated: true, maxUnits: 1)
            }
            else {
                return "long ago"
            }
        }
        set(arg) {
            tweetDictionary[Tweet.TimestampKey] = arg
        }
    }
    var absoluteTimestamp : String? {
        get {
            let timestampUnformatted = tweetDictionary[Tweet.TimestampKey] as? String
            if let timestampUnformatted = timestampUnformatted {
                let formatter = NSDateFormatter()
                formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
                return  formatter.dateFromString(timestampUnformatted)!.toString()
            }
            else {
                return "long ago"
            }
        }
        set(arg) {
            tweetDictionary[Tweet.TimestampKey] = arg
        }
    }
    
    var tweetID : String? {
        get {
            return tweetDictionary[Tweet.IDKey] as? String
        }
    }
    
    var isRetweeted : Bool? {
        get {
            return (tweetDictionary[Tweet.isRetweetedKey] as? Bool) ?? false
        }
        set(arg) {
            tweetDictionary[Tweet.isRetweetedKey] = arg
        }
    }
    
    var isFavorited : Bool? {
        get {
            return (tweetDictionary[Tweet.isFavoritedKey] as? Bool) ?? false
        }
        set(arg) {
            tweetDictionary[Tweet.isFavoritedKey] = arg
        }
    }

}
