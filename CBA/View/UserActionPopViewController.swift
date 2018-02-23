//
//  UserActionPopViewController.swift
//  CBA
//
//  Created by Nandhakumar on 16/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class UserActionPopViewController: UIViewController {
    
    @IBOutlet var optionStackView: UIStackView?
    var selectedIndexChanged: ((Int) -> Void)?
    fileprivate var optionsView: [PopFilterOptionView] = [PopFilterOptionView]()
    var userOptionsArray: [UserOptions] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userOptionsArray.append(UserOptions.init(option: "Add Beneficiary"))
        userOptionsArray.append(UserOptions.init(option: "Instant Transfer"))
        createStackView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createStackView() {
        optionsView = [PopFilterOptionView]()
        
        for item in userOptionsArray {
            let detailRowView = PopFilterOptionView.instanceFromNib()
            detailRowView.frame.size.height = 44.0
            
            detailRowView.configureDetailItem(item.optionlabel , isSelected: item.isSelected)
            
            let selectionGesture = UITapGestureRecognizer(target: self, action: #selector(UserActionPopViewController.changeSelection))
            detailRowView.addGestureRecognizer(selectionGesture)
            optionsView.append(detailRowView)
            optionStackView?.addArrangedSubview(detailRowView)
        }
    }
    
    @objc func changeSelection(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            if let selectedView = recognizer.view as? PopFilterOptionView , optionsView.contains(selectedView) {
                let aIndex = optionsView.index(of: selectedView)
                self.dismiss(animated: true, completion: {
                    self.selectedIndexChanged?(aIndex!)
                })
            }
        }
    }
    
}

class UserOptions {
    var optionlabel: String
    var isSelected: Bool = false
    
    init(option: String) {
        self.optionlabel = option
    }
}
