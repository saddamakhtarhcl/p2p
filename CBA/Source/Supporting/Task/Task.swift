//
//  Task.swift
//
//  Created by Saddam on 15/02/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation

// MARK: - Task Protocol

protocol Task {
    
    // MARK: - Functions
        
    func executeAsync(_ completionHandler: @escaping (_ result: Any?, _ error: NSError?) -> Void)
    func executeAsyncInQueue(_ queue: OperationQueue, completionHandler: @escaping ((_ result: Any?, _ error: NSError?) -> Void))
    func cancel()
    
    var isCancelled: Bool {get}
    var hasResult: Bool {get}
    var urlResponse: URLResponse? {get}
    var result: AnyObject? {get}
    var hasError: Bool {get}
    var error: NSError? {get}
}
