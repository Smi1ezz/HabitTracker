//
//  AppColours.swift
//  HabitsTracker
//
//  Created by admin on 26.10.2021.
//

import Foundation
import UIKit

enum AppColours {
    case sysGray, sysGray2, grayLight, violet, blue, green, purple, orange
}

extension UIColor {
    
    static func appColour(name: AppColours) -> UIColor {
        switch name {
        case .grayLight:
            return UIColor(named: "appGrayLight")!
        case .violet:
            return UIColor(named: "appViolet")!
        case .blue:
            return UIColor(named: "appBlue")!
        case .green:
            return UIColor(named: "appGreen")!
        case .purple:
            return UIColor(named: "appPurple")!
        case .orange:
            return UIColor(named: "appOrange")!
        case .sysGray:
            return UIColor.systemGray
        case .sysGray2:
            return UIColor.systemGray2
        }
    }
}
