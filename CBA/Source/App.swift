//
//  App.swift
//  CBA
//
//  Created by Saddam on 16/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

class App {
    
    // MARK: - Constants
    
    /*
     *  Register to this notification to listen if user is idle for long time.
     *  This gets executed from timeHasExceeded() method.
     */
    static let IdleTimeExceededNotification: String = "IdleTimeExceededNotification"
    
    // MARK: - Private properties
    
    private static let TokenRefreshTimeInterval: TimeInterval = 40.0 // 40.0 Secs
    
    private static let IdleTimeInterval: TimeInterval = 50.0 // 50.0 Secs
    private static var idleTimer: Timer?
    
    private static var prIsUserIdleForLong: Bool = false
    
    /*
     *  This is to identify if the user is idle for a long time.
     *  Idle time is defined by IdleTimeInterval property.
     *  If idleTimer executes its selector the property will be set to
     *  false and will be down until resetIdleTimer() method is invoked back.
     */
    static var isUserIdleForLong: Bool {
        return prIsUserIdleForLong
    }
    
    // MARK: - Class properties
    
    /* The property may be nil if following:
     *  1. No login happened before accessing it.
     *  2. Accessing after logout
     */
    static var user: UserInfo!
    
    /*
     *  The property is to retrieve a P2P manager instance
     *  with pre configured user identity to be broadcasted.
     *  May return a mis-configured manager in case there is
     *  no current user session basically if user property is nil
     */
    static var p2pManager: PeerToPeer {
        return P2PManager(withName: App.user?.accountNumber ?? "")
    }
    
}

// MARK: - Idle time management

extension App {
    
    /*
     *  Use this method to keep identify if a user is active.
     *
     *  This method sets the isUserIdleForLong flag to false and
     *  schedules a timer to down the flag back again if
     *  this is not re-invoked.
     */
    static func resetIdleTimer() {
        prIsUserIdleForLong = false
        if idleTimer != nil {
            idleTimer!.invalidate()
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
        
    }
    
}

// MARK: - Token refresh management

extension App {
    
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
    
}
