//
//  Utililty.swift
//  P2POverBluteeoth
//
//  Created by Saddam on 15/02/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit

class Device {
    
    static var isJailBroken: Bool {
        if TARGET_OS_SIMULATOR != 1 {
            // Check 1 : existence of files that are common for jailbroken devices
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                || FileManager.default.fileExists(atPath: "/bin/bash")
                || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                || FileManager.default.fileExists(atPath: "/etc/apt")
                || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.example.package")!) {
                
                return true
            }
            // Check 2 : Reading and writing in system directories (sandbox violation)
            let stringToWrite = "Jailbreak Test"
            do {
                try stringToWrite.write(toFile:"/private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)
                //Device is jailbroken
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
    }
    
}

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
