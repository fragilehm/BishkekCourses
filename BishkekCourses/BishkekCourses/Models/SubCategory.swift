//
//  SubCategory.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/1/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import Mapper

class Subcategory: Mappable {
    var id: Int
    var title: String
    var parent: Int
    var subcategory_image_url: String
    
    required init(map: Mapper) throws {
        try id = map.from("id")
        try title = map.from("title")
        try parent = map.from("parent")
        try subcategory_image_url = map.from("subcategory_image_url")
    }
}

