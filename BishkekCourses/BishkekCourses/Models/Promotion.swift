//
//  Promotion.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/13/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import Mapper

struct Promotion: Mappable {
    var id: Int
    var title: String
    var description: String
    var subcategories: [SimpleSubcategory]
    var course: CourseHeader
    var start_date: String
    var end_date: String
    var isActual: Bool
    var action_image: String
    
    init(map: Mapper) throws {
        course = map.optionalFrom("course")!
        subcategories = map.optionalFrom("subcategories") ?? []
        try id = map.from("id")
        try title = map.from("title")
        try description = map.from("description")
        try start_date = map.from("start_date")
        try end_date = map.from("end_date")
        try isActual = map.from("isActual")
        try action_image = map.from("action_image")
    }
}
struct CourseHeader: Mappable {
   
    var id: Int
    var title: String
    var logo_image_url: String
    var main_image_url: String
    var description: String
    init(map: Mapper) throws {
        try id = map.from("id")
        try title = map.from("title")
        try logo_image_url = map.from("logo_image_url")
        try main_image_url = map.from("main_image_url")
        try description = map.from("description")
    }
    
}
