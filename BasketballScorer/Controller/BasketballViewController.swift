//
//  BasketballViewController.swift
//  BasketballScorer
//
//  Created by Igor-Macbook Pro on 08/12/2018.
//  Copyright © 2018 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import CoreData

class BasketballViewController : UIViewController {
    
    var teamOne : String?
    var teamTwo : String?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var teamOneLabel: UILabel!
    @IBOutlet weak var teamTwoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var secondsTimeLabel: UILabel!
    
    @IBOutlet weak var teamOneCounter: UILabel!
    @IBOutlet weak var teamTwoCounter: UILabel!
    @IBOutlet weak var setGameStatusButton: UIButton!
    @IBOutlet weak var quaterLabel: UILabel!
    
    @IBOutlet weak var plusTwoB: UIButton!
    @IBOutlet weak var plusThreeB: UIButton!
    @IBOutlet weak var plusThreeBTwo: UIButton!
    @IBOutlet weak var plusTwoBTwo: UIButton!
    
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
        
        setGameStatusButton.setTitle("Start", for: .normal)
        quaterLabel.text = "1 quater"
        
    }
    
    private func countPoints(score : Int, teamPoints : [Int]) -> Int {
        var sum : Int = 0
        for item in teamPoints {
            sum += item
        }

        return score - sum
    }
    
    private func sendInfo() {
        let game = Game(context: context)
        
        game.teamOneName = teamOne
        game.teamTwoName = teamTwo
        game.date = Date.init()
        if quaters == 4 {
            game.isFinished = true
        }
        else {
            game.isFinished = false
        }
        game.minutesRemain = Int16(minutes)
        game.secondsRemain = Int16(seconds)
        game.quater = Int16(quaters)
        game.teamOneScore = Int16(teamOneC)
        game.teamTwoScore = Int16(teamTwoC)
        game.teamOneScoreTable = firstTeamPoints as NSObject
        game.teamTwoScoreTable = secondTeamPoints as NSObject
        
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.seconds -= 1
            self.secondsTimeLabel.text = "\(self.seconds)"
            self.timeLabel.text = "     \(self.minutes)"
            self.quaterLabel.text = "\(self.quaters) quater"
            if self.seconds == 0 {
                if self.minutes == 0 {
                    if self.quaters == 4 {
                        self.quaterLabel.text = "End of the game"
                        self.sendInfo()
                        self.quaters = 0
                        // Saving data if match is finished
                    }
                    self.firstTeamPoints.append(self.countPoints(score: self.teamOneC, teamPoints: self.firstTeamPoints))
                    self.secondTeamPoints.append(self.countPoints(score: self.teamTwoC, teamPoints: self.secondTeamPoints))
                    self.pauseTimer()
                    self.plusTwoB.isEnabled = false
                    self.plusThreeB.isEnabled = false
                    self.plusThreeBTwo.isEnabled = false
                    self.plusTwoBTwo.isEnabled = false
                    self.setGameStatusButton.setTitle("Start", for: .normal)
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
        timeLabel.text = "     12"
        secondsTimeLabel.text = "00"
    }
    
    private func pauseTimer() {
        timer.invalidate()
    }
    
    
    private func plusPoints(result: String, score : Int) -> Int {
        return Int(result)! + score
    }
    
    
    @IBAction func teamOnePlusTwo(_ sender: UIButton) {
        teamOneCounter.text = String(describing: plusPoints(result: teamOneCounter.text!, score: 2))
        teamOneC += 2
    }
    
    @IBAction func teamOnePlusThree(_ sender: UIButton) {
        teamOneCounter.text = String(describing: plusPoints(result: teamOneCounter.text!, score: 3))
        teamOneC += 3
    }
    
    @IBAction func teamTwoPlusThree(_ sender: UIButton) {
        teamTwoCounter.text = String(describing: plusPoints(result: teamTwoCounter.text!, score: 3))
        teamTwoC += 3
    }
    
    @IBAction func teamTwoPlusTwo(_ sender: UIButton) {
        teamTwoCounter.text = String(describing: plusPoints(result: teamTwoCounter.text!, score: 2))
        teamTwoC += 2
    }
    
    
    @IBAction func setGameStatus(_ sender: UIButton) {
        if setGameStatusButton.titleLabel?.text == "Pause" {
            setGameStatusButton.setTitle("Play", for: .normal)
            pauseTimer()
        }
        else if setGameStatusButton.titleLabel?.text == "Start" {
            setGameStatusButton.setTitle("Pause", for: .normal)
            plusTwoB.isEnabled = true
            plusThreeB.isEnabled = true
            plusThreeBTwo.isEnabled = true
            plusTwoBTwo.isEnabled = true
            startTimer()
        }
        else {
            setGameStatusButton.setTitle("Pause", for: .normal)
            startTimer()
        }
    }
    
}
