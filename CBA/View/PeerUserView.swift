//
//  FoundUserView.swift
//  P2POverBluteeoth
//
//  Created by Saddam on 15/02/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit

class PeerUser {
    var name: String
    var imageUrl: URL?
    var userDetail: UserInfo?
    
    init(detail: UserInfo) {
        self.userDetail = detail
        self.name = detail.userName!
    }
}

class PeerUserView: UIView {
    
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var imgAvatar: UIImageView!
    
    private var prUser: PeerUser!
    var user: PeerUser {
        return prUser
    }    
    
    var tapped: ((PeerUser, PeerUserView) -> Void)?
    
    class func instanceFromNib(user: PeerUser) -> PeerUserView {
        let view = (UINib(nibName: String(describing: self).components(separatedBy: ".").last!,
                          bundle: Bundle.main).instantiate(withOwner: self, options: nil).last
            as? PeerUserView)!
        view.prUser = user
        
        return view
    }
    
    // MARK: - UIView overriden methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handletap))
        self.addGestureRecognizer(tapGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lblName.text = prUser.name
    }
    
    // MARK: -
    
    @objc func handletap() {
        self.tapped?(prUser, self)
    }
}
