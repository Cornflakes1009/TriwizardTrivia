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
        label.font = titleLabelFont
        label.textColor = buttonTitleColor
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("< Back", for: .normal)
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    let fifteenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("15 Questions", for: .normal)
        button.backgroundColor = crimsonColor
        button.setTitleColor(gryffindorFontColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = buttonFont
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(fifteenTapped), for: .touchUpInside)
        return button
    }()
    
    let twentyFiveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("25 Questions", for: .normal)
        button.backgroundColor = hufflepuffColor
        button.setTitleColor(hufflepuffFontColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = buttonFont
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(twentyFiveTapped), for: .touchUpInside)
        return button
    }()
    
    let fiftyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("50 Questions", for: .normal)
        button.backgroundColor = ravenclawColor
        button.setTitleColor(ravenclawFontColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = buttonFont
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(fiftyTapped), for: .touchUpInside)
        return button
    }()
    
    let oneHundredButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("100 Questions", for: .normal)
        button.backgroundColor = slytherinColor
        button.setTitleColor(slytherinFontColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = buttonFont
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(oneHundredTapped), for: .touchUpInside)
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
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
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
        
        view.addSubview(stackView)
        stackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: stackViewHeight)
    }
    
    func startGameNavigation() {
        let vc = self.storyboard?.instantiateViewController(identifier: "SoloQuestionViewController") as! SoloQuestionViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        vibrate()
    }
    
    @objc func fifteenTapped() {
        convertSoloJSON(jsonToRead: "harryPotterSoloQuestions", numberOfQuestions: 15)
        startGameNavigation()
    }
    
    @objc func twentyFiveTapped() {
        convertSoloJSON(jsonToRead: "harryPotterSoloQuestions", numberOfQuestions: 25)
        startGameNavigation()
    }
    
    @objc func fiftyTapped() {
        convertSoloJSON(jsonToRead: "harryPotterSoloQuestions", numberOfQuestions: 50)
        startGameNavigation()
    }
    
    @objc func oneHundredTapped() {
        convertSoloJSON(jsonToRead: "harryPotterSoloQuestions", numberOfQuestions: 100)
        startGameNavigation()
    }
}
