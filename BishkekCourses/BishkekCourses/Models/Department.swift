//
//  File.swift
//  BishkekCourses
//
//  Created by Khasanza on 3/28/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//
import Mapper
struct Department: Mappable {
    var title: String
    var description: String
    
    init(map: Mapper) throws {
        try title = map.from("title")
        try description = map.from("description")
    }
}
