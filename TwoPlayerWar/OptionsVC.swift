//
//  OptionsVC.swift
//  TwoPlayerWar
//
//  Created by Aaron Justman on 5/14/21.
//

import UIKit

protocol OptionsDelegate {
    func updateWarCardsTo(numberOfCards: Int)
    func resetGame()
}

class OptionsVC: UIViewController {
    
    var delegate: OptionsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateWarCards(sender: UISlider) {
        delegate?.updateWarCardsTo(numberOfCards: Int(sender.value))
    }
    
    @IBAction func resetGame() {
        delegate?.resetGame()
    }
    
    @IBAction func cancel() {
        dismiss(animated: true)
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
