//
//  MainViewController.swift
//  lifecounter
//
//  Created by vinh on 4/22/24.
//

import UIKit

class PlayerTableCell: UITableViewCell {
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
}

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var playerData : [(String, Int)] = []
    var gameHistory : [(String, Int)] = []
    
    var selectedPlayerIndex : Int? = nil
    var activeGame : Bool = false
    
    @IBOutlet weak var lifeStepper: UIStepper!
    var stepperValue : Int = 0
    @IBOutlet weak var customLifeButton: UIButton!
    @IBOutlet weak var addLifeButton: UIButton!
    @IBOutlet weak var subLifeButton: UIButton!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var removePlayerButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        for _ in 1...4 {
            playerData.append(("Player\(playerData.count + 1)", 20))
        }
        tableView.reloadData()
    }
    
    @IBAction func updateStepper(_ sender: UIStepper) {
        stepperValue = Int(sender.value)
        if stepperValue >= 0 {
            customLifeButton.tintColor = UIColor.systemGreen
            customLifeButton.setTitle("+\(stepperValue)", for: .normal)
        } else {
            customLifeButton.tintColor = UIColor.systemRed
            customLifeButton.setTitle("\(stepperValue)", for: .normal)
        }
    }
    
    func checkWinner() {
        var aliveCount = 0
        var winner : String = ""
        for (player, life) in playerData {
            if life > 0 {
                aliveCount += 1
                winner = player
            }
        }
        if aliveCount == 1 {
            let alert = UIAlertController(title: "Game Over", message: "\(winner) is the winner!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: resetGame(_:)))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        if playerData.count < 8 {
            playerData.append(("Player\(playerData.count + 1)", 20))
            tableView.reloadData()
        }
    }
    
    @IBAction func removePlayer(_ sender: Any) {
        if playerData.count > 2 {
            playerData.removeLast()
            tableView.reloadData()
        }
    }
    
    
    @IBAction func resetGame(_ sender: Any) {
        for (index, (player, life)) in playerData.enumerated() {
            playerData[index] = (player, 20)
        }
        gameHistory = []
        activeGame = false
        selectedPlayerIndex = nil
        updatePlayerButtons()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableCell", for: indexPath) as! PlayerTableCell
        let (player, life) = playerData[indexPath.row]
        cell.playerLabel.text = player
        cell.lifeLabel.text = String(life)
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlayerIndex = indexPath.row
    }
    
    func updatePlayerButtons() {
        addPlayerButton.isEnabled = !activeGame
        removePlayerButton.isEnabled = !activeGame
    }
    
    @IBAction func lifeButtonPress(_ sender: UIButton) {
        if selectedPlayerIndex != nil {
            if !activeGame {
                activeGame = true
                updatePlayerButtons()
            }
            var amount : Int = 0
            if sender === customLifeButton {
                amount = stepperValue
            } else if sender === addLifeButton {
                amount = 1
            } else if sender === subLifeButton {
                amount = -1
            }
            let (player, currentLife) = playerData[selectedPlayerIndex!]
            playerData[selectedPlayerIndex!] = (player, currentLife + amount)
            gameHistory.append((player, amount))
            tableView.reloadData()
            checkWinner()
        }
    }
    
    
}
