//
//  Course.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/3/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SimplifiedCourse {
    var id: Int
    var title: String
    var description: String
    var image_url: String
    var is_favorite: Bool
    
    init() {
        self.id = 0
        self.title = ""
        self.description = ""
        self.image_url = ""
        self.is_favorite = false
    }
    
    init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        image_url = json["image_url"].stringValue
        is_favorite = json["is_favorite"].boolValue
    }
}

class SimplifiedCourses: NSObject {
    var array: Array = Array<SimplifiedCourse>()
    override init() {
    }
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = SimplifiedCourse(json:json)
            array.append(tempObject)
        }
    }
}

