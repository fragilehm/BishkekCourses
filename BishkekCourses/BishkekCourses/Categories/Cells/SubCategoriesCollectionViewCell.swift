//
//  SubCategoriesCollectionViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/4/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class SubCategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var subCategoriesImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blurView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func fillCell(subcategory: Subcategory){
        titleLabel.text = subcategory.title
        titleLabel.heroID = "\(subcategory.title)_name"
        titleLabel.heroModifiers = [.beginWith([.zPosition(10), .useGlobalCoordinateSpace])]
        blurView.heroID = "\(subcategory.title)_view"
        blurView.heroModifiers = [.zPosition(5)]
        let url = URL(string: subcategory.subcategory_image_url)
        subCategoriesImageView.kf.setImage(with: url, placeholder: Constants.PLACEHOLDER_IMAGE, options: [], progressBlock: nil, completionHandler: nil)
        subCategoriesImageView.heroID = "\(subcategory.title)_image"
        subCategoriesImageView.heroModifiers = [.zPosition(2)]
    }
}

