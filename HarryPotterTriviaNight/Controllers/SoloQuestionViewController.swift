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
        button.setTitle("Himself with the Sorcerer's Stone", for: .normal)
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
        button.setTitle("Boomslang skin & lacewing flies", for: .normal)
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
        button.setTitle("The Misuse of Muggle Artifacts", for: .normal)
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
        button.setTitle("Accidental Magic Reversal Squad", for: .normal)
        button.backgroundColor = slytherinColor
        button.setTitleColor(slytherinFontColor, for: .normal)
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
    
    let correctAnswerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        view.alpha = 0
        return view
    }()
    
    let correctAnswerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorry, the correct answer was:"
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let correctAnswerLabel: UILabel = {
        let label = UILabel()
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let nextQuestionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next Question", for: .normal)
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
        button.addTarget(self, action: #selector(nextQuestionTapped), for: .touchUpInside)
        return button
    }()
    
    let exitConfirmationView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        view.alpha = 0
        return view
    }()
    
    let exitConfirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "Are you sure you wish to exit?"
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let explanationConfirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "This will exit the game and you'll lose your current progress?"
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let exitGameCancel: UIButton = {
       let button = UIButton(type: .system)
       button.setTitle("Cancel", for: .normal)
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
       button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
       return button
   }()
    
    let exitGameConfirm: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Exit", for: .normal)
        button.backgroundColor = crimsonColor
        button.setTitleColor(gryffindorFontColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = buttonFont
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateUI()
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
        questionLabel.text = "\(soloQuestionList[soloQuestionIndex].question)"
        optionZeroButton.setTitle(soloQuestionList[soloQuestionIndex].optionZero, for: .normal)
        optionOneButton.setTitle(soloQuestionList[soloQuestionIndex].optionOne, for: .normal)
        optionTwoButton.setTitle(soloQuestionList[soloQuestionIndex].optionTwo, for: .normal)
        optionThreeButton.setTitle(soloQuestionList[soloQuestionIndex].optionThree, for: .normal)
    }
    
    func showCorrectAnswer() {
        backButton.isEnabled = false
        view.addSubview(correctAnswerView)
        correctAnswerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: 0)
        UIView.animate(withDuration: 0.5) {
            self.correctAnswerView.alpha = 1
        }
        
        let currentCorrectAnswer = soloQuestionList[soloQuestionIndex].answer
        if currentCorrectAnswer == 0 {
            correctAnswerLabel.text = "\(soloQuestionList[soloQuestionIndex].optionZero)"
        } else if currentCorrectAnswer == 1 {
            correctAnswerLabel.text = "\(soloQuestionList[soloQuestionIndex].optionOne)"
        } else if currentCorrectAnswer == 2 {
            correctAnswerLabel.text = "\(soloQuestionList[soloQuestionIndex].optionTwo)"
        } else {
            correctAnswerLabel.text = "\(soloQuestionList[soloQuestionIndex].optionThree)"
        }
        
        correctAnswerView.addSubview(correctAnswerTitleLabel)
        correctAnswerTitleLabel.anchor(top: correctAnswerView.topAnchor, left: correctAnswerView.leftAnchor, bottom: nil, right: correctAnswerView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        correctAnswerView.addSubview(correctAnswerLabel)
        correctAnswerLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        correctAnswerLabel.centerXAnchor.constraint(equalTo: correctAnswerView.centerXAnchor).isActive = true
        correctAnswerLabel.centerYAnchor.constraint(equalTo: correctAnswerView.centerYAnchor).isActive = true
        
        correctAnswerView.addSubview(nextQuestionButton)
        nextQuestionButton.anchor(top: nil, left: correctAnswerView.leftAnchor, bottom: correctAnswerView.bottomAnchor, right: correctAnswerView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: buttonHeight)
    }
    
    func checkIfCorrect(buttonNumber: Int) {
        if buttonNumber == soloQuestionList[soloQuestionIndex].answer {
            soloScore += 1
        } else {
            showCorrectAnswer()
        }
        
        soloQuestionIndex += 1
        updateUI()
    }
    
    func presentBackConfirmationsView() {
        view.addSubview(exitConfirmationView)
        exitConfirmationView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: 0)
        UIView.animate(withDuration: 0.5) {
            self.exitConfirmationView.alpha = 1
        }
        
        backButton.isEnabled = false
        
        exitConfirmationView.addSubview(exitConfirmationLabel)
        exitConfirmationLabel.anchor(top: exitConfirmationView.topAnchor, left: exitConfirmationView.leftAnchor, bottom: nil, right: exitConfirmationView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        exitConfirmationView.addSubview(explanationConfirmationLabel)
        explanationConfirmationLabel.anchor(top: exitConfirmationLabel.bottomAnchor, left: exitConfirmationView.leftAnchor, bottom: nil, right: exitConfirmationView.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        setupExitStackView()
    }
    
    var exitStackView = UIStackView()
    func setupExitStackView() {
        exitStackView = UIStackView(arrangedSubviews: [exitGameCancel, exitGameConfirm])
        let exitStackViewWidth = UIScreen.main.bounds.size.width - 80
        exitStackView.distribution = .fillEqually
        exitStackView.axis = .horizontal
        exitStackView.spacing = 10
        
        exitConfirmationView.addSubview(exitStackView)
        exitStackView.centerXAnchor.constraint(equalTo: exitConfirmationView.centerXAnchor).isActive = true
        exitStackView.centerYAnchor.constraint(equalTo: exitConfirmationView.centerYAnchor).isActive = true
        exitStackView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: exitStackViewWidth, height: 50)
    }
    
    @objc func backTapped() {
        presentBackConfirmationsView()
        vibrate()
    }
    
    @objc func confirmTapped() {
        self.navigationController?.popViewController(animated: true)
        resetGame()
        vibrate()
    }
    
    @objc func cancelTapped() {
        UIView.animate(withDuration: 1) {
            self.exitConfirmationView.alpha = 0
        }
        backButton.isEnabled = true
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
    
    @objc func nextQuestionTapped() {
        UIView.animate(withDuration: 1) {
            self.correctAnswerView.alpha = 0
        }
        backButton.isEnabled = true
    }
}
