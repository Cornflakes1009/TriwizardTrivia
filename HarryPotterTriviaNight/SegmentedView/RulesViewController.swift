//
//  RulesViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 2/10/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {

    @IBOutlet var textField: UITextView!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.textColor = .white
        
        // if iPhone SE, adjusting the font view
        let screenHeight = UIScreen.main.bounds.size.height
        if(screenHeight < 569) {
            textField.font = textField.font?.withSize(13)
        }
    }
}
