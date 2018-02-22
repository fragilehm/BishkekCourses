//
//  TutorHeaderView.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/22/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class TutorHeaderView: UIView {
    let headerBackImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "coding").withRenderingMode(.alwaysOriginal)
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headerBackImageView)
        headerBackImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerBackImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        headerBackImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        headerBackImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
