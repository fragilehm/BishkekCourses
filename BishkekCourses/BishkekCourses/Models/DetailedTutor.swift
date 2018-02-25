//
//  DetailedTutor.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/23/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import Mapper
struct DetailedTutor: Mappable {
    var id: Int
    var subcategories: [SimpleSubcategory]
    var name: String
    var description: String
    var contacts: [Contact]
    var branches: [Branch]
    var start_date: String
    var price: String
    var tutor_image: String
    var timetable: String

    init() {
        id = 0
        name = ""
        description = ""
        start_date = ""
        price = ""
        tutor_image = ""
        timetable = ""
        contacts = [Contact]()
        branches = [Branch]()
        subcategories = [SimpleSubcategory]()
    }
    init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
        try description = map.from("description")
        try start_date = map.from("start_date")
        try price = map.from("price")
        try tutor_image = map.from("tutor_image")
        try timetable = map.from("timetable")
        subcategories = map.optionalFrom("subcategories") ?? []
        contacts = map.optionalFrom("contacts") ?? []
        branches = map.optionalFrom("branches") ?? []
    }
}
