//
//  PaginatedTutor.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/3/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Mapper

struct PaginatedTutor: Decodable {
    var count: Int
    var results: [Tutor]
}
