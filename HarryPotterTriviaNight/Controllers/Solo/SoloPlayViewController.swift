//
//  SoloPlayViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 10/24/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit
import AVFoundation

class SoloPlayViewController: UIViewController {
    
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
        button.isEnabled = true
        button.tintColor = backButtonColor
        button.setTitleColor(whiteColor, for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    let fifteenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("15 Questions", for: .normal)
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
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.layer.shadowRadius = 1.0
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.titleLabel?.layer.masksToBounds = false
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
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.layer.shadowRadius = 3.0
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.layer.masksToBounds = false
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
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.layer.shadowRadius = 3.0
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.layer.masksToBounds = false
        button.addTarget(self, action: #selector(oneHundredTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        player?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player?.pause()
    }
    
    func setupViews() {
//        view.addSubview(backgroundImage)
//        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        playBackgroundVideo()
        
        let backButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let backButtonImage = UIImage(systemName: backButtonSymbol, withConfiguration: backButtonImageConfig)
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        if soloTriviaFileToRead == "harryPotterSoloQuestions" {
            titleLabel.text = "Classic"
        } else {
            titleLabel.text = "Fantastic Beasts"
        }
        view.addSubview(titleLabel)
        titleLabel.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setupStackView()
    }
    
    // MARK: - Background Video
    func playBackgroundVideo() {
        let path = Bundle.main.path(forResource: "smoke1", ofType: ".mp4")
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
    
    // MARK: - StackView
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
//        let vc = self.storyboard?.instantiateViewController(identifier: "SoloQuestionViewController") as! SoloQuestionViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let vc = SoloQuestionViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .partialCurl
        present(vc, animated: true)
        vibrate()
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        vibrate()
    }
    
    @objc func fifteenTapped() {
        convertSoloJSON(jsonToRead: soloTriviaFileToRead, numberOfQuestions: 15)
        startGameNavigation()
    }
    
    @objc func twentyFiveTapped() {
        convertSoloJSON(jsonToRead: soloTriviaFileToRead, numberOfQuestions: 25)
        startGameNavigation()
    }
    
    @objc func fiftyTapped() {
        convertSoloJSON(jsonToRead: soloTriviaFileToRead, numberOfQuestions: 50)
        startGameNavigation()
    }
    
    @objc func oneHundredTapped() {
        convertSoloJSON(jsonToRead: soloTriviaFileToRead, numberOfQuestions: 100)
        startGameNavigation()
    }
}
