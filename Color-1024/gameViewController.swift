//
//  gameViewController.swift
//  Color-1024
//
//  Created by Air on 2/22/15.
//  Copyright (c) 2015 mzk. All rights reserved.
//

import UIKit

class gameViewController: UIViewController {
  
  @IBOutlet var highscoreLabel: UILabel!
  @IBOutlet var scoreLabel: UILabel!
  @IBOutlet var ShowNumSwich: UISwitch!
  @IBOutlet var Score: UILabel!
  @IBOutlet var highscore: UILabel!
  @IBOutlet var img00: UIImageView!
  @IBOutlet var img01: UIImageView!
  @IBOutlet var img02: UIImageView!
  @IBOutlet var img03: UIImageView!
  @IBOutlet var img10: UIImageView!
  @IBOutlet var img11: UIImageView!
  @IBOutlet var img12: UIImageView!
  @IBOutlet var img13: UIImageView!
  @IBOutlet var img20: UIImageView!
  @IBOutlet var img21: UIImageView!
  @IBOutlet var img22: UIImageView!
  @IBOutlet var img23: UIImageView!
  @IBOutlet var img30: UIImageView!
  @IBOutlet var img31: UIImageView!
  @IBOutlet var img32: UIImageView!
  @IBOutlet var img33: UIImageView!
  @IBOutlet var numLabel00: UILabel!
  @IBOutlet var numLabel01: UILabel!
  @IBOutlet var numLabel02: UILabel!
  @IBOutlet var numLabel03: UILabel!
  @IBOutlet var numLabel10: UILabel!
  @IBOutlet var numLabel11: UILabel!
  @IBOutlet var numLabel12: UILabel!
  @IBOutlet var numLabel13: UILabel!
  @IBOutlet var numLabel20: UILabel!
  @IBOutlet var numLabel21: UILabel!
  @IBOutlet var numLabel22: UILabel!
  @IBOutlet var numLabel23: UILabel!
  @IBOutlet var numLabel30: UILabel!
  @IBOutlet var numLabel31: UILabel!
  @IBOutlet var numLabel32: UILabel!
  @IBOutlet var numLabel33: UILabel!
  
  var hanteiUp :Bool = true
  var hanteiDown :Bool = true
  var hanteiRight :Bool = true
  var hanteiLeft :Bool = true
  var showNumSwich :Bool = true
  var banAttackCheck :Bool = false
  var timeAttackCheck :Bool = false
  var score = 0
  var kaisu = -1
  var finishNum = 0
  var scoretimes :Double = 0
  var bord:[[Int]] = [[0,0,0,0] ,[0,0,0,0] ,[0,0,0,0] ,[0,0,0,0]]
  var bordtemp:[[Int]] = [[0,0,0,0] ,[0,0,0,0] ,[0,0,0,0] ,[0,0,0,0]]
  var check:[Int] = [0,0,0,0]
  let bordimg = [
    UIImage(named: "0.png"),
    UIImage(named: "1.png"),
    UIImage(named: "2.png"),
    UIImage(named: "3.png"),
    UIImage(named: "4.png"),
    UIImage(named: "5.png"),
    UIImage(named: "6.png"),
    UIImage(named: "7.png"),
    UIImage(named: "8.png"),
    UIImage(named: "9.png"),
    UIImage(named: "10.png"),
    UIImage(named: "11.png"),
    UIImage(named: "12.png"),
    UIImage(named: "13.png")
  ]
  
  //時間計測用の変数.
  var cnt :Float = 0
  var timer :NSTimer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    ImplementationsGestures()

  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    var temp = 0
    
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    banAttackCheck = appDelegate.bantimesCheck
    timeAttackCheck = appDelegate.timeattackCheck
    
    finishNum = appDelegate.finishNum
    
    // SwitchをOnに設定する.
    ShowNumSwich.on = true
    //highscoreの取得
    // NSUserDefaultsインスタンスの生成
    let userDefaults = NSUserDefaults.standardUserDefaults()

    if(banAttackCheck == true){
      scoreLabel.text = "回数"
      highscoreLabel.text = "ベスト回数"
      temp = userDefaults.integerForKey("high-kaisu")
      if(temp == 0){
        temp = 9999
      }
      highscore.text = "\(temp)回"
    }else if(timeAttackCheck == true){
      scoreLabel.text = "Time"
      highscoreLabel.text = "最小時間"
      //timerを生成する.
      timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
      temp = userDefaults.integerForKey("hightime")
      if(temp==0){
        temp = 99999
      }
      highscore.text = "\(temp)"
    }else{
      scoreLabel.text = "Score"
      highscoreLabel.text = "HighScore"
      // キーが"saveText"のIntegerをとります。
      temp = userDefaults.integerForKey("highscore")
      highscore.text = "\(temp)"
    }
    
    appear()
    appear()
    show()
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

  //  Implementation of Swipe Gestures
  func ImplementationsGestures() {
    // Left Swipe Gesture
    var leftSwipeGesture: UISwipeGestureRecognizer  = UISwipeGestureRecognizer(target: self, action: "MakeSomeThingUnique:")
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.Left
    
    // Right Swipe Gesture
    var rightSwipeGesture: UISwipeGestureRecognizer  = UISwipeGestureRecognizer(target: self, action: "MakeSomeThingUnique:")
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.Right
    
    // Up Swipe Gesture
    var upSwipeGesture: UISwipeGestureRecognizer  = UISwipeGestureRecognizer(target: self, action: "MakeSomeThingUnique:")
    upSwipeGesture.direction = UISwipeGestureRecognizerDirection.Up
    
    // Down Swipe Gesture
    var downSwipeGesture: UISwipeGestureRecognizer  = UISwipeGestureRecognizer(target: self, action: "MakeSomeThingUnique:")
    downSwipeGesture.direction = UISwipeGestureRecognizerDirection.Down
    
    // Adding Gestures into the self view's GestureRecogniser.
    self.view.addGestureRecognizer(leftSwipeGesture)
    self.view.addGestureRecognizer(rightSwipeGesture)
    self.view.addGestureRecognizer(upSwipeGesture)
    self.view.addGestureRecognizer(downSwipeGesture)
  }
  
  func MakeSomeThingUnique(sender: UISwipeGestureRecognizer) {
    switch(sender.direction){
    case UISwipeGestureRecognizerDirection.Right:
      check=[0,0,0,0]
      scoretimes=0
      pazzleRight()
      if(check != [0,0,0,0]){
        appear()
        show()
        points()
        hanteiRight = true
        hanteiLeft = true
        hanteiUp = true
        hanteiDown = true
        println("\(bord[0])")
        println("\(bord[1])")
        println("\(bord[2])")
        println("\(bord[3])")
        if(check == [2,2,2,2]){
          if(timeAttackCheck == true){
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
            appDelegate.timetemp = self.cnt
          }else{
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
            appDelegate.score = self.score
          }
          let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
          GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
          self.presentViewController(GameOverView, animated: true, completion: nil)
        }
      }else{
        hanteiRight = false
        if(hanteiRight == false &&
          hanteiLeft == false &&
          hanteiUp == false &&
          hanteiDown == false){
            if(timeAttackCheck == true){
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.timetemp = self.cnt
            }else{
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.score = self.score
            }
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
        }
      }
      break;
    case UISwipeGestureRecognizerDirection.Left:
      check=[0,0,0,0]
      scoretimes=0
      pazzleLeft()
      if(check != [0,0,0,0]){
        appear()
        show()
        points()
        println("\(bord[0])")
        println("\(bord[1])")
        println("\(bord[2])")
        println("\(bord[3])")
        hanteiRight = true
        hanteiLeft = true
        hanteiUp = true
        hanteiDown = true
        if(check == [2,2,2,2]){
          if(timeAttackCheck == true){
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
            appDelegate.timetemp = self.cnt
          }else{
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
            appDelegate.score = self.score
          }
          let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
          GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
          self.presentViewController(GameOverView, animated: true, completion: nil)
        }
      }else{
        hanteiLeft = false
        if(hanteiRight == false &&
          hanteiLeft == false &&
          hanteiUp == false &&
          hanteiDown == false){
            if(timeAttackCheck == true){
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.timetemp = self.cnt
            }else{
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.score = self.score
            }
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
        }
      }
      break;
    case UISwipeGestureRecognizerDirection.Up:
      check=[0,0,0,0]
      scoretimes=0
      pazzleup()
      if(check != [0,0,0,0]){
        appear()
        show()
        points()
        println("\(bord[0])")
        println("\(bord[1])")
        println("\(bord[2])")
        println("\(bord[3])")
        hanteiRight = true
        hanteiLeft = true
        hanteiUp = true
        hanteiDown = true
        if(check == [2,2,2,2]){
          if(timeAttackCheck == true){
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
            appDelegate.timetemp = self.cnt
          }else{
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
            appDelegate.score = self.score
          }
          let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
          GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
          self.presentViewController(GameOverView, animated: true, completion: nil)
        }
      }else{
        hanteiUp = false
        if(hanteiRight == false &&
          hanteiLeft == false &&
          hanteiUp == false &&
          hanteiDown == false){
            if(timeAttackCheck == true){
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.timetemp = self.cnt
            }else{
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.score = self.score
            }
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
        }
      }
      break;
    case UISwipeGestureRecognizerDirection.Down:
      check=[0,0,0,0]
      scoretimes=0
      pazzledown()
      if(check != [0,0,0,0]){
        appear()
        show()
        points()
        println("\(bord[0])")
        println("\(bord[1])")
        println("\(bord[2])")
        println("\(bord[3])")
        hanteiRight = true
        hanteiLeft = true
        hanteiUp = true
        hanteiDown = true
        if(check == [2,2,2,2]){
          if(timeAttackCheck == true){
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
            appDelegate.timetemp = self.cnt
          }else{
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
            appDelegate.score = self.score
          }
          let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
          GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
          self.presentViewController(GameOverView, animated: true, completion: nil)
        }
      }else{
        hanteiDown = false
        if(hanteiRight == false &&
          hanteiLeft == false &&
          hanteiUp == false &&
          hanteiDown == false){
            if(timeAttackCheck == true){
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.timetemp = self.cnt
            }else{
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.score = self.score
            }
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
        }
      }
      break;
    default:
      println ("Not Swipe")
      break;
    }
    
  }
  
  func pazzleLeft(){
    for k in 0...3 {
      if(bord[k][0] != 0){
        if(bord[k][0]==bord[k][1]){
          bord[k][0] = bord[k][0]*2
          bord[k][1] = 0
          check[0] = 1
          check[1] = 1
          scoretimes++
        }else if(bord[k][1]==0 && bord[k][0]==bord[k][2]){
          bord[k][0] = bord[k][0]*2
          bord[k][2] = 0
          check[0]=1
          check[2]=1
          scoretimes++
        }else if(bord[k][1]==0 && bord[k][2]==0 && bord[k][0]==bord[k][3]){
          bord[k][0] = bord[k][0]*2
          bord[k][3] = 0
          check[0]=1
          check[3]=1
          scoretimes++
        }
      }
      if(bord[k][1] != 0){
        if(bord[k][1]==bord[k][2]){
          bord[k][1]=bord[k][1]*2
          bord[k][2]=0
          check[1]=1
          check[2]=1
          scoretimes++
        }else if(bord[k][2]==0 && bord[k][1]==bord[k][3]){
          bord[k][1] = bord[k][1]*2
          bord[k][3] = 0
          check[1]=1
          check[3]=1
          scoretimes++
        }
      }
      if(bord[k][2] != 0){
        if(bord[k][2]==bord[k][3]){
          bord[k][2]=bord[k][2]*2
          bord[k][3]=0
          check[2]=1
          check[3]=1
          scoretimes++
        }
      }
    }
    
    for l in 0...3 {
      for k in 0...3 {
        if(bord[k][0]==0){
          bord[k][0]=bord[k][1]
          bord[k][1]=bord[k][2]
          bord[k][2]=bord[k][3]
          bord[k][3]=0
          check[0]=1
        }else if(bord[k][1]==0){
          bord[k][1]=bord[k][2]
          bord[k][2]=bord[k][3]
          bord[k][3]=0
          check[1]=1
        }else if(bord[k][2]==0){
          bord[k][2]=bord[k][3]
          bord[k][3]=0
          check[2]=1
        }
      }
    }
  }
  
  func pazzleRight() {
    for k in 0...3 {
      if(bord[k][3] != 0){
        if(bord[k][3]==bord[k][2]){
          bord[k][3] = bord[k][3]*2
          bord[k][2] = 0
          check[3] = 1
          check[2] = 1
          scoretimes++
        }else if(bord[k][2]==0 && bord[k][3]==bord[k][1]){
          bord[k][3] = bord[k][3]*2
          bord[k][1] = 0
          check[3]=1
          check[1]=1
          scoretimes++
        }else if(bord[k][2]==0 && bord[k][1]==0 && bord[k][3]==bord[k][0]){
          bord[k][3] = bord[k][3]*2
          bord[k][0] = 0
          check[3]=1
          check[0]=1
          scoretimes++
        }
      }
      if(bord[k][2] != 0){
        if(bord[k][2]==bord[k][1]){
          bord[k][2]=bord[k][2]*2
          bord[k][1]=0
          check[2]=1
          check[1]=1
          scoretimes++
        }else if(bord[k][1]==0 && bord[k][2]==bord[k][0]){
          bord[k][2] = bord[k][2]*2
          bord[k][0] = 0
          check[2]=1
          check[0]=1
          scoretimes++
        }
      }
      if(bord[k][1] != 0){
        if(bord[k][1]==bord[k][0]){
          bord[k][1]=bord[k][1]*2
          bord[k][0]=0
          check[1]=1
          check[0]=1
          scoretimes++
        }
      }
    }
    
    for l in 0...3 {
      for k in 0...3 {
        if(bord[k][3]==0){
          bord[k][3]=bord[k][2]
          bord[k][2]=bord[k][1]
          bord[k][1]=bord[k][0]
          bord[k][0]=0
          check[3]=1
        }else if(bord[k][2]==0){
          bord[k][2]=bord[k][1]
          bord[k][1]=bord[k][0]
          bord[k][0]=0
          check[2]=1
        }else if(bord[k][1]==0){
          bord[k][1]=bord[k][0]
          bord[k][0]=0
          check[1]=1
        }
      }
    }
  }
  
  func pazzleup() {
    for k in 0...3 {
      if(bord[0][k] != 0){
        if(bord[0][k]==bord[1][k]){
          bord[0][k] = bord[0][k]*2
          bord[1][k] = 0
          check[0] = 1
          check[1] = 1
          scoretimes++
          println("a")
        }else if(bord[1][k]==0 && bord[0][k]==bord[2][k]){
          bord[0][k] = bord[0][k]*2
          bord[2][k] = 0
          check[0]=1
          check[2]=1
          scoretimes++
          println("b")
        }else if(bord[1][k]==0 && bord[2][k]==0 && bord[0][k]==bord[3][k]){
          bord[0][k] = bord[0][k]*2
          bord[3][k] = 0
          check[0]=1
          check[3]=1
          scoretimes++
          println("c")
        }
      }
      if(bord[1][k] != 0){
        if(bord[1][k]==bord[2][k]){
          bord[1][k]=bord[1][k]*2
          bord[2][k]=0
          check[1]=1
          check[2]=1
          scoretimes++
          println("d")
        }else if(bord[2][k]==0 && bord[1][k]==bord[3][k]){
          bord[1][k] = bord[1][k]*2
          bord[3][k] = 0
          check[1]=1
          check[3]=1
          scoretimes++
          println("e")
        }
      }
      if(bord[2][k] != 0){
        if(bord[2][k]==bord[3][k]){
          bord[2][k]=bord[2][k]*2
          bord[3][k]=0
          check[2]=1
          check[3]=1
          scoretimes++
          println("f")
        }
      }
    }
    
    for l in 0...3 {
      for k in 0...3 {
        if(bord[0][k]==0){
          bord[0][k]=bord[1][k]
          bord[1][k]=bord[2][k]
          bord[2][k]=bord[3][k]
          bord[3][k]=0
          check[0]=1
          println("g")
        }else if(bord[1][k]==0){
          bord[1][k]=bord[2][k]
          bord[2][k]=bord[3][k]
          bord[3][k]=0
          check[1]=1
        }else if(bord[2][k]==0){
          bord[2][k]=bord[3][k]
          bord[3][k]=0
          check[2]=1
        }
      }
    }
  }
  
  func pazzledown(){
    for k in 0...3 {
      if(bord[3][k] != 0){
        if(bord[3][k]==bord[2][k]){
          bord[3][k] = bord[3][k]*2
          bord[2][k] = 0
          check[3] = 1
          check[2] = 1
          scoretimes++
        }else if(bord[2][k]==0 && bord[3][k]==bord[1][k]){
          bord[3][k] = bord[3][k]*2
          bord[1][k] = 0
          check[3]=1
          check[1]=1
          scoretimes++
        }else if(bord[2][k]==0 && bord[1][k]==0 && bord[3][k]==bord[0][k]){
          bord[3][k] = bord[3][k]*2
          bord[0][k] = 0
          check[0]=1
          check[3]=1
          scoretimes++
        }
      }
      if(bord[2][k] != 0){
        if(bord[2][k]==bord[1][k]){
          bord[2][k]=bord[2][k]*2
          bord[1][k]=0
          check[1]=1
          check[2]=1
          scoretimes++
        }else if(bord[1][k]==0 && bord[2][k]==bord[0][k]){
          bord[2][k] = bord[2][k]*2
          bord[0][k] = 0
          check[2]=1
          check[0]=1
          scoretimes++
        }
      }
      if(bord[1][k] != 0){
        if(bord[1][k]==bord[0][k]){
          bord[1][k]=bord[1][k]*2
          bord[0][k]=0
          check[1]=1
          check[0]=1
          scoretimes++
        }
      }
      
    }
    
    for l in 0...3 {
      for k in 0...3 {
        if(bord[3][k]==0){
          bord[3][k]=bord[2][k]
          bord[2][k]=bord[1][k]
          bord[1][k]=bord[0][k]
          bord[0][k]=0
          check[3]=1
        }else if(bord[2][k]==0){
          bord[2][k]=bord[1][k]
          bord[1][k]=bord[0][k]
          bord[0][k]=0
          check[2]=1
        }else if(bord[1][k]==0){
          bord[1][k]=bord[0][k]
          bord[0][k]=0
          check[1]=1
        }
      }
    }
  }
  
  func appear(){
    println("enter appear")
    var i = 0
    var j = 0
    //デバッグ用
    for i in 0...3 {
        println("test \(bord[i])")
    
    }
    //    var k:Int = 1
    //    var l:Int
    //    var w:Int = 1
    //    do {
    //      i = Int(arc4random() % 4)
    //      j = Int(arc4random() % 4)
    //    }while (bord[i][j] != 0)
    //    l = Int((arc4random() % 5) + 1)
    //    while ( k < l ){
    //      k++
    //      w *= 2
    //    }
    //    bord[i][j] = w
    do {
      i = Int(arc4random() % 4)
      j = Int(arc4random() % 4)
    }while (bord[i][j] != 0)
    bord[i][j] = 1
    println("appearOK")
  }
  
  func change(){
    for i in 0...3{
      for j in 0...3{
        if(bord[i][j]==0){
          bordtemp[i][j]=0
        }else if(bord[i][j]==1){
          bord[i][j]=1
          bordtemp[i][j]=1
        }else if(bord[i][j]==2){
          bordtemp[i][j]=2
        }else if(bord[i][j]==4){
          bordtemp[i][j]=3
        }else if(bord[i][j]==8){
          bordtemp[i][j]=4
        }else if(bord[i][j]==16){
          bordtemp[i][j]=5
        }else if(bord[i][j]==32){
          bordtemp[i][j]=6
        }else if(bord[i][j]==64){
          bordtemp[i][j]=7
        }else if(bord[i][j]==128){
          bordtemp[i][j]=8
          if(finishNum==128){
            check = [2,2,2,2]
          }
        }else if(bord[i][j]==256){
          bordtemp[i][j]=9
          if(finishNum==256){
            check = [2,2,2,2]
          }
        }else if(bord[i][j]==512){
          bordtemp[i][j]=10
          if(finishNum==512){
            check = [2,2,2,2]
          }
        }else if(bord[i][j]==1024){
          bordtemp[i][j]=11
          if(finishNum==1024){
            check = [2,2,2,2]
          }
        }else if(bord[i][j]==2048){
          bordtemp[i][j]=12
          if(finishNum==2048){
            check = [2,2,2,2]
          }
        }else if(bord[i][j]==4096){
          bordtemp[i][j]=13
          if(finishNum==4096){
            check = [2,2,2,2]
          }
        }
      }
    }
  }
  func show(){
    kaisu++
    if ShowNumSwich.on == true {
      if(bord[0][0]==0){
        numLabel00.text = ""
      }else{
        numLabel00.text = "\(bord[0][0]*2)"
      }
      if(bord[0][1]==0){
        numLabel01.text = ""
      }else{
        numLabel01.text = "\(bord[0][1]*2)"
      }
      if(bord[0][2]==0){
        numLabel02.text = ""
      }else{
        numLabel02.text = "\(bord[0][2]*2)"
      }
      if(bord[0][3]==0){
        numLabel03.text = ""
      }else{
        numLabel03.text = "\(bord[0][3]*2)"
      }
      if(bord[1][0]==0){
        numLabel10.text = ""
      }else{
        numLabel10.text = "\(bord[1][0]*2)"
      }
      if(bord[1][1]==0){
        numLabel11.text = ""
      }else{
        numLabel11.text = "\(bord[1][1]*2)"
      }
      if(bord[1][2]==0){
        numLabel12.text = ""
      }else{
        numLabel12.text = "\(bord[1][2]*2)"
      }
      if(bord[1][3]==0){
        numLabel13.text = ""
      }else{
        numLabel13.text = "\(bord[1][3]*2)"
      }
      if(bord[2][0]==0){
        numLabel20.text = ""
      }else{
        numLabel20.text = "\(bord[2][0]*2)"
      }
      if(bord[2][1]==0){
        numLabel21.text = ""
      }else{
        numLabel21.text = "\(bord[2][1]*2)"
      }
      if(bord[2][2]==0){
        numLabel22.text = ""
      }else{
        numLabel22.text = "\(bord[2][2]*2)"
      }
      if(bord[2][3]==0){
        numLabel23.text = ""
      }else{
        numLabel23.text = "\(bord[2][3]*2)"
      }
      if(bord[3][0]==0){
        numLabel30.text = ""
      }else{
        numLabel30.text = "\(bord[3][0]*2)"
      }
      if(bord[3][1]==0){
        numLabel31.text = ""
      }else{
        numLabel31.text = "\(bord[3][1]*2)"
      }
      if(bord[3][2]==0){
        numLabel32.text = ""
      }else{
        numLabel32.text = "\(bord[3][2]*2)"
      }
      if(bord[3][3]==0){
        numLabel33.text = ""
      }else{
        numLabel33.text = "\(bord[3][3]*2)"
      }
    }else{
      numLabel00.text = ""
      numLabel01.text = ""
      numLabel02.text = ""
      numLabel03.text = ""
      numLabel10.text = ""
      numLabel11.text = ""
      numLabel12.text = ""
      numLabel13.text = ""
      numLabel20.text = ""
      numLabel21.text = ""
      numLabel22.text = ""
      numLabel23.text = ""
      numLabel30.text = ""
      numLabel31.text = ""
      numLabel32.text = ""
      numLabel33.text = ""
    }
    
    change()
    
    var i = 0
    for i in 0...3{
      println("\(bordtemp[i])")
    }
    img00.image = bordimg[bordtemp[0][0]]
    img01.image = bordimg[bordtemp[0][1]]
    img02.image = bordimg[bordtemp[0][2]]
    img03.image = bordimg[bordtemp[0][3]]
    img10.image = bordimg[bordtemp[1][0]]
    img11.image = bordimg[bordtemp[1][1]]
    img12.image = bordimg[bordtemp[1][2]]
    img13.image = bordimg[bordtemp[1][3]]
    img20.image = bordimg[bordtemp[2][0]]
    img21.image = bordimg[bordtemp[2][1]]
    img22.image = bordimg[bordtemp[2][2]]
    img23.image = bordimg[bordtemp[2][3]]
    img30.image = bordimg[bordtemp[3][0]]
    img31.image = bordimg[bordtemp[3][1]]
    img32.image = bordimg[bordtemp[3][2]]
    img33.image = bordimg[bordtemp[3][3]]
  }
  func points(){
    switch scoretimes{
    case 0:
      break
    case 1:
      score += 10
    case 2:
      score += 30
    case 3:
      score += 50
    case 4:
      score += 80
    case 5:
      score += 120
    default :
      score = score + Int(scoretimes * 2.5)
    }
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    if(banAttackCheck == true){
      Score.text = "\(kaisu)回"
      score = kaisu
    }else if(timeAttackCheck == true){
    }else{
      Score.text = "\(score)"
    }
  }
  
  
  //モンテカルロ法で最適な動かし方を求める．
  @IBAction func auto(){
    var upCount = 0
    var downCount = 0
    var rightCount = 0
    var leftCount = 0
    var upScore = 0
    var downScore = 0
    var leftScore = 0
    var rightScore = 0
    for i in 0...3 {
      for j in 0...3 {
        bordtemp[i][j] = bord[i][j]
      }
    }
    check = [0,0,0,0]
    pazzleup()
    upScore = Int(scoretimes)
    scoretimes = 0
    while(check != [0,0,0,0]){
      println("up\(check)")
      appear()
      check = [0,0,0,0]
      upCount++
      montekaruro()
      if(upCount==20) {
        break
      }
    }
    println("upFinish\(upCount)")
    for i in 0...3 {
      for j in 0...3 {
        bord[i][j] = bordtemp[i][j]
      }
    }
    check = [0,0,0,0]
    pazzledown()
    downScore = Int(scoretimes)
    scoretimes = 0
    while(check != [0,0,0,0]){
      println("down\(check)")
      appear()
      check = [0,0,0,0]
      downCount++
      montekaruro()
      if(downCount==20) {
        break
      }
    }
    println("downFinish\(downCount)")
    for i in 0...3 {
      for j in 0...3 {
        bord[i][j] = bordtemp[i][j]
      }
    }
    check = [0,0,0,0]
    pazzleLeft()
    leftScore = Int(scoretimes)
    scoretimes = 0
    while(check != [0,0,0,0]){
      println("Left\(check)")
      appear()
      check = [0,0,0,0]
      leftCount++
      montekaruro()
      if(leftCount==20){
        break
      }
    }
    println("leftFinish\(leftCount)")
    for i in 0...3 {
      for j in 0...3 {
        bord[i][j] = bordtemp[i][j]
      }
    }
    check = [0,0,0,0]
    pazzleRight()
    rightScore = Int(scoretimes)
    scoretimes = 0
    while(check != [0,0,0,0]){
      println("RIGHT\(check)")
      appear()
      check = [0,0,0,0]
      rightCount++
      montekaruro()
      if(rightCount==20){
        break
      }
    }
    println("rightFinish\(rightCount)")
    for i in 0...3 {
      for j in 0...3 {
        bord[i][j] = bordtemp[i][j]
      }
    }
    
    //一番良かった方向に動かす．同じ場合は上から
    var k = max(upCount, downCount, leftCount, rightCount)
    if( k==upCount && k==downCount && k==leftCount && k==rightCount ){
      k = max(upScore, downScore, leftScore, rightScore)
      switch k {
      case rightScore:
        check=[0,0,0,0]
        scoretimes=0
        pazzleRight()
        if(check != [0,0,0,0]){
          appear()
          show()
          points()
          hanteiRight = true
          hanteiLeft = true
          hanteiUp = true
          hanteiDown = true
          if(check == [2,2,2,2]){
            if(timeAttackCheck == true){
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.timetemp = self.cnt
            }else{
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.score = self.score
            }
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }else{
          hanteiRight = false
          if(rightCount == 0 &&
            leftCount == 0 &&
            upCount == 0 &&
            downCount == 0){
              if(timeAttackCheck == true){
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.timetemp = self.cnt
              }else{
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.score = self.score
              }
              let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
              GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
              self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }
      case leftScore:
        check=[0,0,0,0]
        scoretimes=0
        pazzleLeft()
        if(check != [0,0,0,0]){
          println("\(check)")
          appear()
          show()
          points()
          hanteiRight = true
          hanteiLeft = true
          hanteiUp = true
          hanteiDown = true
          if(check == [2,2,2,2]){
            if(timeAttackCheck == true){
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.timetemp = self.cnt
            }else{
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.score = self.score
            }
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }else{
          hanteiLeft = false
          if(rightCount == 0 &&
            leftCount == 0 &&
            upCount == 0 &&
            downCount == 0){
              if(timeAttackCheck == true){
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.timetemp = self.cnt
              }else{
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.score = self.score
              }
              let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
              GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
              self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }
      case downScore:
        check=[0,0,0,0]
        scoretimes=0
        pazzledown()
        if(check != [0,0,0,0]){
          println("\(check)")
          appear()
          show()
          points()
          hanteiRight = true
          hanteiLeft = true
          hanteiUp = true
          hanteiDown = true
          if(check == [2,2,2,2]){
            if(timeAttackCheck == true){
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.timetemp = self.cnt
            }else{
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.score = self.score
            }
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }else{
          hanteiDown = false
          if(rightCount == 0 &&
            leftCount == 0 &&
            upCount == 0 &&
            downCount == 0){
              if(timeAttackCheck == true){
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.timetemp = self.cnt
              }else{
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.score = self.score
              }
              let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
              GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
              self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }
      case upScore:
        check=[0,0,0,0]
        scoretimes=0
        pazzleup()
        if(check != [0,0,0,0]){
          println("\(check)")
          appear()
          show()
          points()
          hanteiRight = true
          hanteiLeft = true
          hanteiUp = true
          hanteiDown = true
          if(check == [2,2,2,2]){
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
            appDelegate.score = self.score
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }else{
          hanteiUp = false
          if(rightCount == 0 &&
            leftCount == 0 &&
            upCount == 0 &&
            downCount == 0){
              if(timeAttackCheck == true){
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.timetemp = self.cnt
              }else{
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.score = self.score
              }
              let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
              GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
              self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }
      default :
        break
      }
    }else{
      switch k {
      case upCount:
        check=[0,0,0,0]
        scoretimes=0
        pazzleup()
        if(check != [0,0,0,0]){
          appear()
          show()
          points()
          hanteiRight = true
          hanteiLeft = true
          hanteiUp = true
          hanteiDown = true
          if(check == [2,2,2,2]){
            if(timeAttackCheck == true){
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.timetemp = self.cnt
            }else{
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.score = self.score
            }
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }else{
          hanteiUp = false
          if(rightCount == 0 &&
            leftCount == 0 &&
            upCount == 0 &&
            downCount == 0){
              if(timeAttackCheck == true){
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.timetemp = self.cnt
              }else{
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.score = self.score
              }
              let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
              GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
              self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }
      case downCount:
        check=[0,0,0,0]
        scoretimes=0
        pazzledown()
        if(check != [0,0,0,0]){
          println("\(check)")
          appear()
          show()
          points()
          hanteiRight = true
          hanteiLeft = true
          hanteiUp = true
          hanteiDown = true
          if(check == [2,2,2,2]){
            if(timeAttackCheck == true){
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.timetemp = self.cnt
            }else{
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.score = self.score
            }
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }else{
          hanteiDown = false
          if(rightCount == 0 &&
            leftCount == 0 &&
            upCount == 0 &&
            downCount == 0){
              if(timeAttackCheck == true){
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.timetemp = self.cnt
              }else{
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.score = self.score
              }
              let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
              GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
              self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }
      case leftCount:
        check=[0,0,0,0]
        scoretimes=0
        pazzleLeft()
        if(check != [0,0,0,0]){
          println("\(check)")
          appear()
          show()
          points()
          hanteiRight = true
          hanteiLeft = true
          hanteiUp = true
          hanteiDown = true
          if(check == [2,2,2,2]){
            if(timeAttackCheck == true){
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.timetemp = self.cnt
            }else{
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.score = self.score
            }
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }else{
          hanteiLeft = false
          if(rightCount == 0 &&
            leftCount == 0 &&
            upCount == 0 &&
            downCount == 0){
              if(timeAttackCheck == true){
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.timetemp = self.cnt
              }else{
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.score = self.score
              }
              let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
              GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
              self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }
      case rightCount:
        check=[0,0,0,0]
        scoretimes=0
        pazzleRight()
        if(check != [0,0,0,0]){
          println("\(check)")
          appear()
          show()
          points()
          hanteiRight = true
          hanteiLeft = true
          hanteiUp = true
          hanteiDown = true
          if(check == [2,2,2,2]){
            if(timeAttackCheck == true){
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.timetemp = self.cnt
            }else{
              var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
              appDelegate.score = self.score
            }
            let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Clear") as UIViewController
            GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }else{
          hanteiRight = false
          if(rightCount == 0 &&
            leftCount == 0 &&
            upCount == 0 &&
            downCount == 0){
              if(timeAttackCheck == true){
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.timetemp = self.cnt
              }else{
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.score = self.score
              }
              let GameOverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameOver") as UIViewController
              GameOverView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
              self.presentViewController(GameOverView, animated: true, completion: nil)
          }
        }
      default :
        break
      }
    }
  }
  
  func montekaruro() {
    var i :Int = Int(arc4random() % 4)
    switch i {
    case 0:
      pazzleup()
      println("0")
    case 1:
      pazzledown()
      println("1")
    case 2:
      pazzleLeft()
      println("2")
    case 3:
      pazzleRight()
      println("3")
    default :
      println("4")
        break;
    }
  }
  
  func onUpdate(timer : NSTimer){
    cnt += 0.1
    //桁数を指定して文字列を作る.
    let str = "".stringByAppendingFormat("%.1f",cnt)
    Score.text = "\(str)秒"
    }

}
