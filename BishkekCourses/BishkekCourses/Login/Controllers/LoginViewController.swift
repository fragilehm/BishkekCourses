//
//  LoginViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/3/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import M13Checkbox
class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: CustomTextField! {
        didSet {
            loginTextField.layer.borderWidth = 0.5
            loginTextField.layer.borderColor = UIColor.init(netHex: Colors.lightGray).cgColor
            loginTextField.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var rememberCheckbox: M13Checkbox? {
        didSet {
            //print(rememberCheckbox?.checkState.hashValue)
            //rememberCheckbox.boxLineWidth = 1
            rememberCheckbox?.boxType = .square
            rememberCheckbox?.markType = .checkmark
            rememberCheckbox?.tintColor = UIColor(netHex: Colors.darkPurple)
        }
    }
    @IBOutlet weak var passwordTextField: CustomTextField! {
        didSet {
            passwordTextField.layer.borderWidth = 0.5
            passwordTextField.layer.borderColor = UIColor.init(netHex: Colors.lightGray).cgColor
            passwordTextField.layer.cornerRadius = 4

        }
    }
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 4
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Авторизация"
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Авторизация"
    }
    @IBAction func registratePressed(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Registration", bundle: nil)
        let registrationVC = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController")
        self.navigationController?.show(registrationVC, sender: self)
    }
    @IBAction func loginPressed(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainRootViewController")
        self.navigationController?.present(mainVC, animated: false, completion: nil)
        
    }
    
}
