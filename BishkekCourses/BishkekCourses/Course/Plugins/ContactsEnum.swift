//
//  ContactsEnum.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import UIKit
var contactIDs = ["PHONE": 0, "EMAIL": 1, "WEBSITE": 2,
                  "WHATSAPP": 3, "FACEBOOK": 4,]
enum ConatctsEnum: Int {
    case phone = 0
    case email
    case website
    case whatsapp
    case facebook
    func getImage() -> UIImage {
        switch self {
        case .phone:
            return #imageLiteral(resourceName: "phone")
        case .email:
            return #imageLiteral(resourceName: "email")
        case .website:
            return #imageLiteral(resourceName: "website")
        case .whatsapp:
            return #imageLiteral(resourceName: "whatsapp")
        case .facebook:
            return #imageLiteral(resourceName: "facebook")
        }
    }
}
