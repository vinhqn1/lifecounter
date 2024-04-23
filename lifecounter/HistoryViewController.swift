//
//  HistoryViewController.swift
//  lifecounter
//
//  Created by vinh on 4/22/24.
//

import UIKit

class HistoryTableCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var gameHistory : [(String, Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableCell", for: indexPath) as! HistoryTableCell
        let (player, amount) = gameHistory.reversed()[indexPath.row]
        var text : String
        if amount > 0 {
            text = "\(player) gained \(amount) life points"
        } else {
            text = "\(player) lost \(amount * -1) life points"
        }
        cell.label.text = text
        return cell
    }
    
 
    
    
}
