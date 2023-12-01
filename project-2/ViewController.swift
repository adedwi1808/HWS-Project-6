//
//  ViewController.swift
//  project-2
//
//  Created by Ade Dwi Prayitno on 29/11/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score: Int = 0
    var correctAnswer: Int = 0
    var correctAnswerText: String = ""
    var totalAnsweredQuestion: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries.append(
            contentsOf: ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    @objc func showScore() {
        let ac = UIAlertController(
            title: "Current Score",
            message: "Your current score is \(score)",
            preferredStyle: .alert
        )
        
        ac.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: {_ in }))
        
        present(ac, animated: true)
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(
            UIImage(named: countries[0]),
            for: .normal
        )
        button2.setImage(
            UIImage(named: countries[1]),
            for: .normal
        )
        button3.setImage(
            UIImage(named: countries[2]),
            for: .normal
        )
        
        correctAnswerText = countries[correctAnswer].uppercased()
        
        title = "\(correctAnswerText) : \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        if sender.tag == correctAnswer {
            title = "Correct"
            message = "Your Score is \(score)"
            score += 1
        } else {
            title = "Wrong"
            message = "The correct answer is \(correctAnswerText)"
            score -= 1
        }
        
        totalAnsweredQuestion += 1
        
        if totalAnsweredQuestion < 10 {
            let ac = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "Your Final Score is \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Restart Game", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        }
    }
    
    func restartgame(action: UIAlertAction! = nil) {
        score = 0
        totalAnsweredQuestion = 0
        askQuestion()
    }
}

