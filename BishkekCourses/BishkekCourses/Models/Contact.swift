//
//  Contact.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import Mapper

struct Contact: Mappable {
    var type: String
    var contact: String
    
    init(map: Mapper) throws {
        try type = map.from("type")
        try contact = map.from("contact")
    }
}

