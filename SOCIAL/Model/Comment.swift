//
//  Comment.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/9/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import ObjectMapper

class Comment: Mappable {
    var id = 0
    var postId = 0
    var name: String?
    var email: String?
    var body: String?
    var avatarURL = String(format: "https://d3iw72m71ie81c.cloudfront.net/male-%d.jpg", arc4random_uniform(55)+50)
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        postId <- map["postId"]
        name <- map["name"]
        email <- map["email"]
        body <- map["body"]
    }
}
