//
//  UserInfoProvider.swift
//  CBA
//
//  Created by Saddam Akhtar on 27/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

class UserInfoProvider: ServiceProvider, UserInfoService {
    func getCurrentUserInfo(completion: @escaping ((UserInfo?, Error?) -> Void)) {
        let routeStr: String = "Account"
        
        _ = getWithRoute(routeStr, mimeType: MIMEType.ApplicationJSON,
                       cacheCriteria: nil) { (data, error) in
                        
                        if error == nil && data != nil {
                            let userInfo = UserInfo.instanceFromData(data!) as? UserInfo
                            completion(userInfo, error)
                        } else {
                            completion(nil, error)
                        }
        }
        
    }
    
    func getUserInfo(userToken: String?, completion: @escaping ((UserInfo?, Error?) -> Void)) {
        completion(nil, nil)
    }
}
