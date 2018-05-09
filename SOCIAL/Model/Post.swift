//
//  Post.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import ObjectMapper

class Post: Mappable {
    var id = 0
    var userId = 0
    var title: String?
    var body: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        userId <- map["userId"]
        title <- map["title"]
        body <- map["body"]
    }
}
