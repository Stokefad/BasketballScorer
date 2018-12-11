//
//  TeamPickerViewController.swift
//  BasketballScorer
//
//  Created by Igor-Macbook Pro on 08/12/2018.
//  Copyright © 2018 Igor-Macbook Pro. All rights reserved.
//

import UIKit

class TeamPickerViewController : UIViewController {
    
    @IBOutlet weak var teamOneTF: UITextField!
    @IBOutlet weak var teamTwoTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToGamePicker", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! GamePickerViewController
        
        if let text1 = teamOneTF.text, let text2 = teamTwoTF.text {
            destVC.teamOne = text1
            destVC.teamTwo = text2
        }
    }
    
}
