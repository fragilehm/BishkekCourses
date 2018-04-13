//
//  CategoriesCollectionViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/3/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoriesImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var containerView: UIView! {
//        didSet {
//            containerView.dropShadow()
//        }
//    }
    
    func fillCell(category: Category){
        titleLabel.text = category.title
        let url = URL(string: category.category_image_url)
        categoriesImageView.kf.setImage(with: url, placeholder: Constants.PLACEHOLDER_IMAGE, options: [], progressBlock: nil, completionHandler: nil)
    }
}
