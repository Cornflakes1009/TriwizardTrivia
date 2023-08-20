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
        label.text = NSLocalizedString("Select a Game Mode", comment: "")
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

    let singlePlayerButton: GameButton = {
        let button = GameButton(title: "Classic", backgroundColor: gryffindorColor, fontColor: buttonTitleColor)
        button.addTarget(nil, action: #selector(soloPlayTapped), for: .touchUpInside)
        return button
    }()

    let potionsClassButton: GameButton = {
        let button = GameButton(title: "Potions Class", backgroundColor: gryffindorColor, fontColor: buttonTitleColor)
        button.addTarget(nil, action: #selector(potionsClassTapped), for: .touchUpInside)
        return button
    }()
    
    let partyButton: GameButton = {
        let button = GameButton(title: "Party", backgroundColor: gryffindorColor, fontColor: buttonTitleColor)
        button.addTarget(nil, action: #selector(partyPlayTapped), for: .touchUpInside)
        return button
    }()
    
    let survivalButton: GameButton = {
        let button = GameButton(title: "Survival", backgroundColor: gryffindorColor, fontColor: buttonTitleColor)
        button.addTarget(nil, action: #selector(survivalTapped), for: .touchUpInside)
        return button
    }()
    
    let blitzButton: GameButton = {
        let button = GameButton(title: "Blitz", backgroundColor: gryffindorColor, fontColor: buttonTitleColor)
        button.addTarget(nil, action: #selector(blitzTapped), for: .touchUpInside)
        return button
    }()
    
    let fantasticBeastsButton: GameButton = {
        let button = GameButton(title: "Fantastic Beasts", backgroundColor: gryffindorColor, fontColor: buttonTitleColor)
        button.addTarget(nil, action: #selector(fantasticBeastsTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Horizontal Scroll View items
    let creditsButton: TextButton = {
        let button = TextButton(title: "Credits", fontColor: whiteColor)
        button.addTarget(nil, action: #selector(creditsTapped), for: .touchUpInside)
        return button
    }()
    
    let scoresButton: TextButton = {
        let button = TextButton(title: "Scores", fontColor: whiteColor)
        button.addTarget(nil, action: #selector(scoresTapped), for: .touchUpInside)
        return button
    }()
    
    let contactButton: TextButton = {
        let button = TextButton(title: "Contact", fontColor: whiteColor)
        button.addTarget(nil, action: #selector(scoresTapped), for: .touchUpInside)
        return button
    }()
    
    let bannerView: GADBannerView = {
        let bannerView = GADBannerView()
        return bannerView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        screenHeight = UIScreen.main.bounds.size.height
        screenWidth = UIScreen.main.bounds.size.width
        
        varyForScreenSizes(screenHeight: screenHeight)
        setupViews()
        titleLabel.font                         = titleLabelFont
        instructionLabel.font                   = instructionLabelFont
        singlePlayerButton.titleLabel?.font     = buttonFont
        potionsClassButton.titleLabel?.font     = buttonFont
        partyButton.titleLabel?.font            = buttonFont
        survivalButton.titleLabel?.font         = buttonFont
        blitzButton.titleLabel?.font            = buttonFont
        fantasticBeastsButton.titleLabel?.font  = buttonFont
        creditsButton.titleLabel?.font          = instructionLabelFont
        scoresButton.titleLabel?.font           = instructionLabelFont
        contactButton.titleLabel?.font          = instructionLabelFont
        
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
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
    
    @objc func appMovedToBackground() {
        player?.pause()
    }
    
    @objc func appMovedToForeground() {
        player?.play()
    }
    
    // MARK: - Setting Up Views
    func setupViews() {
        
        // setting the buttonHeight for each button in the game
        buttonHeight = screenHeight / 10
        
        playBackgroundVideo()
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        view.addSubview(instructionLabel)
        instructionLabel.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        setupBannerView()
        view.addSubview(bannerView)
        bannerView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        setupHorizontalStackView()
        
        setupCategoryStackView()
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
    private var categoryStackView = UIStackView()
    // MARK: Setting Up the StackView
    private func setupCategoryStackView() {
        categoryStackView = UIStackView(arrangedSubviews: [singlePlayerButton, potionsClassButton, partyButton, survivalButton, blitzButton, fantasticBeastsButton])
        categoryStackView.distribution = .fillEqually
        categoryStackView.axis = .vertical
        categoryStackView.spacing = 10
        
        let stackViewHeight = CGFloat(Int(buttonHeight) * categoryStackView.arrangedSubviews.count + 50)
        
        view.addSubview(scrollView)
        scrollView.anchor(top: instructionLabel.bottomAnchor, left: view.leftAnchor, bottom: horizontalStackView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)

        scrollView.addSubview(categoryStackView)
        categoryStackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: stackViewHeight)
        categoryStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    // MARK: Setting Up the StackView
    private var horizontalStackView = UIStackView()
    private func setupHorizontalStackView() {
        horizontalStackView = UIStackView(arrangedSubviews: [creditsButton, scoresButton, contactButton])
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.axis = .horizontal
        categoryStackView.spacing = 10
        view.addSubview(horizontalStackView)
        horizontalStackView.anchor(top: nil, left: view.leftAnchor, bottom: bannerView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -5, paddingRight: 20, width: 0, height: buttonHeight)
    }
    
    private func setupBannerView() {
        // starting ads on the bannerview
        bannerView.adUnitID = prodAdMobsKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    @objc func soloPlayTapped() {
        soloTriviaFileToRead = "harryPotterSoloQuestions"
        let vc = ClassicQuestionSelectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func partyPlayTapped() {
        let vc = self.storyboard?.instantiateViewController(identifier: "PartyRulesViewController") as! PartyRulesViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func potionsClassTapped() {
        let vc = PotionsClassCategorySelectViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func survivalTapped() {
        convertSoloJSON(jsonToRead: "harryPotterSoloQuestions")
        let vc = SurvivalQuestionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func blitzTapped() {
        convertSoloJSON(jsonToRead: "harryPotterSoloQuestions")
        let vc = BlitzQuestionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func fantasticBeastsTapped() {
        soloTriviaFileToRead = "fantasticBeastsQuestions"
        let vc = ClassicQuestionSelectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func creditsTapped() {
        let vc = GameCreditsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func scoresTapped() {
        let vc = ScoresViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
}
