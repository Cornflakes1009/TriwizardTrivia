//
//  ModeSelectViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 10/24/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit
import AVFoundation
import StoreKit
import GoogleMobileAds

class ModeSelectViewController: UIViewController {
    
    var player: AVPlayer?
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "clouds")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TriwizardTrivia"
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
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Select a Game Mode"
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.layer.cornerRadius = 5
        return scrollView
    }()
    
    let singlePlayerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Classic", for: .normal)
        button.backgroundColor = gryffindorColor
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.layer.shadowRadius = 3.0
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.layer.masksToBounds = false
        button.titleLabel?.font = buttonFont
        button.isEnabled = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(soloPlayTapped), for: .touchUpInside)
        return button
    }()
    
    let partyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Party", for: .normal)
        button.backgroundColor = gryffindorColor
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.layer.shadowRadius = 3.0
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.layer.masksToBounds = false
        button.layer.cornerRadius = 5
        button.titleLabel?.font = buttonFont
        button.isEnabled = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(partyPlayTapped), for: .touchUpInside)
        return button
    }()
    
    let survivalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Survival", for: .normal)
        button.backgroundColor = gryffindorColor
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.layer.shadowRadius = 3.0
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.layer.masksToBounds = false
        button.titleLabel?.font = buttonFont
        button.isEnabled = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(survivalTapped), for: .touchUpInside)
        return button
    }()
    
    let blitzButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Blitz", for: .normal)
        button.backgroundColor = gryffindorColor
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.layer.shadowRadius = 3.0
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.layer.masksToBounds = false
        button.titleLabel?.font = buttonFont
        button.isEnabled = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(blitzTapped), for: .touchUpInside)
        return button
    }()
    
    let fantasticBeastsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fantastic Beasts", for: .normal)
        button.backgroundColor = gryffindorColor
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.layer.shadowRadius = 3.0
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.layer.masksToBounds = false
        button.titleLabel?.font = buttonFont
        button.isEnabled = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(fantasticBeastsTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK:- Horizontal Scroll View items
    let creditsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Credits", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = instructionLabelFont
        button.isEnabled = true
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(creditsTapped), for: .touchUpInside)
        return button
    }()
    
    let scoresButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Scores", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = instructionLabelFont
        button.isEnabled = true
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(scoresTapped), for: .touchUpInside)
        return button
    }()
    
    let contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Contact", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = instructionLabelFont
        button.isEnabled = true
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(scoresTapped), for: .touchUpInside)
        return button
    }()
    
    let bannerView: GADBannerView = {
        let bannerView = GADBannerView()
        return bannerView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenHeight = UIScreen.main.bounds.size.height
        varyForScreenSizes(screenHeight: screenHeight)
        
        setupViews()
        titleLabel.font = titleLabelFont
        instructionLabel.font = instructionLabelFont
        singlePlayerButton.titleLabel?.font = buttonFont
        partyButton.titleLabel?.font = buttonFont
        survivalButton.titleLabel?.font = buttonFont
        blitzButton.titleLabel?.font = buttonFont
        fantasticBeastsButton.titleLabel?.font = buttonFont
    }
    
    override func viewWillAppear(_ animated: Bool) {
        player?.play()
        if completedGame && numOfGamesPlayed >= 3 {
            SKStoreReviewController.requestReview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player?.pause()
    }
    
    // MARK: - Setting Up Views
    func setupViews() {
        screenHeight = UIScreen.main.bounds.size.height
        screenWidth = UIScreen.main.bounds.size.width
        
        // setting the buttonHeight for each button in the game
        buttonHeight = screenHeight / 10
        
//        view.addSubview(backgroundImage)
//        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        playBackgroundVideo()
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        setupStackView()
        
        setupHorizontalStackView()
        
        view.addSubview(instructionLabel)
        instructionLabel.anchor(top: nil, left: view.leftAnchor, bottom: scrollView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -10, paddingRight: 20, width: 0, height: 0)
        
        setupBannerView()
        
        view.addSubview(bannerView)
        bannerView.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -20, paddingRight: 0, width: 281, height: 50)
        
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
    
    // MARK: - Button Stack View
    var stackView = UIStackView()
    // MARK: Setting Up the StackView
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [singlePlayerButton, partyButton, survivalButton, blitzButton, fantasticBeastsButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        // calculating based on the number of buttons in stack view and adding 20 padding
        let scrollViewHeight = CGFloat(Int(buttonHeight) * stackView.arrangedSubviews.count)
        let stackViewHeight = CGFloat(Int(buttonHeight) * stackView.arrangedSubviews.count + 50)
        
        view.addSubview(scrollView)
        scrollView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: scrollViewHeight)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: stackViewHeight)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    var horizontalStackView = UIStackView()
    // MARK: Setting Up the StackView
    func setupHorizontalStackView() {
        horizontalStackView = UIStackView(arrangedSubviews: [creditsButton, scoresButton, contactButton])
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.axis = .horizontal
        stackView.spacing = 10
        
        // calculating based on the number of buttons in stack view and adding 20 padding
        //let stackViewHeight = CGFloat(Int(buttonHeight) * stackView.arrangedSubviews.count + 40)
        
        view.addSubview(horizontalStackView)
        horizontalStackView.anchor(top: scrollView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: buttonHeight)
    }
    
    func setupBannerView() {
        // starting ads on the bannerview
        bannerView.adUnitID = prodAdMobsKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    @objc func partyPlayTapped() {
        let vc = self.storyboard?.instantiateViewController(identifier: "PartyRulesViewController") as! PartyRulesViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func soloPlayTapped() {
        soloTriviaFileToRead = "harryPotterSoloQuestions"
        let vc = self.storyboard?.instantiateViewController(identifier: "SoloPlayViewController") as! SoloPlayViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func survivalTapped() {
        convertAllJSON(jsonToRead: "harryPotterSoloQuestions")
        let vc = self.storyboard?.instantiateViewController(identifier: "SurvivalQuestionViewController") as! SurvivalQuestionViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func blitzTapped() {
        convertAllJSON(jsonToRead: "harryPotterSoloQuestions")
        let vc = self.storyboard?.instantiateViewController(identifier: "BlitzQuestionViewController") as! BlitzQuestionViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func fantasticBeastsTapped() {
        soloTriviaFileToRead = "fantasticBeastsQuestions"
        let vc = self.storyboard?.instantiateViewController(identifier: "SoloPlayViewController") as! SoloPlayViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func creditsTapped() {
        let vc = self.storyboard?.instantiateViewController(identifier: "GameCreditsViewController") as! GameCreditsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func scoresTapped() {
        let vc = self.storyboard?.instantiateViewController(identifier: "ScoresViewController") as! ScoresViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
}
