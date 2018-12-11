//
//  WelcomeScreenViewController.swift
//  BasketballScorer
//
//  Created by Igor-Macbook Pro on 08/12/2018.
//  Copyright © 2018 Igor-Macbook Pro. All rights reserved.
//

import UIKit

class WelcomeScreenViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToPick", sender: self)
    }
    
    @IBAction func historyButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToHistory", sender: self)
    }
    
}
