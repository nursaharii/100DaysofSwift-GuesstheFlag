//
//  ViewController.swift
//  GuesstheFlag
//
//  Created by Nurşah on 12.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var Btn2: UIButton!
    @IBOutlet weak var Btn1: UIButton!
    
    var countries = [String]()
    var correctAnswer = Int()
    var score = Int()
    var btnTap = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(RetryButton))
        correctAnswer = 0
        score = 0
        btnTap = 0
        Btn1.layer.borderWidth = 1
        Btn2.layer.borderWidth = 1
        btn3.layer.borderWidth = 1

        Btn1.layer.borderColor = UIColor.lightGray.cgColor
        Btn2.layer.borderColor = UIColor.lightGray.cgColor
        btn3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        question()
    }
    func question(action : UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
        Btn1.setImage(UIImage(named: countries[0]), for: .normal)
        Btn2.setImage(UIImage(named: countries[1]), for: .normal)
        btn3.setImage(UIImage(named: countries[2]), for: .normal)
        
        
    }
    @objc func nextButton() {
            btnTap = 0
            question()
            }
    @objc func RetryButton () {
        viewDidLoad()
    }
    @IBAction func BtnTap(_ sender: UIButton) { //connect action for all buttons
        btnTap += 1
        if btnTap == 1 {
            if sender.tag == self.correctAnswer {
                self.score += 1
                self.Alert(title: "Correct", message: "Your answer is correct.")
                
            }
            else {
                if score > 0 {
                    self.score -= 1
                }
                else {
                    score = 0
                }
                self.Alert(title: "Wrong", message: "Your answer is wrong.")
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "You have no chance.", preferredStyle: UIAlertController.Style.alert)
            let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okBtn)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func Alert(title: String,message: String) {
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let nextButton = UIAlertAction(title: "Next", style: UIAlertAction.Style.default) { action in
            self.nextButton()
        }
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
                    let alertOk = UIAlertController(title: "Game Over", message:  "Total Score : \(self.score)", preferredStyle: UIAlertController.Style.alert)
                    let retryButton = UIAlertAction(title: "Retry", style: UIAlertAction.Style.default) { action in
                        self.viewDidLoad()
                    }
                    let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alertOk.addAction(retryButton)
                    alertOk.addAction(okBtn)
                    self.present(alertOk, animated: true, completion: nil)
                }
                alert.addAction(okButton)
                alert.addAction(nextButton)
                self.present(alert, animated: true, completion: nil)
            }

    
}

