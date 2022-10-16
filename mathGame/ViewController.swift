//
//  ViewController.swift
//  mathGame
//
//  Created by 董禾翊 on 2022/10/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var numberOfQuestionLable: UILabel!
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet var optionsBtns: [UIButton]!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    //隨機選取運算符號用
    var i = 0
    //運算符號
    let symbol = ["+", "-", "×", "÷"]
    //兩個數
    var numA = 0
    var numB = 0
    //正確答案
    var answer = 0
    //選項
    var options = [Int]()
    //分數
    var score = 0
    //題號
    var numOfQuestion = 0
    //答對總題數
    var rightCount = 0
    //連續答對題數
    var continuousRightCount = 0
    //時間60秒
    var time = 60
    var timer: Timer?
    //倒數計時
    @objc func countDown(){
        time -= 1
        timeLable.text = "\(time)"
        if time < 0{
            //停止計時
            timer?.invalidate()
            //顯示成績alert
            let alert = UIAlertController(title: "時間到了～", message: "你答對了\(rightCount)題，成績是\(score)分", preferredStyle: .alert)
            let replayAction = UIAlertAction(title: "再玩一次！", style: .default){_ in
                self.replay()
            }
            alert.addAction(replayAction)
            present(alert, animated: true)
            
            time = 60
            timeLable.text = "\(time)"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //時鐘動畫
        let imageView = UIImageView(frame: CGRect(x: 40, y: 67, width: 65, height: 65))
        let animatedImage = UIImage.animatedImageNamed("f37159abe6cc41b5f6b4e714279b5b9d7PtG9h4HKPrHWbVJ-", duration: 1)
        imageView.image = animatedImage
        view.addSubview(imageView)
        
        for j in 0...3{
            optionsBtns[j].isEnabled = false
        }
        next()
    }
    //重玩
    func replay(){
        startBtn.alpha = 1
        score = 0
        scoreLable.text = "\(score)"
        numOfQuestion = 1
        numberOfQuestionLable.text = "第 \(numOfQuestion) 題"
        rightCount = 0
        continuousRightCount = 0
        for j in 0...3{
            optionsBtns[j].isEnabled = false
        }
    }
    //刷新題目
    func next(){
        scoreLable.text = "\(score)"
        numOfQuestion += 1
        numberOfQuestionLable.text = "第 \(numOfQuestion) 題"
        //指派數字、答案、選項給個運算符號
        i = Int.random(in: 0...3)
        switch i{
        case 0:
            numA = Int.random(in: 1...999)
            numB = Int.random(in: 1...999)
            answer = numA + numB
            options = [numA + numB,numA + numB + Int.random(in: 1...9), numA + numB - Int.random(in: 1...9), numA + numB - 13]
        case 1:
            numA = Int.random(in: 500...999)
            numB = Int.random(in: 1...499)
            answer = numA - numB
            options = [numA - numB,numA - numB + Int.random(in: 1...9), numA - numB - Int.random(in: 1...9), numA - numB + 13]
        case 2:
            numA = Int.random(in: 1...99)
            numB = Int.random(in: 1...9)
            answer = numA * numB
            options = [numA * numB,numA * numB + Int.random(in: 1...9), numA * numB - Int.random(in: 1...9), numA * numB - 13]
        default:
            numB = Int.random(in: 2...10)
            numA = numB * Int.random(in: 2...99)
            answer = numA / numB
            options = [numA / numB,numA / numB + Int.random(in: 1...9), numA / numB - Int.random(in: 2...5), numA / numB - 1]
        }
        //問題
        questionLable.text = "\(numA) \(symbol[i]) \(numB) = ?"
        //讓選項按鈕隨機
        options.shuffle()
        for j in 0...3{
            optionsBtns[j].setTitle("\(options[j])", for: .normal)
            
        }
    }
    //開始按鈕
    @IBAction func start(_ sender: UIButton) {
        startBtn.alpha = 0
        for j in 0...3{
            optionsBtns[j].isEnabled = true
        }
        //開始倒數計時
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
    }
    //選項按鈕
    @IBAction func optionsBtn(_ sender: UIButton) {
        if Int(sender.currentTitle!) == answer{
            rightCount += 1
            continuousRightCount += 1
            if continuousRightCount < 4{
                score += 10
            }else{
                score += 30
            }
        }else{
            continuousRightCount = 0
            if score > 0{
                score -= 10
            }
        }
        next()
                
    }
    
}

