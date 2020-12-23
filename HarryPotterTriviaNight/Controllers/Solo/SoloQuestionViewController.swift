//
//  SoloQuestionViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 10/30/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SoloQuestionViewController: UIViewController, GADInterstitialDelegate {
    
    var interstitial: GADInterstitial!
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "clouds")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.tintColor = backButtonColor
        button.setTitleColor(whiteColor, for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let optionZeroButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.backgroundColor = gryffindorColor
        button.setTitleColor(gryffindorFontColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = answerFont
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
        button.setTitle("", for: .normal)
        button.backgroundColor = hufflepuffColor
        button.setTitleColor(hufflepuffFontColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = answerFont
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
        button.setTitle("", for: .normal)
        button.backgroundColor = ravenclawColor
        button.setTitleColor(ravenclawFontColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = answerFont
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
        button.setTitle("", for: .normal)
        button.backgroundColor = slytherinColor
        button.setTitleColor(slytherinFontColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = answerFont
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
        return button
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = answerFont
        label.textAlignment = .center
        label.textColor = buttonTitleColor
        return label
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
        label.numberOfLines = 0
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
        button.backgroundColor = gryffindorColor
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = buttonFont
        button.isEnabled = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.layer.shadowRadius = 3.0
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.layer.masksToBounds = false
        button.addTarget(self, action: #selector(nextQuestionTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK:- Exit View
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
        label.numberOfLines = 0
        return label
    }()
    
    let explanationConfirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "This will exit the game and you'll lose your current progress."
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
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.layer.shadowRadius = 3.0
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.layer.masksToBounds = false
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    let exitGameConfirm: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Exit", for: .normal)
        button.backgroundColor = gryffindorColor
        button.setTitleColor(gryffindorFontColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = buttonFont
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.layer.shadowRadius = 3.0
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.layer.masksToBounds = false
        button.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        return button
    }()
    
    let popUpBackground: UIImageView = {
        let image = UIImageView()
        image.image = popUpBackgroundImage
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.alpha = 0.3
        return image
    }()
    
    let bannerView: GADBannerView = {
        let bannerView = GADBannerView()
        return bannerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateUI()
        
        interstitial = GADInterstitial(adUnitID: adUnitID)
        let request = GADRequest()
        interstitial.load(request)
    }
    
    func setupViews() {
        let screenHeight = UIScreen.main.bounds.size.height
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(scoreLabel)
        scoreLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        
        let questionLableHeight = CGFloat(screenHeight / 4)
        view.addSubview(questionLabel)
        questionLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: questionLableHeight)
        
        let backButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let backButtonImage = UIImage(systemName: backButtonSymbol, withConfiguration: backButtonImageConfig)
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setupStackView()
        
        setupBannerView()
        view.addSubview(bannerView)
        bannerView.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -20, paddingRight: 0, width: 281, height: 50)
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
        
        scoreLabel.text = "\(soloQuestionIndex + 1)/\(soloQuestionList.count)"
    }
    
    func showCorrectAnswer() {
        backButton.isEnabled = false
        view.addSubview(correctAnswerView)
        correctAnswerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: 0)
        UIView.animate(withDuration: 0.5) {
            self.correctAnswerView.alpha = 1
        }
        
        correctAnswerView.addSubview(popUpBackground)
        popUpBackground.anchor(top: correctAnswerView.topAnchor, left: correctAnswerView.leftAnchor, bottom: nil, right: correctAnswerView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        popUpBackground.centerXAnchor.constraint(equalTo: correctAnswerView.centerXAnchor).isActive = true
        popUpBackground.centerYAnchor.constraint(equalTo: correctAnswerView.centerYAnchor).isActive = true
        
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
            
            if soloQuestionIndex + 1 != soloQuestionList.count {
                soloQuestionIndex += 1
                updateUI()
            } else {
                showInterstitial()
                let vc = self.storyboard?.instantiateViewController(identifier: "SoloScoreResultsViewController") as! SoloScoreResultsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            showCorrectAnswer()
        }
    }
    
    func presentBackConfirmationsView() {
        view.addSubview(exitConfirmationView)
        exitConfirmationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: 0)
        UIView.animate(withDuration: 0.5) {
            self.exitConfirmationView.alpha = 1
        }
        
        exitConfirmationView.addSubview(popUpBackground)
        popUpBackground.anchor(top: exitConfirmationView.topAnchor, left: exitConfirmationView.leftAnchor, bottom: nil, right: exitConfirmationView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        popUpBackground.centerXAnchor.constraint(equalTo: exitConfirmationView.centerXAnchor).isActive = true
        popUpBackground.centerYAnchor.constraint(equalTo: exitConfirmationView.centerYAnchor).isActive = true
        
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
        exitStackView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: exitStackViewWidth, height: buttonHeight)
    }
    
    func setupBannerView() {
        // starting ads on the bannerview
        bannerView.adUnitID = prodAdMobsKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func showInterstitial() {
        if (interstitial.isReady) {
            interstitial.present(fromRootViewController: self)
            interstitial = createAd()
        }
    }
    
    // MARK: AdMob Function
    func createAd() -> GADInterstitial {
        let inter = GADInterstitial(adUnitID: adUnitID)
        inter.load(GADRequest())
        return inter
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
        vibrate()
    }
    
    @objc func nextQuestionTapped() {
        
        if soloQuestionIndex + 1 != soloQuestionList.count {
            soloQuestionIndex += 1
            updateUI()
        } else {
            showInterstitial()
            
            let vc = self.storyboard?.instantiateViewController(identifier: "SoloScoreResultsViewController") as! SoloScoreResultsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        UIView.animate(withDuration: 1) {
            self.correctAnswerView.alpha = 0
        }
        backButton.isEnabled = true
    }
}
