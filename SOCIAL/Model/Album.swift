//
//  Album.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/9/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import ObjectMapper

class Album : Mappable {
    var id = 0
    var userId = 0
    var title: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        userId <- map["userId"]
        title <- map["title"]
    }
}
