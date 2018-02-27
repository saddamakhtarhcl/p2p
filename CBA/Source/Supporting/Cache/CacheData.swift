//
//  CacheData.swift
//
//  Copyright © 2016 Saddam Akhtar. All rights reserved.
//

import Foundation

protocol CacheData: NSCoding {
    var rawData: Data {get}
}

class TimeCacheData: NSObject, CacheData {
    fileprivate var cacheRawData: Data
    let modifiedTimestamp: Date
    let expiresIn: TimeInterval
    
    init(data: Data, expiresIn: TimeInterval) {
        cacheRawData = data
        self.expiresIn = expiresIn
        modifiedTimestamp = Date()
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        cacheRawData = (aDecoder.decodeObject(forKey: "data") as? Data)!
        expiresIn = aDecoder.decodeDouble(forKey: "expiresInTime")
        modifiedTimestamp = (aDecoder.decodeObject(forKey: "modifiedTimestamp") as? Date)!
    }
    
    @objc func encode(with aCoder: NSCoder) {
        aCoder.encode(cacheRawData, forKey: "data")
        aCoder.encode(expiresIn, forKey: "expiresInTime")
        aCoder.encode(modifiedTimestamp, forKey: "modifiedTimestamp")
    }
    
    var rawData: Data {
        return cacheRawData
    }
}
