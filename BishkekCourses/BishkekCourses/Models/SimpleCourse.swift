//
//  SimpleCourse.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/29/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

//import Moya
//import RxOptional
//import RxSwift
import Mapper
struct SimpleCourse: Mappable {
    
    var id: Int
    var title: String
    var subcategories: [SimpleSubcategory]
    var description: String
    var main_image_url: String
    var logo_image_url: String
    var background_image_url: String
    init(map: Mapper) throws {
        subcategories = map.optionalFrom("subcategories") ?? []
        try id = map.from("id")
        try title = map.from("title")
        try description = map.from("description")
        try main_image_url = map.from("main_image_url")
        try logo_image_url = map.from("logo_image_url")
        try background_image_url = map.from("background_image_url")
    }
}
struct SimpleSubcategory: Mappable {
    let title: String
    let id: Int
    
    init(map: Mapper) throws {
        try title = map.from("title")
        try id = map.from("id")
    }
    
}

