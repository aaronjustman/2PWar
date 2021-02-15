//
//  PlayerArea.swift
//  TwoPlayerWar
//
//  Created by Aaron Justman on 1/8/21.
//

import UIKit

protocol PlayButtonDelegate {
    func play(for: String)
}

@IBDesignable class PlayerArea: UIView {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var cardsLeftLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var deckImage: UIImageView!
    @IBOutlet weak var totalCardsWonLabel: UILabel!
    
    @IBInspectable var playerName: String = "New Player" {
        willSet {
            playerNameLabel.text = newValue
        }
    }
    @IBInspectable var cardsLeft: String = "26" {
        willSet {
            cardsLeftLabel.text = newValue
        }
    }
    
    var playerNumber = 0
    var playDelegate: PlayButtonDelegate!
        
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBAction func play() {
        guard playerNumber != 0 else {
            print("This button is player number 0!")
            return
        }
        
        (playerNumber == 1) ? playDelegate.play(for: "Player 1") : playDelegate.play(for: "Player 2")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bundle = Bundle(for: PlayerArea.self)
        let nib = UINib(nibName: "PlayerArea", bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
            if let view = views.last as? UIView {
                view.frame = bounds
                view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
                addSubview(view)
            }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let bundle = Bundle(for: PlayerArea.self)
        let nib = UINib(nibName: "PlayerArea", bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
            if let view = views.last as? UIView {
                view.frame = bounds
                view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
                addSubview(view)
            }
    }

}
