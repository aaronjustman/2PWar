//
//  StatsVC.swift
//  TwoPlayerWar
//
//  Created by Aaron Justman on 2/14/21.
//

import UIKit

class StatsVC: UIViewController {
    
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

        // Do any additional setup after loading the view.
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
