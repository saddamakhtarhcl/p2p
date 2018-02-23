//
//  ImmediatePayViewController.swift
//  CBA
//
//  Created by Nandhakumar on 16/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class InstantMoneyTransferViewController: UIViewController {
    
    var foundUserDetail: PeerUser!
    static let Identifier: String = "InstantMoneyTransferViewController"
    static let segueID: String = "InstantMoneySegue"
    @IBOutlet weak var payeeName: UILabel!
    
    @IBOutlet weak var payeeNameTxt: UITextField!
    @IBOutlet weak var accNoTxt: UITextField!
    @IBOutlet weak var lblAmount: UITextField!
    @IBOutlet weak var lblRemarks: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payeeName?.text = "Payee Name : \(foundUserDetail.userDetail?.userName ?? "")\nAccount No  : \(foundUserDetail.userDetail?.accountNumber ?? "")"
        
        self.title = "Instant Transfer"
    }
    
    @IBAction func btnTransferTapped(_ sender: UIButton) {
        if lblAmount.text != nil, lblRemarks != nil {
            if let amount = lblAmount.text {
                let transaction = TransactionInfo()
                transaction.accountNo = foundUserDetail.userDetail?.accountNumber
                transaction.amount = Double(amount)!
                transaction.date = Date()
                transaction.remark = lblRemarks.text
                
                DataServiceManager.accountService.transfer(transactionInfo: transaction) { (status, _) in
                    if status == true {
                        self.showInvalidDetailsAlert(msg: "Transfered successfully")
                    } else {
                        self.showInvalidDetailsAlert(msg: "Transaction Failed")
                    }
                }
            } else {
                self.showInvalidDetailsAlert(msg: "Invalid Amount or Remark")
            }
        }
    }
    
    private func showInvalidDetailsAlert(msg: String) {
        let alert = UIAlertController(title: msg,
                                      message: "",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertActionStyle.default,
                                      handler: backTapped))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func backTapped(action: UIAlertAction) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
