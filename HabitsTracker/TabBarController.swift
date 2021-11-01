//
//  TabBarController.swift
//  HabitsTracker
//
//  Created by admin on 26.10.2021.
//
import Foundation

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor.appColour(name: .grayLight)
        tabBar.tintColor = UIColor.appColour(name: .violet)
        
    }

}

