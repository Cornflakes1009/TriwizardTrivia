//
//  PotionsClassViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 2/13/22.
//  Copyright © 2022 HaroldDavidson. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class PotionsClassViewController: UIViewController {

    var player: AVPlayer?
    var interstitial: GADInterstitial!
    private let topCharacters: [String] = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    private let middleCharacters: [String] = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
    private let bottomCharacters: [String] = ["Z", "X", "C", "V", "B", "N", "M"]
    private var underscoreString = ""
    private var wordToGuess = hangmanWordList[hangmanIndex].word.uppercased()
    private var guessedCharacters: [String] = []
    private var underscoreArray  = [String]()
    private var wordToGuessArray = [String]()
    private var currentWordArray = [String]()
    private var wordCountForAds = 0
    private let cauldronArray = ["cauldron1", "cauldron2", "cauldron3", "cauldron4", "cauldron5", "cauldron6", "cauldron7"]
    private var wrongGuesses = 0

    //MARK:- UI
    private var topButtons = [UIButton]()
    private var middleButtons = [UIButton]()
    private var bottomButtons = [UIButton]()
    
    private var keyboardView = UIStackView()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.tintColor = backButtonColor
        button.setTitleColor(whiteColor, for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    private let wordLabel: UILabel = {
        let label = UILabel()
        label.textColor = whiteColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let cauldronImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cauldron1")
        return image
    }()
    
    // MARK:- Exit Confirmation
    private let popUpBackground: UIImageView = {
        let image = UIImageView()
        image.image = popUpBackgroundImage
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.alpha = 0.3
        return image
    }()
    
    private let exitConfirmationView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.alpha = 0
        view.isOpaque = true
        return view
    }()
    
    private let exitConfirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "Are you sure you wish to exit? This will exit the game and you'll lose your current progress"
        label.font = popupLabelFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let exitGameCancel: GameButton = {
        let button = GameButton(title: "Cancel", backgroundColor: slytherinColor, fontColor: slytherinFontColor)
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    private let exitGameConfirm: GameButton = {
        let button = GameButton(title: "Exit", backgroundColor: gryffindorColor, fontColor: gryffindorFontColor)
        button.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK:- Exit View
    private func presentBackConfirmationsView() {
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
    
    // MARK: - Admob
    let bannerView: GADBannerView = {
        let bannerView = GADBannerView()
        return bannerView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundVideo()
        setupViews()
        prepareWordLabel(with: wordToGuess)
        
        interstitial = GADInterstitial(adUnitID: adUnitID)
        let request = GADRequest()
        interstitial.load(request)
    }
    
    // MARK: - Setting Up Views
    private func setupViews() {
        let backButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let backButtonImage = UIImage(systemName: backButtonSymbol, withConfiguration: backButtonImageConfig)
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(wordLabel)
        wordLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        setupBannerView()
        view.addSubview(bannerView)
        bannerView.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -20, paddingRight: 0, width: 281, height: 50)
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupStackView()
        view.addSubview(keyboardView)
        keyboardView.anchor(top: nil, left: view.leftAnchor, bottom: bannerView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 150)
        
        view.addSubview(cauldronImage)
        cauldronImage.anchor(top: wordLabel.bottomAnchor, left: nil, bottom: keyboardView.topAnchor, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: -5, paddingRight: 0, width: screenWidth * 0.5, height: screenWidth * 0.5)
        cauldronImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        cauldronImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupStackView() {
        
        convertStringToButton()
        
        let topStackView = createHorizontalStackView(for: topButtons)
        let middleStackView = createHorizontalStackView(for: middleButtons)
        let bottomStackView = createHorizontalStackView(for: bottomButtons)
        
        keyboardView = UIStackView(arrangedSubviews: [topStackView, middleStackView, bottomStackView])
        keyboardView.distribution = .fillEqually
        keyboardView.axis = .vertical
        keyboardView.alignment = .center
        keyboardView.spacing = 12
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
    
    // MARK:- Exit StackView
    private var exitStackView = UIStackView()
    private func setupExitStackView() {
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
    
    private func createHorizontalStackView(for buttons: [UIButton]) -> UIStackView {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 5
        buttons.forEach { (button) in
            sv.addArrangedSubview(button)
        }
        return sv
    }
    
    private func convertStringToButton() {
        topCharacters.forEach { (character) in
            topButtons.append(createButton(withText: character))
        }

        middleCharacters.forEach { (character) in
            middleButtons.append(createButton(withText: character))
        }

        bottomCharacters.forEach { (character) in
            bottomButtons.append(createButton(withText: character))
        }
    }
    
    private var tagIndex = 0
    private func createButton(withText text: String) -> UIButton {
        tagIndex += 1
        let button = UIButton(type: .system)
        button.setTitleColor(blackColor, for: .normal)
        button.backgroundColor = whiteColor
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleKeyboardPressed(_:)), for: .touchUpInside)
        button.tag = tagIndex
        return button
    }
    
    final func resetKeyboard() {
        resetButtons(for: topButtons)
        resetButtons(for: middleButtons)
        resetButtons(for: bottomButtons)
    }
    
    private func resetButtons(for buttons: [UIButton]) {
        buttons.forEach { (button) in
            resetButton(for: button)
        }
    }
    
    private func resetButton(for button: UIButton) {
        button.backgroundColor = whiteColor
        button.isEnabled = true
    }
    
    // converting word to underscores and spaces
    private func prepareWordLabel(with word: String) {
        underscoreString = ""
        underscoreArray.removeAll()
        wordToGuessArray.removeAll()
        currentWordArray.removeAll()
        
        for char in word {
            if char != " " {
                underscoreString += " _ "
                underscoreArray.append(" _ ")
            } else {
                underscoreString += "  "
                underscoreArray.append("  ")
            }
        }
        wordLabel.text = underscoreString
        for char in wordToGuess { wordToGuessArray.append(String(char)) }
        wordCountForAds += 1
    }
    
    // MARK: - Button Actions
    @objc func backTapped() {
        presentBackConfirmationsView()
        vibrate()
    }
    
    @objc func confirmTapped() {
        self.navigationController?.popViewController(animated: true)
        //resetGame()
        vibrate()
    }
    
    @objc func cancelTapped() {
        UIView.animate(withDuration: 1) {
            self.exitConfirmationView.alpha = 0
        }
        backButton.isEnabled = true
        vibrate()
    }
    
    // Keyboard buttons tapped
    @objc private func handleKeyboardPressed(_ button: UIButton) {
        var endString = ""
        button.isEnabled = false
        var matched = false
        var newRound = false
        
        if let text = button.titleLabel?.text {
            guessedCharacters.append(text)
            
            if wordToGuessArray.contains(text) {
                matched = true
                for (index, char) in wordToGuessArray.enumerated() {
                    if char == text {
                        underscoreArray[index] = char
                    }
                }
            } else {
                wrongGuesses += 1
                if wrongGuesses > cauldronArray.count - 1{
                    wrongGuesses = 0
                }
                cauldronImage.image = UIImage(named: cauldronArray[wrongGuesses])
            }
            
            
            // alerting the player that the letters have all been guessed
            if !underscoreArray.contains(" _ ") {
                if hangmanIndex != hangmanWordList.count {
                    hangmanIndex += 1
                } else {
                    hangmanIndex = 0
                }

                wordToGuess = hangmanWordList[hangmanIndex].word.uppercased()
                prepareWordLabel(with: wordToGuess)
                resetKeyboard()
                wrongGuesses = 0
                cauldronImage.image = UIImage(named: cauldronArray[wrongGuesses])
                newRound = true
            }
            
            endString = underscoreArray.joined(separator: " ")
            wordLabel.text = endString
            if !newRound { button.backgroundColor = matched ? .green : .red }
            
        }
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
}
