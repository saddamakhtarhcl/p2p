//
//  TransationViewController.swift
//  CBA
//
//  Created by Nandhakumar on 22/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    static let segueID: String = "TransationSegue"
    var trancations: [TransactionInfo] = []
    @IBOutlet weak var trancactionTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        trancactionTbl.dataSource = self
        trancactionTbl.delegate = self
        trancactionTbl.separatorColor = UIColor.clear
        
        DataServiceManager.accountService.getTransactions(startDate: nil,
                                                          endDate: nil,
                                                          completion: { (transactions, _) in
                                                            self.trancations = transactions
        })
    }    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trancations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell") as? TransactionTableViewCell {
            let transaction: TransactionInfo = trancations[indexPath.item]
            cell.configure(transaction: transaction)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
