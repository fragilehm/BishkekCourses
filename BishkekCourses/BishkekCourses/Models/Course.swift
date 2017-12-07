//
//  Course.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Course {
    var id: Int
    var subcategory: Int
    var title: String
    var description: String
    var contacts: Contacts
    var branches: Branches
    var images: Imagess
    var services: Services
    
    init() {
        id = 0
        subcategory = 0
        title = ""
        description = ""
        contacts = Contacts()
        branches = Branches()
        images = Imagess()
        services = Services()
    }
    init(json: JSON) {
        id = json["id"].intValue
        subcategory = json["subcategory"].intValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        contacts = Contacts(json: json["contacts"])
        branches = Branches(json: json["branches"])
        images = Imagess(json: json["images"])
        services = Services(json: json["services"])
    }
}
class Courses: NSObject {
    var array: Array = Array<Course>()
    override init() {
    }
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Course(json:json)
            array.append(tempObject)
        }
    }
}




