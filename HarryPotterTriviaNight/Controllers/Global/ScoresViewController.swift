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
    let percentageAnsweredCorrectly = round(Double(totalNumberOfCorrect) / Double(totalNumberOfQuestions) * 100)
    
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
    
    // MARK:- Scores
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
        label.text = "Questions Answered: \(totalNumberOfQuestions)"
        return label
    }()
    
    let totalNumberCorrectLabel: UILabel = {
        let label = UILabel()
        label.font = scoreViewFont
        label.textColor = whiteColor
        label.text = "Correctly Answered: \(totalNumberOfCorrect)"
        return label
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = scoreViewFont
        label.textColor = whiteColor
        return label
    }()
    
    let numOfGamesPlayedLabel: UILabel = {
        let label = UILabel()
        label.font = scoreViewFont
        label.textColor = whiteColor
        label.text = "Games Played: \(numOfGamesPlayed)"
        return label
    }()
    
    let emailButton: GameButton = {
        let button = GameButton(title: "Email", backgroundColor: gryffindorColor, fontColor: gryffindorFontColor)
        button.addTarget(self, action: #selector(emailTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
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
        
        let backButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let backButtonImage = UIImage(systemName: backButtonSymbol, withConfiguration: backButtonImageConfig)
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        setupStackView()
        
        view.addSubview(emailButton)
        emailButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: buttonHeight)
    }
    
    // MARK:- StackView
    var stackView = UIStackView()
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [totalNumberCorrectLabel, totalNumberOfQuestionsLabel, numOfGamesPlayedLabel, percentageLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        let stackViewHeight = screenHeight * 0.5
        
        if percentageAnsweredCorrectly.isNaN {
            percentageLabel.text = "Percent Correct: N/A"
        } else {
            percentageLabel.text = "Percent Correct: \(percentageAnsweredCorrectly)%"
        }
        
        view.addSubview(stackView)
        stackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: stackViewHeight)
    }
    
    // MARK:- Email Functions
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
