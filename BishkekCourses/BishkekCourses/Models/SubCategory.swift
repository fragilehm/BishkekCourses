//
//  SubCategory.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SubCategory {
    var id: Int
    var title: String
    var parent: Int
    var subcategory_image_url: String
    
    init() {
        self.id = 0
        self.title = ""
        parent = 0
        subcategory_image_url = ""
    }
    
    init(json: JSON) {
        id = json["id"].intValue
        parent = json["parent"].intValue
        title = json["title"].stringValue
        subcategory_image_url = json["subcategory_image_url"].stringValue
    }
}

class SubCategories: NSObject {
    var array: Array = Array<SubCategory>()
    override init() {
    }
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = SubCategory(json:json)
            array.append(tempObject)
        }
    }
}



