//
//  Tutor.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/22/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import Mapper

struct Tutor: Mappable {
    
    var id: Int
    var subcategories: [SimpleSubcategory]
    var name: String
    var description: String
    var start_date: String
    var price: String
    var tutor_image: String
    var timetable: String
    init(map: Mapper) throws {
        try id = map.from("id")
        subcategories = map.optionalFrom("subcategories") ?? []
        try name = map.from("name")
        try description = map.from("description")
        try start_date = map.from("start_date")
        try price = map.from("price")
        try tutor_image = map.from("tutor_image")
        try timetable = map.from("timetable")
    }
}
