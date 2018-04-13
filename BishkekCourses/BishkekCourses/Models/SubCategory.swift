//
//  SubCategory.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/1/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import Mapper

struct Subcategory: Decodable {
    var id: Int
    var title: String
    var parent: Int?
    var subcategory_image_url: String

}

