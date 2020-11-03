//
//  GameCreditsViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 11/2/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit

class GameCreditsViewController: UIViewController {
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "clouds")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("< Back", for: .normal)
        button.setTitleColor(buttonTitleColor, for: .normal)
        //            button.titleLabel?.font = buttonFont
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Credits"
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
        label.font = titleLabelFont
        label.textColor = buttonTitleColor
        return label
    }()
    
    let rulesTextView: UITextView = {
        let tv = UITextView()
        tv.text = """
        The goal of mob programming:
        Mob programming is meant to facilitate the collaboration of programmers of all levels to work together and build a common app on a single computer.
        
        How mob programming works:
        First, whomever is closest to the phone/tablet that you’re using for this app, enter the names of the group starting with their own and going clockwise. Discuss how long each round should be and how long and frequent breaks should be. Enter those times. Start the timer. This person is now the navigator and the driver is the person to their left. The navigator now reads the rules out loud.
        
        Rules:
        1. Be respectful to each other and their property. No greasy pizza fingers!
        2. The navigator is the only person allowed to direct the driver.
        3. The navigator should discuss with the other group members on the next steps, but only the navigator is allowed to direct the driver.
        4. The navigator has the final say in all matters related to the project during the navigator’s turn.
        5. Once the timer runs out, pass the role of navigator and driver to the next group members specified.
        6. The navigator discusses with the entire group to determine what they’ll build and what the requirements of “done” are. The navigator will instruct the driver to write this down.
        7. Follow the app to determine turns and breaks.
        8. Mob programming is over when the app is complete or the session time runs out. Ex. 6pm-8pm.
        """
//        tv.font = rulesFont
        tv.textColor = .white
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = true
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        let screenHeight = UIScreen.main.bounds.size.height
        let textViewHeight = CGFloat(screenHeight * 0.6)
        view.addSubview(rulesTextView)
        rulesTextView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: textViewHeight)
    }
    
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        vibrate()
    }
    
    
    
    
}
