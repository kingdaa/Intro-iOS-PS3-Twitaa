////
////  ProfileViewController.swift
////  Chirpy
////
////  Created by David Melvin on 6/30/16.
////  Copyright © 2016 David Melvin. All rights reserved.
////
//
//import UIKit
//
//class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var userNameLabel: UILabel!
//    @IBOutlet weak var screennameLabel: UILabel!
//    @IBOutlet weak var userTaglineLabel: UILabel!
//    @IBOutlet weak var locationLabel: UILabel!
//    @IBOutlet weak var followingCountLabel: UILabel!
//    @IBOutlet weak var followersCountLabel: UILabel!
//    @IBOutlet weak var tweetsCountLabel: UILabel!
//    @IBOutlet weak var profileImageView: UIImageView!
//    @IBOutlet weak var profileBannerImageView: UIImageView!
//
//    @IBOutlet weak var profileTweetsTableView: UITableView!
//
//    var user : User?
//    //var tweets : [Tweet]? = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.profileTweetsTableView.delegate = self
//        self.profileTweetsTableView.dataSource = self
//        self.profileTweetsTableView.estimatedRowHeight = 100
//        self.profileTweetsTableView.rowHeight = UITableViewAutomaticDimension
//
//        if user == nil {
//            user = User.currentUser
//        }
//
//        userNameLabel.text = user?.name
//        screennameLabel.text = "@\(user!.screenname!)"
//        userTaglineLabel.text = user?.tagline
//        tweetsCountLabel.text = "\(user!.tweetCount)"
//        followersCountLabel.text = "\(user!.followersCount)"
//        followingCountLabel.text = "\(user!.follwingCount)"
//        locationLabel.text = user!.location
//        profileImageView.setImageWithURL((user?.profileImageURL)!)
//        profileBannerImageView.setImageWithURL((user?.profileBannerImageURL)!)
//        //!! what if there is no URL?
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (user?.tweetCount)!
//    }
//
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = profileTweetsTableView.dequeueReusableCellWithIdentifier("profileTweetCellReuseIdentifier", forIndexPath: indexPath) as! TweetTableViewCell
//
//        TwitterClient.sharedInstance.userTimeline(user!.id!, success: { (tweets: [Tweet]) in
//            cell.tweet = tweets[indexPath.row]
//        }) { (error: NSError) in
//            print(error)
//        }
//
//
//        return cell
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
