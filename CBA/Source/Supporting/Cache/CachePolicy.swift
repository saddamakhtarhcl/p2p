//
//  CachePolicy.swift
//
//  Copyright, Manchester United Ltd, 2016
//

import Foundation

protocol CachePolicy {
    func dataWithMetaData(_ data: Data) -> CacheData
    func isDataValid(_ cacheManager: Caching, key: String, completion: @escaping (_ isValid: Bool) -> Void)
}
