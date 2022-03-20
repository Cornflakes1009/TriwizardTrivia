//
//  QuestionViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 6/21/19.
//  Copyright © 2019 HaroldDavidson. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class QuestionViewController: UIViewController, GADInterstitialDelegate {
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var questionToAnswerLabel: NSLayoutConstraint!
    @IBOutlet var correctButtonHeight: NSLayoutConstraint!
    @IBOutlet var incorrectButtonHeight: NSLayoutConstraint!
    @IBOutlet var nextQuestionButtonHeight: NSLayoutConstraint!
    var interstitial: GADInterstitial!
    var player: AVPlayer?
    
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
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = answerFont
        label.textAlignment = .center
        label.textColor = buttonTitleColor
        return label
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
    
    
    var answeredCorrectly = false
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playBackgroundVideo()
        
        // adding shadow
        for button in buttons {
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 5, height: 5)
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 1.0
        }
        
        // updating UI
        teamLabel.text = teams[0].name
        questionLabel.text = "Question: \(questionList[questionIndex].question)"
        answerLabel.text = "Answer: \(questionList[questionIndex].answer)"
        nextQuestionButton.isHidden = true
        
        // starting ads on the bannerview
        bannerView.adUnitID = prodAdMobsKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        // if iPhone SE, adjusting the font view
        let screenHeight = UIScreen.main.bounds.size.height
        if(screenHeight < 569) {
            teamLabel.font = teamLabel.font.withSize(34)
            questionLabel.font = questionLabel.font.withSize(15)
            answerLabel.font = answerLabel.font.withSize(15)
            questionToAnswerLabel.constant = 10
            nextQuestionButtonHeight.constant = 60
            correctButtonHeight.constant = 60
            incorrectButtonHeight.constant = 60
            nextQuestionButton.titleLabel?.font = nextQuestionButton.titleLabel?.font.withSize(24)
            
            view.layoutIfNeeded()
        }
        
        interstitial = GADInterstitial(adUnitID: adUnitID)
        let request = GADRequest()
        interstitial.load(request)
        
        teamLabel.textAlignment = .center
        teamLabel.layer.shadowColor = UIColor.black.cgColor
        teamLabel.layer.shadowRadius = 3.0
        teamLabel.layer.shadowOpacity = 1.0
        teamLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        teamLabel.layer.masksToBounds = false
        
        let backButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let backButtonImage = UIImage(systemName: backButtonSymbol, withConfiguration: backButtonImageConfig)
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(scoreLabel)
        scoreLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        
        scoreLabel.text = "\(questionIndex + 1)/\(questionList.count)"
        
        numOfGamesPlayed += 1
        defaults.setValue(numOfGamesPlayed, forKey: "numOfGamesPlayed")
        
        correctButton.titleLabel?.font = buttonFont
        incorrectButton.titleLabel?.font = buttonFont
    }
    
    // added to prevent the segue added from partial curl
    override func viewDidAppear(_ animated: Bool) {
        self.view.gestureRecognizers?.removeAll()
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
    
    // MARK:- UI Functions
    func updateUI() {
        if(questionIndex == (teams.count * 15)) { // teams.count * 15
            
            if (interstitial.isReady) {
                interstitial.present(fromRootViewController: self)
                interstitial = createAd()
            }
            
            let vc = self.storyboard?.instantiateViewController(identifier: "ResultsStoryboard") as! ResultsViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            if(teams.count == currentTeam + 1) {
                currentTeam = 0
            } else {
                currentTeam += 1
            }
            
            teamLabel.text = teams[currentTeam].name
            questionLabel.text = "Question: \(questionList[questionIndex].question)"
            answerLabel.text = "Answer: \(questionList[questionIndex].answer)"
            correctButton.backgroundColor = slytherinColor
            incorrectButton.backgroundColor = gryffindorColor
            correctButton.titleLabel?.font = buttonFont
            incorrectButton.titleLabel?.font = buttonFont
        }
        
        scoreLabel.text = "\(questionIndex + 1)/\(questionList.count)"
    }
    
    func presentBackConfirmationsView() {
        correctButton.isEnabled = false
        incorrectButton.isEnabled = false
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
    
    // MARK:- AdMob Function
    func createAd() -> GADInterstitial {
        let inter = GADInterstitial(adUnitID: adUnitID)
        inter.load(GADRequest())
        return inter
    }
    
    // MARK:- Button Functions
    @IBAction func correctTapped(_ sender: Any) {
        vibrate()
        correctButton.backgroundColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)
        incorrectButton.backgroundColor = gryffindorColor
        answeredCorrectly = true
        nextQuestionButton.isHidden = false
    }
    
    @IBAction func incorrectTapped(_ sender: Any) {
        vibrate()
        incorrectButton.backgroundColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)
        correctButton.backgroundColor = slytherinColor
        answeredCorrectly = false
        nextQuestionButton.isHidden = false
    }
    
    @IBAction func nextQuestionTapped(_ sender: Any) {
        totalNumberOfQuestions += 1
        defaults.setValue(totalNumberOfQuestions, forKey: "totalNumberOfQuestions")
        
        if(answeredCorrectly) {
            teams[currentTeam].score += 1
            totalNumberOfCorrect += 1
            defaults.setValue(totalNumberOfCorrect, forKey: "totalNumberOfCorrect")
        }
        nextQuestionButton.isHidden = true
        questionIndex += 1
        updateUI()
        vibrate()
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
        correctButton.isEnabled = true
        incorrectButton.isEnabled = true
        vibrate()
    }
}
