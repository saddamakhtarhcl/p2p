//
//  TransactionTableViewCell.swift
//  CBA
//
//  Created by Nandhakumar on 22/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var accountNumberLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var remark: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(transaction: TransactionInfo) {
        cell.accountNumberLbl.text = transaction.accountNo
        cell.amountLbl.text = "$\(String(format: "%.2f", transaction.amount))"
        cell.dateLbl.text = self.currentDate(date: transaction.date!)
        cell.remark.text = transaction.remark
    }
}
