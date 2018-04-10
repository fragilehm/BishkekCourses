//
//  DetailedCourse.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/4/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import Mapper
struct DetailedCourse: Decodable {
    var id: Int
    var title: String
    var description: String
    var contacts: [Contact]
    var branches: [Branch]
    var services: [Service]?
    var actions: [SimplePromotion]?
    var departments: [Department]?
    var logo_image_url: String
    var main_image_url: String
    
    init() {
        id = 0
        title = ""
        description = ""
        main_image_url = ""
        logo_image_url = ""
        contacts = [Contact]()
        branches = [Branch]()
        services = [Service]()
        actions = [SimplePromotion]()
        departments = [Department]()
    }
}
