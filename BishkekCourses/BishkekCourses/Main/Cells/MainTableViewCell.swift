//
//  MainTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/3/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView! {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            favoriteImageView.isUserInteractionEnabled = true
            favoriteImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    var is_selected = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func fillCell(){
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if is_selected {
            self.favoriteImageView.image = UIImage(named: "favorite_unselected")
        }
        else {
            self.favoriteImageView.image = UIImage(named: "favorite_selected")
        }
        is_selected = !is_selected
    }

}
