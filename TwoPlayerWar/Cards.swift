//
//  Cards.swift
//  TwoPlayerWar
//
//  Created by Aaron Justman on 1/19/21.
//

// Totally promoted from https://codereview.stackexchange.com/a/219993

import Foundation

enum Suit: String, CaseIterable {
    case clubs = "Clubs"
    case diamonds = "Diamonds"
    case hearts = "Hearts"
    case spades = "Spades"
}

enum Rank: String, CaseIterable {
    case two = "Two"
    case three = "Three"
    case four = "Four"
    case five = "Five"
    case six = "Six"
    case seven = "Seven"
    case eight = "Eight"
    case nine = "Nine"
    case ten = "Ten"
    case jack = "Jack"
    case queen = "Queen"
    case king = "King"
    case ace = "Ace"
}

struct Card {
    let suit: Suit
    let rank: Rank
}

extension Card: CustomStringConvertible {
    var description: String {
        return rank.rawValue + " of " + suit.rawValue
    }
}

/*
 usage:
 
var deck: [Card] = []
for suit in Suit.allCases {
    for rank in Rank.allCases {
        let newCard = Card(suit: suit, rank: rank)
        deck.append(newCard)
    }
}
 */

