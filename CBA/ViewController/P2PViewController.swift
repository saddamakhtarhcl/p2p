//
//  P2PViewController.swift
//  CBA
//
//  Created by Nandhakumar on 14/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import UIKit

class P2PViewController: UIViewController {
    
    static let segueID: String = "P2PSegue"
    
    // MARK: - String literals
    
    private let strPageTitle: String = "Pear to Pear"
    private let strVisibleON: String = "Visibility On"
    private let strVisibleOFF: String = "Visibility Off"
    private let strFindUser: String = "Find Users"
    private let strStopScan: String = "Stop Scan"
    
    @IBOutlet weak var switchVisibility: UISwitch!
    @IBOutlet weak var lblVisibility: UILabel!
    @IBOutlet weak var scanView: BackgroundViewView!
    @IBOutlet weak var findUserBtn: UIButton!
    
    var foundUsers: [PeerUser] = []
    
    var gradientLayer: CAGradientLayer?
    
    let p2pManager: PeerToPeer = P2PManager(withName: App.user.userToken ?? UIDevice.current.name)
    var scanAnimationTimer: Timer?
    
    // MARK: - UIViewController overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pear to pear"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.stopScaning()
        self.broadcast  = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.applyGradient()        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
    // MARK: - IBAction methods
    
    @IBAction func switchValueChange(_ sender: UISwitch) {
        broadcast = sender.isOn
    }
    
    @IBAction func btnScanTapped(_ sender: UIButton) {
        if p2pManager.isScanning {
            p2pManager.stopScan()
            stopScanAnimation()
            sender.setTitle(strFindUser, for: .normal)
        } else {
            startScan(status: { [weak self] (flag) in
                if flag {
                    sender.setTitle(self?.strStopScan, for: .normal)
                } else {
                    sender.setTitle(self?.strFindUser, for: .normal)
                }
            })
        }
    }
    
    private func stopScaning() {
        if p2pManager.isScanning {
            p2pManager.stopScan()
            stopScanAnimation()
            findUserBtn.setTitle(strFindUser, for: .normal)
        }
    }
    
    // MARK: - Private methods
    
    private func startScan(status: @escaping ((Bool) -> Void)) {
        
        stopScanAnimation()
        p2pManager.stopScan()
        
        p2pManager.scan(callBack: { [weak self] (isStartedScaning) in
            status(isStartedScaning)
            if isStartedScaning {
                self?.scanAnimationTimer = Timer.scheduledTimer(withTimeInterval: 2.8,
                                                                repeats: true,
                                                                block: { [weak self] (_) in
                                                                    self?.showScanAnimation(withDuration: 3.0)
                                                                    self?.showScanAnimation(withDuration: 1.0)
                })
            } else {
                self?.stopScanAnimation()
                self?.p2pManager.stopScan()
            }
            
            self?.scanAnimationTimer?.fire()
            }, found: { peerId in
                guard peerId != nil else {return}
                
                DataServiceManager.userInfoService.getUserInfo(userID: peerId) { [weak self] (userInfo, _) in
                    if userInfo != nil {
                        let newFoundUser = PeerUser(detail: userInfo!)
                        if self?.userAlreadyExists(user: newFoundUser) == false {
                            self?.addUserView(user: newFoundUser)
                        }
                    }
                }
        })
        
    }
    
    private func stopScanAnimation() {
        scanAnimationTimer?.invalidate()
        scanAnimationTimer = nil
    }
    
    private func showScanAnimation(withDuration: TimeInterval) {
        let radarLayer = RadarAnimationLayer(color: UIColor(colorCode:"FFFFFF"))
        radarLayer.animationDuration = withDuration
        radarLayer.fillAlpha = 0.1
        radarLayer.animate(startPoint: self.scanView.center,
                           diameter: self.scanView.frame.width + 80.0,
                           parentLayer: self.view.layer)
    }
    
    private var broadcast: Bool {
        
        get {
            return p2pManager.isBroadcasting
        }
        
        set (newValue) {
            if newValue {
                lblVisibility.text = strVisibleON
                if p2pManager.isBroadcasting == false {
                    p2pManager.startBroadcast { (_, _) in
                    }
                }
            } else {
                lblVisibility.text = strVisibleOFF
                p2pManager.stopBroadcast()
            }
            
            switchVisibility.isOn = newValue
        }
        
    }
    
    private func userAlreadyExists(user: PeerUser) -> Bool {
        return foundUsers.contains { user.userDetail?.userToken == $0.userDetail?.userToken }
    }
    
    private func addUserView(user: PeerUser) {
        
        foundUsers.append(user)
        
        var searchGraphRect: CGRect = self.scanView.frame
        
        // Adjusting the frame available to add found user view's
        let extraHeight: CGFloat = searchGraphRect.size.height - searchGraphRect.size.width
        searchGraphRect.size.width -=  100
        searchGraphRect.size.height = searchGraphRect.size.width
        searchGraphRect.origin.x += 10
        searchGraphRect.origin.y += extraHeight / 2
        
        let randomPoint = searchGraphRect.randomPointInRect()
        let viewFrame = CGRect(origin: randomPoint,
                               size: CGSize(width: 100, height: 80))
        
        let userView = PeerUserView.instanceFromNib(user: user)
        userView.frame = viewFrame
        
        userView.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
        
        self.view.addSubview(userView)
        self.view.bringSubview(toFront: userView)
        
        UIView.animate(withDuration: 0.5, delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: [.beginFromCurrentState], animations: {
                        userView.transform = CGAffineTransform.identity
        })
        
        userView.tapped = { [unowned self] user,userView  in
            print(user.name)
            self.showPopover(userDetail: user, foundUserView: userView)
        }
    }
    
    private func showPopover(userDetail: PeerUser, foundUserView: PeerUserView) {
        if let optionController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserActionPopViewController") as? UserActionPopViewController {
            optionController.selectedIndexChanged = {(selectedIndex: Int) -> Void in
                self.stopScaning()
                if selectedIndex == 0 {
                    if let beneficiaryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AddBeneficiaryViewController.Identifier) as? AddBeneficiaryViewController {
                        beneficiaryViewController.foundUserDetail = userDetail
                        self.navigationController?.pushViewController(beneficiaryViewController, animated: true)
                    }
                } else {
                    if let immediatePayController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: InstantMoneyTransferViewController.Identifier) as? InstantMoneyTransferViewController {
                        immediatePayController.foundUserDetail = userDetail
                        self.navigationController?.pushViewController(immediatePayController, animated: true)
                    }
                }
            }
            optionController.preferredContentSize = CGSize(width: 236.0, height: 100.0)
            optionController.modalPresentationStyle = .popover
            
            let popoverController: UIPopoverPresentationController = optionController.popoverPresentationController!
            popoverController.backgroundColor = UIColor.white
            popoverController.sourceView =  self.view
            let frame = foundUserView.frame
            popoverController.sourceRect = frame
            popoverController.delegate = self
            
            self.present(optionController, animated: true, completion: nil)
        }
        
    }
    
    private func applyGradient() {
        
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = CAGradientLayer()
        
        let gradientFrame = CGRect(origin: CGPoint.zero, size: scanView.frame.size)
        gradientLayer!.frame = gradientFrame
        gradientLayer!.colors = [UIColor(colorCode:"96B2B4").cgColor,
                                 UIColor(colorCode:"2B616C").cgColor
        ]
        gradientLayer!.backgroundColor = UIColor.clear.cgColor
        
        gradientLayer!.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer!.endPoint = CGPoint(x: 0.5, y: 0.3)
        
        gradientLayer!.removeFromSuperlayer()
        scanView.layer.addSublayer(gradientLayer!)
        
    }
    
}

extension P2PViewController: UIPopoverPresentationControllerDelegate {
    
    // MARK: - UIPopoverPresentationControllerDelegate Func
        
    func adaptivePresentationStyle(for controller: UIPresentationController)
        -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
}
