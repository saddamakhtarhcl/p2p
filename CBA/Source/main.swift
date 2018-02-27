//
//  main.swift
//  CBA
//
//  Created by Saddam Akhtar on 27/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(AppDelegate.self),
    NSStringFromClass(AppDelegate.self)
)
