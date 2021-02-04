//
//  WarVC.swift
//  TwoPlayerWar
//
//  Created by Aaron Justman on 1/8/21.
//

import UIKit

class WarVC: UIViewController, PlayButtonDelegate {
    
    @IBOutlet weak var player1Area: PlayerArea!
    @IBOutlet weak var player2Area: PlayerArea!
    @IBOutlet weak var playedCard1Label: UILabel!
    @IBOutlet weak var playedCard2Label: UILabel!
    @IBOutlet weak var play1Button: UIButton!
    @IBOutlet weak var play2Button: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var p1ResultLabel: UILabel!
    @IBOutlet weak var p2ResultLabel: UILabel!
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet weak var p1WarCardsStack: UIStackView!
    @IBOutlet weak var p2WarCardsStack: UIStackView!
    @IBOutlet weak var p1CardIV: UIImageView!
    @IBOutlet weak var p2CardIV: UIImageView!
    
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
        
        winLabel.isHidden = true
        
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                let newCard = Card(suit: suit, rank: rank)
                deck.append(newCard)
            }
        }
        deck.shuffle()
        
        deal()
        
        player1Area.cardsLeftLabel.text = String(player1.count)
        player1Area.playButton.setTitle("", for: .normal)
        player1Area.playerNumber = 1
        player1Area.playDelegate = self
        for view in p1WarCardsStack.arrangedSubviews {
            let imageView = view as! UIImageView
            imageView.image = .none
        }
        
        player2Area.playerNameLabel.text = "Player 2"
        player2Area.cardsLeftLabel.text = String(player2.count)
        player2Area.playButton.setTitle("", for: .normal)
        player2Area.playerNumber = 2
        player2Area.playDelegate = self
        player2Area.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        playedCard2Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        play2Button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        p2ResultLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        for view in p2WarCardsStack.arrangedSubviews {
            let imageView = view as! UIImageView
            imageView.image = .none
        }
        p2WarCardsStack.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        p2CardIV.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    func play(for player: String) {
        switch player {
        case "Player 1":
            if !warIsOver { p1PlayWar() }  else { p1Play(player1Area.playButton) }
        case "Player 2":
            if !warIsOver { p2PlayWar() }  else { p2Play(player2Area.playButton) }
        default:
            return
        }
    }

    @IBAction func p1Play(_ sender: UIButton) {
        if turnIsOver { resetForNextTurn() }
        else {
            //play1Button.isEnabled = false
            player1Area.playButton.isEnabled = false
            if let nextCard = player1.popLast() {
                card1 = nextCard
                //playedCard1Label.text = "\(card1.rank.cardNumber)\(card1.suit.emoji)"
                p1CardIV.image = UIImage(imageLiteralResourceName: "\(card1.rank)-\(card1.suit)")
                player1Area.cardsLeft = String(player1.count)
                p1DidPlay = true
                turnIsOver = p1DidPlay && p2DidPlay
            } else { gameOver(for: "Player 1") }
        }
        if turnIsOver { evaluateCards() }
    }
    
    @IBAction func p2Play(_ sender: UIButton) {
        if turnIsOver { resetForNextTurn() }
        else {
            //play2Button.isEnabled = false
            player2Area.playButton.isEnabled = false
            if let nextCard = player2.popLast() {
                card2 = nextCard
                //playedCard2Label.text = "\(card2.rank.cardNumber)\(card2.suit.emoji)"
                p2CardIV.image = UIImage(imageLiteralResourceName: "\(card2.rank)-\(card2.suit)")
                player2Area.cardsLeft = String(player2.count)
                p2DidPlay = true
                turnIsOver = p1DidPlay && p2DidPlay
            } else { gameOver(for: "Player 2") }
        }
        if turnIsOver { evaluateCards() }
    }
    
    @IBAction func playAgain() {
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
        winLabel.text = "Win!"
        winLabel.isHidden = true
        //playedCard1Label.text = ""
        //playedCard2Label.text = ""
        p1CardIV.image = .none
        p2CardIV.image = .none
        p1ResultLabel.isHidden = true
        p2ResultLabel.isHidden = true
        againButton.isHidden = true
        
//        play1Button.setTitle("Play!", for: .normal)
//        play1Button.setTitleColor(.blue, for: .normal)
//        play1Button.setTitleColor(.lightGray, for: .disabled)
//        play1Button.removeTarget(self, action: #selector(p1PlayWar), for: .touchUpInside)
//        play1Button.addTarget(self, action: #selector(p1Play(_:)), for: .touchUpInside)
//        play1Button.isEnabled = true
//
//        play2Button.setTitle("Play!", for: .normal)
//        play2Button.setTitleColor(.blue, for: .normal)
//        play2Button.setTitleColor(.lightGray, for: .disabled)
//        play2Button.removeTarget(self, action: #selector(p2PlayWar), for: .touchUpInside)
//        play2Button.addTarget(self, action: #selector(p2Play(_:)), for: .touchUpInside)
//        play2Button.isEnabled = true
        
        deck.shuffle()
        deal()
        player1Area.cardsLeft = String(player1.count)
        player2Area.cardsLeft = String(player2.count)
    }
    
    @objc func p1PlayWar() {
        if warIsOver { resetForNextTurn() }
        else {
            play1Button.isEnabled = false
            
            var cardsToAdd = 3
            while cardsToAdd > 0 {
                if let nextCard = player1.popLast() {
                    let warCardIV = p1WarCardsStack.arrangedSubviews[cardsToAdd - 1] as! UIImageView
                    warCardIV.image = UIImage(imageLiteralResourceName: "\(nextCard.rank)-\(nextCard.suit)") //warCardLabel.text = nextCard.description
                    warCards.append(nextCard)
                    cardsToAdd -= 1
                } else { gameOver(for: "Player 1") }
            }
            if let nextCard = player1.popLast() {
                card1 = nextCard
                p1CardIV.image = UIImage(imageLiteralResourceName: "\(card1.rank)-\(card1.suit)")//playedCard1Label.text = card1.description
                player1Area.cardsLeft = String(player1.count)
                p1DidPlayWar = true
                warIsOver = p1DidPlayWar && p2DidPlayWar
            } else { gameOver(for: "Player 1") }
        }
        if warIsOver { evaluateCards() }
    }
    
    @objc func p2PlayWar() {
        if warIsOver { resetForNextTurn() }
        else {
            play2Button.isEnabled = false
            
            var cardsToAdd = 3
            while cardsToAdd > 0 {
                if let nextCard = player2.popLast() {
                    let warCardIV = p2WarCardsStack.arrangedSubviews[cardsToAdd - 1] as! UIImageView
                    warCardIV.image = UIImage(imageLiteralResourceName: "\(nextCard.rank)-\(nextCard.suit)")
                    warCards.append(nextCard)
                    cardsToAdd -= 1
                } else { gameOver(for: "Player 2") }
            }
            if let nextCard = player2.popLast() {
                card2 = nextCard
                p2CardIV.image = UIImage(imageLiteralResourceName: "\(card2.rank)-\(card2.suit)") //playedCard2Label.text = card2.description
                player2Area.cardsLeft = String(player2.count)
                p2DidPlayWar = true
                warIsOver = p1DidPlayWar && p2DidPlayWar
            } else { gameOver(for: "Player 2") }
        }
        if warIsOver { evaluateCards() }
    }
    
    func deal() {
        var cardIterator = deck.makeIterator()
        while let nextCard = cardIterator.next() {
            if cardForP1 { player1.append(nextCard)  } else { player2.append(nextCard) }
            cardForP1.toggle()
        }
    }
    
    func evaluateCards() {
        player1Area.cardsLeft = String(player1.count)
        player2Area.cardsLeft = String(player2.count)
        
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
        } else if card2.rank.cardValue > card1.rank.cardValue {
            if isFacingP1 { winLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi) }
            isFacingP1 = false
            winLabel.text = "Win!"
            winLabel.isHidden = false
            player2.insert(contentsOf: [card1, card2], at: 0)
            if !warCards.isEmpty {
                player2.insert(contentsOf: warCards, at: 0)
                warCards.removeAll()
            }
        } else if card1.rank.cardValue == card2.rank.cardValue {
            warIsOver = false
            p1DidPlayWar = false
            p2DidPlayWar = false
            
            winLabel.text = "WAR!"
            winLabel.isHidden = false
            p1WarCardsStack.isHidden = false
            p2WarCardsStack.isHidden = false
            
            warCards.append(card1)
            warCards.append(card2)
            
//            play1Button.setTitle("WAR!", for: .normal)
//            play1Button.setTitleColor(.red, for: .normal)
//            play1Button.setTitleColor(.lightGray, for: .disabled)
//            play1Button.removeTarget(self, action: #selector(p1Play(_:)), for: .touchUpInside)
//            play1Button.addTarget(self, action: #selector(p1PlayWar), for: .touchUpInside)
//
//            play2Button.setTitle("WAR!", for: .normal)
//            play2Button.setTitleColor(.red, for: .normal)
//            play2Button.setTitleColor(.lightGray, for: .disabled)
//            play2Button.removeTarget(self, action: #selector(p2Play(_:)), for: .touchUpInside)
//            play2Button.addTarget(self, action: #selector(p2PlayWar), for: .touchUpInside)
            
            //player1Area.setForWar()
            //player2Area.setForWar()
        }
        
        play1Button.isEnabled = true
        play2Button.isEnabled = true
    }
    
    func resetForNextTurn() {
        player1Area.cardsLeft = String(player1.count)
        player2Area.cardsLeft = String(player2.count)
        
        if warIsOver {
            p1DidPlayWar = false
            p2DidPlayWar = false
            warIsOver = false
            
//            p1WarCardsStack.isHidden = true
//            for view in p1WarCardsStack.arrangedSubviews {
//                if let label = view as? UILabel {
//                    label.text = ""
//                }
//            }
//
//            p2WarCardsStack.isHidden = true
//            for view in p2WarCardsStack.arrangedSubviews {
//                if let label = view as? UILabel {
//                    label.text = ""
//                }
//            }
//
//            play1Button.setTitle("Play!", for: .normal)
//            play1Button.setTitleColor(.blue, for: .normal)
//            play1Button.setTitleColor(.lightGray, for: .disabled)
//            play1Button.removeTarget(self, action: #selector(p1PlayWar), for: .touchUpInside)
//            play1Button.addTarget(self, action: #selector(p1Play(_:)), for: .touchUpInside)
//
//            play2Button.setTitle("Play!", for: .normal)
//            play2Button.setTitleColor(.blue, for: .normal)
//            play2Button.setTitleColor(.lightGray, for: .disabled)
//            play2Button.removeTarget(self, action: #selector(p2PlayWar), for: .touchUpInside)
//            play2Button.addTarget(self, action: #selector(p2Play(_:)), for: .touchUpInside)
            
            for view in p1WarCardsStack.arrangedSubviews {
                let imageView = view as! UIImageView
                imageView.image = .none
            }
            for view in p2WarCardsStack.arrangedSubviews {
                let imageView = view as! UIImageView
                imageView.image = .none
            }
        }
        
        //playedCard1Label.text = ""
        //playedCard2Label.text = ""
        p1CardIV.image = .none
        p2CardIV.image = .none
        p1DidPlay = false
        p2DidPlay = false
        winLabel.isHidden = true
        winLabel.text = "Win!"
        turnIsOver = false
        
        //play1Button.isEnabled = true
        //play2Button.isEnabled = true
        player1Area.playButton.isEnabled = true
        player2Area.playButton.isEnabled = true
    }
    
    func gameOver(for player: String) {
        print("Game over! \(player) loses!")
        
        if player == "Player 1" {
            p1ResultLabel.text = "LOSE"
            p1ResultLabel.textColor = .red
            p1ResultLabel.isHidden = false
            
            p2ResultLabel.text = "WIN"
            p2ResultLabel.textColor = .green
            p2ResultLabel.isHidden = false
        } else {
            p1ResultLabel.text = "WIN"
            p1ResultLabel.textColor = .green
            p1ResultLabel.isHidden = false
            
            p2ResultLabel.text = "LOSE"
            p2ResultLabel.textColor = .red
            p2ResultLabel.isHidden = false
        }
        
        againButton.isHidden = false
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
