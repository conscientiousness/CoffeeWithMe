//
//  DataService.swift
//  CoffeeWithMe
//
//  Created by Jesselin on 2016/7/9.
//  Copyright © 2016年 JesseLin. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let shared = DataService()
    
    lazy var baseRef: FIRDatabaseReference = FIRDatabase.database().reference()
    lazy var postsRef: FIRDatabaseReference = self.baseRef.child(FirebaseRefKey.posts)
    lazy var usersRef: FIRDatabaseReference = self.baseRef.child(FirebaseRefKey.users)
    
    lazy var currentUsersRef: FIRDatabaseReference = {
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultsKey.uid) as! String
        let user = self.usersRef.child(uid)
        return user
    }()
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        NSUserDefaults.standardUserDefaults().setValue(uid, forKey: UserDefaultsKey.uid)
        usersRef.child(uid).updateChildValues(user)
    }
}