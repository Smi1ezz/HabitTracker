//
//  SrtingExtensionChangeColor.swift
//  HabitsTracker
//
//  Created by admin on 29.10.2021.
//

import Foundation
import UIKit

extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}

/*
 Чтобы это использовать делай что-то вроде:
 let attributedWithTextColor: NSAttributedString = "Doc, welcome back :)".attributedStringWithColor(["Doc", "back"], color: UIColor.black)

 myLabel.attributedText = attributedWithTextColor
 */

