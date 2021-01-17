//
//  ConfigureVaryingSizes.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 11/12/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit


// MARK: Screen Sizes - h x w
/*
 
 https://developer.apple.com/library/archive/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/Displays/Displays.html
 
 iPhones
 12 Pro Max                       =       926 x 428
 12, 12 Pro                       =       844 x 390
 11 Pro, Xs, X, 12m               =       812 x 375
 11 Pro Max, 11, Xs Max, XR       =       896 x 414
 8+, 7+                           =       736 x 414
 8, 7, 6s, 6s+, 6+, 6, SE2        =       667 x 375
 SE, Touch 7                      =       568 x 320


 iPads
 12.9" Pro 1-2                    =       1366 x 1024
 10.5" Pro, Air 3                 =       1112 x 834
 9.7" Pro, Air 2, Mini 5          =       1024 x 768
*/

enum Devices: CGFloat {
    case twelveProMaxHeight         =     926
    case twelveHeight               =     844
    case elevenAndProMaxHeight      =     896
    case elevenProHeight            =     812
    case eightPlusHeight            =     736
    case eightHeight                =     667
    case sEHeight                   =     568
    case bigiPadProHeight           =     1366
    case airThreeHeight             =     1112
    case airTwoHeight               =     1024
}

func varyForScreenSizes(screenHeight: CGFloat) {
    switch screenHeight {
    case Devices.twelveProMaxHeight.rawValue:
        titleLabelFont = UIFont(name: "ParryHotter", size: 60)
        textViewFont =  UIFont(name: "Papyrus", size: 20)
        instructionLabelFont = UIFont(name: "Papyrus", size: 21)
        buttonFont = UIFont(name: "Harry P", size: 60)
        scoreViewFont = UIFont(name: "Papyrus", size: 30)
        break
    case Devices.twelveHeight.rawValue:
        titleLabelFont = UIFont(name: "ParryHotter", size: 50)
        textViewFont =  UIFont(name: "Papyrus", size: 20)
        instructionLabelFont = UIFont(name: "Papyrus", size: 21)
        buttonFont = UIFont(name: "Harry P", size: 50)
        scoreViewFont = UIFont(name: "Papyrus", size: 30)
        break
    case Devices.elevenAndProMaxHeight.rawValue:
        titleLabelFont = UIFont(name: "ParryHotter", size: 55)
        textViewFont =  UIFont(name: "Papyrus", size: 20)
        instructionLabelFont = UIFont(name: "Papyrus", size: 25)
        buttonFont = UIFont(name: "Harry P", size: 55)
        scoreViewFont = UIFont(name: "Papyrus", size: 30)
        break
    case Devices.elevenProHeight.rawValue:
        titleLabelFont = UIFont(name: "ParryHotter", size: 50)
        textViewFont =  UIFont(name: "Papyrus", size: 20)
        instructionLabelFont = UIFont(name: "Papyrus", size: 21)
        buttonFont = UIFont(name: "Harry P", size: 50)
        scoreViewFont = UIFont(name: "Papyrus", size: 30)
        break
    case Devices.eightPlusHeight.rawValue:
        titleLabelFont = UIFont(name: "ParryHotter", size: 60)
        textViewFont =  UIFont(name: "Papyrus", size: 20)
        instructionLabelFont = UIFont(name: "Papyrus", size: 25)
        buttonFont = UIFont(name: "Harry P", size: 50)
        scoreViewFont = UIFont(name: "Papyrus", size: 30)
        break
    case Devices.eightHeight.rawValue:
        titleLabelFont = UIFont(name: "ParryHotter", size: 60)
        textViewFont =  UIFont(name: "Papyrus", size: 20)
        instructionLabelFont = UIFont(name: "Papyrus", size: 20)
        buttonFont = UIFont(name: "Harry P", size: 50)
        titleLabelFont = UIFont(name: "ParryHotter", size: 50)
        scoreViewFont = UIFont(name: "Papyrus", size: 25)
        break
    case Devices.sEHeight.rawValue:
        instructionLabelFont = UIFont(name: "Papyrus", size: 20)
        titleLabelFont = UIFont(name: "ParryHotter", size: 45)
        buttonFont = UIFont(name: "Harry P", size: 45)
        scoreViewFont = UIFont(name: "Papyrus", size: 20)
        break
    case Devices.bigiPadProHeight.rawValue:
        break
    case Devices.airThreeHeight.rawValue:
        break
    case Devices.airTwoHeight.rawValue:
        break
    default:
        titleLabelFont = UIFont(name: "ParryHotter", size: 30)
        break
    }
}
