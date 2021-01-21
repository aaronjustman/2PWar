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
    var p1DidPlayWar = false
    var p2DidPlayWar = false
    var warIsOver = false
    
    var card1 = Card(suit: .clubs, rank: .two)
    var card2 = Card(suit: .clubs, rank: .two)
    var warCards = [Card]()
    
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
            //card1 = player1.popLast()! //deck.popLast()!
            if let nextCard = player1.popLast() {
                card1 = nextCard
                playedCard1Label.text = card1.description
                player1Area.cardsLeft = String(player1.count)
                p1DidPlay = true
                turnIsOver = p1DidPlay && p2DidPlay
            }
        }
        if turnIsOver { evaluateCards() }
    }
    
    @IBAction func p2Play(_ sender: UIButton) {
        if turnIsOver { resetForNextTurn() }
        else {
            //sender.isHidden = true
            if let nextCard = player2.popLast() {
                card2 = nextCard
                playedCard2Label.text = card2.description
                player2Area.cardsLeft = String(player2.count)
                p2DidPlay = true
                turnIsOver = p1DidPlay && p2DidPlay
            }
        }
        if turnIsOver { evaluateCards() }
    }
    
    @objc func p1PlayWar() {
        if warIsOver { resetForNextTurn() }
        else {
            //sender.isHidden = true
            var cardsToAdd = 3
            while cardsToAdd > 0 {
                if let nextCard = player1.popLast() {
                    warCards.append(nextCard)
                    cardsToAdd -= 1
                }
            }
            //warCards.append(player1.popLast()!)
            //warCards.append(player1.popLast()!)
            //warCards.append(player1.popLast()!)
            if let nextCard = player1.popLast() {
                card1 = nextCard
                //card1 = player1.popLast()! //deck.popLast()!
                playedCard1Label.text = card1.description
                player1Area.cardsLeft = String(player1.count)
                p1DidPlayWar = true
                warIsOver = p1DidPlayWar && p2DidPlayWar
            }
        }
        if warIsOver { evaluateCards() }
    }
    
    @objc func p2PlayWar() {
        if warIsOver { resetForNextTurn() }
        else {
            //sender.isHidden = true
            var cardsToAdd = 3
            while cardsToAdd > 0 {
                if let nextCard = player2.popLast() {
                    warCards.append(nextCard)
                    cardsToAdd -= 1
                }
            }
            //warCards.append(player2.popLast()!)
            //warCards.append(player2.popLast()!)
            //warCards.append(player2.popLast()!)
            //card2 = player2.popLast()! //deck.popLast()!
            if let nextCard = player2.popLast() {
                card2 = nextCard
                playedCard2Label.text = card2.description
                player2Area.cardsLeft = String(player2.count)
                p2DidPlayWar = true
                warIsOver = p1DidPlayWar && p2DidPlayWar
            }
        }
        if warIsOver { evaluateCards() }
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
            if !isFacingP1 { winLabel.transform = CGAffineTransform(rotationAngle: CGFloat.zero) }
            isFacingP1 = true
            winLabel.text = "Win!"
            winLabel.isHidden = false
            player1.insert(contentsOf: [card1, card2], at: 0)
            if !warCards.isEmpty {
                player1.insert(contentsOf: warCards, at: 0)
                warCards.removeAll()
            }
            player1Area.cardsLeft = String(player1.count)
            //player2Area.cardsLeft = String(player2.count)
            //card1 = nil
            //card2 = nil
        } else if card2.rank.cardValue > card1.rank.cardValue {
            if isFacingP1 { winLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi) }
            isFacingP1 = false
            //winLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            winLabel.isHidden = false
            player2.insert(contentsOf: [card1, card2], at: 0)
            if !warCards.isEmpty {
                player2.insert(contentsOf: warCards, at: 0)
                warCards.removeAll()
            }
            //player1Area.cardsLeft = String(player1.count)
            player2Area.cardsLeft = String(player2.count)
        } else if card1.rank.cardValue == card2.rank.cardValue {
            print("WAR!")
            warIsOver = false
            p1DidPlayWar = false
            p2DidPlayWar = false
            
            winLabel.text = "WAR!"
            winLabel.isHidden = false
            
            play1Button.setTitle("WAR!", for: .normal)
            play1Button.setTitleColor(.red, for: .normal)
            play1Button.removeTarget(self, action: #selector(p1Play(_:)), for: .touchUpInside)
            play1Button.addTarget(self, action: #selector(p1PlayWar), for: .touchUpInside)
            
            play2Button.setTitle("WAR!", for: .normal)
            play2Button.setTitleColor(.red, for: .normal)
            play2Button.removeTarget(self, action: #selector(p2Play(_:)), for: .touchUpInside)
            play2Button.addTarget(self, action: #selector(p2PlayWar), for: .touchUpInside)
        }
    }
    
//    func displayWinLabel() {
//        winLabel.isHidden = false
//    }
    
    func resetForNextTurn() {
        //play1Button.isHidden = false
        //play2Button.isHidden = false
        
        if warIsOver {
            p1DidPlayWar = false
            p2DidPlayWar = false
            warIsOver = false
            
            play1Button.setTitle("Play!", for: .normal)
            play1Button.setTitleColor(.blue, for: .normal)
            play1Button.removeTarget(self, action: #selector(p1PlayWar), for: .touchUpInside)
            play1Button.addTarget(self, action: #selector(p1Play(_:)), for: .touchUpInside)
            
            play2Button.setTitle("Play!", for: .normal)
            play2Button.setTitleColor(.blue, for: .normal)
            play2Button.removeTarget(self, action: #selector(p2PlayWar), for: .touchUpInside)
            play2Button.addTarget(self, action: #selector(p2Play(_:)), for: .touchUpInside)
        }
        
        playedCard1Label.text = ""
        playedCard2Label.text = ""
        p1DidPlay = false
        p2DidPlay = false
        winLabel.isHidden = true
        winLabel.text = "WIN!"
        turnIsOver = false
    }
    
    func gameOver(for player: String) {
        print("Game over! \(player) loses!")
        player1.removeAll()
        player2.removeAll()
        warCards.removeAll()
        cardForP1 = true
        p1DidPlay = false
        p2DidPlay = false
        turnIsOver = false
        isFacingP1 = true
        p1DidPlayWar = false
        p2DidPlayWar = false
        warIsOver = false
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
