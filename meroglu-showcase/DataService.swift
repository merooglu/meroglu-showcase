//
//  DataService.swift
//  meroglu-showcase
//
//  Created by Mehmet Eroğlu on 28.07.2017.
//  Copyright © 2017 Mehmet Eroğlu. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = Database.database().reference()

class DataService {
    static let ds = DataService()
    private var _REF_BASE = URL_BASE
    private var _REF_POSTS = URL_BASE.child("posts")
    private var _REF_USERS = URL_BASE.child("users")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    
    var REF_USER_CURRENT: DatabaseReference {
        let uid = UserDefaults.standard.string(forKey: KEY_UID)
        let user = URL_BASE.child("users").child(uid!)
        return user
    }
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(user)
    }
}
