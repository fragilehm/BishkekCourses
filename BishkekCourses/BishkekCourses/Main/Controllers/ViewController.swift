//
//  ViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 11/30/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }

    
}

extension ViewController {
    func configureTabBar(){
        let bars = self.tabBarController?.tabBar.items
        for (index, bar) in bars!.enumerated() {
            bar.title = nil
            bar.image = MainPageItems(rawValue: index)?.getImage()
            bar.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
}
