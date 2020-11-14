//
//  Globals.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 10/24/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit

let backgroundImage         =   UIImage(named: "clouds.jpg")!
var titleLabelFont          =   UIFont(name: "ParryHotter", size: 30)
var instructionLabelFont    =   UIFont(name: "Papyrus", size: 20)
let crimsonColor            =   UIColor.rgb(red: 125, green: 25, blue: 21, alpha: 1)
let hufflepuffColor         =   UIColor.rgb(red: 238, green: 182, blue: 69, alpha: 1)
let ravenclawColor          =   UIColor.rgb(red: 26, green: 27, blue: 76, alpha: 1)
let slytherinColor          =   UIColor.rgb(red: 54, green: 118, blue: 75, alpha: 1)
let buttonTitleColor        =   UIColor.rgb(red: 238, green: 182, blue: 69, alpha: 1)
//let buttonFont              =   UIFont(name: "ParryHotter", size: 20)
var buttonFont              =   UIFont(name: "Harry P", size: 30)
let answerFont              =   UIFont(name: "Harry P", size: 30)
var textViewFont            =   UIFont(name: "Papyrus", size: 15)
var buttonHeight: CGFloat   =   0
var soloScore               =   0
let gryffindorFontColor     =   UIColor.rgb(red: 235, green: 192, blue: 66, alpha: 1)
let hufflepuffFontColor     =   UIColor.rgb(red: 20, green: 20, blue: 35, alpha: 1)
let ravenclawFontColor      =   UIColor.rgb(red: 199, green: 199, blue: 208, alpha: 1)
let slytherinFontColor      =   UIColor.rgb(red: 186, green: 185, blue: 195, alpha: 1)
// TEST
//let adUnitID                =   "ca-app-pub-3940256099942544/4411468910"
// PROD
let adUnitID                =   "ca-app-pub-6504174477930496/7071782026"
let finalScoreLabelFont     =   UIFont(name: "Harry P", size: 70)
func resetGame() {
    soloScore             =   0
    soloQuestionIndex     =   0
    questionIndex         =   0
    currentTeam           =   0
    soloQuestionList.removeAll()
    questionList.removeAll()
    teams.removeAll()
}
