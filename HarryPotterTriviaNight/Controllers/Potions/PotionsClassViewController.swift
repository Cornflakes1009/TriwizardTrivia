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
        button.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    let winsLabel: UILabel = {
        let label = UILabel()
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.text = "W: 0"
        label.textColor = whiteColor
        return label
    }()
    
    let lossesLabel: UILabel = {
        let label = UILabel()
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.text = "L: 0"
        label.textColor = whiteColor
        return label
    }()
    
    let wordNumberLabel: UILabel = {
        let label = UILabel()
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.textColor = whiteColor
        return label
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
        button.addTarget(nil, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    private let exitGameConfirm: GameButton = {
        let button = GameButton(title: "Exit", backgroundColor: gryffindorColor, fontColor: gryffindorFontColor)
        button.addTarget(nil, action: #selector(confirmTapped), for: .touchUpInside)
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
        exitConfirmationLabel.anchor(top: exitConfirmationView.topAnchor, left: exitConfirmationView.leftAnchor, bottom: nil, right: exitConfirmationView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        setupExitStackView()
        
        UIView.animate(withDuration: 0.5) {
            self.exitConfirmationView.alpha = popUpViewAlpha
        }
    }
    
    // MARK: - Word Complete Popup
    private let wordCompletePopupView: UIView = {
        let view = UIView()
        view.backgroundColor = blackColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = whiteColor
        label.font = instructionLabelFont
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let popupWordLabel: UILabel = {
        let label = UILabel()
        label.textColor = whiteColor
        label.font = instructionLabelFont
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let nextWordButton: GameButton = {
        let button = GameButton(title: "Next Word", backgroundColor: gryffindorColor, fontColor: gryffindorFontColor)
        button.addTarget(nil, action: #selector(nextWordTapped), for: .touchUpInside)
        return button
    }()
    
    private func triggerCompleteWordPopup(with status: String) {
        backButton.isEnabled = false
        view.addSubview(wordCompletePopupView)
        wordCompletePopupView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 0)
        
        
        wordCompletePopupView.addSubview(popUpBackground)
        popUpBackground.anchor(top: wordCompletePopupView.topAnchor, left: wordCompletePopupView.leftAnchor, bottom: wordCompletePopupView.bottomAnchor, right: wordCompletePopupView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        popUpBackground.centerXAnchor.constraint(equalTo: wordCompletePopupView.centerXAnchor).isActive = true
        popUpBackground.centerYAnchor.constraint(equalTo: wordCompletePopupView.centerYAnchor).isActive = true
        
        statusLabel.text = "\(status) The word was:"
        wordCompletePopupView.addSubview(statusLabel)
        statusLabel.anchor(top: wordCompletePopupView.topAnchor, left: wordCompletePopupView.leftAnchor, bottom: nil, right: wordCompletePopupView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        popupWordLabel.text = "\(wordToGuess.capitalized)"
        wordCompletePopupView.addSubview(popupWordLabel)
        popupWordLabel.anchor(top: nil, left: wordCompletePopupView.leftAnchor, bottom: nil, right: wordCompletePopupView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        popupWordLabel.centerYAnchor.constraint(equalTo: wordCompletePopupView.centerYAnchor).isActive = true
        
        wordCompletePopupView.addSubview(nextWordButton)
        nextWordButton.anchor(top: nil, left: wordCompletePopupView.leftAnchor, bottom: wordCompletePopupView.bottomAnchor, right: wordCompletePopupView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: buttonHeight)
        
        UIView.animate(withDuration: 0.5) {
            self.wordCompletePopupView.alpha = popUpViewAlpha
        }
    }
    
    // MARK: - Admob
    private let bannerView: GADBannerView = {
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
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setupWinLossStackView()
            
        view.addSubview(wordNumberLabel)
        wordNumberLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        wordNumberLabel.text = "\(hangmanIndex + 1)/\(hangmanWordList.count)"
        
        view.addSubview(wordLabel)
        wordLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        setupBannerView()
        view.addSubview(bannerView)
        bannerView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        setupKeyboardStackView()
        view.addSubview(keyboardView)
        keyboardView.anchor(top: nil, left: view.leftAnchor, bottom: bannerView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 150)
        
        view.addSubview(cauldronImage)
        cauldronImage.anchor(top: wordLabel.bottomAnchor, left: nil, bottom: keyboardView.topAnchor, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: -5, paddingRight: 0, width: screenWidth * 0.5, height: screenWidth * 0.5)
        cauldronImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    // MARK: - AdMob Function
    func createAd() -> GADInterstitial {
        let inter = GADInterstitial(adUnitID: adUnitID)
        inter.load(GADRequest())
        return inter
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
    
    // MARK: - Win/Loss StackView
    private var winLossStackView = UIStackView()
    private func setupWinLossStackView() {
        winLossStackView = UIStackView(arrangedSubviews: [winsLabel, lossesLabel])
        winLossStackView.distribution = .fillEqually
        winLossStackView.axis = .horizontal
        winLossStackView.spacing = 10
        
        view.addSubview(winLossStackView)
        winLossStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        winLossStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: screenWidth / 3, height: 0)
    }
    
    // MARK: - Exit StackView
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
    
    // MARK: - Creating Keyboard
    private func setupKeyboardStackView() {
        
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
    
    private func createHorizontalStackView(for buttons: [UIButton]) -> UIStackView {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
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
    
    // MARK: -  Converting Word to Underscores and Spaces
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
    
    @objc func nextWordTapped() {
        UIView.animate(withDuration: 1) {
            self.wordCompletePopupView.alpha = 0
        }
        backButton.isEnabled = true
        vibrate()
    }
    
    // MARK: - Keyboard buttons tapped
    @objc private func handleKeyboardPressed(_ button: UIButton) {
        button.isEnabled = false
        vibrate()
        var matched = false
        var newRound = false
        
        
        if let text = button.titleLabel?.text {
            guessedCharacters.append(text)
            
            if wordToGuessArray.contains(text) {
                matched = true
                // replacing underscores with correctly guessed letter
                for (index, char) in wordToGuessArray.enumerated() {
                    if char == text {
                        underscoreArray[index] = char
                    }
                }
                
                // checking if all letters guessed
                if !underscoreArray.contains(" _ ") {
                    totalNumberOfWords += 1
                    defaults.setValue(totalNumberOfWords, forKey: "totalNumberOfWords")
                    
                    totalCorrectWords += 1
                    defaults.setValue(totalCorrectWords, forKey: "totalCorrectWords")
                    triggerCompleteWordPopup(with: "Outstanding!")
                    if hangmanIndex + 1 != hangmanWordList.count {
                        hangmanIndex += 1
                    } else {
                        hangmanIndex = 0
                    }
                    
                    // running ad on every 5th word
                    let totalWords = passedWords + failedWords
                    if totalWords % 5 == 0 && totalWords > 1 {
                        showInterstitial()
                    }
                    
                    wordNumberLabel.text = "\(hangmanIndex + 1)/\(hangmanWordList.count)"
                    wordToGuess = hangmanWordList[hangmanIndex].word.uppercased()
                    prepareWordLabel(with: wordToGuess)
                    resetKeyboard()
                    wrongGuesses = 0
                    passedWords += 1
                    winsLabel.text = "W: \(passedWords)"
                    newRound = true
                }
                
            } else {
                wrongGuesses += 1
                // resetting the cauldron index and incrementing failed words
                if wrongGuesses == cauldronArray.count - 1 {
                    totalNumberOfWords += 1
                    defaults.setValue(totalNumberOfWords, forKey: "totalNumberOfWords")
                    wrongGuesses = 0
                    resetKeyboard()
                    failedWords += 1
                    lossesLabel.text = "L: \(failedWords)"
                    triggerCompleteWordPopup(with: "Oh no! The potion went bad!")
                    if hangmanIndex + 1 != hangmanWordList.count {
                        hangmanIndex += 1
                    } else {
                        hangmanIndex = 0
                    }
                    wordNumberLabel.text = "\(hangmanIndex + 1)/\(hangmanWordList.count)"
                    wordToGuess = hangmanWordList[hangmanIndex].word.uppercased()
                    prepareWordLabel(with: wordToGuess)
                    newRound = true
                }
            }

            wordLabel.text = underscoreArray.joined(separator: "")
            if !newRound { button.backgroundColor = matched ? .green : .red }
            cauldronImage.image = UIImage(named: cauldronArray[wrongGuesses])
            
            
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
