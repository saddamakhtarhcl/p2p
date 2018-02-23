//
//  RadarAnimationLayer.swift
//
//  Copyright © 2018 HCL Technologies. All rights reserved.
//

import Foundation
import UIKit

class RadarAnimationLayer: CAShapeLayer {
    
    var animationDuration: CFTimeInterval = 0.4
    var fillAlpha: CGFloat = 0.2 {
        didSet {
            fillColor = self.color.withAlphaComponent(fillAlpha).cgColor
        }
    }
    
    private var startPoint: CGPoint = CGPoint.zero
    private var diameter: CGFloat = 0.0
    private var startDiameter: CGFloat = 0.0
    
    var color: UIColor {
        didSet {
            strokeColor = color.cgColor
            fillColor = color.withAlphaComponent(fillAlpha).cgColor
            backgroundColor = UIColor.clear.cgColor
        }
    }
    
    init(color: UIColor) {
        self.color = color
        super.init()
        
        strokeColor = color.cgColor
        fillColor = color.withAlphaComponent(fillAlpha).cgColor
        backgroundColor = UIColor.clear.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var ovalPathZero: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(origin: CGPoint(x:startPoint.x - startDiameter/2,
                                                           y:startPoint.y - startDiameter/2),
                                           size: CGSize(width: startDiameter,
                                                        height: startDiameter)))
    }
    
    private var ovalPathMax: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(origin: CGPoint(x:startPoint.x - diameter/2,
                                                           y:startPoint.y - diameter/2),
                                           size: CGSize(width: diameter,
                                                        height: diameter)))
    }
    
    func animate(startPoint: CGPoint,
                 diameter: CGFloat,
                 parentLayer: CALayer,
                 startDiameter: CGFloat = 0.0,
                 addBelowParentLayer: Bool = false,
                 parentView: UIView? = nil) {
        
        self.startPoint = startPoint
        self.diameter = diameter
        self.startDiameter = startDiameter
        
        frame = CGRect(origin: CGPoint.zero, size: CGSize(width: parentLayer.frame.width,
                                                          height: parentLayer.frame.height))
        
        if !addBelowParentLayer {
            parentLayer.addSublayer(self)
        } else {
            if parentView != nil {
                parentView!.layer.insertSublayer(self, below: parentLayer)
            }
        }
        
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = ovalPathZero.cgPath
        expandAnimation.toValue = ovalPathMax.cgPath
        expandAnimation.duration = animationDuration
        
        let opacityAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        opacityAnimation.beginTime = animationDuration / 2
        opacityAnimation.duration = animationDuration / 2
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [expandAnimation, opacityAnimation]
        groupAnimation.duration = animationDuration
        
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        add(groupAnimation, forKey: nil)
        
        Timer.scheduledTimer(timeInterval: animationDuration, target: self,
                             selector: #selector(remove),
                             userInfo: nil, repeats: false)
        
    }
    
    @objc func remove() {
        self.removeFromSuperlayer()
    }
    
}
