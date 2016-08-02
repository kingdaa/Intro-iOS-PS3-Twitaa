////
////  ComposeViewController.swift
////  Chirpy
////
////  Created by David Melvin on 7/1/16.
////  Copyright © 2016 David Melvin. All rights reserved.
////
//
//import UIKit
//
//class ComposeViewController: UIViewController {
//
//    @IBOutlet weak var inputTextField: UITextView!
//
//    @IBOutlet weak var inputBoxField: UITextField!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    @IBAction func onSend(sender: AnyObject) {
//        let message = self.inputTextField.text
//        print("messsageOut: \(message)")
//
//        TwitterClient.sharedInstance.makeTweet(message!, success: {
//            print("messsageIn: \(message)")
//            }) { (error) in
//                print(error)
//        }
//    }
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
