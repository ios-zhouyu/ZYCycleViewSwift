
//
//  UIColor+Extension.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/20.
//  Copyright © 2017年 周玉. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    static func colorWithHexString(hexStr : String) -> UIColor {
        var color = UIColor.red
        var cStr : String = hexStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cStr.hasPrefix("#") {
            let index = cStr.index(after: cStr.startIndex)
            cStr = String(cStr[index...])
            //'substring(from:)' is deprecated: Please use String slicing subscript with a 'partial range from' operator.
            //cStr = cStr.substring(from: index)
        }
        if cStr.count != 6 {
            return UIColor.white
        }
        
        let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
        let rStr = String(cStr[rRange])
        //'substring(with:)' is deprecated: Please use String slicing subscript.
        //let rStr = cStr.substring(with: rRange)
        
        let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
        let gStr = String(cStr[gRange])
//        let gStr = cStr.substring(with: gRange)
        
        let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
        let bStr = String(cStr[bIndex...])
//        let bStr = cStr.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
        
        return color
    }
}
