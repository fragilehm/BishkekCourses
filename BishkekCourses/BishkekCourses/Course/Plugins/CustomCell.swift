//
//  CustomCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/27/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import UIKit
class CustomCell: UITableViewCell {
    
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            var sizeRation: CGFloat = 1
            if UIDevice.current.userInterfaceIdiom == .pad {
                sizeRation = 0.7
            }
            let newWidth = frame.width * sizeRation // get 50% width here
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space
            super.frame = frame
            
        }
    }
    
}
