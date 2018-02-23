//
//  AlternatePopFilterOptionView.swift
//
//  Copyright © 2016 HCL Technologies. All rights reserved.
//

import UIKit

class PopFilterOptionView: UIView {
    
    @IBOutlet weak var optionTitle: UILabel!
    @IBOutlet weak var bottomLine: UILabel!
    @IBOutlet weak var radioButton: UIButton!
    
    // MARK: - UIView Override
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Class func
    
    class func instanceFromNib() -> PopFilterOptionView {
        return (UINib(nibName: String(describing: self).components(separatedBy: ".").last!,
                      bundle: Bundle.main).instantiate(withOwner: self, options: nil).last
            as? PopFilterOptionView)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        optionTitle.font = UIFont.systemFont(ofSize: 16.0)
    }
    
    func configureDetailItem(_ title: String = String(), isSelected: Bool = false, showBottomLine: Bool = true) {
        self.optionTitle.text = title
        if isSelected {
            radioButton.isSelected = true
            optionTitle.font = UIFont.systemFont(ofSize: 16.0)
        } else {
            radioButton.isSelected = false
            optionTitle.font = UIFont.systemFont(ofSize: 16.0)
        }
        if !showBottomLine {
            self.bottomLine.backgroundColor = UIColor.clear
        }
    }
}
