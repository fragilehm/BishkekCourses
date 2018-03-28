//
//  SimpleUniversity.swift
//  BishkekCourses
//
//  Created by Khasanza on 3/28/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//
import Mapper
struct SimpleUniversity: Mappable {
    
    var id: Int
    var title: String
    var categories: [Category]
    var description: String
    var main_image_url: String
    var logo_image_url: String
    init(map: Mapper) throws {
        categories = map.optionalFrom("categories") ?? []
        try id = map.from("id")
        try title = map.from("title")
        try description = map.from("description")
        try main_image_url = map.from("main_image_url")
        try logo_image_url = map.from("logo_image_url")
    }
}
