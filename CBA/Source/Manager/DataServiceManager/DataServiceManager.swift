//
//  ServiceManager.swift
//  CBA
//
//  Created by Nandhakumar on 19/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

class DataServiceManager {
    
    static var loginService: LoginService {
        return LoginProvider()
    }
    
    static var userInfoService: UserInfoService {
        return UserInfoProvider()
    }
    
    static var accountService: AccountService {
        return AccountMockProvider()
    }
    
}
