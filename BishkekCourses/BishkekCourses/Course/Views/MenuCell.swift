//
//  MenuCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/7/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor(netHex: Colors.LIGHT_BLUE) : UIColor.lightGray
        }
    }
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor(netHex: Colors.LIGHT_BLUE) : UIColor.lightGray
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
