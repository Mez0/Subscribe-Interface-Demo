//
//  OvalButton.swift
//  SubscribeAnimationDemo
//
//  Created by QL on 16/8/28.
//  Copyright © 2016年 QL. All rights reserved.
//

import UIKit

class OvalButton: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    internal var textColor: UIColor = UIColor.blackColor()
    internal var fillColor: UIColor = UIColor.whiteColor()
    internal var strokeColor: UIColor = RedColor
    
    var buttonActivated = false
    
    var text: String = "Subscribe"
    var clickClosure: () -> () = {}
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextAddRect(context, rect)
        UIColor.clearColor().set()
        CGContextFillPath(context)
        
        let roundPath = UIBezierPath(roundedRect: CGRectInset(rect, 1, 1), cornerRadius: rect.height / 2)
        fillColor.setFill()
        roundPath.fill()
        strokeColor.setStroke()
        roundPath.lineWidth = 1.5
        roundPath.stroke()
        
        let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = .Center
        let attr = [NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: UIFont.boldSystemFontOfSize(16), NSForegroundColorAttributeName: textColor]
        let textSize = text.sizeWithAttributes(attr)
        
        let r = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - textSize.height) / 2, rect.size.width, textSize.height)
        text.drawInRect(r, withAttributes: attr)
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        clickClosure()
    }
    
    func animateAfterTapped() {
        if buttonActivated == false {
            let buttonOpacityAnimation = CABasicAnimation(keyPath: "opacity")
            buttonOpacityAnimation.fromValue = 1
            buttonOpacityAnimation.toValue = 0
            buttonOpacityAnimation.duration = 0.3
            buttonOpacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            buttonOpacityAnimation.fillMode = kCAFillModeForwards
            buttonOpacityAnimation.removedOnCompletion = false
            buttonOpacityAnimation.delegate = self
            
            self.layer.addAnimation(buttonOpacityAnimation, forKey: "buttonVanish")
            buttonActivated = true
        }
        
    }
    
    

}
