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
    @IBOutlet weak var winLabel: UILabel!
    
    var deck = [Card]()
    
    var player1 = [Card]()
    var player2 = [Card]()
    
    var cardForP1 = true
    var p1DidPlay = false
    var p2DidPlay = false
    var turnIsOver = false
    var isFacingP1 = true
    
    var card1 = Card(suit: .clubs, rank: .two)
    var card2 = Card(suit: .clubs, rank: .two)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print("did load?")
        
        winLabel.isHidden = true
        
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                let newCard = Card(suit: suit, rank: rank)
                deck.append(newCard)
            }
        }
        deck.shuffle()
        
        deal()
        //turnIsOver = p1DidPlay && p2DidPlay
        
        player1Area.cardsLeftLabel.text = String(player1.count)
        
        player2Area.playerNameLabel.text = "Player 2"
        player2Area.cardsLeftLabel.text = String(player2.count)
        player2Area.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        playedCard2Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        play2Button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }

    @IBAction func p1Play(_ sender: UIButton) {
        if turnIsOver { resetForNextTurn() }
        else {
            //sender.isHidden = true
            card1 = player1.popLast()! //deck.popLast()!
            playedCard1Label.text = card1.description
            p1DidPlay = true
            turnIsOver = p1DidPlay && p2DidPlay
        }
        if turnIsOver { evaluateCards() }
    }
    
    @IBAction func p2Play(_ sender: UIButton) {
        if turnIsOver { resetForNextTurn() }
        else {
            //sender.isHidden = true
            card2 = player2.popLast()!
            playedCard2Label.text = card2.description
            p2DidPlay = true
            turnIsOver = p1DidPlay && p2DidPlay
        }
        if turnIsOver { evaluateCards() }
    }
    
    func deal() {
        var cardIterator = deck.makeIterator()
        while let nextCard = cardIterator.next() {
            if cardForP1 {  player1.append(nextCard)  } else {  player2.append(nextCard) }
            cardForP1.toggle()
        }
    }
    
    func evaluateCards() {
        print("card1:", card1.description, "card2:", card2.description)
        if card1.rank.cardValue > card2.rank.cardValue {
            if !isFacingP1 { winLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi) }
            isFacingP1 = true
            winLabel.isHidden = false
            player1.insert(contentsOf: [card1, card2], at: 0)
            //card1 = nil
            //card2 = nil
        } else if card2.rank.cardValue > card1.rank.cardValue {
            if isFacingP1 { winLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi) }
            isFacingP1 = false
            //winLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            winLabel.isHidden = false
            player2.insert(contentsOf: [card1, card2], at: 0)
        } else if card1.rank.cardValue == card2.rank.cardValue {
            print("WAR!")
        }
    }
    
//    func displayWinLabel() {
//        winLabel.isHidden = false
//    }
    
    func resetForNextTurn() {
        //play1Button.isHidden = false
        //play2Button.isHidden = false
        playedCard1Label.text = ""
        playedCard2Label.text = ""
        p1DidPlay = false
        p2DidPlay = false
        winLabel.isHidden = true
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
