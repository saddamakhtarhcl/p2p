//
//  TransactionInfo.swift
//  CBA
//
//  Created by Nandhakumar on 22/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class TransactionInfo: BaseModel {
    
    private struct JsonKey {
        static let accountNo: String          =     "accountNo"
        static let amount: String             =     "amount"
        static let remark: String             =     "remark"
        static let type: String               =     "type"
        static let date: String               =     "date"
    }
    
    // MARK: - Properties
    var accountNo: String?
    var amount: Double = 0
    var remark: String?
    var type: String?
    var date: Date?
    
    static func instanceFromDictionary(_ dictionary: [String : Any]?) -> Any? {
        if dictionary == nil {
            return nil
        }
        let instance = UserInfo()
        instance.setAttributesFromDictionary(dictionary)
        return instance
    }
    
    func dictionaryRepresentation() -> [String : Any]? {
        var dictionary = [String: Any]()
        
        dictionary[JsonKey.accountNo] = accountNo
        dictionary[JsonKey.amount] = amount
        dictionary[JsonKey.remark] = remark
        dictionary[JsonKey.type] = type
        dictionary[JsonKey.date] = date
        
        if dictionary.isEmpty {
            return nil
        } else {
            return dictionary
        }
    }
    
    func setAttributesFromDictionary(_ dictionary: [String : Any]?) {
        self.accountNo = dictionary?[JsonKey.accountNo] as? String
        if let amount = dictionary?[JsonKey.amount] as? Double {
            self.amount = amount
        }
        self.remark = dictionary?[JsonKey.remark] as? String
        self.type = dictionary?[JsonKey.type] as? String
        self.date = dictionary?[JsonKey.date] as? Date
    }
}
