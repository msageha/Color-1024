//
//  ClearViewController.swift
//  Color-1024
//
//  Created by Air on 2/23/15.
//  Copyright (c) 2015 mzk. All rights reserved.
//

import UIKit

class ClearViewController: UIViewController {

  @IBOutlet var scoreLabel: UILabel!
  @IBOutlet var highScoreLabel: UILabel!
  @IBOutlet var scoreNumLabel: UILabel!
  @IBOutlet var highScoreNumLabel: UILabel!
  var hightemp = 0
  var score = 0
  var banAttackCheck :Bool = false
  var timeAttackCheck :Bool = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
      var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
      score = appDelegate.score
      banAttackCheck = appDelegate.bantimesCheck
      timeAttackCheck = appDelegate.timeattackCheck
      
      //highscoreの取得
      // NSUserDefaultsインスタンスの生成
      let userDefaults = NSUserDefaults.standardUserDefaults()
      
      //現在のゲームの種類の判定
      if(banAttackCheck == true){
        scoreLabel.text = "回数"
        highScoreLabel.text = "ベスト回数"
        
        // キーが"saveText"のStringをとります。
        hightemp = userDefaults.integerForKey("high-kaisu")
        if(hightemp == 0){
          hightemp = 9999
        }
        if(score < hightemp){
          // データ保存処理
          // NSUserDefaultsインスタンスの生成
          hightemp = score
          let userDefaults = NSUserDefaults.standardUserDefaults()
          // キー: "highscore" , 値: "<textFieldの入力値>" を格納。（idは任意）
          userDefaults.setObject(hightemp, forKey: "high-kaisu")
        }
        scoreNumLabel.text = "\(score)回"
        highScoreNumLabel.text = "\(hightemp)回"
        
      }else if(timeAttackCheck == true){
        scoreLabel.text = "Time"
        highScoreLabel.text = "ベストTime"
        
        hightemp = userDefaults.integerForKey("hightime")
        if(hightemp == 0){
          hightemp = 99999
        }
        if(score < hightemp){
          hightemp = score
          let userDefaults = NSUserDefaults.standardUserDefaults()
          userDefaults.setObject(hightemp, forKey: "hightime")
        }
        scoreNumLabel.text = "\(score)秒"
        highScoreLabel.text = "\(hightemp)秒"
        
      }else{
        // キーが"saveText"のStringをとります。
        hightemp = userDefaults.integerForKey("highscore")
      
        if(score > hightemp){
          // データ保存処理
          // NSUserDefaultsインスタンスの生成
          hightemp = score
          let userDefaults = NSUserDefaults.standardUserDefaults()
          // キー: "highscore" , 値: "<textFieldの入力値>" を格納。（idは任意）
          userDefaults.setObject(hightemp, forKey: "highscore")
        }
        scoreNumLabel.text = "\(score)"
        highScoreNumLabel.text = "\(hightemp)"
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
