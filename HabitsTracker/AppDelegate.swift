//
//  AppDelegate.swift
//  HabitsTracker
//
//  Created by admin on 26.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //MARK: настройка общих свойств navigationController
        UINavigationBar.appearance().backgroundColor = UIColor.appColour(name: .naviBackground)
        UINavigationBar.appearance().tintColor = UIColor.appColour(name: .purple)
        UINavigationBar.appearance().isTranslucent = false

        return true
    }

}

