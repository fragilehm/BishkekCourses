//
//  ContactsTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/6/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class ContactsTableViewCell: CustomCell {

    @IBOutlet weak var contactLabel: UILabel! {
        didSet {
            contactLabel.textColor = UIColor.init(netHex: Colors.INSTAGRAM_BLUE)
        }
    }
    @IBOutlet weak var contactImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func fillCell(contact: Contact){
      
        contactLabel.text = contact.contact
        contactImageView.image = getContactIcon(type: contact.type)
        
    }
    func getContactIcon(type: String) -> UIImage {
        return UIImage.init(named: type)!
    }
}
