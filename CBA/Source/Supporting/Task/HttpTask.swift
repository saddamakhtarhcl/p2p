//
//  HttpTask.swift
//
//  Created by Saddam on 15/02/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit

// MARK: - HttpTaskDelegate protocol

protocol HttpTaskDelegate: class {
    var requestURL: URL {get}
    func configureRequest(_ request: NSMutableURLRequest) -> Bool
    func prepareRequest(_ request: NSMutableURLRequest) -> Bool
}

// MARK: - HttpTask Class

class HttpTask : Task {

    // MARK: - Properties
    
    var urlResponse: URLResponse?
    static var blockAllRequests: Bool = false
    
    fileprivate var taskResult: Data?
    fileprivate var taskError: NSError?
    fileprivate var cancelled: Bool = false
    fileprivate var delegate: HttpTaskDelegate
    
    fileprivate var dataTask: URLSessionDataTask?
    
    // MARK: - Initializers
    
    init(delegate: HttpTaskDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Task Protocol implementation
    
    func executeAsync(_ completionHandler: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
        let httpTaskQueue = OperationQueue()
        httpTaskQueue.name = "Http task queue"
        executeAsyncInQueue(httpTaskQueue, completionHandler: completionHandler)
    }
    
    func executeAsyncInQueue(_ queue: OperationQueue, completionHandler: @escaping ((_ result: Any?, _ error: NSError?) -> Void)) {
        
        if (isCancelled) {
            return
        }
        
        let request = createRequest()
        guard request != nil else {
            self.taskError = NSError(domain: "", code: HttpStatus.httpStatusBadRequest.rawValue,
                                     userInfo: ["errorMessage":"URL request is nil"])
            completionHandler(nil as AnyObject?, self.taskError as NSError?)
            return
        }
        
        let session = URLSession(configuration: URLSession.shared.configuration,
                                   delegate: nil,
                                   delegateQueue: queue)
        
        dataTask = session.dataTask(with: request!, completionHandler: {(data, response, error) -> Void in
            if(self.isCancelled) {
                session.invalidateAndCancel()
                return
            }
            
            guard let _:Data = data, let _: URLResponse = response else {
                
                OperationQueue.main.addOperation({
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                })
                completionHandler(data as AnyObject?, error as NSError?)
                session.invalidateAndCancel()
                return
            }
            
            self.taskResult = data
            self.urlResponse = response
            self.taskError = error as NSError?
                        
            OperationQueue.main.addOperation({
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            
            completionHandler(data as AnyObject?, self.taskError as NSError?)
            session.invalidateAndCancel()
        })
        
        OperationQueue.main.addOperation({
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        })
        dataTask?.resume()
        
    }
    
    func cancel() {
        OperationQueue.main.addOperation({
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
        dataTask?.cancel()
        self.cancelled = true
    }
    
    var isCancelled : Bool {
        return self.cancelled
    }
    
    var hasResult: Bool {
        if self.taskResult != nil {
            return true
        } else {
            return false
        }
    }
    
    var result: AnyObject? {
        return self.result
    }
    
    var hasError: Bool {
        if self.taskError != nil {
            return true
        } else {
            return false
        }
    }
    
    var error: NSError? {
        return self.taskError
    }
    
    // MARK: - Private functions
    
    fileprivate func createRequest() -> URLRequest? {
        let request = NSMutableURLRequest(url: self.delegate.requestURL)
        if self.delegate.configureRequest(request) == false {
            return nil
        }
        if self.delegate.prepareRequest(request) == false {
            return nil
        }
        return request as URLRequest
    }
}
