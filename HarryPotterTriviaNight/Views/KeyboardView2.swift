//
//  KeyboardView2.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 3/19/22.
//  Copyright © 2022 HaroldDavidson. All rights reserved.
//

import UIKit

//enum GameResult {
//    case successTile
//    case successRound
//    case win
//    case failTile
//    case failRound
//    case gameOver
//}

protocol KeyboardViewDelegate: AnyObject {
    func didTapKeyboard(button: UIButton)
}

final class KeyboardView: UIView {

    //MARK:- Properties
    weak var delegate: KeyboardViewDelegate?

    private let topCharacters: [String] = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    private let middleCharacters: [String] = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
    private let bottomCharacters: [String] = ["Z", "X", "C", "V", "B", "N", "M"]

    //MARK:- UI
    private var topButtons = [UIButton]()
    private var middleButtons = [UIButton]()
    private var bottomButtons = [UIButton]()

    //MARK:- Initialiser
    override init(frame: CGRect) {
        super.init(frame: frame)
        convertStringToButton()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:- Setup UI
    private func setupUI() {
        
        setupVerticalStackView()
    }
    
    var verticalStack = UIStackView()
    private func setupVerticalStackView() {
        verticalStack.backgroundColor = whiteColor
        let topStackView = createHorizontalStackView(for: topButtons)
        let middleStackView = createHorizontalStackView(for: middleButtons)
        let bottomStackView = createHorizontalStackView(for: bottomButtons)

        verticalStack = UIStackView(arrangedSubviews: [topStackView, middleStackView, bottomStackView])
        verticalStack.distribution = .fillEqually
        verticalStack.axis = .vertical
        verticalStack.alignment = .center
        verticalStack.spacing = 12
        
        self.addSubview(verticalStack)
    }

    //MARK:- Functions
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
    
    var tagIndex = 0
    private func createButton(withText text: String) -> UIButton {
        tagIndex += 1
        let button = UIButton(type: .system)
        button.setTitleColor(slytherinFontColor, for: .normal)
        button.setTitle(text, for: .normal)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleKeyboardPressed(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.tag = tagIndex
        return button
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

    //MARK:- Button actions
    @objc private func handleKeyboardPressed(_ button: UIButton) {
        delegate?.didTapKeyboard(button: button)
        print(button.tag)
    }

    //MARK:- Functions
//    final func update(_ button: UIButton, for result: GameResult) {
//        switch result {
//        case .successTile:
//            updateStateOf(button, toActive: true)
//        case .successRound, .win, .failRound, .gameOver:
//            break
//        case .failTile:
//            updateStateOf(button, toActive: false)
//        }
//    }
//
//    final private func updateStateOf(_ button: UIButton, toActive isActive: Bool) {
//        if isActive {
//            button.backgroundColor = .systemGreen
//        } else {
//            button.backgroundColor = .systemRed
//            button.alpha = 0.3
//            button.isEnabled = false
//        }
//    }
//
//    final func reset() {
//        resetButtons(for: topButtons)
//        resetButtons(for: middleButtons)
//        resetButtons(for: bottomButtons)
//        self.isUserInteractionEnabled = true
//    }
//
//    private func resetButtons(for buttons: [UIButton]) {
//        buttons.forEach { (button) in
//            resetButton(for: button)
//        }
//    }
//
//    private func resetButton(for button: UIButton) {
//        button.backgroundColor = .white
//        button.alpha = 1
//        button.isEnabled = true
//    }
}
