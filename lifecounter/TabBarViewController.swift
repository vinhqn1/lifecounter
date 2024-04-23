//
//  TabBarViewController.swift
//  lifecounter
//
//  Created by vinh on 4/22/24.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let fromVC = self.selectedIndex
        let toVC = tabBarController.viewControllers?.firstIndex(of: viewController) ?? 0
        if fromVC != toVC {
            moveHistory()
        }
        
        return true // Return false if you do not want the tab to switch
    }
    
    private func moveHistory() {
        let mainVC = self.viewControllers?[0] as! MainViewController
        let historyVC = self.viewControllers?[1] as! HistoryViewController
        historyVC.gameHistory = mainVC.gameHistory
    }
}
