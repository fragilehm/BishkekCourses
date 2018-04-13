//
//  CustomUI.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/12/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customizeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customizeView()
    }
    
    private func customizeView() {
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.8
    }
}
class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 2))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.closePath()
        context.setFillColor(red: 255, green: 255, blue: 255, alpha: 1)
        context.fillPath()
    }
}
