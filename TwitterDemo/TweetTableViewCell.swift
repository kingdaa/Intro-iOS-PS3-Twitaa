import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var relativeTimestampLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var profileImageButton: UIButton!

    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            userNameLabel.text = tweet.user!.name
            screennameLabel.text = "@\(tweet.user!.screenname!)"
            profileImage.setImageWithURL(tweet.user!.profileImageURL!)
            relativeTimestampLabel.text = tweet.timestamp
            likesLabel.text =  "\(tweet.favoritesCount!)"
            retweetsLabel.text = "\(tweet.retweetsCount!)"
        }
    }

    @IBAction func onRetweet(sender: AnyObject) {
        print("tweetID: \(tweet.tweetID)")
        print("isretweeted: \(tweet.isRetweeted)")

        if (tweet.isRetweeted == false) {
            TwitterClient.clientInstance.retweet(tweet.tweetID!, params: nil, success: { () in
                print("Successful retweet")

                self.tweet.isRetweeted = true
                self.tweet.retweetsCount! += 1
                self.retweetsLabel.text = "\(self.tweet.retweetsCount!)"

                }, failure: { (error) in
                    print(error)
            })
        } else {
            TwitterClient.clientInstance.unretweet(tweet.tweetID!, params: nil, success: { () in
                print("successful unretweet")
                self.tweet.isRetweeted = false
                self.tweet.retweetsCount! -= 1
                self.retweetsLabel.text = "\(self.tweet.retweetsCount!)"
                }, failure: { (error) in
                    print(error)
            })
        }
    }

    @IBAction func onFavorite(sender: UIButton) {

        print("isFavorited: \(tweet.isFavorited)")
        if (tweet.isFavorited == false) {
            TwitterClient.clientInstance.favorite(tweet.tweetID!, params: nil, success: { () in
                    self.tweet.isFavorited = true
                    self.tweet.favoritesCount! += 1
                    self.likesLabel.text = "\(self.tweet.favoritesCount!)"
                }, failure: { (error) in
                    print(error)
            })

        } else {
            sender.setImage(UIImage(named: "like-action"), forState: .Normal)

            TwitterClient.clientInstance.unfavorite(tweet.tweetID!, params: nil, success: { () in
                self.tweet.isFavorited = false
                self.tweet.favoritesCount! -= 1
                self.likesLabel.text = "\(self.tweet.favoritesCount!)"

                }, failure: { (error) in
                    print(error)
            })

        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
