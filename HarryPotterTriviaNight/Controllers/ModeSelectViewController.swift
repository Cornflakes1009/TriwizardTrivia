//
//  ModeSelectViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 10/24/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit

class ModeSelectViewController: UIViewController {
    
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
        //        label.backgroundColor = UIColor.rgb(red: 255, green: 0, blue: 0, alpha: 1)
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
    
    let singlePlayerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Solo Mode", for: .normal)
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
        button.addTarget(self, action: #selector(soloPlayTapped), for: .touchUpInside)
        return button
    }()
    
    let partyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Party Mode", for: .normal)
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
        button.addTarget(self, action: #selector(partyPlayTapped), for: .touchUpInside)
        return button
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    func setupViews() {
        //self.view.backgroundColor = UIColor(patternImage:  backgroundImage)
        let screenHeight = UIScreen.main.bounds.size.height
        // setting the buttonHeight for each button in the game
        buttonHeight = screenHeight / 10
        
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        view.addSubview(instructionLabel)
        instructionLabel.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        setupStackView()
        view.addSubview(creditsButton)
        creditsButton.anchor(top: stackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    var stackView = UIStackView()
    // MARK: Setting Up the StackView
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [singlePlayerButton, partyButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        // calculating based on the number of buttons in stack view and adding 20 padding
        let stackViewHeight = CGFloat(Int(buttonHeight) * stackView.arrangedSubviews.count + 40)
        
        view.addSubview(stackView)
        stackView.anchor(top: instructionLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: stackViewHeight)
    }
    
    @objc func partyPlayTapped() {
        let vc = self.storyboard?.instantiateViewController(identifier: "PartyRulesViewController") as! PartyRulesViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func soloPlayTapped() {
        let vc = self.storyboard?.instantiateViewController(identifier: "SoloPlayViewController") as! SoloPlayViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
    @objc func creditsTapped() {
        let vc = self.storyboard?.instantiateViewController(identifier: "GameCreditsViewController") as! GameCreditsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vibrate()
    }
    
}
