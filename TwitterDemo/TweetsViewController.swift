import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet] = [] {
        didSet {
            self.tweetsTableView.reloadData()
        }
    }

    @IBOutlet weak var tweetsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self

        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tweetsTableView.insertSubview(refreshControl, atIndex: 0)

        refreshControlAction(refreshControl)

        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tweetCell = tweetsTableView.dequeueReusableCellWithIdentifier("tweetCell") as! TweetTableViewCell
        tweetCell.tweet = tweets[indexPath.row]
        return tweetCell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.clientInstance.logout()
    }

    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.clientInstance.homeTimeline({
            (tweets: [Tweet]) in
            //set up table view
            //Tweet.tweetsFromArray(tweets)
            self.tweets = tweets
        }) {
            (error: NSError) in
            print("hometimeline error: \(error.localizedDescription)")
        }
        self.tweetsTableView.reloadData()
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "tweetDetailSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tweetsTableView.indexPathForCell(cell)
            let tweet = tweets[indexPath!.row]
            let destinationViewController = segue.destinationViewController as! TweetDetailsViewController
            destinationViewController.tweet = tweet
        }
    }

}
