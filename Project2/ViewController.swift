//
//  ViewController.swift
//  Project2
//
//  Created by Андрей Бородкин on 22.06.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    
    @IBOutlet var button2: UIButton!
    
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
//        button1.layer.borderColor = UIColor.lightGray.cgColor
//        button2.layer.borderColor = UIColor.lightGray.cgColor
//        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " [Your scrore is \(score)]"
    }

    @IBAction func checkAnswer(_ sender: UIButton) {
       
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            sender.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        } completion: { finished in
            //sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { [self] finished in
           // sender.transform = CGAffineTransform(scaleX: 1, y: 1)
            var title: String
            
            
            guard round != 10 else {
                //showAlert(title: "Game over", score: score)
                checkTopScore()
                round = 0
                score = 0
                return
            }
            
            if sender.tag == correctAnswer {
                score += 1
                round += 1
                askQuestion()
                
            } else {
                title = "Wrong, that's the flag of \(countries[sender.tag].uppercased())"
                score -= 1
                round += 1
                showAlert(title: title, score: score)}
            
        }

        
       
        
    }
    
    func showAlert(title: String, score: Int){
        let alert = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(alert, animated: true, completion: nil)
    }
    
    func checkTopScore() {
        let defaults = UserDefaults.standard
        
          if var topScore = try? defaults.integer(forKey: "score") {
              if score > topScore {
                  showAlert(title: "You beat your previous top Score", score: score)
                  topScore = score
                  defaults.set(score, forKey: "score")
              } else { showAlert(title: "Try harder - Game Over", score: score) }
          } else {
              defaults.set(score, forKey: "score")
          }
      
        
        
        
        
        
        
    }
}

