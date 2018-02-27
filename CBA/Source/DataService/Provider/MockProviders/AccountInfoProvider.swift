//
//  AccountInfoProvider.swift
//  CBA
//
//  Created by Nandhakumar on 22/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class AccountMockProvider: AccountService {
    
    private static var currentBalance: Double = 10000
    private static var transactions: [TransactionInfo] = []
    
    func transfer(transactionInfo: TransactionInfo, completion: @escaping ((Bool, Error?) -> Void)) {
        if AccountMockProvider.currentBalance >= transactionInfo.amount &&
            AccountMockProvider.currentBalance > 0 {
            AccountMockProvider.currentBalance -= transactionInfo.amount
            AccountMockProvider.transactions.append(transactionInfo)
            completion(true, nil)
        } else {
            completion(false, nil)
        }
    }
    
    func getTransactions(startDate: Date?, endDate: Date?,
                         completion: @escaping (([TransactionInfo], Error?) -> Void)) {
        completion(AccountMockProvider.transactions, nil)
    }
    
    func getCurrentBalance(completion: @escaping ((Double, Error?) -> Void)) {
        completion(AccountMockProvider.currentBalance, nil)
    }
    
}
