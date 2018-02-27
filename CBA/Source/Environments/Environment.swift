//
//  Environment.swift
//
//  Created by Nandhakumar on 20/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

/**
 * This protocol is to setting up list of services
 */

protocol Environment {
    
    init()
    
    var serviceBaseHostURL: String {get}
}
