//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by yunus emre vural on 20.09.2022.
//

import UIKit
import Foundation

let imageName = "Kenny.jpg"

let image = UIImage(named: imageName)

let imageKenny = UIImageView(image: image)

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    //Variables
    var flag = true
    var timer = Timer()
    var timer2 = Timer()
    var counter = 0
    var counterClicked = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        timerLabel.textColor = UIColor.black
        scoreLabel.textColor = UIColor.black
        highscoreLabel.textColor = UIColor.black
        
        
        imageKenny.isUserInteractionEnabled = true

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickPic))
        
        imageKenny.addGestureRecognizer(gestureRecognizer)
        
        imageKenny.frame = CGRect(x:50 ,y:200, width: 80, height: 80)
        
        view.addSubview(imageKenny)

        let highestScore = UserDefaults.standard.object(forKey: "score")
        
        if let convertScoreToString = highestScore{
            highscoreLabel.text = "Highest Score: \(convertScoreToString)"
        }
                
        counter = 10
        
        timerLabel.text = "Ready..."
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction) , userInfo: nil, repeats: true)
        
        timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerFunction2) , userInfo: nil, repeats: true)
        
    }
    
    @objc func timerFunction(){
        
        timerLabel.text = String(counter)
        
        counter -= 1
  
        if counter == 0{
            
            flag = false
            timer.invalidate()
            timer2.invalidate()
            timerLabel.text = "Finished"
            
            let previousScore = UserDefaults.standard.integer(forKey: "score")
            
            if previousScore < counterClicked {
                
                UserDefaults.standard.set(counterClicked, forKey: "score")
                
                highscoreLabel.text = "Highest Score: \(String(counterClicked))"
 
            }
            
            alertPop(title: "Time is over !", message: "Play again ?")
            
            
            
            
        }
        
    }
    
    @objc func clickPic(){
        
        if flag != false && timerLabel.text != "Ready..."{
            counterClicked += 1
        }
        
        //counter += 1
        scoreLabel.text = "Score: \(String(counterClicked))"
    }
    
    @objc func timerFunction2(){
   
        let randNo = spawnRandomPosition(x: 30, y: 250)
        
        imageKenny.frame = CGRect(x:randNo.0 ,y:randNo.1, width: 80, height: 80)

    }
    
    func spawnRandomPosition(x:Int, y:Int) -> (Int, Int){
        
        let rand1 = Int.random(in: x...300)
        
        let rand2 = Int.random(in: y...500)
        
        return(Int(rand1),Int(rand2))
        
    }
    
    func alertPop(title:String,message:String){
        
        flag = true
        
        self.timerLabel.text = "Ready..."
          
          let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
          
          let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        
        let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in self.replay() }
        
          alert.addAction(okButton)
          alert.addAction(replayButton)
          self.present(alert, animated: true, completion: nil)
          
      }
    
        func replay(){
        self.counterClicked = 0
        self.scoreLabel.text = "Score: \(String(self.counterClicked))"
        self.counter = 10
        self.timerLabel.text = String(self.counter)
        
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction) , userInfo: nil, repeats: true)
        
            self.timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.timerFunction2) , userInfo: nil, repeats: true)
    }
    
    
}


