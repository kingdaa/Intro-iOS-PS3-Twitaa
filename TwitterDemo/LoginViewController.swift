//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Qin Huang on 7/29/16.
//  Copyright © 2016 kingdaa. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginButton(sender: AnyObject) {
        TwitterClient.clientInstance.login({() ->  () in
            print("login successful")
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }) { (error: NSError) in
            print("Login error: \(error.localizedDescription)")
        }

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
