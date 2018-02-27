//
//  TimeCachePolicy.swift
//
//  Copyright, Manchester United Ltd, 2016
//

import Foundation

class TimeCachePolicy : CachePolicy {
    
    // MARK: - Properties
    
    let timeInterval: TimeInterval
    
    // MARK: - Initializers
    
    init(validFor: TimeInterval) {
        self.timeInterval = validFor
    }
    
    // MARK: - CachePolicy Protocol
    
    func isDataValid(_ cacheManager: Caching, key: String, completion: @escaping (_ isValid: Bool) -> Void) {
            cacheManager.dataForKey(key) { (data) -> Void in
                if let timeCacheData = data as? TimeCacheData {
                    let dataValidTill = timeCacheData.modifiedTimestamp.addingTimeInterval(timeCacheData.expiresIn)
                    if dataValidTill.compare(Date()) == ComparisonResult.orderedDescending {
                        completion(true)
                    } else {
                        completion(false)
                    }
                    
                } else {
                    completion(false)
                }
            }
    }
    
    func dataWithMetaData(_ data: Data) -> CacheData {
        return TimeCacheData(data: data, expiresIn: timeInterval)
    }
}
