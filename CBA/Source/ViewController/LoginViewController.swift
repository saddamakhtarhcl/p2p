//
//  LoginViewController.swift
//  CBA
//
//  Created by Nandhakumar on 13/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    private let userInfoService = DataServiceManager.userInfoService
    private let loginService = DataServiceManager.loginService
    
    @IBOutlet weak var txtClientNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    // MARK: - UIViewController overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBOutlets
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        
        if txtClientNumber?.text?.isEmpty == false && txtPassword?.text?.isEmpty == false {
            
            let credentials: LoginCredentials = LoginCredentials()
            credentials.userId = txtClientNumber!.text!
            credentials.password = txtPassword!.text!
            
            loginService.login(credentials: credentials) { [weak self] (success, error) in
                if error == nil && success {
                    
                    self?.userInfoService.getCurrentUserInfo { [weak self] (userInfo, _) in
                        
                        DispatchQueue.main.async(execute: {
                            if userInfo != nil {
                                
                                App.scheduleTokenRefresh()
                                
                                App.user = userInfo
                                self?.performSegue(withIdentifier: DashBoardViewController.segueID,
                                                   sender: nil)
                                self?.txtClientNumber.text = ""
                                self?.txtPassword.text = ""
                            } else {
                                self?.showInvalidCredentialsAlert()
                                self?.txtPassword.text = ""
                            }
                        })
                    }
                } else {
                    DispatchQueue.main.async(execute: {
                        self?.showInvalidCredentialsAlert()
                    })                    
                }
            }
            
        } else {
            self.showInvalidCredentialsAlert()
        }
    }
    
    // MARK: - Private methods
    
    private func layoutUI() {
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 133.0/255.0,
                                                                        green: 163.0/255.0,
                                                                        blue: 165.0/255.0,
                                                                        alpha: 1.0)
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
