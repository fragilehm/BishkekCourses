//
//  Category.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import Mapper

class Category: Mappable {
    var id: Int
    var title: String
    var category_image_url: String
    
    required init(map: Mapper) throws {
        try id = map.from("id")
        try title = map.from("title")
        try category_image_url = map.from("category_image_url")
    }
}

