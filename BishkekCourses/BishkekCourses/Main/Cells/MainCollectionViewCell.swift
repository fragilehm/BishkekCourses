//
//  MainCollectionViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/3/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
   //@IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
   //@IBOutlet weak var mainImageHeightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
//        let width = UIScreen.main.bounds.width - 24
//        mainImageHeightConstraint.constant = width - bottomView.frame.size.height
        cardView.layer.cornerRadius = 6
        cardView.layer.masksToBounds = true
    }
}
