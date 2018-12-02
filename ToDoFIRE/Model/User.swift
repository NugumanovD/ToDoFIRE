//
//  User.swift
//  ToDoFIRE
//
//  Created by Nugumanov Dmitry on 11/28/18.
//  Copyright © 2018 Nugumanov Dmitry. All rights reserved.
//

import Foundation
import Firebase

struct UserModel {
    let uid: String
    let email: String
    
    init(_ user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
    
}
