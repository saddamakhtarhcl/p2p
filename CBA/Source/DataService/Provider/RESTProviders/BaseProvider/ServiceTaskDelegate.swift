//
//  ServiceTaskDelegate.swift
//
//  Created by Nandhakumar on 22/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

// MARK: - ServiceTaskDelegate class

class ServiceTaskDelegate : HttpTaskDelegate {
    
    // MARK: - Properties
    
    fileprivate let httpRequestURL: URL
    
    let httpRequestMethod: HttpMethod
    var httpRequestHeaders: [String: String]?
    var httpRequestTimeoutInterval: TimeInterval?
    var httpRequestBody: Data?
    var httpCachePolicy: NSURLRequest.CachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
    
    // MARK: - Initilizers
    
    init(httpRequestURL: URL, httpRequestMethod: HttpMethod) {
        self.httpRequestMethod = httpRequestMethod
        self.httpRequestURL = httpRequestURL
    }
    
    // MARK: - HttpTaskDelegate functions
    
    var requestURL: URL {
        return httpRequestURL
    }
    
    func configureRequest(_ request: NSMutableURLRequest) -> Bool {
        request.httpMethod = self.httpRequestMethod.rawValue
        request.cachePolicy = self.httpCachePolicy
        
        if self.httpRequestTimeoutInterval != nil {
            request.timeoutInterval = self.httpRequestTimeoutInterval!
        }
        
        if self.httpRequestHeaders != nil {
            for (headerKey, headerValue) in self.httpRequestHeaders! {
                request.setValue(headerValue, forHTTPHeaderField: headerKey)
            }
        }
        
        return true
    }
    
    func prepareRequest(_ request: NSMutableURLRequest) -> Bool {
        if self.httpRequestMethod == HttpMethod.POST || self.httpRequestMethod == HttpMethod.PUT {
            request.httpBody = self.httpRequestBody
        }
        return true
    }
}
