//
//  Photo.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/9/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import ObjectMapper

class Photo : Mappable {
    var id = 0
    var albumId = 0
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        albumId <- map["albumId"]
        title <- map["title"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
    }
}
