//
//  PartyRulesViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 10/29/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit

class PartyRulesViewController: UIViewController {
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "clouds")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let backButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("< Back", for: .normal)
            button.setTitleColor(buttonTitleColor, for: .normal)
            button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
            return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How to Play"
        label.textAlignment = .center
        label.layer.masksToBounds = false
        label.font = titleLabelFont
        label.textColor = buttonTitleColor
        return label
    }()
    
    let rulesTextView: UITextView = {
        let tv = UITextView()
        tv.text = """
        Party Mode is a team-based trivia game.

        Each house represents a team. A team can be 1 or many players.

        The trivia master holds the device and selects the players' houses. The first team selected goes first.

        Once each team is selected, the questions are randomly selected and each team will be asked a question.

        The trivia master must ask the question out loud and each member of the respective team whose turn it is can collaborate and provide one answer to the trivia master.

        The trivia master tells the teams what the correct answer is and marks whether the team answered correctly or not.

        Each team has 15 questions to answer and the results will be displayed after each team answers their 15 questions.

        """
        tv.textColor = .white
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = true
        return tv
    }()

    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.backgroundColor = crimsonColor
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = buttonFont
        button.isEnabled = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        let screenHeight = UIScreen.main.bounds.size.height
        let textViewHeight = CGFloat(screenHeight * 0.6)
        view.addSubview(rulesTextView)
        rulesTextView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: textViewHeight)
        
        
        view.addSubview(playButton)
        playButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: buttonHeight)
    }

    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        vibrate()
    }
    
    @objc func playTapped() {
        let vc = self.storyboard?.instantiateViewController(identifier: "PickTeamsStoryboard") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
