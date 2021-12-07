//
//  AppFontsUILabelExtension.swift
//  HabitsTracker
//
//  Created by admin on 10.11.2021.
//

import UIKit

extension UILabel {
    func titleStyle() {
        self.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.textColor = .black
    }
    
    func headlineStyle() {
        self.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.textColor = UIColor.appColour(name: .blue)
    }
    
    func bodyStyle() {
        self.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.textColor = .black
    }
    
    func footnoteStyle() {
        self.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        self.textColor = UIColor.appColour(name: .sysGray)
    }
    
    func statusFootnoteStyle() {
        self.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.textColor = UIColor.appColour(name: .sysGray)
    }
    
    func footnoteBlackStyle() {
        self.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.textColor = .black
        self.text = self.text?.uppercased()
    }
    
    func captionStyle() {
        self.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.textColor = UIColor.appColour(name: .sysGray2)
    }
}
