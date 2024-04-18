//
//  ViewController.swift
//  lifecounter
//
//  Created by vinh on 4/15/24.
//

import UIKit

class LifeButton : UIButton {
    @objc dynamic var amount : Int = 0
    @objc dynamic var player : String = ""
}

class ViewController: UIViewController {
    
    var player1Life : Int = 20
    var player2Life : Int = 20
    @IBOutlet weak var lifeLabelPlayer1: UILabel!
    @IBOutlet weak var lifeLabelPlayer2: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func lifeCounterButton(_ sender: LifeButton) {
        let button = sender
        let amount : Int = sender.amount
        let player : String = sender.player
        
        switch player {
        case "Player1":
            player1Life += amount
        case "Player2":
            player2Life += amount
        default:
            break
        }
        updateLifeLabels()
        checkWinner()
    }

    func updateLifeLabels() {
        lifeLabelPlayer1.text = String(player1Life)
        lifeLabelPlayer2.text = String(player2Life)
    }
    
    func checkWinner() {
        if player1Life <= 0 {
            winnerLabel.text = "PLAYER 2 WINS!!!"
            winnerLabel.isHidden = false
        } else if player2Life <= 0 {
            winnerLabel.text = "PLAYER 1 WINS!!!"
            winnerLabel.isHidden = false
        }
    }
    
}
