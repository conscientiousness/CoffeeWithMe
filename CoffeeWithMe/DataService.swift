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
    static let dataService = DataService()
    
    private lazy var rootRef: FIRDatabaseReference = FIRDatabase.database().reference()
    private lazy var postsRef: FIRDatabaseReference = self.rootRef.child("posts")
    private lazy var usersRef: FIRDatabaseReference = self.rootRef.child("users")
    
    private lazy var currentUsersRef: FIRDatabaseReference = {
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultsKey.uid) as! String
        let user = self.usersRef.child(uid)
        return user
    }()
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        usersRef.child(uid).updateChildValues(user)
    }
}