//
//  Post.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/19/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Post {
    let title: String
    let body: String
    let id: String
    let creatorID: String
    let dateCreated: Date?
    
    //create locally
    init(title: String, body: String, creatorID: String, dateCreated: Date? = nil) {
        self.title = title
        self.body = body
        self.creatorID = creatorID
        self.id = UUID().description
        self.dateCreated = dateCreated
    }
    //create remotely
    init?(from dict: [String: Any], id: String) {
        guard let title = dict["title"] as? String,
            let body = dict["body"] as? String,
            let userID = dict["creatorID"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
        
        self.title = title
        self.body = body
        self.creatorID = userID
        self.id = id
        self.dateCreated = dateCreated
    }
    
    var fieldsDict: [String: Any] {
        return [
            "title": self.title,
            "body": self.body,
            "creatorID": self.creatorID
        ]
    }
}
