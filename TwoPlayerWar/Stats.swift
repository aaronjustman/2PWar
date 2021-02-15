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
    var fixedMatchTime: String {
        let totalSeconds = Int(matchTime)
        let totalMinutes = totalSeconds / 60
        let totalHours = totalMinutes / 60
        let minutesLeft = totalMinutes - (totalHours * 60)
        let secondsLeft = totalSeconds - (totalMinutes * 60)
        
        var matchTimeString = ""
        if totalHours != 0 { matchTimeString += "\(totalHours)h:"}
        matchTimeString += "\(minutesLeft)m:\(secondsLeft)s"
        
        return matchTimeString
    }
    var winner = ""
    var p1TotalCardsWon = 0, p2TotalCardsWon = 0
    var p1TotalHandsWon = 0, p2TotalHandsWon = 0
    var p1TotalHandsLost = 0, p2TotalHandsLost = 0
    var p1WarsWon = 0, p2WarsWon = 0
    var p1WarsLost = 0, p2WarsLost = 0
    
    init(player1: [Card], player2: [Card]) {
        self.player1 = player1
        self.player2 = player2
        
        startTime = Date()
    }
    
    var p1Stats: [Int] {
        return [p1TotalCardsWon, p1TotalHandsWon, p1TotalHandsLost, p1WarsWon, p1WarsLost]
    }
    
    var p2Stats: [Int] {
        return [p2TotalCardsWon, p2TotalHandsWon, p2TotalHandsLost, p2WarsWon, p2WarsLost]
    }
    
}
