//
//  SoloQuestionViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 10/30/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit

class SoloQuestionViewController: UIViewController {
    
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
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "This is a filler question. This text should be automatically replaced while the app is running."
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let optionZeroButton: UIButton = {
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
        button.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
        return button
    }()
    
    let optionOneButton: UIButton = {
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
        button.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
        return button
    }()
    
    let optionTwoButton: UIButton = {
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
        button.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
        return button
    }()
    
     let optionThreeButton: UIButton = {
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
        //            button.sender.tag = 4
        button.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        //updateUI()
        
        //optionThreeButton.addTarget(self, action: #selector(answerTapped(_ :)), for: .touchUpInside)
    }
    
    func setupViews() {
        let screenHeight = UIScreen.main.bounds.size.height
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let questionLableHeight = CGFloat(screenHeight / 4)
        view.addSubview(questionLabel)
        questionLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: questionLableHeight)
        
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setupStackView()
    }
    
    var stackView = UIStackView()
    // MARK: Setting Up the StackView
    func setupStackView() {
        let screenHeight = UIScreen.main.bounds.size.height
        stackView = UIStackView(arrangedSubviews: [optionZeroButton, optionOneButton, optionTwoButton, optionThreeButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
    
        let stackViewHeight = CGFloat(screenHeight / 2)
        
        view.addSubview(stackView)
        stackView.anchor(top: questionLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: stackViewHeight)
    }
    
    func updateUI() {
        questionLabel.text = soloQuestionList[soloQuestionIndex].question
        //        optionZeroButton.text = soloQuestionList[soloQuestionIndex].optionZero
        //        optionOneButton.text = soloQuestionList[soloQuestionIndex].optionOne
        //        optionTwoButton.text = soloQuestionList[soloQuestionIndex].optionTwo
        optionThreeButton.setTitle(soloQuestionList[soloQuestionIndex].optionThree, for: .normal)
    }
    
    func showCorrectAnswer() {
        
    }
    
    
    func checkIfCorrect(buttonNumber: Int) {
//        if buttonNumber == answer {
//            soloScore += 1
//        } else {
//            showCorrectAnswer()
//        }
        updateUI()
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        vibrate()
    }
    
    @objc func answerTapped(_ sender: UIButton!) {
        // check if selected button has correct answer, if not, present a view with correct answer
        if sender == optionZeroButton {
            checkIfCorrect(buttonNumber: 0)
        } else if sender == optionOneButton {
            checkIfCorrect(buttonNumber: 1)
        } else if sender == optionTwoButton {
            checkIfCorrect(buttonNumber: 2)
        } else if sender == optionThreeButton {
            checkIfCorrect(buttonNumber: 3)
        }
    }
    
}
