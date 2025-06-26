//
//  UIColor+Extensions.swift
//  UserListApp-CoverageX
//
//  Created by Lahiru Neranjan on 2025-06-26.
//

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        
        if hexString.count == 6 {
            hexString = "FF" + hexString 
        }

        guard hexString.count == 8,
              let hexValue = UInt64(hexString, radix: 16) else {
            return nil
        }

        let a = CGFloat((hexValue & 0xFF000000) >> 24) / 255
        let r = CGFloat((hexValue & 0x00FF0000) >> 16) / 255
        let g = CGFloat((hexValue & 0x0000FF00) >> 8) / 255
        let b = CGFloat(hexValue & 0x000000FF) / 255

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
