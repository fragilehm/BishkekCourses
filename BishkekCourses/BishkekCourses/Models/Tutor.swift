//
//  Tutor.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/22/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import Mapper

struct Tutor: Decodable {
    var id: Int
    var subcategories: [SimpleSubcategory]?
    var name: String
    var description: String
    var start_date: String
    var price: String
    var tutor_image: String
    var timetable: String
}
