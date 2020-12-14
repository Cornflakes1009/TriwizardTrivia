//
//  GameButton.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 12/12/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit

class GameButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String, backgroundColor: UIColor, fontColor: UIColor) {
        super.init(frame: .zero)
        //alpha = 0.8
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitleColor(fontColor, for: .normal)
        layer.cornerRadius = 5
        //layer.borderWidth = 2
        titleLabel?.font = buttonFont
        setTitleShadowColor(.black, for: .normal)
        titleLabel?.layer.shadowRadius = 3.0
        titleLabel?.layer.shadowOpacity = 1.0
        titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 4)
        titleLabel?.layer.masksToBounds = false
        titleLabel?.font = buttonFont
        isEnabled = true
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 10.0
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        titleLabel?.alpha = 0.2
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        titleLabel?.alpha = 1
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        titleLabel?.alpha = 1
        vibrate()
    }
}
