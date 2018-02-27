//
//  AppConfiguration.swift
//
//  Created by Nandhakumar on 20/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

class AppConfig {
    
    static let sharedInstance: AppConfig = AppConfig()
    
    static let environment = environmentFromUserDefinedSetting
    
    let serviceBaseHostURL: String = AppConfig.environment.serviceBaseHostURL

    /**
     * Dynamically create specific environment instance based on user-defined setting
     * "Environment" containing the specific environment class name
     *
     * Returns: instance of concrete Environment class
     */
    static fileprivate var environmentFromUserDefinedSetting: Environment {
        let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        
        let currentEnv = buildEnvironment
        
        if currentEnv == nil {
            NSException.raise(NSExceptionName(rawValue: "Exception"), format:"Error: %@",
                arguments: getVaList(["Environment class not defined in the config !!!"]))
        }
        
        let environmentType = NSClassFromString("\(bundleName!).\(currentEnv!)") as? Environment.Type
        if environmentType == nil {
            NSException.raise(NSExceptionName(rawValue: "Class not found exception"), format:"Error: %@",
                arguments: getVaList(["Environment class: \(currentEnv!) is not defined !!!"]))
        }
        
        return environmentType!.init()
    }
    
    // Gives the environment on which the app is build
    static var buildEnvironment: String? {
        // "Environment" is a user-defined configuration defined under projects "Build Settings"
        return Bundle.main.object(forInfoDictionaryKey: "Environment") as? String
    }
}
