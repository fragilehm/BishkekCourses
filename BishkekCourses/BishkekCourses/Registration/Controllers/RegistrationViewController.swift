//
//  RegistrationViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/3/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var surnameTextField: CustomTextField! {
        didSet {
            surnameTextField.layer.borderWidth = 1
            surnameTextField.layer.borderColor = UIColor.init(netHex: Colors.DARK_PURPLE).cgColor
        }
    }
    @IBOutlet weak var nameTextField: CustomTextField! {
        didSet {
            nameTextField.layer.borderWidth = 1
            nameTextField.layer.borderColor = UIColor.init(netHex: Colors.DARK_PURPLE).cgColor
        }
    }
    @IBOutlet weak var phoneTextField: CustomTextField! {
        didSet {
            phoneTextField.layer.borderWidth = 1
            phoneTextField.layer.borderColor = UIColor.init(netHex: Colors.DARK_PURPLE).cgColor
        }
    }
    @IBOutlet weak var dateOfBirthTextField: CustomTextField! {
        didSet {
            dateOfBirthTextField.layer.borderWidth = 1
            dateOfBirthTextField.layer.borderColor = UIColor.init(netHex: Colors.DARK_PURPLE).cgColor
        }
    }
    @IBOutlet weak var addressTextField: CustomTextField! {
        didSet {
            addressTextField.layer.borderWidth = 1
            addressTextField.layer.borderColor = UIColor.init(netHex: Colors.DARK_PURPLE).cgColor
        }
    }
    @IBOutlet weak var emailTextField: CustomTextField! {
        didSet {
            emailTextField.layer.borderWidth = 1
            emailTextField.layer.borderColor = UIColor.init(netHex: Colors.DARK_PURPLE).cgColor
        }
    }
    @IBOutlet weak var usernameTextField: CustomTextField! {
        didSet {
            usernameTextField.layer.borderWidth = 1
            usernameTextField.layer.borderColor = UIColor.init(netHex: Colors.DARK_PURPLE).cgColor
        }
    }
    @IBOutlet weak var passwordTextField: CustomTextField! {
        didSet {
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = UIColor.init(netHex: Colors.DARK_PURPLE).cgColor
        }
    }
    @IBOutlet weak var passwordRepeatTextField: CustomTextField! {
        didSet {
            passwordRepeatTextField.layer.borderWidth = 1
            passwordRepeatTextField.layer.borderColor = UIColor.init(netHex: Colors.DARK_PURPLE).cgColor
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
