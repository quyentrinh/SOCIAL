//
//  Person.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import ObjectMapper

class Person: Mappable {
    
    var id = 0
    var name: String?
    var userName: String?
    var email: String?
    var phone: String?
    var avatarURL = String(format: "https://d3iw72m71ie81c.cloudfront.net/male-%d.jpg", arc4random_uniform(50)+1)
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        userName <- map["username"]
        email <- map["email"]
        phone <- map["phone"]
    }
    

}
