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
    var subcategory: String
    var title: String
    var description: String
    var main_image_url: String
    var logo_image_url: String
    var background_image_url: String
    
    
    init() {
        id = 0
        subcategory = ""
        title = ""
        description = ""
        main_image_url = ""
        logo_image_url = ""
        background_image_url = ""
    }
    init(json: JSON) {
        id = json["id"].intValue
        subcategory = json["subcategory"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        main_image_url = json["main_image_url"].stringValue
        logo_image_url = json["logo_image_url"].stringValue
        background_image_url = json["background_image_url"].stringValue
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
