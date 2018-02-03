//
//  CoursesHeaderTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/3/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
protocol BackButtonDelegate : class {
    func back_tapper()
}
class CoursesHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    weak var buttonDelegate: BackButtonDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        let screenHeight = UIScreen.main.bounds.height
            backImageView.heightAnchor.constraint(equalToConstant: screenHeight * 2 / 5).isActive = true
        // Initialization code
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        buttonDelegate?.back_tapper()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func fillCell(imageString: String, title: String){
        self.title.text = title
        let url = URL(string: imageString)
        backImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
        //subCategoriesImageView.kf.setImage(with: url)
    }
}
