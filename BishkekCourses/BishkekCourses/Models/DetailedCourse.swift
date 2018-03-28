//
//  DetailedCourse.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/4/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import Mapper
struct DetailedCourse: Mappable {
    var id: Int
    var subcategories: [SimpleSubcategory]
    var title: String
    var description: String
    var contacts: [Contact]
    var branches: [Branch]
    var services: [Service]
    var actions: [SimplePromotion]
    var departments: [Department]
    var main_image_url: String
    var logo_image_url: String
    init() {
        id = 0
        title = ""
        description = ""
        main_image_url = ""
        logo_image_url = ""
        contacts = [Contact]()
        branches = [Branch]()
        services = [Service]()
        subcategories = [SimpleSubcategory]()
        actions = [SimplePromotion]()
        departments = [Department]()

    }
    init(map: Mapper) throws {
        try id = map.from("id")
        try title = map.from("title")
        try description = map.from("description")
        try main_image_url = map.from("main_image_url")
        try logo_image_url = map.from("logo_image_url")
        subcategories = map.optionalFrom("subcategories") ?? []
        contacts = map.optionalFrom("contacts") ?? []
        branches = map.optionalFrom("branches") ?? []
        services = map.optionalFrom("services") ?? []
        actions = map.optionalFrom("actions") ?? []
        departments = map.optionalFrom("departments") ?? []


    }
}
