//
//  SighUpViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 3/2/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class SighUpViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: CustomTextField! {
        didSet {
            nameTextField.layer.borderWidth = 0.5
            nameTextField.layer.borderColor = UIColor.init(netHex: Colors.lightGray).cgColor
            nameTextField.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var emailTextField: CustomTextField! {
        didSet {
            emailTextField.layer.borderWidth = 0.5
            emailTextField.layer.borderColor = UIColor.init(netHex: Colors.lightGray).cgColor
            emailTextField.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var passwordTextField: CustomTextField! {
        didSet {
            passwordTextField.layer.borderWidth = 0.5
            passwordTextField.layer.borderColor = UIColor.init(netHex: Colors.lightGray).cgColor
            passwordTextField.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var passwordRepeatTextField: CustomTextField! {
        didSet {
            passwordRepeatTextField.layer.borderWidth = 0.5
            passwordRepeatTextField.layer.borderColor = UIColor.init(netHex: Colors.lightGray).cgColor
            passwordRepeatTextField.layer.cornerRadius = 4
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
