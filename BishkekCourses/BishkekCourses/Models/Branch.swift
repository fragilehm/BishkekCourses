//
//  Branch.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import Mapper

struct Branch: Mappable{
    var address: String
    var latitude: String
    var longitude: String

    init(map: Mapper) throws {
        try address = map.from("address")
        try latitude = map.from("latitude")
        try longitude = map.from("longitude")
    }
}

