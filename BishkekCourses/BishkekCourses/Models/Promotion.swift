//
//  Promotion.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/13/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import Mapper

struct Promotion: Decodable {
    var id: Int
    var title: String
    var description: String
    var subcategories: [SimpleSubcategory]
    var course: CourseHeader
    var start_date: String?
    var end_date: String?
    var isActual: Bool?
    var action_image: String
}
struct SimplePromotion: Decodable {
    var id: Int
    var title: String
    var description: String
    var end_date: String?
    var action_image: String
    init(id: Int, title: String, description: String, end_date: String, action_image: String) {
        self.id = id
        self.title = title
        self.action_image = action_image
        self.end_date = end_date
        self.description = description
    }
}
struct CourseHeader: Decodable {
   
    var id: Int
    var title: String
    var logo_image_url: String
    var main_image_url: String
    var description: String
    init(id: Int, title: String, logo_image_url: String, main_image_url: String, description: String) {
        self.id = id
        self.title = title
        self.main_image_url = main_image_url
        self.logo_image_url = logo_image_url
        self.description = description
    }
//    init(map: Mapper) throws {
//        try id = map.from("id")
//        try title = map.from("title")
//        try logo_image_url = map.from("logo_image_url")
//        try main_image_url = map.from("main_image_url")
//        try description = map.from("description")
//    }
    
}
