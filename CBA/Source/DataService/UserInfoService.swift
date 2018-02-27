//
//  UserInfoService.swift
//  CBA
//
//  Created by Nandhakumar on 20/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

protocol UserInfoService {
    func getUserInfo(userToken: String?, completion: @escaping ((UserInfo?, Error?) -> Void))
    func getCurrentUserInfo(completion: @escaping ((UserInfo?, Error?) -> Void))
}
