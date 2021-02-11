//
//  Stats.swift
//  TwoPlayerWar
//
//  Created by Aaron Justman on 2/11/21.
//

import Foundation

struct Stats {
    
    let player1, player2: [Card]
    var startTime, endTime: Date!
    var matchTime: Double = 0
    var p1TotalCardsWon = 0, p2TotalCardsWon = 0
    var p1TotalHandsWon = 0, p2TotalHandsWon = 0
    var p1WarsWon = 0, p2WarsWon = 0
    
    init(player1: [Card], player2: [Card]) {
        self.player1 = player1
        self.player2 = player2
        
        startTime = Date()
    }
    
}
