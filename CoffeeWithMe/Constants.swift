//
//  Constants.swift
//  CoffeeWithMe
//
//  Created by Jesselin on 2016/7/10.
//  Copyright © 2016年 JesseLin. All rights reserved.
//

import Foundation

enum UserDefaultsKey {
    static let uid = "uid"
}

enum FirebaseStatus {
    static let missingCredents = -5
    static let accountNoExist = -8
}

enum FirebaseRefKey {
    static let users = "users"
    static let posts = "posts"
    static let likes = "likes"
}