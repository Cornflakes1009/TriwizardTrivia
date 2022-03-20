//
//  PotionsClassViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 2/13/22.
//  Copyright © 2022 HaroldDavidson. All rights reserved.
//

import UIKit

class PotionsClassViewController: UIViewController {

    private let topCharacters: [String] = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    private let middleCharacters: [String] = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
    private let bottomCharacters: [String] = ["Z", "X", "C", "V", "B", "N", "M"]

    //MARK:- UI
    private var topButtons = [UIButton]()
    private var middleButtons = [UIButton]()
    private var bottomButtons = [UIButton]()
    
    var keyboardView = UIStackView()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.tintColor = backButtonColor
        button.setTitleColor(whiteColor, for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK:- Exit Confirmation
    let popUpBackground: UIImageView = {
        let image = UIImageView()
        image.image = popUpBackgroundImage
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.alpha = 0.3
        return image
    }()
    
    let exitConfirmationView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.alpha = 0
        view.isOpaque = true
        return view
    }()
    
    let exitConfirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "Are you sure you wish to exit? This will exit the game and you'll lose your current progress"
        label.font = popupLabelFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let exitGameCancel: GameButton = {
        let button = GameButton(title: "Cancel", backgroundColor: slytherinColor, fontColor: slytherinFontColor)
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    let exitGameConfirm: GameButton = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let backButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let backButtonImage = UIImage(systemName: backButtonSymbol, withConfiguration: backButtonImageConfig)
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setupStackView()
        view.addSubview(keyboardView)
        keyboardView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 150)
       
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
    
    private func createButton(withText text: String) -> UIButton {
        let button = UIButton()
        button.setTitleColor(slytherinFontColor, for: .normal)
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }
    
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
}
