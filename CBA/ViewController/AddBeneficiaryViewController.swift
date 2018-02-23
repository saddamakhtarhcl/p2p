//
//  AddAsBeneficiaryViewController.swift
//  CBA
//
//  Created by Nandhakumar on 16/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class AddBeneficiaryViewController: UIViewController {
    
    var foundUserDetail: PeerUser!
    static let Identifier: String = "AddBeneficiaryViewController"
    static let segueID: String = "AddBeneficiarySegue"
    @IBOutlet weak var payeeDetailsLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payeeDetailsLbl?.text = "Payee Name : \(foundUserDetail.userDetail?.userName ?? "")\nAccount No  : \(foundUserDetail.userDetail?.accountNumber ?? "")"
        
        self.title = "Add Payee"        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
