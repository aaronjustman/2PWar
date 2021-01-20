//
//  WarVC.swift
//  TwoPlayerWar
//
//  Created by Aaron Justman on 1/8/21.
//

import UIKit

class WarVC: UIViewController {
    
    @IBOutlet weak var player1Area: PlayerArea!
    @IBOutlet weak var player2Area: PlayerArea!
    @IBOutlet weak var playedCard1Label: UILabel!
    @IBOutlet weak var playedCard2Label: UILabel!
    @IBOutlet weak var play1Button: UIButton!
    @IBOutlet weak var play2Button: UIButton!
    
    var deck = [Card]()
    
    var player1 = [Card]()
    var player2 = [Card]()
    
    var cardForP1 = true
    var p1DidPlay = false
    var p2DidPlay = false
    var turnIsOver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print("did load?")
        
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                let newCard = Card(suit: suit, rank: rank)
                deck.append(newCard)
            }
        }
        deck.shuffle()
        
        deal()
        turnIsOver = p1DidPlay && p2DidPlay
        
        player1Area.cardsLeftLabel.text = String(player1.count)
        
        player2Area.playerNameLabel.text = "Player 2"
        player2Area.cardsLeftLabel.text = String(player2.count)
        player2Area.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        playedCard2Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        play2Button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }

    @IBAction func p1Play(_ sender: UIButton) {
        sender.isHidden = true
        let card = deck.popLast()!
        playedCard1Label.text = card.description
        //p1DidPlay = true
        
        if turnIsOver { resetForNextTurn() }
    }
    
    @IBAction func p2Play(_ sender: UIButton) {
        sender.isHidden = true
        let card = deck.popLast()!
        playedCard2Label.text = card.description
        //p2DidPlay = true
        
        if turnIsOver { resetForNextTurn() }
    }
    
    func deal() {
        var cardIterator = deck.makeIterator()
        while let nextCard = cardIterator.next() {
            if cardForP1 {  player1.append(nextCard)  } else {  player2.append(nextCard) }
            cardForP1.toggle()
        }
    }
    
    func evaluateCards(card1: Card, card2: Card) {
        if card1.rank.cardValue > card2.rank.cardValue {
            
        } else if card2.rank.cardValue > card1.rank.cardValue {
            
        } else if card1.rank.cardValue == card2.rank.cardValue {
            
        }
    }
    
    func resetForNextTurn() {
        play1Button.isHidden = false
        play2Button.isHidden = false
        playedCard1Label.text = ""
        playedCard2Label.text = ""
        p1DidPlay = false
        p2DidPlay = false
        turnIsOver = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
