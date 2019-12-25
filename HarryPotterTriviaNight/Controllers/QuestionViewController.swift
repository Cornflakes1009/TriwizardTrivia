//
//  QuestionViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 6/21/19.
//  Copyright © 2019 HaroldDavidson. All rights reserved.
//

import UIKit
import GoogleMobileAds

class QuestionViewController: UIViewController {

    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet var buttons: [UIButton]!
    
    var answeredCorrectly = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adding shadow
        for button in buttons {
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 5, height: 5)
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 1.0
        }
        
        // converting JSON
        convertJSON(jsonToRead: "harryPotterTriviaQuestions", numberOfTeams: teams.count)
        
        // updating UI
        teamLabel.text = teams[0].name
        questionLabel.text = "Question: \(questionList[questionIndex].question)"
        answerLabel.text = "Answer: \(questionList[questionIndex].answer)"
        nextQuestionButton.isHidden = true
        
        // starting ads on the bannerview
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        
    }
    
    // added to prevent the segue added from partial curl
    override func viewDidAppear(_ animated: Bool) {
        self.view.gestureRecognizers?.removeAll()
    }
    
    @IBAction func correctTapped(_ sender: Any) {
        correctButton.backgroundColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)
        incorrectButton.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0, blue: 0.01568627451, alpha: 1)
        answeredCorrectly = true
        nextQuestionButton.isHidden = false
    }
    
    @IBAction func incorrectTapped(_ sender: Any) {
        incorrectButton.backgroundColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)
        correctButton.backgroundColor = #colorLiteral(red: 0.02352941176, green: 0.6392156863, blue: 0.01568627451, alpha: 1)
        answeredCorrectly = false
        nextQuestionButton.isHidden = false
    }
    
    @IBAction func nextQuestionTapped(_ sender: Any) {
        
        if(answeredCorrectly) {
            teams[currentTeam].score += 1
        }
        nextQuestionButton.isHidden = true
        updateUI()
    }
    
    func updateUI() {
        if(questionIndex == (5)) { // teams.count * 15

            //performSegue(withIdentifier: "showResults", sender: nil)
            
            let vc = self.storyboard?.instantiateViewController(identifier: "ResultsStoryboard") as! ResultsViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            if(teams.count == currentTeam + 1) {
                currentTeam = 0
            } else {
                currentTeam += 1
            }

            teamLabel.text = teams[currentTeam].name
            questionLabel.text = "Question: \(questionList[questionIndex].question)"
            answerLabel.text = "Answer: \(questionList[questionIndex].answer)"
            correctButton.backgroundColor = #colorLiteral(red: 0.02352941176, green: 0.6392156863, blue: 0.01568627451, alpha: 1)
            incorrectButton.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0, blue: 0.01568627451, alpha: 1)
            questionIndex += 1
        }
    }
}

