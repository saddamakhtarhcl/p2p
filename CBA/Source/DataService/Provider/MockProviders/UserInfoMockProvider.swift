//
//  UserInfoProvider.swift
//  CBA
//
//  Created by Nandhakumar on 20/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

class UserInfoMockProvider: UserInfoService {
    func getCurrentUserInfo(completion: @escaping ((UserInfo?, Error?) -> Void)) {
        completion(nil, nil)
    }
    
    func getUserInfo(userToken userID: String?, completion: @escaping ((UserInfo?, Error?) -> Void)) {
        
        guard userID?.isEmpty == false else {
            completion(nil, nil)
            return
        }
        
        var accDetail: UserInfo?
        if let users = Users.instanceFromFile("users") as? Users {
            accDetail = users.getUser(userID: userID)            
        }        
        
        completion(accDetail, nil)
    }
}

class Users: BaseModel {
    
    // MARK: - Model Json Keys
    
    private struct JsonKey {
        static let UserDetails: String     =     "userDetails"
    }
    
    // MARK: - Properties
    
    var userDetails: [String: Any]?
    
    class func instanceFromDictionary(_ dictionary: [String: Any]?) -> Any? {
        if dictionary == nil {
            return nil
        }
        
        let instance = Users()
        instance.setAttributesFromDictionary(dictionary)
        
        return instance
    }
    
    func dictionaryRepresentation() -> [String: Any]? {
        var dictionary = [String: Any]()
        
        dictionary[JsonKey.UserDetails] = userDetails
        
        if dictionary.isEmpty {
            return nil
        } else {
            return dictionary
        }
    }
    
    func setAttributesFromDictionary(_ dictionary: [String: Any]?) {
        userDetails = dictionary?[JsonKey.UserDetails] as? [String: Any]
    }
    
    func getUser(userID: String?) -> UserInfo? {
        guard userID?.isEmpty == false else {return nil}
        var accDetail: UserInfo?
        
        if let userDict = userDetails?[userID!] as? [String: Any] {
            accDetail = UserInfo.instanceFromDictionary(userDict) as? UserInfo            
        }
        
        return accDetail
    }
    
}
