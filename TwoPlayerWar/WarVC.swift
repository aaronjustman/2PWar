//
//  WarVC.swift
//  TwoPlayerWar
//
//  Created by Aaron Justman on 1/8/21.
//

import UIKit

class WarVC: UIViewController {

//    @IBOutlet weak var player1Label: UILabel!
//    @IBOutlet weak var player2Label: UILabel!
//    @IBOutlet weak var player3Label: UILabel!
//    @IBOutlet weak var player3Cards: UILabel!
    
    @IBOutlet weak var player1Area: PlayerArea!
    @IBOutlet weak var player2Area: PlayerArea!
    @IBOutlet weak var playedCard1Label: UILabel!
    @IBOutlet weak var playedCard2Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print("did load?")
        
        player2Area.playerNameLabel.text = "Player 2"
        player1Area.cardsLeftLabel.text = "26"
        player2Area.cardsLeftLabel.text = "26"
        player2Area.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
//        player2Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//        player3Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//        player3Cards.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
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
