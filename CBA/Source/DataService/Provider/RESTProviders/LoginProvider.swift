//
//  AccountProvider.swift
//  CBA
//
//  Created by Saddam Akhtar on 27/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

class LoginProvider: ServiceProvider, LoginService {
    
    func login(credentials: LoginCredentials,
               completion: @escaping ((Bool, Error?) -> Void)) {
        
        let routeStr: String = "Account/Login"
        
        guard let postDataDictionary: [String: Any] = credentials.dictionaryRepresentation() else {
            completion(false, nil)
            return
        }
        
        do {
            let postData: Data? =
                try JSONSerialization.data(withJSONObject: postDataDictionary, options: .prettyPrinted)
            
            if postData != nil {
                
                _ = self.postWithRoute(routeStr, content: postData!,
                                       mimeType: MIMEType.ApplicationJSON) { (data, error) -> Void in
                                        
                                        var isLoginSuccess: Bool = false
                                        
                                        if data != nil && error == nil {
                                            
                                            // Removing inverted comma from the token received.
                                            // This should be fixed at API end
                                            var token = String(data: data! , encoding: .utf8)
                                            token = token?.replacingOccurrences(of: "\"", with: "")
                                            
                                            if token?.isEmpty == false {
                                                ServiceProvider.accessToken = token
                                                isLoginSuccess = true
                                            }
                                        }
                                        
                                        completion(isLoginSuccess, error)
                }
            } else {
                completion(false, nil)
            }
        } catch {
            completion(false, nil)
        }
    }
    
    func logout(completion: @escaping ((Bool, Error?) -> Void)) {
        ServiceProvider.accessToken = nil
        completion(true, nil)
    }
    
    func refreshToken(token: String, completion: @escaping ((Bool, Error?) -> Void)) {
        
        let routeStr: String = "Account/RefreshToken"
        
        let requestHeaders: [String: String] = [
            HttpHeader.Authorization: "bearer \(token)"
        ]
        
        _ = getWithRoute(routeStr, mimeType: MIMEType.ApplicationJSON,
                       cacheCriteria: nil,
                       headers: requestHeaders) { (data, error) in
                        
                        if data != nil && error == nil {
                            var isLoginSuccess: Bool = false
                            
                            // Removing inverted comma from the token received.
                            // This should be fixed at API end
                            var token = String(data: data! , encoding: .utf8)
                            token = token?.replacingOccurrences(of: "\"", with: "")
                            
                            if token?.isEmpty == false {
                                ServiceProvider.accessToken = token
                                isLoginSuccess = true
                            } else {
                                ServiceProvider.accessToken = nil
                            }
                            completion(isLoginSuccess, error)
                        } else {
                            completion(false, error)
                        }
        }
    }
}
