//
//  Caching.swift
//
//  Copyright, Manchester United Ltd, 2016
//

import Foundation

protocol Caching {
    
    func putData(_ data: CacheData?, key: String)
    func dataForKey(_ key: String, completion: @escaping (_ data: CacheData?) -> Void)
    func removeDataForKey(_ key: String)
    func clearCache()
    
}
