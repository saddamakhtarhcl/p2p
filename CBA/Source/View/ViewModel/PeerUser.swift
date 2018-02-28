//
//  PeerUser.swift
//  CBA
//
//  Created by Saddam Akhtar on 28/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

import UIKit

class PeerUser {
    var name: String
    var imageUrl: URL?
    var userDetail: UserInfo?
    
    init(detail: UserInfo) {
        self.userDetail = detail
        self.name = detail.userName!
    }
}
