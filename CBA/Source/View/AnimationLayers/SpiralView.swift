//
//  BackgroundViewView.swift
//
//  Copyright © 2018 HCL Technologies. All rights reserved.
//

import Foundation
import UIKit

class SpiralView: UIView {
    
    private var layers = [CAShapeLayer]()
    
    private var radii: [CGFloat] = []
    private var viewCenter: CGPoint
    
    private let angles: [CGFloat] = [0,45,135,180,225,315]
    
    private var ringColors = [UIColor(colorCode:"212026"),
                              UIColor(colorCode:"1C1C22"),
                              UIColor(colorCode:"18181E"),
                              UIColor(colorCode:"141419"),
                              UIColor(colorCode:"100F13"),
                              UIColor(colorCode:"0B0A0D")]
    
    private let bgColor = UIColor(colorCode:"040407")
    
    var levels: [Int] = [4,1,3,5,0,2]
    
    required init?(coder aDecoder: NSCoder) {
        viewCenter = CGPoint.zero
        super.init(coder: aDecoder)
        
        self.clipsToBounds = true
        
        backgroundColor = bgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        refresh()
    }
    
    func refresh() {
        clear()
        drawLevelLayers()
    }
    
    private func clear() {
        // Clearing the older layers
        for layer in layers {
            layer.removeFromSuperlayer()
        }
        
        layers = [CAShapeLayer]()
    }
    
    func drawLevelLayers() {
        
        var radius: CGFloat = 0
        let radiusDelta: CGFloat = 0.10
        
        radii = []
        
        for index in 1...6 {
            
            viewCenter = CGPoint.init(x: bounds.midX, y: bounds.midY)
            let viewRadius = (bounds.size.width < bounds.size.height ?
                bounds.size.width : bounds.size.height) / 2
            
            if index == 1 {
                radius = viewRadius * 0.4
            } else {
                radius += viewRadius * radiusDelta
            }
            
            let path = arcPath(center: viewCenter, radius: radius, startAngle: 0, angle: 360)
            
            var ringWidth:CGFloat = radius
            var fillColor = true
            if index > 1 {
                ringWidth = radius - radii.last!
                fillColor = false
            }
            
            _ = drawPath(path: path, color: ringColors[index-1], lineWidth: ringWidth, fillColor: fillColor)
            
            radii.append(radius)
        }
    }
    
    /**
     *  Returns bezier path of the arc
     **/
    private func arcPath(center: CGPoint, radius: CGFloat,
                         startAngle: CGFloat, angle: CGFloat) -> UIBezierPath {
        let path = UIBezierPath.init()
        
        let startAngleInRadians = radians(degree: startAngle)
        let angleInRadians = radians(degree: angle)
        
        path.addArc(withCenter: center,
                    radius: radius,
                    startAngle: startAngleInRadians,
                    endAngle: startAngleInRadians + angleInRadians,
                    clockwise: true)
        
        return path
    }
    
    /**
     *  Draws the arcs
     **/
    private func drawPath(path: UIBezierPath, color: UIColor, lineWidth: CGFloat, fillColor: Bool = false) -> CALayer {
        let layer = CAShapeLayer()
        
        if fillColor {
            layer.fillColor = color.cgColor
        } else {
            layer.fillColor = UIColor.clear.cgColor
        }
        
        layer.strokeColor = color.cgColor
        layer.lineWidth = lineWidth
        layer.path = path.cgPath
        
        layers.append(layer)
        
        self.layer.addSublayer(layer)
        
        return layer
        
    }
    
    // MARK: - Helper func
    
    private func radians(degree: CGFloat) -> CGFloat {
        let b = CGFloat(Double.pi) * (degree/180)
        return b
    }
    
}
