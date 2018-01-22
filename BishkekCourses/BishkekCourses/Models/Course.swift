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
    var subcategory: String
    var title: String
    var description: String
    var contacts: Contacts
    var branches: Branches
    var services: Services
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
        contacts = Contacts()
        branches = Branches()
        services = Services()
    }
    init(json: JSON) {
        id = json["id"].intValue
        //subcategory = json["subcategories"].stringValue
        subcategory = ""
        title = json["title"].stringValue
        description = json["description"].stringValue
        contacts = Contacts(json: json["contacts"])
        branches = Branches(json: json["branches"])
        main_image_url = json["main_image_url"].stringValue
        logo_image_url = json["logo_image_url"].stringValue
        background_image_url = json["background_image_url"].stringValue
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




