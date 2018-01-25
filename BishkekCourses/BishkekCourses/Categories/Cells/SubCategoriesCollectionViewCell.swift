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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 5
        cardView.layer.masksToBounds = true
    }
    func fillCell(subcategory: SubCategory){
        titleLabel.text = subcategory.title
        let url = URL(string: subcategory.subcategory_image_url)
         subCategoriesImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
        //subCategoriesImageView.kf.setImage(with: url)
    }
}

