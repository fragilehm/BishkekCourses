//
//  PaginatedNews.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/13/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
struct PaginatedNews: Decodable {
    var count: Int
    var results: [News]
}
