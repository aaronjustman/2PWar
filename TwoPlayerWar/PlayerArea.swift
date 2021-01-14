//
//  PlayerArea.swift
//  TwoPlayerWar
//
//  Created by Aaron Justman on 1/8/21.
//

import UIKit

@IBDesignable class PlayerArea: UIView {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var cardsLeftLabel: UILabel!
    
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
        
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
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
