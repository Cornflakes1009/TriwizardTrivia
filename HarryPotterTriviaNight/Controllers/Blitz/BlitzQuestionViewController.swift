//
//  BlitzQuestionViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 12/12/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class BlitzQuestionViewController: UIViewController, GADInterstitialDelegate, GADRewardedAdDelegate {

    var player: AVPlayer?
    
    // MARK:- handle the completion of watching rewarded ad
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        UIView.animate(withDuration: 1) {
            self.correctAnswerView.alpha = 0
            self.extraLifeExitButton.alpha = 0
        }
        
        time = 30
        startTimer()
        backButton.isEnabled = true
        createAndLoadRewardedAd()
    }
    
    var timer = Timer()
    var time: Double = 120
    var interstitial: GADInterstitial!
    var rewardedAd: GADRewardedAd?
    
    let background: UIImageView = {
        let image = UIImageView()
        image.image = backgroundImage
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
        label.textColor = whiteColor
        label.numberOfLines = 0
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "120.0"
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.textColor = whiteColor
        return label
    }()
    
    let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.textColor = whiteColor
        return label
    }()
    
    let popUpBackground: UIImageView = {
        let image = UIImageView()
        image.image = popUpBackgroundImage
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.alpha = 0.3
        return image
    }()
    
    // MARK:- Banner View
    let bannerView: GADBannerView = {
        let bannerView = GADBannerView()
        return bannerView
    }()
    
    // MARK:- Answer Buttons
    let optionZeroButton: GameButton = {
        let button = GameButton(title: "", backgroundColor: gryffindorColor, fontColor: gryffindorFontColor)
        button.titleLabel?.font = answerFont
        button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let optionOneButton: GameButton = {
        let button = GameButton(title: "", backgroundColor: hufflepuffColor, fontColor: hufflepuffFontColor)
        button.titleLabel?.font = answerFont
        button.titleLabel?.layer.shadowRadius = 0
        button.titleLabel?.layer.shadowOpacity = 00
        button.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.titleLabel?.layer.masksToBounds = false
        button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let optionTwoButton: GameButton = {
        let button = GameButton(title: "", backgroundColor: ravenclawColor, fontColor: ravenclawFontColor)
        button.titleLabel?.font = answerFont
        button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let optionThreeButton: GameButton = {
        let button = GameButton(title: "", backgroundColor: slytherinColor, fontColor: slytherinFontColor)
        button.titleLabel?.font = answerFont
        button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK:- Ready View
    let explanationView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.alpha = 0
        view.isOpaque = true
        return view
    }()
    
    let explanationTopLabel: UILabel = {
        let label = UILabel()
        label.text = "Answer as many questions as you can before the time's up. No penalty for wrong answers."
        label.font = popupLabelFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let readyButton: GameButton = {
        let button = GameButton(title: "Ready?", backgroundColor: gryffindorColor, fontColor: gryffindorFontColor)
        button.addTarget(self, action: #selector(readyTapped), for: .touchUpInside)
        return button
    }()

    // MARK:- Correct Answer View
    let correctAnswerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.alpha = 0
        view.isOpaque = true
        return view
    }()
    
    let correctAnswerTopLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorry, the correct answer was:"
        label.font = popupLabelFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let correctAnswerLabel: UILabel = {
        let label = UILabel()
        label.text = "\(allQuestionList[questionIndex].answer)"
        label.font = popupLabelFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let nextQuestionButton: GameButton = {
        let button = GameButton(title: "Next Question", backgroundColor: gryffindorColor, fontColor: gryffindorFontColor)
        button.addTarget(self, action: #selector(nextQuestionTapped), for: .touchUpInside)
        button.titleLabel?.font = buttonFont
        return button
    }()
    
    let extraLifeButton: GameButton = {
        let button = GameButton(title: "Extra Life?", backgroundColor: gryffindorColor, fontColor: gryffindorFontColor)
        button.addTarget(self, action: #selector(extraLifeTapped), for: .touchUpInside)
        return button
    }()
    
    let extraLifeExitButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.tintColor = whiteColor
        button.setTitleColor(whiteColor, for: .normal)
        button.addTarget(self, action: #selector(extraLifeExitTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK:- Exit Confirmation
    let exitConfirmationView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.alpha = 0
        view.isOpaque = true
        return view
    }()
    
    let exitConfirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "Are you sure you wish to exit? This will exit the game and you'll lose your current progress"
        label.font = popupLabelFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let exitGameCancel: UIButton = {
        let button = GameButton(title: "Cancel", backgroundColor: slytherinColor, fontColor: slytherinFontColor)
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    let exitGameConfirm: UIButton = {
        let button = GameButton(title: "Exit", backgroundColor: gryffindorColor, fontColor: gryffindorFontColor)
        button.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        numOfGamesPlayed += 1
        defaults.setValue(numOfGamesPlayed, forKey: "numOfGamesPlayed")
        
        // interstitial ad
        interstitial = GADInterstitial(adUnitID: adUnitID)
        let request = GADRequest()
        interstitial.load(request)
        
        // rewarded ad
        createAndLoadRewardedAd()
        
        // handling the app moving to the background and foreground
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        if time < 121 {
            timer.invalidate()
        }
    }
    
    @objc func appMovedToForeground() {
        if time < 120 {
            startTimer()
        }
    }
    
    // MARK:- Setup Views
    func setupViews() {
//        view.addSubview(background)
//        background.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        playBackgroundVideo()
        
        let backButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let backButtonImage = UIImage(systemName: backButtonSymbol, withConfiguration: backButtonImageConfig)
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(timerLabel)
        timerLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(questionNumberLabel)
        questionNumberLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        
        view.addSubview(questionLabel)
        questionLabel.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        bannerView.rootViewController = self
        view.addSubview(bannerView)
        bannerView.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -20, paddingRight: 0, width: 281, height: 50)
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupStackView()
        updateUI()
        
        // needs to be added last so that it shows on top at game mode launch
        addExplanationView()
        backButton.isEnabled = false
        
        setupBannerView()
    }
    
    // MARK: - Background Video
    func playBackgroundVideo() {
        let path = Bundle.main.path(forResource: "smoke", ofType: ".mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        player!.seek(to: CMTime.zero)
        player!.play()
        self.player?.isMuted = true
    }
    
    @objc func playerItemDidReachEnd() {
        player!.seek(to: CMTime.zero)
    }
    
    // MARK:- StackView
    var stackView = UIStackView()
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [optionZeroButton, optionOneButton, optionTwoButton, optionThreeButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        // calculating based on the number of buttons in stack view and adding 20 padding
        let stackViewHeight = CGFloat(Int(buttonHeight) * stackView.arrangedSubviews.count + 40)
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: view.leftAnchor, bottom: bannerView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -30, paddingRight: 20, width: 0, height: stackViewHeight)
    }
    
    // MARK:- Explanation View
    func addExplanationView() {
        view.addSubview(explanationView)
        explanationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 0)
        UIView.animate(withDuration: 1) {
            self.explanationView.alpha = 1
        }
        
        explanationView.addSubview(explanationTopLabel)
        explanationTopLabel.anchor(top: explanationView.topAnchor, left: explanationView.leftAnchor, bottom: nil, right: explanationView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        explanationView.addSubview(popUpBackground)
        popUpBackground.anchor(top: explanationView.topAnchor, left: explanationView.leftAnchor, bottom: explanationView.bottomAnchor, right: explanationView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        popUpBackground.centerXAnchor.constraint(equalTo: explanationView.centerXAnchor).isActive = true
        popUpBackground.centerYAnchor.constraint(equalTo: explanationView.centerYAnchor).isActive = true
        
        explanationView.addSubview(readyButton)
        readyButton.anchor(top: nil, left: explanationView.leftAnchor, bottom: explanationView.bottomAnchor, right: explanationView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: buttonHeight)
    }
    
    // MARK:- Exit View
    func presentBackConfirmationsView() {
        backButton.isEnabled = false
        view.addSubview(exitConfirmationView)
        exitConfirmationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 0)
        
        exitConfirmationView.addSubview(popUpBackground)
        popUpBackground.anchor(top: exitConfirmationView.topAnchor, left: exitConfirmationView.leftAnchor, bottom: exitConfirmationView.bottomAnchor, right: exitConfirmationView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        popUpBackground.centerXAnchor.constraint(equalTo: exitConfirmationView.centerXAnchor).isActive = true
        popUpBackground.centerYAnchor.constraint(equalTo: exitConfirmationView.centerYAnchor).isActive = true
        
        exitConfirmationView.addSubview(exitConfirmationLabel)
        exitConfirmationLabel.anchor(top: exitConfirmationView.topAnchor, left: exitConfirmationView.leftAnchor, bottom: nil, right: exitConfirmationView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        setupExitStackView()
        
        UIView.animate(withDuration: 0.5) {
            self.exitConfirmationView.alpha = popUpViewAlpha
        }
    }
    
    // MARK:- Exit StackView
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
    
    func updateUI() {
        questionLabel.text = "\(allQuestionList[questionIndex].question)"
        optionZeroButton.setTitle(allQuestionList[questionIndex].optionZero, for: .normal)
        optionOneButton.setTitle(allQuestionList[questionIndex].optionOne, for: .normal)
        optionTwoButton.setTitle(allQuestionList[questionIndex].optionTwo, for: .normal)
        optionThreeButton.setTitle(allQuestionList[questionIndex].optionThree, for: .normal)
        
        questionNumberLabel.text = "\(questionIndex + 1)/\(allQuestionList.count)"
    }
    
    // MARK:- Show Rewarded Ad Answer View
    func showRewardedAdAnswerView() {
        nextQuestionButton.removeFromSuperview()
        backButton.isEnabled = false
        extraLifeExitButton.alpha = 1
        view.addSubview(correctAnswerView)
        correctAnswerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 0)
        UIView.animate(withDuration: 0.5) {
            self.correctAnswerView.alpha = popUpViewAlpha
        }
        
        let backButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let backButtonImage = UIImage(systemName: closePopupSymbol, withConfiguration: backButtonImageConfig)
        
        extraLifeExitButton.setImage(backButtonImage, for: .normal)
        correctAnswerView.addSubview(extraLifeExitButton)
        extraLifeExitButton.anchor(top: correctAnswerView.topAnchor, left: correctAnswerView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let currentCorrectAnswer = allQuestionList[questionIndex].answer
        if currentCorrectAnswer == 0 {
            correctAnswerLabel.text = "\(allQuestionList[questionIndex].optionZero)"
        } else if currentCorrectAnswer == 1 {
            correctAnswerLabel.text = "\(allQuestionList[questionIndex].optionOne)"
        } else if currentCorrectAnswer == 2 {
            correctAnswerLabel.text = "\(allQuestionList[questionIndex].optionTwo)"
        } else {
            correctAnswerLabel.text = "\(allQuestionList[questionIndex].optionThree)"
        }
        
        correctAnswerView.addSubview(popUpBackground)
        popUpBackground.anchor(top: correctAnswerView.topAnchor, left: correctAnswerView.leftAnchor, bottom: correctAnswerView.bottomAnchor, right: correctAnswerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        popUpBackground.centerXAnchor.constraint(equalTo: correctAnswerView.centerXAnchor).isActive = true
        popUpBackground.centerYAnchor.constraint(equalTo: correctAnswerView.centerYAnchor).isActive = true
        
        correctAnswerView.addSubview(correctAnswerTopLabel)
        correctAnswerTopLabel.anchor(top: extraLifeExitButton.bottomAnchor, left: correctAnswerView.leftAnchor, bottom: nil, right: correctAnswerView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        correctAnswerView.addSubview(correctAnswerLabel)
        correctAnswerLabel.anchor(top: nil, left: correctAnswerView.leftAnchor, bottom: nil, right: correctAnswerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        correctAnswerLabel.centerXAnchor.constraint(equalTo: correctAnswerView.centerXAnchor).isActive = true
        correctAnswerLabel.centerYAnchor.constraint(equalTo: correctAnswerView.centerYAnchor).isActive = true
        
        correctAnswerView.addSubview(extraLifeButton)
        extraLifeButton.anchor(top: nil, left: correctAnswerView.leftAnchor, bottom: correctAnswerView.bottomAnchor, right: correctAnswerView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: buttonHeight)
    }
    
    // MARK:- Show Correct Answer View
    func showCorrectAnswer() {
        extraLifeButton.removeFromSuperview()
        backButton.isEnabled = false
        view.addSubview(correctAnswerView)
        correctAnswerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 0)
        UIView.animate(withDuration: 0.5) {
            self.correctAnswerView.alpha = popUpViewAlpha
        }
        
        let currentCorrectAnswer = allQuestionList[questionIndex].answer
        if currentCorrectAnswer == 0 {
            correctAnswerLabel.text = "\(allQuestionList[questionIndex].optionZero)"
        } else if currentCorrectAnswer == 1 {
            correctAnswerLabel.text = "\(allQuestionList[questionIndex].optionOne)"
        } else if currentCorrectAnswer == 2 {
            correctAnswerLabel.text = "\(allQuestionList[questionIndex].optionTwo)"
        } else {
            correctAnswerLabel.text = "\(allQuestionList[questionIndex].optionThree)"
        }
        
        correctAnswerView.addSubview(popUpBackground)
        popUpBackground.anchor(top: correctAnswerView.topAnchor, left: correctAnswerView.leftAnchor, bottom: correctAnswerView.bottomAnchor, right: correctAnswerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        popUpBackground.centerXAnchor.constraint(equalTo: correctAnswerView.centerXAnchor).isActive = true
        popUpBackground.centerYAnchor.constraint(equalTo: correctAnswerView.centerYAnchor).isActive = true
        
        correctAnswerView.addSubview(correctAnswerTopLabel)
        correctAnswerTopLabel.anchor(top: correctAnswerView.topAnchor, left: correctAnswerView.leftAnchor, bottom: nil, right: correctAnswerView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        correctAnswerView.addSubview(correctAnswerLabel)
        correctAnswerLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        correctAnswerLabel.centerXAnchor.constraint(equalTo: correctAnswerView.centerXAnchor).isActive = true
        correctAnswerLabel.centerYAnchor.constraint(equalTo: correctAnswerView.centerYAnchor).isActive = true
        
        correctAnswerView.addSubview(nextQuestionButton)
        nextQuestionButton.anchor(top: nil, left: correctAnswerView.leftAnchor, bottom: correctAnswerView.bottomAnchor, right: correctAnswerView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: buttonHeight)
    }
    
    // MARK:- AdMob Functions
    func createAd() -> GADInterstitial {
        let inter = GADInterstitial(adUnitID: adUnitID)
        inter.delegate = self
        inter.load(GADRequest())
        return inter
    }
    
    func createAndLoadRewardedAd() {
      rewardedAd = GADRewardedAd(adUnitID: rewardedAdUnitID)
      rewardedAd?.load(GADRequest()) { error in
        if let error = error {
          print("Loading failed: \(error)")
        } else {
          print("Loading Succeeded")
        }
      }
    }
    
    func setupBannerView() {
        // starting ads on the bannerview
        bannerView.adUnitID = prodAdMobsKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    // MARK:- Check if Answer Tapped is Correct
    func checkIfCorrect(buttonNumber: Int) {
        totalNumberOfQuestions += 1
        defaults.setValue(totalNumberOfQuestions, forKey: "totalNumberOfQuestions")
        if buttonNumber == allQuestionList[questionIndex].answer {
            totalNumberOfCorrect += 1
            defaults.setValue(totalNumberOfCorrect, forKey: "totalNumberOfCorrect")
            correctlyAnswered += 1
        } else {
            extraLifeExitButton.alpha = 1
            showCorrectAnswer()
        }
        
        if questionIndex + 1 != allQuestionList.count {
            questionIndex += 1
            updateUI()
        } else {
            if (interstitial.isReady) {
                interstitial.present(fromRootViewController: self)
                interstitial = createAd()
            }
            
            let vc = self.storyboard?.instantiateViewController(identifier: "BlitzResultsViewController") as! BlitzResultsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK:- Timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(BlitzQuestionViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        time -= 0.1
        // rounding to the tenths. example: 8.1
        time = Double(round(10 * time) / 10)
        timerLabel.text = "\(String(describing: time))"
        if(time == 0) {
            timer.invalidate()
            showRewardedAdAnswerView()
        }
    }

    // MARK:- Button Actions
    @objc func readyTapped() {
        // starting the game timer
        startTimer()
        UIView.animate(withDuration: 1) {
            self.explanationView.alpha = 0
        }
        backButton.isEnabled = true
    }
    
    @objc func backTapped() {
        presentBackConfirmationsView()
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
    
    @objc func extraLifeTapped() {
        timer.invalidate()
        time = 30
        // show rewarded ad
        if rewardedAd?.isReady == true {
               rewardedAd?.present(fromRootViewController: self, delegate:self)
        }
    }
    
    @objc func extraLifeExitTapped() {
        timer.invalidate()
        
        if (interstitial.isReady) {
            interstitial.present(fromRootViewController: self)
            interstitial = createAd()
        }
        
        let vc = self.storyboard?.instantiateViewController(identifier: "BlitzResultsViewController") as! BlitzResultsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func confirmTapped() {
        timer.invalidate()
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

    @objc func nextQuestionTapped() {
        UIView.animate(withDuration: 1) {
            self.correctAnswerView.alpha = 0
        }
        backButton.isEnabled = true
    }
}
