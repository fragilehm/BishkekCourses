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
struct SimpleCourse: Decodable {
    var id: Int
    var title: String
    var subcategories: [SimpleSubcategory]
    var description: String
    var main_image_url: String
    var logo_image_url: String
}
struct SimpleSubcategory: Decodable {
    let title: String
    let id: Int
    let subcategory_image_url: String
}

