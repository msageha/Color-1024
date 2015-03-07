//
//  GameOverViewController.swift
//  Color-1024
//
//  Created by Air on 2/23/15.
//  Copyright (c) 2015 mzk. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
  
  var banAttackCheck :Bool = false
  var timeAttackCheck :Bool = false
  var score = 0
  
  @IBOutlet var scoreLabel: UILabel!
  @IBOutlet var scoreNumLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
      score = appDelegate.score
      banAttackCheck = appDelegate.bantimesCheck
      timeAttackCheck = appDelegate.timeattackCheck

      if(banAttackCheck == true){
        scoreLabel.text = "回数"
        scoreNumLabel.text = "\(score)回"
      }else if(timeAttackCheck == true){
        scoreLabel.text = "Time"
        scoreNumLabel.text = "\(score)秒"
        
      }else{
        scoreLabel.text =  "Score"
        scoreNumLabel.text = "\(score)"
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
