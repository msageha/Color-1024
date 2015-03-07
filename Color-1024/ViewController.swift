//
//  ViewController.swift
//  Color-1024
//
//  Created by Air on 2/22/15.
//  Copyright (c) 2015 mzk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var kaisuNumLabel: UILabel!
  @IBOutlet var timeNumLabel: UILabel!
  @IBOutlet var clearNumLabel: UILabel!
  @IBOutlet var HighScoreLabel: UILabel!
  @IBOutlet var clearNum: UIStepper!
  override func viewDidLoad() {
    
    var hightemp = 0
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //highscoreの取得
    // NSUserDefaultsインスタンスの生成
    let userDefaults = NSUserDefaults.standardUserDefaults()
    // キーが"saveText"のStringをとります。
    hightemp = userDefaults.integerForKey("highscore")
    HighScoreLabel.text = "\(hightemp)"
    hightemp = userDefaults.integerForKey("high-kaisu")
    if(hightemp == 0){
      hightemp = 9999
    }
    kaisuNumLabel.text = "\(hightemp)回"
    hightemp = userDefaults.integerForKey("hightime")
    if(hightemp == 0){
      hightemp = 99999
    }
    timeNumLabel.text = "\(hightemp)秒"
  
    
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.bantimesCheck = false
    appDelegate.timeattackCheck = false
    
    clearNum.addTarget(self, action: "stepperOneChanged:", forControlEvents: UIControlEvents.ValueChanged)
    
    clearNum.minimumValue = 7
    clearNum.maximumValue = 12
    clearNum.value = 10
    
    //ボタンを押した際の数字の動く範囲
    clearNum.stepValue = 1
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func timeAttack(){
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.timeattackCheck = true
  }
  
  @IBAction func banAttack(){
    println("check")
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.bantimesCheck = true
  }
  
  func stepperOneChanged(stepper: UIStepper){
    var showNum = 2
    var temp = Int(clearNum.value)
    
    for i in 1 ... temp {
      showNum = showNum * 2
    }
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    
    appDelegate.finishNum = showNum/2
    println("\(appDelegate.finishNum)")
    clearNumLabel.text = "\(showNum)"
    
  }


}

