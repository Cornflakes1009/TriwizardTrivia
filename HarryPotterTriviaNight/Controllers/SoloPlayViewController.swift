//
//  SoloPlayViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 10/24/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit

class SoloPlayViewController: UIViewController {

    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "clouds")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Solo Play"
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
//        label.font = titleLabelFont
        label.textColor = buttonTitleColor
        return label
    }()
    
    let backButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("< Back", for: .normal)
            button.setTitleColor(buttonTitleColor, for: .normal)
//            button.titleLabel?.font = buttonFont
            button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
            return button
        }()
    
    let fifteenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("15", for: .normal)
        button.backgroundColor = crimsonColor
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = buttonFont
//        button.addTarget(self, action: #selector(membersTapped), for: .touchUpInside)
        return button
    }()
    
        let twentyFiveButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("25", for: .normal)
            button.backgroundColor = hufflepuffColor
            button.setTitleColor(buttonTitleColor, for: .normal)
            button.layer.cornerRadius = 5
            button.titleLabel?.font = buttonFont
    //        button.addTarget(self, action: #selector(membersTapped), for: .touchUpInside)
            return button
        }()
    
        let fiftyButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("50", for: .normal)
            button.backgroundColor = ravenclawColor
            button.setTitleColor(buttonTitleColor, for: .normal)
            button.layer.cornerRadius = 5
            button.titleLabel?.font = buttonFont
    //        button.addTarget(self, action: #selector(membersTapped), for: .touchUpInside)
            return button
        }()
    
        let oneHundredButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("100", for: .normal)
            button.backgroundColor = slytherinColor
            button.setTitleColor(buttonTitleColor, for: .normal)
            button.layer.cornerRadius = 5
            button.titleLabel?.font = buttonFont
    //        button.addTarget(self, action: #selector(membersTapped), for: .touchUpInside)
            return button
        }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
        
    func setupViews() {
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setupStackView()
    }
    
    var stackView = UIStackView()
    // MARK: Setting Up the StackView
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [fifteenButton, twentyFiveButton, fiftyButton, oneHundredButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let screenHeight = UIScreen.main.bounds.size.height
        let stackViewHeight = CGFloat(screenHeight / 2)
        let stackViewButtonHeight = CGFloat((stackViewHeight - 40) / 5)
        
        view.addSubview(stackView)
        stackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: stackViewHeight)
    }
     
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        vibrate()
    }
    
    

}
