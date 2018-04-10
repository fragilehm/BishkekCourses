//
//  DetailedTutor.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/23/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import Mapper
struct DetailedTutor: Decodable {
    var id: Int
    var subcategories: [SimpleSubcategory]?
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
        subcategories = [SimpleSubcategory]()
        name = ""
        description = ""
        contacts = [Contact]()
        branches = [Branch]()
        start_date = ""
        price = ""
        tutor_image = ""
        timetable = ""
    }
}
