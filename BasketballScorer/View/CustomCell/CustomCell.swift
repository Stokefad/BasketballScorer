//
//  CustomCell.swift
//  BasketballScorer
//
//  Created by Igor-Macbook Pro on 11/12/2018.
//  Copyright © 2018 Igor-Macbook Pro. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var teamOne: UILabel!
    @IBOutlet weak var teamOneScore: UILabel!
    
    @IBOutlet weak var teamTwo: UILabel!
    @IBOutlet weak var teamTwoScore: UILabel!
    
    @IBOutlet weak var matchStatus: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(game : Game) {
        teamOne.text = game.teamOneName
        teamTwo.text = game.teamTwoName
        teamOneScore.text = String(describing: game.teamOneScore)
        teamTwoScore.text = String(describing: game.teamTwoScore)
        
        if game.quater == 4 {
            matchStatus.text = "End of game"
        }
        else {
            matchStatus.text = "\(String(describing: game.quater)) Quater"
        }
        
        date.text = String(describing: game.date!)
    }
    
}
