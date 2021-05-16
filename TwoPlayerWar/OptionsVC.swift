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
    
    @IBOutlet weak var warCardsSlider: UISlider!
    @IBOutlet weak var numberOfWarCardsLabel: UILabel!
    
    fileprivate var warCards = 3
    
    var delegate: OptionsDelegate?
    
    init(currentWarCards: Int) {
        warCards = currentWarCards
        super.init(nibName: "OptionsVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        warCardsSlider.value = Float(warCards)
        numberOfWarCardsLabel.text = "\(warCards)"
    }
    
    @IBAction func updateWarCards(_ sender: UISlider, forEvent event: UIEvent) {
        numberOfWarCardsLabel.text = "\(Int(sender.value))"
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
