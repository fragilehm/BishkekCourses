//
//  Category.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Category {
    var id: Int
    var title: String
    var category_image_url: String
    
    init() {
        self.id = 0
        self.title = ""
        category_image_url = ""
    }
    
    init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        category_image_url = json["category_image_url"].stringValue
    }
}

class Categories: NSObject {
    var array: Array = Array<Category>()
    override init() {
    }
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Category(json:json)
            array.append(tempObject)
        }
    }
}


