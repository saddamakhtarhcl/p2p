//
//  KeychainService.swift
//
//  Created by Saddam on 15/02/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import Security

// Constant Identifiers
let userAccount = "com.hcl.cba-api-auth-token"

/**
 *  User defined keys for new entry
 *  Note: add new keys for new secure item and use them in load and save methods
 */

// Arguments for the keychain queries
let kSecClassValue = String(format: kSecClass as String)
let kSecAttrAccountValue = String(format: kSecAttrAccount as String)
let kSecValueDataValue = String(format: kSecValueData as String)
let kSecClassGenericPasswordValue = String(format: kSecClassGenericPassword as String)
let kSecAttrServiceValue = String(format: kSecAttrService as String)
let kSecMatchLimitValue = String(format: kSecMatchLimit as String)
let kSecReturnDataValue = String(format: kSecReturnData as String)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

class KeychainService: NSObject {
    
    /**
     * Exposed methods to perform save and load queries.
     */
    
    class func saveGenericPassword(_ token: String?, forKey serviceKey: String) {
        
        if token != nil {
            self.save(service: serviceKey, token: token!)
        }
    }
    
    class func loadGenericPasswordForKey(_ serviceKey: String) -> String? {
        return self.load(service: serviceKey)
    }
    
    class func updateGenericPassword(_ token: String, forKey serviceKey: String) {
        self.update(service: serviceKey, token: token)
    }
    
    class func removeGenericPasswordForKey(_ serviceKey: String) {
        return self.delete(service: serviceKey)
    }
    
    /**
     * Internal methods for querying the keychain.
     */
    
    private class func save(service: String, token: String) {
        let dataFromString: Data = token.data(using: .utf8, allowLossyConversion: false)!
        
        // Instantiate a new default keychain query
        let keychainQuery: [String: Any] = [
            kSecClassValue: kSecClassGenericPasswordValue,
            kSecAttrServiceValue: service,
            kSecAttrAccountValue: userAccount,
            kSecValueDataValue: dataFromString
        ]
        
        // Add the new keychain item
        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        
        if (status != errSecSuccess) {
            // Always check the status
            updateGenericPassword(token, forKey: service)
        }
    }
    
    private class func load(service: String) -> String? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        let keychainQuery: [String: Any] = [
            kSecClassValue: kSecClassGenericPasswordValue,
            kSecAttrServiceValue: service,
            kSecAttrAccountValue: userAccount,
            kSecReturnDataValue: kCFBooleanTrue,
            kSecMatchLimitValue: kSecMatchLimitOneValue
        ]
        
        var dataTypeRef :AnyObject?
        
        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery as CFDictionary, &dataTypeRef)
        var contentsOfKeychain: String? = nil
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: .utf8)
            }
        } else {
            //
        }
        
        return contentsOfKeychain
    }
    
    private class func update(service: String, token: String) {
        let dataFromString: Data = token.data(using: .utf8, allowLossyConversion: false)! as Data
        
        // Instantiate a new default keychain query
        let keychainQuery: [String: Any] = [
            kSecClassValue: kSecClassGenericPasswordValue,
            kSecAttrServiceValue: service,
            kSecAttrAccountValue: userAccount
        ]
        
        let status = SecItemUpdate(keychainQuery as CFDictionary, [kSecValueDataValue: dataFromString] as CFDictionary)
        
        if (status != errSecSuccess) {
            //
        }
    }
    
    private class func delete(service: String) {
        // Instantiate a new default keychain query
        let keychainQuery: [String: Any] = [
            kSecClassValue: kSecClassGenericPasswordValue,
            kSecAttrServiceValue: service,
            kSecAttrAccountValue: userAccount
        ]
        
        // Delete any existing items
        let status = SecItemDelete(keychainQuery as CFDictionary)
        if (status != errSecSuccess) {
            //
        }
    }
}
