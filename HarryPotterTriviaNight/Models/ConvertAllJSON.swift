//
//  ConvertAllJSON.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 12/12/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import Foundation

func convertAllJSON(jsonToRead: String) {
    // clearing out the questionArr before converting JSON
    var questionArr = [AllQuestion]()
    
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
            guard let answer        = questionAndAnswer["answer"] as? Int else { return }
            guard let optionZero    = questionAndAnswer["0"] as? String else { return }
            guard let optionOne     = questionAndAnswer["1"] as? String else { return }
            guard let optionTwo     = questionAndAnswer["2"] as? String else { return }
            guard let optionThree   = questionAndAnswer["3"] as? String else { return }
            
            // creating a new instance of the Question object
            let qa = AllQuestion(category: category, question: question, answer: answer, optionZero: optionZero, optionOne: optionOne, optionTwo: optionTwo, optionThree: optionThree)
            
            // appending the recently converted JSON object to an array of Question objects to pull questions from
            questionArr.append(qa)
        } // end of the for in loop
        
        // randomly appending to array
        for _ in questionArr {
            let randomNum = (Int(arc4random_uniform(UInt32(questionArr.count))))
            allQuestionList.append(questionArr[randomNum])
            questionArr.remove(at: randomNum)
        }
        
    } catch {
        print(error)
    }
}
