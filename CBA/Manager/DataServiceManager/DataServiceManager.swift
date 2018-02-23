//
//  ServiceManager.swift
//  CBA
//
//  Created by Nandhakumar on 19/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class DataServiceManager {
    static let userInfoService: UserInfoService = UserInfoProvider()
    static let accountService: AccountService = AccountProvider()
}
