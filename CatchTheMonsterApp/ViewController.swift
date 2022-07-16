//
//  ViewController.swift
//  CatchTheMonsterApp
//
//  Created by Emre Gemici on 16.07.2022.
//

import UIKit

class ViewController: UIViewController {

    var score = 0
    var timer = Timer()
    var counter = 0
    var monsterArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var monster1: UIImageView!
    @IBOutlet weak var monster2: UIImageView!
    @IBOutlet weak var monster3: UIImageView!
    @IBOutlet weak var monster4: UIImageView!
    @IBOutlet weak var monster5: UIImageView!
    @IBOutlet weak var monster6: UIImageView!
    @IBOutlet weak var monster7: UIImageView!
    @IBOutlet weak var monster8: UIImageView!
    @IBOutlet weak var monster9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.text = "Score : \(score)"
        
        
        //highscore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if(storedHighScore == nil){
            highScore = 0
            highScoreLabel.text = "High Score : \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        
        monster1.isUserInteractionEnabled = true//Kullanıcıların monsterin uzerine tıklamasını etkin hale getiyordu.
        monster2.isUserInteractionEnabled = true
        monster3.isUserInteractionEnabled = true
        monster4.isUserInteractionEnabled = true
        monster5.isUserInteractionEnabled = true
        monster6.isUserInteractionEnabled = true
        monster7.isUserInteractionEnabled = true
        monster8.isUserInteractionEnabled = true
        monster9.isUserInteractionEnabled = true
        
        monsterArray = [monster1, monster2, monster3, monster4, monster5 ,monster6, monster7, monster8, monster9]
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        monster1.addGestureRecognizer(recognizer1)
        monster2.addGestureRecognizer(recognizer2)
        monster3.addGestureRecognizer(recognizer3)
        monster4.addGestureRecognizer(recognizer4)
        monster5.addGestureRecognizer(recognizer5)
        monster6.addGestureRecognizer(recognizer6)
        monster7.addGestureRecognizer(recognizer7)
        monster8.addGestureRecognizer(recognizer8)
        monster9.addGestureRecognizer(recognizer9)
        
        //Timer
        counter = 30
        timeLabel.text = "Time : \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        // timer ın yapaacağı işlemlerin ne olucağını buradan karar veriyorum.
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideMonster), userInfo: nil, repeats: true)
        
        hideMonster()
        
    }

    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
        
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = "Time : \(counter)"
        
        if counter == 0{
            timer.invalidate() //timer ı durdurma komutu
            hideTimer.invalidate()
            
            //highScore
            if(self.score > self.highScore ){
                self.highScore = self.score
                highScoreLabel.text = "High Score : \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again!", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 30
                self.timeLabel.text = "Time : \(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideMonster), userInfo: nil, repeats: true)
            
                
            
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil )
        }
        
    }
    
    @objc func hideMonster(){
        for monster in monsterArray {
            monster.isHidden = true
        }
        let random = Int (arc4random_uniform(UInt32(monsterArray.count-1))) //rastgele sayı üretme fonkisyonu
        monsterArray[random].isHidden = false
    }


}

 
