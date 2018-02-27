//
//  UserInfoService.swift
//  CBA
//
//  Created by Nandhakumar on 20/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

protocol UserInfoService {
    func getUserInfo(userID: String?, completion: @escaping ((UserInfo?, Error?) -> Void))
}
