//
//  LoginCredentials.swift
//  CBA
//
//  Created by Saddam Akhtar on 27/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

class LoginCredentials: BaseModel {
    
    private struct JsonKey {
        static let UserId: String               =     "UserName"
        static let Password: String             =     "Password"
    }
    
    // MARK: - Properties
    
    var userId: String?
    var password: String?
    
    static func instanceFromDictionary(_ dictionary: [String : Any]?) -> Any? {
        if dictionary == nil {
            return nil
        }
        let instance = LoginCredentials()
        instance.setAttributesFromDictionary(dictionary)
        return instance
    }
    
    func dictionaryRepresentation() -> [String : Any]? {
        var dictionary = [String: Any]()
        
        dictionary[JsonKey.UserId] = userId
        dictionary[JsonKey.Password] = password
        
        if dictionary.isEmpty {
            return nil
        } else {
            return dictionary
        }
    }
    
    func setAttributesFromDictionary(_ dictionary: [String : Any]?) {
        self.userId = dictionary?[JsonKey.UserId] as? String
        self.password  = dictionary?[JsonKey.Password] as? String
    }
}
