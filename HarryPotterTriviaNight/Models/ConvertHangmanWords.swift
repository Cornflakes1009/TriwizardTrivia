//
//  ConvertHangmanWords.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 3/20/22.
//  Copyright © 2022 HaroldDavidson. All rights reserved.
//

import UIKit

var hangmanWordList = [HangmanWords]()
var hangmanIndex = 0

struct HangmanWords {
    var category: String
    var word: String
}

func convertHangmanonJSON(jsonToRead: String) {
    // clearing out the questionArr before converting JSON
    hangmanWordList.removeAll()
    
    guard let path = Bundle.main.path(forResource: jsonToRead, ofType: "json") else { return }
    let url = URL(fileURLWithPath: path)
    
    do {
        let data = try Data(contentsOf: url)
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        
        guard let jsonArray = json as? [Any] else { return }
        
        for questionAnswer in jsonArray {
            guard let words = questionAnswer as? [String: Any] else { return }
            
            guard let category = words["category"] as? String else { return }
            guard let word = words["word"] as? String else { return }

            let hangmanWord = HangmanWords(category: category, word: word)
            
            hangmanWordList.append(hangmanWord)
            
        } // end of the for in loop
        
        hangmanWordList.shuffle()
        
        hangmanWordList = [hangmanWordList[0], hangmanWordList[1], hangmanWordList[2]]
        
    } catch {
        print(error)
    }
}

