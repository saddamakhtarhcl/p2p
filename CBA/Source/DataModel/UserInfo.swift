//
//  UserInfo.swift
//  CBA
//
//  Created by Nandhakumar on 15/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class UserInfo: BaseModel {
    
    // MARK: - Model Json Keys
    
    private struct JsonKey {
        static let AccountNumber: String          =     "accountNumber"
        static let UserName: String               =     "userName"
        static let BranchName: String             =     "branchName"
    }
    
    // MARK: - Properties
    var userToken: String?
    var accountNumber: String?
    var userName: String?
    var branchName: String?
    
    class func instanceFromDictionary(_ dictionary: [String: Any]?) -> Any? {
        if dictionary == nil {
            return nil
        }
        
        let instance = UserInfo()
        instance.setAttributesFromDictionary(dictionary)
        
        return instance
    }
    
    func dictionaryRepresentation() -> [String: Any]? {
        var dictionary = [String: Any]()
        
        dictionary[JsonKey.AccountNumber] = accountNumber
        dictionary[JsonKey.UserName] = userName
        dictionary[JsonKey.BranchName] = branchName
        
        if dictionary.isEmpty {
            return nil
        } else {
            return dictionary
        }
    }
    
    func setAttributesFromDictionary(_ dictionary: [String: Any]?) {
        self.accountNumber = dictionary?[JsonKey.AccountNumber] as? String
        self.userName = dictionary?[JsonKey.UserName] as? String
        self.branchName = dictionary?[JsonKey.BranchName] as? String
    }
}
