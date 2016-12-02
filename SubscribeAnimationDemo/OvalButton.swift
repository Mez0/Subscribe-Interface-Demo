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
  internal var textColor: UIColor = UIColor.black
  internal var fillColor: UIColor = UIColor.white
  internal var strokeColor: UIColor = RedColor
  
  var buttonActivated = false
  
  var text: String = "Subscribe"
  var clickClosure: () -> () = {}
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    context?.addRect(rect)
    UIColor.clear.set()
    context?.fillPath()
    
    let roundPath = UIBezierPath(roundedRect: rect.insetBy(dx: 1, dy: 1), cornerRadius: rect.height / 2)
    fillColor.setFill()
    roundPath.fill()
    strokeColor.setStroke()
    roundPath.lineWidth = 1.5
    roundPath.stroke()
    
    let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
    paragraphStyle.alignment = .center
    let attr = [NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16), NSForegroundColorAttributeName: textColor]
    let textSize = text.size(attributes: attr)
    
    let r = CGRect(x: rect.origin.x, y: rect.origin.y + (rect.size.height - textSize.height) / 2, width: rect.size.width, height: textSize.height)
    text.draw(in: r, withAttributes: attr)
    
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
      buttonOpacityAnimation.isRemovedOnCompletion = false
      
      self.layer.add(buttonOpacityAnimation, forKey: "buttonVanish")
      buttonActivated = true
    }
    
  }
  
  
  
}
