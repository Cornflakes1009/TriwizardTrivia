//
//  PartyRulesViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 10/29/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit

class PartyRulesViewController: UIViewController {

    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.backgroundColor = crimsonColor
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = buttonFont
        button.isEnabled = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        view.addSubview(playButton)
        playButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: 30)
        
    }

    @objc func playTapped() {
        let vc = self.storyboard?.instantiateViewController(identifier: "PickTeamsStoryboard") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
