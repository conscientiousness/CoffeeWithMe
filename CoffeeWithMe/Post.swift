//
//  Post.swift
//  CoffeeWithMe
//
//  Created by Jesselin on 2016/7/10.
//  Copyright © 2016年 JesseLin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Post {
    private var postDescription: String?
    private var imageUrl: String?
    private var likes: Int = 0
    private var username: String?
    private var postKey: String!
    private var postRef: FIRDatabaseReference?
    
    init(description: String?, imageUrl: String?, username: String) {
        self.postDescription = description
        self.imageUrl = imageUrl
        self.username = username
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self.postKey = postKey
        
        if let likes = dictionary["likes"] as? Int {
            self.likes = likes
        }
        
        if let imgUrl = dictionary["imageUrl"] as? String {
            self.imageUrl = imgUrl
        }
        
        if let desc = dictionary["description"] as? String {
            self.postDescription = desc
        }
        
        self.postRef = DataService.shared.postsRef.child(self.postKey)
    }
    
    func adjustLikes(addLike: Bool) {

        if addLike {
            likes = likes + 1
        } else {
            likes = likes - 1
        }
        
        //Save the new total likes to firebase
        if let postRef = postRef {
            postRef.child("likes").setValue(likes)
        }
    }
}
