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
    
    var player1 = [Card](), player2 = [Card]()
    var p1TotalCardsWon = 0, p2TotalCardsWon = 0
    
    var cardForP1 = true
    var p1DidPlay = false, p2DidPlay = false
    var turnIsOver = false
    var isFacingP1 = true
    var p1DidPlayWar = false,  p2DidPlayWar = false
    var isWar = false, warIsOver = false
    
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
        
        //player1Area.cardsLeftLabel.text = String(player1.count)
        player1Area.playButton.setTitle("", for: .normal)
        player1Area.totalCardsWonLabel.text = "0"
        player1Area.playerNumber = 1
        player1Area.playDelegate = self
        for view in p1WarCardsStack.arrangedSubviews {
            let imageView = view as! UIImageView
            imageView.image = .none
        }
        p1CardIV.image = .none
        
        //player2Area.playerNameLabel.text = "Player 2"
        //player2Area.cardsLeftLabel.text = String(player2.count)
        player2Area.playButton.setTitle("", for: .normal)
        player2Area.totalCardsWonLabel.text = "0"
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
        p2CardIV.image = .none
    }
    
    func play(for player: String) {
        switch player {
        case "Player 1":
            if isWar { p1PlayWar() }  else { p1Play(player1Area.playButton) }
        case "Player 2":
            if isWar { p2PlayWar() }  else { p2Play(player2Area.playButton) }
        default:
            return
        }
    }

    @IBAction func p1Play(_ sender: UIButton) {
        if turnIsOver { resetForNextTurn() }
        else {
            player1Area.playButton.isEnabled = false
            let grayDeck = UIImage(imageLiteralResourceName: "deck-gray")
            player1Area.deckImage.image = grayDeck
            if let nextCard = player1.popLast() {
                card1 = nextCard
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
            player2Area.playButton.isEnabled = false
            let grayDeck = UIImage(imageLiteralResourceName: "deck-gray")
            player2Area.deckImage.image = grayDeck
            if let nextCard = player2.popLast() {
                card2 = nextCard
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
        p1TotalCardsWon = 0
        player1Area.totalCardsWonLabel.text = "0"
        p2TotalCardsWon = 0
        player2Area.totalCardsWonLabel.text = "0"
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
        p1CardIV.image = .none
        p2CardIV.image = .none
        p1ResultLabel.isHidden = true
        p2ResultLabel.isHidden = true
        againButton.isHidden = true
        
        deck.shuffle()
        deal()
        player1Area.cardsLeft = String(player1.count)
        player2Area.cardsLeft = String(player2.count)
    }
    
    @objc func p1PlayWar() {
        if warIsOver { resetForNextTurn() }
        else {
            player1Area.playButton.isEnabled = false
            let grayDeck = UIImage(imageLiteralResourceName: "deck-gray")
            player1Area.deckImage.image = grayDeck
            var cardsToAdd = 3
            while cardsToAdd > 0 {
                if let nextCard = player1.popLast() {
                    let warCardIV = p1WarCardsStack.arrangedSubviews[cardsToAdd - 1] as! UIImageView
                    warCardIV.image = UIImage(imageLiteralResourceName: "\(nextCard.rank)-\(nextCard.suit)")
                    warCards.append(nextCard)
                    cardsToAdd -= 1
                } else { gameOver(for: "Player 1"); break; }
            }
            if let nextCard = player1.popLast() {
                card1 = nextCard
                p1CardIV.image = UIImage(imageLiteralResourceName: "\(card1.rank)-\(card1.suit)")
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
            player2Area.playButton.isEnabled = false
            let grayDeck = UIImage(imageLiteralResourceName: "deck-gray")
            player2Area.deckImage.image = grayDeck
            var cardsToAdd = 3
            while cardsToAdd > 0 {
                if let nextCard = player2.popLast() {
                    let warCardIV = p2WarCardsStack.arrangedSubviews[cardsToAdd - 1] as! UIImageView
                    warCardIV.image = UIImage(imageLiteralResourceName: "\(nextCard.rank)-\(nextCard.suit)")
                    warCards.append(nextCard)
                    cardsToAdd -= 1
                } else { gameOver(for: "Player 2"); break; }
            }
            if let nextCard = player2.popLast() {
                card2 = nextCard
                p2CardIV.image = UIImage(imageLiteralResourceName: "\(card2.rank)-\(card2.suit)")
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
            p1TotalCardsWon += 2
            if !warCards.isEmpty {
                player1.insert(contentsOf: warCards, at: 0)
                p1TotalCardsWon += warCards.count
                warCards.removeAll()
            }
        } else if card2.rank.cardValue > card1.rank.cardValue {
            if isFacingP1 { winLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi) }
            isFacingP1 = false
            winLabel.text = "Win!"
            winLabel.isHidden = false
            player2.insert(contentsOf: [card1, card2], at: 0)
            p2TotalCardsWon += 2
            if !warCards.isEmpty {
                player2.insert(contentsOf: warCards, at: 0)
                p2TotalCardsWon += warCards.count
                warCards.removeAll()
            }
        } else if card1.rank.cardValue == card2.rank.cardValue {
            isWar = true
            warIsOver = false
            p1DidPlayWar = false
            p2DidPlayWar = false
            
            winLabel.text = "WAR!"
            winLabel.isHidden = false
            p1WarCardsStack.isHidden = false
            p2WarCardsStack.isHidden = false
            
            warCards.append(card1)
            warCards.append(card2)
        }
        
        let blueDeck = UIImage(imageLiteralResourceName: "deck-blue")
        player1Area.playButton.isEnabled = true
        player1Area.deckImage.image = blueDeck
        player2Area.playButton.isEnabled = true
        player2Area.deckImage.image = blueDeck
    }
    
    func resetForNextTurn() {
        player1Area.cardsLeft = String(player1.count)
        player1Area.totalCardsWonLabel.text = String(p1TotalCardsWon)
        player2Area.cardsLeft = String(player2.count)
        player2Area.totalCardsWonLabel.text = String(p2TotalCardsWon)
        
        if warIsOver {
            p1DidPlayWar = false
            p2DidPlayWar = false
            warIsOver = false
            isWar = false
            
            for view in p1WarCardsStack.arrangedSubviews {
                let imageView = view as! UIImageView
                imageView.image = .none
            }
            for view in p2WarCardsStack.arrangedSubviews {
                let imageView = view as! UIImageView
                imageView.image = .none
            }
        }
        
        p1CardIV.image = .none
        p2CardIV.image = .none
        p1DidPlay = false
        p2DidPlay = false
        winLabel.isHidden = true
        winLabel.text = "Win!"
        turnIsOver = false
        
        let blueDeck = UIImage(imageLiteralResourceName: "deck-blue")
        player1Area.playButton.isEnabled = true
        player1Area.deckImage.image = blueDeck
        player2Area.playButton.isEnabled = true
        player2Area.deckImage.image = blueDeck
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
