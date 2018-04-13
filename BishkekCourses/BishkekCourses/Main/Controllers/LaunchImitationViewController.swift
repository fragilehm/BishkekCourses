//
//  LaunchImitationViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/14/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class LaunchImitationViewController: UIViewController {

    @IBOutlet weak var rocketButtonConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let screenHeight = Constants.SCREEN_HEIGHT
        self.rocketButtonConstraint.constant = screenHeight / 2
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()

        }) { (completed) in
            self.rocketButtonConstraint.constant = screenHeight
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainRootViewController")
                self.present(mainVC!, animated: false, completion: nil)
            })
            
        }
    }
}
