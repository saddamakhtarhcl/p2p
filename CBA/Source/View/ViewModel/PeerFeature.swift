//
//  PeerFeature.swift
//  CBA
//
//  Created by Saddam Akhtar on 28/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

class PeerFeature {
    var optionlabel: String
    var isSelected: Bool = false
    
    init(option: String) {
        self.optionlabel = option
    }
}
