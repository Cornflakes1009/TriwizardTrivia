//
//  SoloQuestions.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 10/30/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//
// Used in Classic, Blitz, and Survival
//

import Foundation

var soloQuestionList = [SoloQuestion]()
var soloQuestionIndex = 0

class SoloQuestion {
    let category: String
    let question: String
    let answer: String
    let optionZero: String
    let optionOne: String
    let optionTwo: String
    let optionThree: String
    
    init(category: String, question: String, answer: String, optionZero: String, optionOne: String, optionTwo: String, optionThree: String) {
        self.category = category
        self.question = question
        self.answer = answer
        self.optionZero = optionZero
        self.optionOne = optionOne
        self.optionTwo = optionTwo
        self.optionThree = optionThree
    }
}

func convertSoloJSON(jsonToRead: String, numberOfQuestions: Int = 0) {
    // clearing out the questionArr before converting JSON
    var questionArr = [SoloQuestion]()
    
    guard let path = Bundle.main.path(forResource: jsonToRead, ofType: "json") else { return }
    let url = URL(fileURLWithPath: path)
    
    do {
        let data = try Data(contentsOf: url)
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        
        guard let jsonArray = json as? [Any] else { return }
        
        for questionAnswer in jsonArray {
            guard let questionAndAnswer = questionAnswer as? [String: Any] else { return }
            
            // assigning the values in the JSON to local variables
            guard let category      = questionAndAnswer["category"] as? String else { return }
            guard let question      = questionAndAnswer["question"] as? String else { return }
            guard let answerIndex   = questionAndAnswer["answer"] as? Int else { return }
            guard let optionZero    = questionAndAnswer["0"] as? String else { return }
            guard let optionOne     = questionAndAnswer["1"] as? String else { return }
            guard let optionTwo     = questionAndAnswer["2"] as? String else { return }
            guard let optionThree   = questionAndAnswer["3"] as? String else { return }
            
            var answers = [optionZero, optionOne, optionTwo, optionThree]
            let answer = answers[answerIndex]
            answers.shuffle()
            
            // creating a new instance of the Question object
            let qa = SoloQuestion(category: category, question: question, answer: answer, optionZero: answers[0], optionOne: answers[1], optionTwo: answers[2], optionThree: answers[3])
            
            // appending the recently converted JSON object to an array of Question objects to pull questions from
            questionArr.append(qa)
            
        } // end of the for in loop
        
        // getting specified number of questions
        questionArr.shuffle()
        
        if numberOfQuestions != 0 {
            soloQuestionList = Array(questionArr[..<numberOfQuestions])
        } else {
            soloQuestionList = questionArr
        }
        
        
        
    } catch {
        print(error)
    }
}
