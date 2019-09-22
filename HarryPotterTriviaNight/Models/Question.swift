//
//  Question.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 6/21/19.
//  Copyright © 2019 HaroldDavidson. All rights reserved.
//

import Foundation

var questionList = [Question]()
var questionIndex = 0

class Question {
    let category: String
    let question: String
    let answer: String
    
    init(category: String, question: String, answer: String) {
        self.category = category
        self.question = question
        self.answer = answer
    }
}

func convertJSON(jsonToRead: String, numberOfTeams: Int) {
    // clearing out the questionArr before converting JSON
    var questionArr = [Question]()
    
    guard let path = Bundle.main.path(forResource: jsonToRead, ofType: "json") else { return }
    let url = URL(fileURLWithPath: path)
    
    do {
        let data = try Data(contentsOf: url)
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        
        guard let jsonArray = json as? [Any] else { return }
        
        for questionAnswer in jsonArray {
            guard let questionAndAnswer = questionAnswer as? [String: Any] else { return }
            
            // assigning the values in the JSON to local variables
            guard let category = questionAndAnswer["category"] as? String else { return }
            guard let question = questionAndAnswer["question"] as? String else { return }
            guard let answer = questionAndAnswer["answer"] as? String else { return }
            
            // creating a new instance of the Question object
            let qa = Question(category: category, question: question, answer: answer)
            
            // appending the recently converted JSON object to an array of Question objects to pull questions from
            questionArr.append(qa)
            
        } // end of the for in loop
        
        // picking 15 questions per team
        for _ in 1...numberOfTeams * 15 {
            let randomNum = (Int(arc4random_uniform(UInt32(questionArr.count))))
            questionList.append(questionArr[randomNum])
            questionArr.remove(at: randomNum)
        }
        
    } catch {
        print(error)
    }
}
