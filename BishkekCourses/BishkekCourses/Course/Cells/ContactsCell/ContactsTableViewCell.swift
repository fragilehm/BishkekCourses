//
//  ContactsTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/6/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactTypeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func fillCell(contact: Contact){
        contactLabel.text = contact.contact
        contactImageView.image = getContactIcon(type: contact.type)
        contactTypeLabel.text = contact.type.lowercased()
    }
    func getContactIcon(type: String) -> UIImage {
        return UIImage.init(named: type)!
    }
}
