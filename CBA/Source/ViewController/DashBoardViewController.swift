//
//  DashBoardViewController.swift
//  CBA
//
//  Created by Nandhakumar on 22/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class DashBoardViewController: UIViewController {
    
    @IBOutlet weak var imgAvatar: UIImageView!
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
        lblAccount.text = "Acc No.\n\(accountNo ?? "")"
        DataServiceManager.accountService.getCurrentBalance { (balance, _) in
            self.lblBalance.text = "$\(String(format: "%.2f", balance))"
        }
        
        imgAvatar.image = UIImage(named: App.user.userToken ?? "") ?? UIImage(named: "avatar")
        self.initLogoutBtn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initLogoutBtn() {
        let rightButtonItem = UIBarButtonItem.init(
            image: UIImage(named: "logout")?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(DashBoardViewController.btnLogout_tap(_:))
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
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
    
    @IBAction func btnLogout_tap(_ sender: UIButton) {
        App.user = nil
        self.navigationController?.popToRootViewController(animated: true)
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
    
}
