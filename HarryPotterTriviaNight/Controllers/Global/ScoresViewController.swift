//
//  ScoresViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 12/14/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit
import MessageUI
import AVFoundation

class ScoresViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var player: AVPlayer?
    var triviaPercentage = 0
    var wordPercentage = 0
    
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
        button.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Scores
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Scores"
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
    
    let totalNumberOfQuestionsLabel: UILabel = {
        let label = UILabel()
        label.font = scoreViewFont
        label.textColor = whiteColor
        label.text = "Trivia Answered: \(totalNumberOfQuestions)"
        return label
    }()
    
    let totalNumberCorrectLabel: UILabel = {
        let label = UILabel()
        label.font = scoreViewFont
        label.textColor = whiteColor
        label.text = "Trivia Correct: \(totalNumberOfCorrect)"
        return label
    }()
    
    let triviaPercentageLabel: UILabel = {
        let label = UILabel()
        label.font = scoreViewFont
        label.textColor = whiteColor
        return label
    }()
    
    let numOfGamesPlayedLabel: UILabel = {
        let label = UILabel()
        label.font = scoreViewFont
        label.textColor = whiteColor
        label.text = "Rounds Played: \(numOfGamesPlayed)"
        return label
    }()
    
    let totalCorrectWordsLabel: UILabel = {
        let label = UILabel()
        label.font = scoreViewFont
        label.textColor = whiteColor
        label.text = "Words Correct: \(totalCorrectWords)"
        return label
    }()
    
    let totalNumberOfWordsLabel: UILabel = {
        let label = UILabel()
        label.font = scoreViewFont
        label.textColor = whiteColor
        label.text = "Words Guessed: \(totalNumberOfWords)"
        return label
    }()
    
    let wordsPercentageLabel: UILabel = {
        let label = UILabel()
        label.font = scoreViewFont
        label.textColor = whiteColor
        return label
    }()
    
    let emailButton: GameButton = {
        let button = GameButton(title: "Email", backgroundColor: gryffindorColor, fontColor: gryffindorFontColor)
        button.addTarget(nil, action: #selector(emailTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // verifying that both percentages can be calculated. If values = NaN, app will crash.
        if !(round(Double(totalNumberOfCorrect) / Double(totalNumberOfQuestions) * 100)).isNaN {
            triviaPercentage = Int(round(Double(totalNumberOfCorrect) / Double(totalNumberOfQuestions) * 100))
        } else {
            triviaPercentage = 0
        }
        
        if !(round(Double(totalCorrectWords) / Double(totalNumberOfWords) * 100)).isNaN {
            wordPercentage = Int(round(Double(totalCorrectWords) / Double(totalNumberOfWords) * 100))
        } else {
            wordPercentage = 0
        }
        
        setupViews()
        
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        player?.pause()
    }
    
    @objc func appMovedToForeground() {
        player?.play()
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
    
    // MARK: - Setup Views
    func setupViews() {
        
        playBackgroundVideo()

        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        setupStackView()
        
        view.addSubview(emailButton)
        emailButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: buttonHeight)
    }
    
    // MARK: - StackView
    var stackView = UIStackView()
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [totalNumberOfQuestionsLabel, totalNumberCorrectLabel, triviaPercentageLabel, numOfGamesPlayedLabel, totalNumberOfWordsLabel, totalCorrectWordsLabel, wordsPercentageLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        let stackViewHeight = screenHeight * 0.5
        
        triviaPercentageLabel.text = triviaPercentage == 0 ? "Trivia % Correct: N/A" : "Trivia % Correct: \(triviaPercentage)%"
        wordsPercentageLabel.text = wordPercentage == 0 ? "Words % Correct: N/A" : "Words % Correct: \(wordPercentage)%"
        
        view.addSubview(stackView)
        stackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: stackViewHeight)
    }
    
    // MARK: - Email Functions
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["spelldevelopment@gmail.com"])
            mail.setSubject("TriwizardTrivia")
            mail.setMessageBody("<p>Hello, Spell Development. I have a question, issue, or general inquiry.</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        vibrate()
    }
    
    @objc func emailTapped() {
        sendEmail()
        vibrate()
    }
}
