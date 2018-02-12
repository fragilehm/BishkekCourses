//
//  HashTagViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/11/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class HashTagViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        let attributedString = NSMutableAttributedString(string: "Want to learn iOS? #You should# visit the best source of free iOS tutorials!")
        attributedString.addAttribute(.link, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 11))
        attributedString.addAttribute(.link, value: "https://hackitosh", range: NSRange(location: 30, length: 23))
        
        textView.attributedText = attributedString
        // Do any additional setup after loading the view.
    }
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print(URL.absoluteString)
        //UIApplication.shared.open(URL, options: [:])
        return false
    }
    
}
