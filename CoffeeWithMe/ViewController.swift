//
//  ViewController.swift
//  CoffeeWithMe
//
//  Created by Jesselin on 2016/7/8.
//  Copyright © 2016年 JesseLin. All rights reserved.
//

import UIKit
import Firebase
import Darwin

class ViewController: UIViewController {

    var email: String?
    var pwd: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initObservers()
    }
    
    func initObservers() {
        
        DataService.shared.postsRef.observeEventType(.Value, withBlock: { snapshot in
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {

                for snap in snapshots {
                    print("SNAP:\(snap)")
                    let key = snap.key
                    
                    //create relationship to user
                    let userPostsRef = DataService.shared.currentUsersRef.child(FirebaseRefKey.posts).child(key)
                    userPostsRef.setValue(true)
                }
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func emailLogingPressed(sender: UIButton!) {
        
        email = "test@testing.com"
        pwd = "1234567"
        
        //Make sure there is an email and a password
        if let email = email where email != "", let pwd = pwd where pwd != "" {
            FIRAuth.auth()?.createUserWithEmail(email, password: pwd, completion: { (user, error) in
                if error != nil {
                    
                } else {
                    NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: UserDefaultsKey.uid)
                        //Store what type of account this is
                        let userData = ["provider": "email"]
                        DataService.shared.createFirebaseUser(user!.uid, user: userData)
                }
            })
        }
    }
    
    @IBAction func postToFirebase(sender: UIButton!) {
        
        let post: Dictionary<String, AnyObject> = [
            "title": "This is title with random number(\(arc4random_uniform(999)))",
            "description": "test...",
            "likes": Int(arc4random_uniform(999))
        ]
        
        //Save new post
        let fbPost = DataService.shared.postsRef.childByAutoId()
        fbPost.setValue(post)
    }
}

