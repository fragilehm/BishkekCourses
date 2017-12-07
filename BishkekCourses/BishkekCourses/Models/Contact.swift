//
//  Contact.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Contact {
    var type: String
    var contact: String
    
    init() {
        type = ""
        contact = ""
    }
    
    init(json: JSON) {
        type = json["type"].stringValue
        contact = json["contact"].stringValue
    }
}

class Contacts: NSObject {
    var array: Array = Array<Contact>()
    override init() {
    }
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Contact(json:json)
            array.append(tempObject)
        }
    }
}



