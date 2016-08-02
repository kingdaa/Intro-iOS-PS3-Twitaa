//
//  TwitterClient.swift
//  Chirpy
//
//  Created by David Melvin on 6/27/16.
//  Copyright © 2016 David Melvin. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let clientInstance = TwitterClient(baseURL: NSURL(string:
        "https://api.twitter.com"), consumerKey: "Xm9OggywIteN6R8HfGCAiguxn", consumerSecret: "NKS0dUUt66VAQpUfEXNi0wWAGDN7hpxanMw67aQhYk7EK6U9WW")

    var loginSucess : (() -> ())?
    var loginFailure: ((NSError) -> ())?

    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSucess = success
        loginFailure = failure

        TwitterClient.clientInstance.deauthorize()
        TwitterClient.clientInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string:"twitaa://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) in
            print("I got a token")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize/?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
        }) { (error: NSError!) in
            print(error.localizedDescription)
            self.loginFailure?(error)

        }
    }

    func logout() {
        User.currentUser = nil
        deauthorize()

        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }

    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        TwitterClient.clientInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in

            self.currentAccount({ (user: User) in
                User.currentUser = user
                self.loginSucess?()
                }, failure: { (error: NSError) in
                    self.loginFailure?(error)
            })

        }) { (error: NSError!) in
            print("Handle open Url error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }

    func myFunc(_: Tweet) -> () {
        print("Thanks for calling me")
    }

    func retweet(tweetId: String, params: NSDictionary?, success: () -> (), failure: (error: NSError?) -> () ) {


        POST("1.1/statuses/retweet.json?id=\(tweetId)", parameters: params, success: { (task: NSURLSessionDataTask, reponse: AnyObject?) in
            success()

            }, failure: { (task: NSURLSessionDataTask?, error: NSError!) in
                failure(error: error)

        })
    }

    func unretweet(tweetId: String, params: NSDictionary?, success: () -> (), failure: (error: NSError?) -> () ) {


        POST("1.1/statuses/unretweet.json?id=\(tweetId)", parameters: params, success: { (task: NSURLSessionDataTask, reponse: AnyObject?) in
            print("unretweet complete")
            success()

            }, failure: { (task: NSURLSessionDataTask?, error: NSError!) in
                failure(error: error)

        })
    }

    func favorite(tweetId: String, params: NSDictionary?, success: () -> (), failure: (error: NSError?) -> () ) {


        POST("1.1/favorites/create.json?id=\(tweetId)", parameters: params, success: { (task: NSURLSessionDataTask, reponse: AnyObject?) in
            success()
            print("favorite POST complete")


            }, failure: { (task: NSURLSessionDataTask?, error: NSError!) in
                failure(error: error)

        })
    }

    func unfavorite(tweetId: String, params: NSDictionary?, success: () -> (), failure: (error: NSError?) -> () ) {

        POST("1.1/favorites/destroy.json?id=\(tweetId)", parameters: params, success: { (task: NSURLSessionDataTask, reponse: AnyObject?) in
            success()
            print("unfavorite POST complete")


            }, failure: { (task: NSURLSessionDataTask?, error: NSError!) in
                print(error)

        })
    }

    func makeTweet(message: String, success: (() -> ()), failure: (error: NSError?) -> () ) {
        var dict = NSDictionary()
        dict = ["status": message]
        POST("1.1/statuses/update.json", parameters: dict, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            success()
        }) { (task: NSURLSessionDataTask?, error: NSError) in
            failure(error: error)
        }
    }

    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in

            let tweetDictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsFromArray(tweetDictionaries)
            success(tweets)

            }, failure: {(task: NSURLSessionDataTask?, error: NSError) in
                failure(error)

        })
    }

    func userTimeline(userId: String, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/user_timeline.json?id=\(userId)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in

            let tweetDictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsFromArray(tweetDictionaries)
            success(tweets)

            }, failure: {(task: NSURLSessionDataTask?, error: NSError) in
                failure(error)

        })
    }

    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters:  nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in

            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            success(user)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
                print(error.localizedDescription)
        })
    }
}
