//
//  Utililty.swift
//  P2POverBluteeoth
//
//  Created by Saddam on 15/02/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(colorCode: String, alpha: Float = 1.0) {
        let scanner: Scanner = Scanner(string:colorCode)
        var color:UInt32 = UInt32(0)
        scanner.scanHexInt32(&color)
        
        let mask:Int = 0x000000FF
        
        let redComponent: Int = Int(color >> 16) & mask
        let normalisedRedComponent: Float = Float(redComponent) / 255.0
        let r: CGFloat = CGFloat(normalisedRedComponent)
        
        let greenComponent: Int = Int(color >> 8) & mask
        let normalisedGreenComponent: Float = Float(greenComponent) / 255.0
        let g: CGFloat = CGFloat(normalisedGreenComponent)
        
        let blueComponent: Int = Int(color) & mask
        let normalisedBlueComponent: Float = Float(blueComponent) / 255.0
        let b: CGFloat = CGFloat(normalisedBlueComponent)
        
        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
}

extension CGRect {
    func randomPointInRect() -> CGPoint {
        let origin = self.origin
        return CGPoint(x: CGFloat(arc4random_uniform(UInt32(self.width))) + origin.x,
                       y: CGFloat(arc4random_uniform(UInt32(self.height))) + origin.y)
    }
}
