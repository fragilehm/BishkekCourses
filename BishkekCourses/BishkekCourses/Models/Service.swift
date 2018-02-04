//
//  Service.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//
import Foundation
import Mapper

struct Service: Mappable {
    var title: String
    var description: String
    var price: Int
    
    init(map: Mapper) throws {
        try title = map.from("title")
        try description = map.from("description")
        try price = map.from("price")
    }
}
