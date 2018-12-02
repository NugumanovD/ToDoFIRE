//
//  Task.swift
//  ToDoFIRE
//
//  Created by Nugumanov Dmitry on 11/28/18.
//  Copyright © 2018 Nugumanov Dmitry. All rights reserved.
//

import Foundation
import Firebase

struct Task {
    let title: String
    let userID: String
    let ref: DatabaseReference?
    var completed = false
    
    init(title:String, userID: String) {
        self.title = title
        self.userID = userID
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        userID = snapshotValue["userID"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    
    func convertToDictionary() -> Any {
        return ["title": title, "userID": userID, "completed": completed]
    }
}
