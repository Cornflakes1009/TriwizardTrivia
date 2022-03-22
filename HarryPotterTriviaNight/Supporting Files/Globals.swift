//
//  Globals.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 10/24/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - Images
let backgroundImage         =   UIImage(named: "clouds.jpg")!
let backButtonSymbol        =   "chevron.left.square"
let closePopupSymbol        =   "xmark.square"
let popUpBackgroundImage    =   UIImage(named: "sorting_hat")

// MARK: - Audio
let buttonClick             =   URL(fileURLWithPath: Bundle.main.path(forResource: "buttonClick", ofType: "mp3")!)
var buttonAudio             =   AVAudioPlayer()

// MARK:- Fonts
var titleLabelFont          =   UIFont(name: "ParryHotter", size: 30)
var instructionLabelFont    =   UIFont(name: "Papyrus", size: 25)
var scoreViewFont           =   UIFont(name: "Papyrus", size: 15)
var popupLabelFont          =   UIFont(name: "Papyrus", size: 20)
var buttonFont              =   UIFont(name: "Harry P", size: 30)
let answerFont              =   UIFont(name: "Harry P", size: 30)
var textViewFont            =   UIFont(name: "Papyrus", size: 15)
let finalScoreLabelFont     =   UIFont(name: "Harry P", size: 70)

// MARK: - Colors
let gryffindorColor         =   UIColor.rgb(red: 125, green: 25, blue: 21, alpha: 1)
let hufflepuffColor         =   UIColor.rgb(red: 238, green: 182, blue: 69, alpha: 1)
let ravenclawColor          =   UIColor.rgb(red: 26, green: 27, blue: 76, alpha: 1)
let slytherinColor          =   UIColor.rgb(red: 54, green: 118, blue: 75, alpha: 1)
let buttonTitleColor        =   UIColor.rgb(red: 238, green: 182, blue: 69, alpha: 1)
let gryffindorFontColor     =   UIColor.rgb(red: 235, green: 192, blue: 66, alpha: 1)
let hufflepuffFontColor     =   UIColor.rgb(red: 20, green: 20, blue: 35, alpha: 1)
let ravenclawFontColor      =   UIColor.rgb(red: 199, green: 199, blue: 208, alpha: 1)
let slytherinFontColor      =   UIColor.rgb(red: 186, green: 185, blue: 195, alpha: 1)
let whiteColor              =   UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
let blackColor              =   UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 1)
let backButtonColor         =   UIColor.rgb(red: 100, green: 100, blue: 100, alpha: 1.0)

// MARK: - App Store Link
let appStoreLink            =   "https://apps.apple.com/us/app/triwizardtrivia/id1499282472"

// MARK: - AdMob
// TEST
//let adUnitID                =   "ca-app-pub-3940256099942544/4411468910"
// PROD
let adUnitID                =   "ca-app-pub-6504174477930496/7071782026"
let rewardedAdUnitID        =   "ca-app-pub-6504174477930496/3101369546"

// MARK: - Sizes
var screenWidth             =   CGFloat(0)
var screenHeight            =   CGFloat(0)
var buttonHeight            =   CGFloat(0)

// MARK: - Miscellaneous
let popUpViewAlpha          =   CGFloat(1)

// MARK: - Persistent Storage
let defaults                =   UserDefaults.standard
var totalNumberOfQuestions  =   defaults.integer(forKey: "totalNumberOfQuestions")
var totalNumberOfCorrect    =   defaults.integer(forKey: "totalNumberOfCorrect")
var numOfGamesPlayed        =   defaults.integer(forKey: "numOfGamesPlayed")

// MARK: - Game Variables
var soloTriviaFileToRead    =   ""
var allQuestionList         =   [AllQuestion]()
var correctlyAnswered       =   0
var soloScore               =   0
var completedGame           =   false

// MARK: - Game Functions
func resetGame() {
    soloScore               =   0
    soloQuestionIndex       =   0
    questionIndex           =   0
    currentTeam             =   0
    correctlyAnswered       =   0
    soloQuestionList.removeAll()
    questionList.removeAll()
    allQuestionList.removeAll()
    teams.removeAll()
}
