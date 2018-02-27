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
        self.accountNumberLbl.text = transaction.accountNo
        self.amountLbl.text = "$\(String(format: "%.2f", transaction.amount))"
        self.dateLbl.text = transaction.date != nil ? self.currentDate(date: transaction.date!) : nil
        self.remark.text = transaction.remark
    }
    
    private func currentDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm"
        let result = formatter.string(from: date)
        return result
    }
}
