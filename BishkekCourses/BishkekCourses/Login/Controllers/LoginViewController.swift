//
//  LoginViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/3/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: CustomTextField! {
        didSet {
            loginTextField.layer.borderWidth = 1
            loginTextField.layer.borderColor = UIColor.init(netHex: Colors.lightGray).cgColor
            print(loginTextField.frame.size.height)
        }
    }
    @IBOutlet weak var passwordTextField: CustomTextField! {
        didSet {
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = UIColor.init(netHex: Colors.lightGray).cgColor
        }
    }
    @IBOutlet weak var loginButton: UIButton!
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
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        self.navigationController?.present(mainVC, animated: false, completion: nil)
        
    }
    
}
