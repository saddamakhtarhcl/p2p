//
//  App.swift
//  CBA
//
//  Created by Saddam on 16/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

class App {
    
    static let IdleTimeExceededNotification: String = "IdleTimeExceededNotification"
    
    private static let TokenRefreshTimeInterval: TimeInterval = 40.0 // 50.0 Secs
    
    private static let IdleTimeInterval: TimeInterval = 50.0 // 50.0 Secs
    private static var idleTimer: Timer?
    
    private static var prIsUserIdleForLong: Bool = false
    static var isUserIdleForLong: Bool {
        return prIsUserIdleForLong
    }
    
    static var user: UserInfo!
    
    // MARK: - Token
    
    static func scheduleTokenRefresh() {
        
        if ServiceProvider.accessToken != nil {
            _ = Timer.scheduledTimer(timeInterval: TokenRefreshTimeInterval,
                                     target: self,
                                     selector: #selector(refreshToken),
                                     userInfo: nil,
                                     repeats: false
            )
        }
    }
    
    @objc private static func refreshToken() {
        if ServiceProvider.accessToken != nil {
            DataServiceManager.loginService.refreshToken(token: ServiceProvider.accessToken!) { (success, error) in
                if success && error == nil {
                    scheduleTokenRefresh()
                }
            }
        }
    }
    
    // MARK: - Idle time management
    
    static func resetIdleTimer() {
        prIsUserIdleForLong = false
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        idleTimer = Timer.scheduledTimer(timeInterval: IdleTimeInterval,
                                         target: self,
                                         selector: #selector(timeHasExceeded),
                                         userInfo: nil,
                                         repeats: false
        )
    }
    
    @objc static private func timeHasExceeded() {
        prIsUserIdleForLong = true
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: IdleTimeExceededNotification),
                                        object: nil)
        
        DataServiceManager.loginService.logout { (_, _) in
            //
        }
    }
}
