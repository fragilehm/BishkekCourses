//
//  SimpleUniversity.swift
//  BishkekCourses
//
//  Created by Khasanza on 3/28/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//
import Mapper
struct SimpleUniversity: Decodable {
    
    var id: Int
    var title: String
    var categories: [Category]
    var description: String
    var main_image_url: String
    var logo_image_url: String
}
