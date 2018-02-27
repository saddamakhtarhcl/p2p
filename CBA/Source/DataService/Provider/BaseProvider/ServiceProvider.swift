//
//  ServiceProvider.swift
//
//  Created by Nandhakumar on 22/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

// MARK: - ServiceProvider class

class ServiceProvider {
    
    // MARK: - Properties
    
    let defaultTimeoutInterval: TimeInterval = 30
    
    var serviceBaseHostURL: String {
        return AppConfig.sharedInstance.serviceBaseHostURL
    }
    
    private var serviceHost: String {
        let baseUrl = AppConfig.sharedInstance.serviceBaseHostURL
        
        if let url = URL(string: baseUrl) {
            return url.host ?? ""
        }
        
        return ""
    }

    // MARK: - Internal functions
    
    func getWithURL(_ requestURL: String,
                    mimeType: MIMEType?,
                    cacheCriteria: CacheCriteria?,
                    executionOnMainQueue: Bool = false,
                    gzipEncoding: Bool = true,
                    headers:[String: String]? = nil,
                    completionHandler: @escaping (_ data: Data?, _ error: NSError?) -> Void) -> Task? {
        
        let taskDelegate = serviceDelegate(requestURL, httpMethod: HttpMethod.GET,
            mimeType: mimeType, requestBody: nil,
            gzipEncoding: gzipEncoding, headers: headers)
        
        return executeService(taskDelegate, cacheCriteria: cacheCriteria,
            executionOnMainQueue: executionOnMainQueue, completionHandler: completionHandler)
    }
    
    func getWithRoute(_ route: String,
                      mimeType: MIMEType?,
                      cacheCriteria: CacheCriteria?,
                      executeOnMainQueue: Bool = false,
                      gzipEncoding: Bool = true,
                      headers:[String: String]? = nil,
                      completionHandler: @escaping (_ data: Data?, _ error: NSError?) -> Void) -> Task? {
        
        let requestURL = serviceBaseHostURL + route
        return getWithURL(requestURL, mimeType: mimeType, cacheCriteria:  cacheCriteria,
                          executionOnMainQueue: executeOnMainQueue,
                          gzipEncoding: gzipEncoding, headers: headers, completionHandler: completionHandler)
    }
    
    func postWithRoute(_ route: String,
                       content: Data,
                       mimeType: MIMEType?,
                       executeOnMainQueue: Bool = false,
                       gzipEncoding: Bool = true,
                       headers:[String: String]? = nil,
                       completionHandler: @escaping (_ data: Data?, _ error: NSError?) -> Void) -> Task? {
        
        let requestURL = serviceBaseHostURL + route
        
        let taskDelegate = serviceDelegate(requestURL, httpMethod: HttpMethod.POST,
                                           mimeType: mimeType, requestBody: content,
                                           gzipEncoding: gzipEncoding, headers: headers)
        
        return executeService(taskDelegate, cacheCriteria: nil,
                              executionOnMainQueue: executeOnMainQueue, completionHandler: completionHandler)
    }
    
    func postWithURL(_ requestURL: String,
                     content: Data,
                     mimeType: MIMEType?,
                     executionOnMainQueue: Bool = false,
                     gzipEncoding: Bool = true,
                     headers:[String: String]? = nil,
                     completionHandler: @escaping (_ data: Data?, _ error: NSError?) -> Void) -> Task? {
        
        let taskDelegate = serviceDelegate(requestURL, httpMethod: HttpMethod.POST,
                                           mimeType: mimeType, requestBody: content,
                                           gzipEncoding: gzipEncoding, headers: headers)
        
        return executeService(taskDelegate, cacheCriteria: nil,
                              executionOnMainQueue: executionOnMainQueue, completionHandler: completionHandler)
    }
    
    func putWithRoute(_ route: String,
                      content: Data,
                      mimeType: MIMEType,
                      executeOnMainQueue: Bool = false,
                      gzipEncoding: Bool,
                      headers:[String: String]? = nil,
                      completionHandler: @escaping (_ data: Data?, _ error: NSError?) -> Void) -> Task? {
        
        let requestURL = serviceBaseHostURL + route
        let taskDelegate = serviceDelegate(requestURL, httpMethod: HttpMethod.PUT,
                                           mimeType: mimeType, requestBody: content, gzipEncoding: gzipEncoding, headers: headers)
        
        return executeService(taskDelegate, cacheCriteria: nil,
                              executionOnMainQueue: executeOnMainQueue, completionHandler: completionHandler)
    }
    
    func deleteWithRoute(_ route: String,
                         mimeType: MIMEType,
                         executeOnMainQueue: Bool = false,
                         gzipEncoding: Bool = true,
                         headers:[String: String]? = nil,
                         completionHandler: @escaping (_ data: Data?, _ error: NSError?) -> Void) -> Task? {
        
        let requestURL = serviceBaseHostURL + route
        let taskDelegate = serviceDelegate(requestURL, httpMethod: HttpMethod.DELETE,
                                           mimeType: mimeType, requestBody: nil, gzipEncoding: gzipEncoding, headers: headers)
        
        return executeService(taskDelegate, cacheCriteria: nil,
                              executionOnMainQueue: executeOnMainQueue, completionHandler: completionHandler)
    }
    
    // MARK: - Private functions
    
    fileprivate func executeService(_ taskDelegate: ServiceTaskDelegate?,
                                    cacheCriteria: CacheCriteria?,
                                    executionOnMainQueue: Bool,
                                    completionHandler: @escaping (_ data: Data?, _ error: NSError?) -> Void) -> Task? {
        
        guard taskDelegate != nil else {
            let error = NSError(domain: "URL",
                                code: 0,
                                userInfo: ["Error":"Http task delegate is nil !!!",
                                           "Description":"Url would be in improper format."])
            completionHandler(nil, error)
            return nil
        }
        
        var task: Task
        task = HttpTask(delegate: taskDelegate!)
        
        if executionOnMainQueue {
            task.executeAsyncInQueue(OperationQueue.main, completionHandler: { (result, error) -> Void in
                
                completionHandler(result as? Data, error)
            })
        } else {
            task.executeAsync { (result, error) -> Void in
                
                completionHandler(result as? Data, error)
                return
            }
        }
        
        return task
    }
    
    fileprivate func serviceDelegate(_ requestURL: String,
                                     httpMethod: HttpMethod,
                                     mimeType: MIMEType?,
                                     requestBody: Data?,
                                     gzipEncoding: Bool,
                                     headers: [String: String]?) -> ServiceTaskDelegate? {
        
        let url = URL(string: requestURL)
        
        guard url != nil else {
            return nil
        }
        
        let serviceTaskDelegate = ServiceTaskDelegate(httpRequestURL: url!, httpRequestMethod: httpMethod)
        serviceTaskDelegate.httpRequestBody = requestBody
        
        configureServiceDelegateHeaders(serviceTaskDelegate,
                                        mimeType: mimeType,
                                        gzipEncoding: gzipEncoding,
                                        headers: headers)
        
        return serviceTaskDelegate
        
    }
    
    fileprivate func configureServiceDelegateHeaders(_ serviceDelegate: ServiceTaskDelegate,
                                                     mimeType: MIMEType?,
                                                     gzipEncoding: Bool,
                                                     headers: [String: String]?) {
        
        var finalHeaders: [String:String] = headers ?? [:]
        
        if mimeType != nil && finalHeaders[HttpHeader.Accept] == nil {
            finalHeaders[HttpHeader.Accept] = mimeType!.rawValue
        }
        
        if serviceDelegate.httpRequestMethod == .POST {
            if mimeType != nil && finalHeaders[HttpHeader.ContentType] == nil {
                finalHeaders[HttpHeader.ContentType] = mimeType!.rawValue
            }
        }
        
        if gzipEncoding && finalHeaders[HttpHeader.AcceptEncoding] == nil {
            finalHeaders[HttpHeader.AcceptEncoding] = MIMEType.Gzip.rawValue
        }
        
        // For safety, in case we request an outside url, this avoids adding
        // the headers to such calls made
        if serviceDelegate.requestURL.host == serviceHost {
            //
        }
        
        serviceDelegate.httpRequestHeaders = finalHeaders
    }
}
