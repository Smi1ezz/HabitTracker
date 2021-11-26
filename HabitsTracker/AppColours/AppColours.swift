//
//  AppColours.swift
//  HabitsTracker
//
//  Created by admin on 26.10.2021.
//

import Foundation
import UIKit

enum AppColours {
    case sysGray, sysGray2, grayLight, purple, blue, green, indigo, orange, naviBackground
}

extension UIColor {
    
    static func appColour(name: AppColours) -> UIColor {
        switch name {
        case .grayLight:
            return UIColor(named: "appGrayLight") ?? .lightGray
        case .purple:
            return UIColor(named: "appViolet") ?? .purple
        case .blue:
            return UIColor(named: "appBlue") ?? .blue
        case .green:
            return UIColor(named: "appGreen") ?? .green
        case .indigo:
            return UIColor(named: "appPurple") ?? .purple
        case .orange:
            return UIColor(named: "appOrange") ?? .orange
        case .sysGray:
            return UIColor.systemGray //darkGray
        case .sysGray2:
            return UIColor.systemGray2 //mediumGray
        case .naviBackground:
            return UIColor(named: "appNaviBackground") ?? .green
        }
    }
}
