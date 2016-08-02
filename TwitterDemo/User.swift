import UIKit

class User: NSObject {

    static let userDidLogoutNotification = "UserDidLogout"
    static let ScreennameKey = "screen_name"
    static let UserNameKey = "name"
    static let ProfileImageUrlKey = "profile_image_url_https"
    static let TaglineKey = "description"
    static let followersCountKey = "followers_count"
    static let followingCountKey = "friends_count"
    static let locationKey = "location"
    static let profileBanneyKey = "profile_banner_url"
    static let tweetCountKey = "statuses_count"
    static let userIDKey = "id_str"

    var mutableDict: NSMutableDictionary!

    convenience override init() {
        self.init( dictionary: NSMutableDictionary())
    }

    init(dictionary: NSDictionary) {
        super.init()
        mutableDict = dictionary as? NSMutableDictionary
    }

    var id: String? {
        get {
            return mutableDict[User.userIDKey] as? String
        }
    }

    var name: String? {
        get {
            return mutableDict[User.UserNameKey] as? String
        }
        set(arg) {
            mutableDict[User.UserNameKey] = arg
        }
    }

    var screenname: String? {
        get {
            return mutableDict[User.ScreennameKey] as? String
        }
        set(arg) {
            mutableDict[User.ScreennameKey] = arg
        }
    }

    var tagline: String? {
        get {
            return mutableDict[User.TaglineKey] as? String
        }
        set(arg) {
            mutableDict[User.TaglineKey] = arg
        }
    }

    var profileImageURL: NSURL? {
        get {
            if let string = mutableDict[User.ProfileImageUrlKey] as? String {
                return NSURL(string: string)
            } else {
                return nil
            }
        }
        set(arg) {
            mutableDict[User.ProfileImageUrlKey] = arg
        }
    }

    var profileBannerImageURL: NSURL? {
        get {
            if let string = mutableDict[User.profileBanneyKey] as? String {
                return NSURL(string: string)
            } else {
                //use a default background image
                return NSURL(string: "https://pbs.twimg.com/profile_banners/6253282/1431474710/mobile_retina")
            }
        }
    }

    var location: String? {
        get {
            return mutableDict[User.locationKey] as? String
        }

    }

    var followersCount: Int {
        get {
            return (mutableDict[User.followersCountKey] as? Int)!
        }
    }

    var follwingCount: Int {
        get {
            return (mutableDict[User.followingCountKey] as? Int)!
        }
    }

    var tweetCount: Int {
        get {
            return (mutableDict[User.tweetCountKey] as? Int)!
        }
    }

    static var _currentUser: User?

    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user

            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.mutableDict!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData'")
            }

            defaults.synchronize()

        }
    }
}
