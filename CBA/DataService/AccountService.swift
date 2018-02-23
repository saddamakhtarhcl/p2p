//
//  TransactionInfoService.swift
//  CBA
//
//  Created by Nandhakumar on 22/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import Foundation

protocol AccountService {
    func getTransactions(startDate: Date?, endDate: Date?,
                         completion: @escaping (([TransactionInfo], Error?) -> Void))
    func transfer(transactionInfo: TransactionInfo,
                  completion: @escaping ((Bool, Error?) -> Void))
    func getCurrentBalance(completion: @escaping ((Double, Error?) -> Void))
}
