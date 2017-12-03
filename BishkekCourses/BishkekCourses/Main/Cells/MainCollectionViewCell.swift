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
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 6
        cardView.layer.masksToBounds = true
    }
}
