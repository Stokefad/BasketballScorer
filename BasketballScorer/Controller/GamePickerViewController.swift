//
//  File.swift
//  BasketballScorer
//
//  Created by Igor-Macbook Pro on 09/12/2018.
//  Copyright © 2018 Igor-Macbook Pro. All rights reserved.
//

import UIKit

class GamePickerViewController : UIViewController {
    
    var teamOne : String?
    var teamTwo : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func basketballPicked(_ sender: UIButton) {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        
        let destVC = mainSB.instantiateViewController(withIdentifier: String(describing: BasketballViewController.self)) as! BasketballViewController
        
        destVC.teamOne = teamOne
        destVC.teamTwo = teamTwo
        
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    @IBAction func streetballPicked(_ sender: UIButton) {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        
        let destVC = mainSB.instantiateViewController(withIdentifier: String(describing: "StreetBallViewController")) as! StreetBallViewController
        
        destVC.teamOne = teamOne
        destVC.teamTwo = teamTwo
        
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
