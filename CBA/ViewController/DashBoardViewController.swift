//
//  DashBoardViewController.swift
//  CBA
//
//  Created by Nandhakumar on 22/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class DashBoardViewController: UIViewController {
    
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    static let segueID: String = "DashBoardSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let accountNo = App.user.accountNumber
        lblAccount.text = "Account Number\n\t\(accountNo ?? "")"
        DataServiceManager.accountService.getCurrentBalance { (balance, _) in
            self.lblBalance.text = "Avalible Balance: $\(String(describing: balance))"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnP2pTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: P2PViewController.segueID, sender: nil)
    }
    
    @IBAction func btnAllTransactionTapped(_ sender: UIButton) {
        DataServiceManager.accountService.getTransactions(startDate: nil, endDate: nil, completion: { (transactions, _) in
            if transactions.isEmpty == false {
                self.performSegue(withIdentifier: TransactionViewController.segueID, sender: nil)
            } else {
                self.showInvalidDetailsAlert(msg: "No Transaction found")
            }
        })
    }
    
    private func showInvalidDetailsAlert(msg: String) {
        let alert = UIAlertController(title: msg,
                                      message: "",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertActionStyle.default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
