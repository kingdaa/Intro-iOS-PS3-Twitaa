import UIKit

class TweetDetailsViewController: UIViewController {

//    @IBOutlet weak var profileImageView: UIImageView!
//    @IBOutlet weak var usernameLabel: UILabel!
//    @IBOutlet weak var screennameLabel: UILabel!
//    @IBOutlet weak var tweetTextLabel: UILabel!
//    @IBOutlet weak var timestampLabel: UILabel!
//    @IBOutlet weak var retweetCountLabel: UILabel!
//    @IBOutlet weak var likesCountLabel: UILabel!

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!

    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.setImageWithURL(tweet.user!.profileImageURL!)
        usernameLabel.text = tweet.user!.name
        screennameLabel.text = tweet.user!.screenname
        timestampLabel.text = tweet.absoluteTimestamp
        likesCountLabel.text =  "\(tweet.favoritesCount!)"
        retweetCountLabel.text = "\(tweet.retweetsCount!)"
        tweetTextLabel.text = tweet.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onRetweetDetail(sender: AnyObject) {
        if (tweet.isRetweeted == false) {
            TwitterClient.clientInstance.retweet(tweet.tweetID!, params: nil, success: { () in
                print("Successful retweet")

                self.tweet.isRetweeted = true
                self.tweet.retweetsCount! += 1
                self.retweetCountLabel.text = "\(self.tweet.retweetsCount!)"

                }, failure: { (error) in
                    print(error)
            })
        } else {
            TwitterClient.clientInstance.unretweet(tweet.tweetID!, params: nil, success: { () in

                print("successful unretweet")
                self.tweet.isRetweeted = false
                self.tweet.retweetsCount! -= 1
                self.retweetCountLabel.text = "\(self.tweet.retweetsCount!)"


                }, failure: { (error) in
                    print(error)
            })
        }
    }

    @IBAction func onFavoriteDetail(sender: AnyObject) {
        if (tweet.isFavorited == false) {
            TwitterClient.clientInstance.favorite(tweet.tweetID!, params: nil, success: { () in
                self.tweet.isFavorited = true
                self.tweet.favoritesCount! += 1
                self.likesCountLabel.text = "\(self.tweet.favoritesCount!)"
                }, failure: { (error) in
                    print(error)
            })

        } else {
            sender.setImage(UIImage(named: "like-action"), forState: .Normal)

            TwitterClient.clientInstance.unfavorite(tweet.tweetID!, params: nil, success: { () in
                self.tweet.isFavorited = false
                self.tweet.favoritesCount! -= 1
                self.likesCountLabel.text = "\(self.tweet.favoritesCount!)"

                }, failure: { (error) in
                    print(error)
            })

        }
    }

     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.

//        if segue.identifier == "detailProfileSegue" {
//            let user = tweet.user
//            let destinationViewController = segue.destinationViewController as! ProfileViewController
//            destinationViewController.user = user
//        }
     }


}
