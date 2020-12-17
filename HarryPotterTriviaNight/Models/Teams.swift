//
//  Teams.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 8/18/19.
//  Copyright © 2019 HaroldDavidson. All rights reserved.
//

import Foundation

var teams = [Team]()
var currentTeam = 0

class Team {
    let name: String
    var score = 0
    
    init(name: String) {
        self.name = name
    }
}
