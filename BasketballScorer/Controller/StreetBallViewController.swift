//
//  StreetBallViewController.swift
//  BasketballScorer
//
//  Created by Igor-Macbook Pro on 08/12/2018.
//  Copyright © 2018 Igor-Macbook Pro. All rights reserved.
//

import UIKit

class StreetBallViewController : UIViewController {
    
    var teamOne : String?
    var teamTwo : String?
    
    @IBOutlet weak var teamOneLabel: UILabel!
    @IBOutlet weak var teamTwoLabel: UILabel!
    @IBOutlet weak var changeStatusButton: UIButton!
    
    @IBOutlet weak var teamOneScoreLabel: UILabel!
    @IBOutlet weak var teamTwoScoreLabel: UILabel!
    
    @IBOutlet weak var quaterLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet weak var teamOnePlusOneB: UIButton!
    @IBOutlet weak var teamOnePlusTwoB: UIButton!
    @IBOutlet weak var teamTwoPlusTwoB: UIButton!
    @IBOutlet weak var teamTwoPlusOneB: UIButton!
    
    var timer = Timer()
    var seconds : Int = 60
    var minutes : Int = 0
    var quaters : Int = 1
    
    
    var firstTeamPoints : [Int] = [Int]()
    var secondTeamPoints : [Int] = [Int]()
    
    var teamOneC : Int = 0
    var teamTwoC : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamOneLabel.text = teamOne
        teamTwoLabel.text = teamTwo
        
        changeStatusButton.setTitle("Start", for: .normal)
        quaterLabel.text = "1 quater"
        
    }
    
    private func countPoints(score : Int, teamPoints : [Int]) -> Int {
        var sum : Int = 0
        for item in teamPoints {
            sum += item
        }
        
        return score - sum
    }
    
    private func plusPoints(result: String, score : Int) -> Int {
        return Int(result)! + score
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.seconds -= 1
            self.secondsLabel.text = "\(self.seconds)"
            self.minuteLabel.text = "     \(self.minutes)"
            self.quaterLabel.text = "\(self.quaters) quater"
            if self.seconds == 0 {
                if self.minutes == 0 {
                    if self.quaters == 4 {
                        self.quaterLabel.text = "End of the game"
                        self.quaters = 0
                    }
                    self.firstTeamPoints.append(self.countPoints(score: self.teamOneC, teamPoints: self.firstTeamPoints))
                    self.secondTeamPoints.append(self.countPoints(score: self.teamTwoC, teamPoints: self.secondTeamPoints))
                    self.pauseTimer()
                    self.teamOnePlusOneB.isEnabled = false
                    self.teamOnePlusTwoB.isEnabled = false
                    self.teamTwoPlusOneB.isEnabled = false
                    self.teamTwoPlusTwoB.isEnabled = false
                    self.changeStatusButton.setTitle("Start", for: .normal)
                    self.resetTimer()
                    self.quaters += 1
                }
                else {
                    self.seconds = 60
                    self.minutes -= 1
                }
            }
        })
    }
    
    private func resetTimer() {
        pauseTimer()
        seconds = 60
        minutes = 0
        minuteLabel.text = "     12"
        secondsLabel.text = "00"
    }
    
    private func pauseTimer() {
        timer.invalidate()
    }
    
    
    @IBAction func teamOnePlusOne(_ sender: UIButton) {
        teamOneScoreLabel.text = String(describing: plusPoints(result: teamOneScoreLabel.text!, score: 1))
        teamOneC += 1
    }
    
    @IBAction func teamOnePlusTwo(_ sender: UIButton) {
        teamOneScoreLabel.text = String(describing: plusPoints(result: teamOneScoreLabel.text!, score: 2))
        teamOneC += 2
    }
    
    @IBAction func teamTwoPlusTwo(_ sender: UIButton) {
        teamTwoScoreLabel.text = String(describing: plusPoints(result: teamTwoScoreLabel.text!, score: 2))
        teamTwoC += 2
    }
    
    @IBAction func teamTwoPlusOne(_ sender: UIButton) {
        teamTwoScoreLabel.text = String(describing: plusPoints(result: teamTwoScoreLabel.text!, score: 1))
        teamTwoC += 1
    }
    
    @IBAction func changeGameStatus(_ sender: UIButton) {
        if changeStatusButton.titleLabel?.text == "Pause" {
            changeStatusButton.setTitle("Play", for: .normal)
            pauseTimer()
        }
        else if changeStatusButton.titleLabel?.text == "Start" {
            changeStatusButton.setTitle("Pause", for: .normal)
            teamOnePlusOneB.isEnabled = true
            teamOnePlusTwoB.isEnabled = true
            teamTwoPlusOneB.isEnabled = true
            teamTwoPlusTwoB.isEnabled = true
            startTimer()
        }
        else {
            changeStatusButton.setTitle("Pause", for: .normal)
            startTimer()
        }
    }
    
}
