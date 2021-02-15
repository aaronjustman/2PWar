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
        
        var currentStats = stats.p1Stats
        print("stats count:", currentStats.count)
        var currentStat = 0
        var times = 0
        let p1WinLoseLabel = p1StatsStack.arrangedSubviews.first as! UILabel
        p1WinLoseLabel.text = (stats.winner == "Player 1") ? "WIN!" : "LOSE!"
        var bottomStack = p1StatsStack.arrangedSubviews[1] as! UIStackView
        for oStack in bottomStack.arrangedSubviews {
            
            let titlesStack = oStack as! UIStackView
            for iView in titlesStack.arrangedSubviews {
                print("times:", times)
                if times == 0 || times > 5 { times += 1; continue }
                
                let label = iView as! UILabel
                print("label?", label, "current stat?", currentStat , currentStats[currentStat])
                label.text = String(currentStats[currentStat])
                currentStat += 1
                times += 1
            }
        }
        
//        currentStats = stats.p2Stats
//        currentStat = 0
//        let p2WinLoseLabel = p2StatsStack.arrangedSubviews.first as! UILabel
//        p2WinLoseLabel.text = (stats.winner == "Player 2") ? "WIN!" : "LOSE!"
//        for oView in p2StatsStack.arrangedSubviews[1] {
//            let stack = oView as! UIStackView
//            for iView in stack.arrangedSubviews {
//                let label = iView as! UILabel
//                label.text = String(currentStats[currentStat])
//                currentStat += 1
//            }
//        }
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
