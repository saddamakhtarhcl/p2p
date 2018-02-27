//
//  LoginService.swift
//  CBA
//
//  Created by Saddam Akhtar on 27/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

protocol LoginService {
    func login(credentials: LoginCredentials, completion: @escaping ((Bool, Error?) -> Void))
    func refreshToken(token: String, completion: @escaping ((Bool, Error?) -> Void))
    
    func logout(completion: @escaping ((Bool, Error?) -> Void))
}
