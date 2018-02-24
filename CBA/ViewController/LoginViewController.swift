//
//  LoginViewController.swift
//  CBA
//
//  Created by Nandhakumar on 13/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtClientNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 133.0/255.0,
                                                                        green: 163.0/255.0,
                                                                        blue: 165.0/255.0,
                                                                        alpha: 1.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if txtClientNumber?.text?.isEmpty == false && txtPassword?.text?.isEmpty == false {
            DataServiceManager.userInfoService.getUserInfo(userID: txtClientNumber?.text ?? "") { [weak self] (userInfo, _) in
                if userInfo != nil {
                    App.user = userInfo
                    self?.performSegue(withIdentifier: DashBoardViewController.segueID,
                                       sender: nil)
                    self?.txtClientNumber.text = ""
                    self?.txtPassword.text = ""
                } else {
                    self?.showInvalidCredentialsAlert()
                    self?.txtPassword.text = ""
                }
            }
        } else {
            self.showInvalidCredentialsAlert()
        }
    }
    
    private func showInvalidCredentialsAlert() {
        let alert = UIAlertController(title: "Invalid Client Number or password",
                                      message: "",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertActionStyle.default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
