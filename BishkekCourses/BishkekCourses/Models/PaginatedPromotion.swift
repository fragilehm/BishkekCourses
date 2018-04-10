//
//  PaginatedPromotion.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/3/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Mapper

struct PaginatedPromotion: Decodable {
    var count: Int
    var results: [Promotion]
}
