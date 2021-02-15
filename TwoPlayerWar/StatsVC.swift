//
//  StatsVC.swift
//  TwoPlayerWar
//
//  Created by Aaron Justman on 2/14/21.
//

import UIKit

class StatsVC: UIViewController {
    
    @IBOutlet weak var p1StatsStack: UIStackView!
    @IBOutlet weak var p2StatsStack: UIStackView!
    
    let stats: Stats!
    
    init(stats: Stats) {
        self.stats = stats
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.stats = nil
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        p2StatsStack.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        let currentStats = stats.p1Stats + stats.p2Stats
        var currentStat = 0
        let p1WinLoseLabel = p1StatsStack.arrangedSubviews.first as! UILabel
        p1WinLoseLabel.text = (stats.winner == "Player 1") ? "WIN!" : "LOSE!"
        var bottomStack = p1StatsStack.arrangedSubviews[1] as! UIStackView
        let p1StatsValuesStack = bottomStack.arrangedSubviews[1] as! UIStackView
        for view in p1StatsValuesStack.arrangedSubviews[1...5] {
            let label = view as! UILabel
            label.text = String(currentStats[currentStat])
            currentStat += 1
        }
        
        let p2WinLoseLabel = p2StatsStack.arrangedSubviews.first as! UILabel
        p2WinLoseLabel.text = (stats.winner == "Player 2") ? "WIN!" : "LOSE!"
        bottomStack = p2StatsStack.arrangedSubviews[1] as! UIStackView
        let p2StatsValuesStack = bottomStack.arrangedSubviews[1] as! UIStackView
        for view in p2StatsValuesStack.arrangedSubviews[1...5] {
            let label = view as! UILabel
            label.text = String(currentStats[currentStat])
            currentStat += 1
        }
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
