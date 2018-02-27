//
//  HttpCacheTask.swift
//
//  Copyright, Manchester United Ltd, 2016
//

import Foundation

class CacheCriteria {
    let key: String
    var cachePolicy: CachePolicy
    
    init(key: String, cachePolicy: CachePolicy) {
        self.key = key
        self.cachePolicy = cachePolicy
    }
}

//class HttpCacheTask : HttpTask {
//    
//    // MARK: - Properties
//    
//    fileprivate let cacheCriteria: CacheCriteria
//    fileprivate let cacheManager: Caching! = App.cacheMGR
//    
//    // MARK: - Initializers
//    
//    init(delegate: HttpTaskDelegate, cacheCriteria: CacheCriteria) {
//        self.cacheCriteria = cacheCriteria
//        super.init(delegate: delegate)
//    }
//    
//    // MARK: - Overriden functions
//    override func executeAsyncInQueue(_ queue: OperationQueue,completionHandler: @escaping ((_ result: Any?, _ error: NSError?) -> Void)) {
//        
//        cachedData (cacheCriteria) { (cacheData, isValid) -> Void in
//            
//            if (cacheData != nil && isValid) || HttpTask.blockAllRequests {
//                
//                completionHandler(cacheData as AnyObject?, nil)
//            } else {
//                super.executeAsyncInQueue(queue) { (result, error) -> Void in
//                    
//                    if error == nil { // Data received from server without error
//                        
//                        if(result != nil) {
//                            
//                            if  let err = NSError.doesErrorExist(data: (result! as? NSData)!) {
//                                // Handling 5XX series error case
//                                if (((err.httpstatus?.rawValue)!>=500 && (err.httpstatus?.rawValue)!<600) && NSError.isValidDataAvailable(data: (result as? NSData)!)) {
//                                    
//                                    let err = NSError(domain: "", code: 0, userInfo: ["ErrorObject":err])
//                                    self.cacheData(self.cacheCriteria, data: result as? Data)
//                                    
//                                    completionHandler(result, err) // Server data
//                                    return
//                                }
//                                
//                            } else {
//                                if let httpResponse = self.urlResponse as? HTTPURLResponse {
//                                    if httpResponse.statusCode != 200 {
//                                        let error = NSError.getErrorObjectFromHttpCode(code:  httpResponse.statusCode)
//                                        
//                                        completionHandler(cacheData, error)
//                                        return
//                                    }
//                                }
//                                
//                                self.cacheData(self.cacheCriteria, data: result as? Data)
//                                completionHandler(result, error) // Server data
//                                return
//                            }
//                        } else {
//                            
//                            completionHandler(result, NSError(domain: "error", code: 401, userInfo: nil)) // Server data
//                            return
//                        }
//                    }
//                    
//                    // If connection throws error, fallback to cached data
//                    if cacheData != nil {
//                        if((result) != nil) {
//                            if  let error = NSError.doesErrorExist(data: (result! as? NSData)!) {
//                                let err = NSError(domain: "", code: 0, userInfo: ["ErrorObject":error])
//                                
//                                completionHandler(cacheData, err)
//                                return
//                            }
//                        }
//                        completionHandler(cacheData, error)
//                        return
//                    } else {
//                        if((result) != nil) {
//                            if  let error = NSError.doesErrorExist(data: (result! as? NSData)!) {
//                                let err = NSError(domain: "", code: 0, userInfo: ["ErrorObject":error])
//                                
//                                completionHandler(nil, err)
//                                return
//                            }
//                        }
//                        
//                        completionHandler(nil, error)
//                        return
//                    }
//                }
//            }
//        }
//    }
//    
//    // MARK: - Private functions
//    
//    /**
//    * Fetches cached data
//    */
//    fileprivate func cachedData(_ cacheCriteria: CacheCriteria, completion: @escaping (_ cacheData: Data?, _ isValid: Bool) -> Void) {
//        cacheManager.dataForKey(cacheCriteria.key, completion: { (data) -> Void in
//            if let _ = data {
//                cacheCriteria.cachePolicy.isDataValid(self.cacheManager,
//                    key: self.cacheCriteria.key,
//                    completion: { (isValid) -> Void in
//                        completion(data!.rawData, isValid)
//                })
//            } else {
//                completion(nil, false)
//            }
//        })
//    }
//    
//    /**
//     * Add data to the cache.
//     */
//    fileprivate func cacheData(_ cacheCriteria: CacheCriteria, data: Data?) {
//        var cacheData: CacheData?
//        if data != nil {
//            cacheData = cacheCriteria.cachePolicy.dataWithMetaData(data!)
//        }
//        
//        cacheManager.putData(cacheData, key: cacheCriteria.key)
//    }
//}
