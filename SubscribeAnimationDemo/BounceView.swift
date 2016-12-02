//
//  BounceView.swift
//  SubscribeAnimationDemo
//
//  Created by QL on 16/8/27.
//  Copyright © 2016年 QL. All rights reserved.
//

import UIKit

let Padding: CGFloat = 15
let CellPadding: CGFloat = 10
let RedColor: UIColor = UIColor(red:0.90, green:0.13, blue:0.09, alpha:1.00)
let GrayColor: UIColor = UIColor(red:0.80, green:0.76, blue:0.75, alpha:1.00)


struct Video {
  var image: UIImage
  var title: String
}


class BounceView: UIView {
  
  var backgroundView = UIView()
  var frontView = UIView()
  var buttonView = UIView()
  
  fileprivate var imageView = UIView()
  fileprivate var scrollView:UIScrollView = UIScrollView()
  
  internal var button = OvalButton()
  internal var buttonText: String = "Subscribe"
  internal var videoList: [Video] = [Video]()
  
  
  var channelLabel: UILabel = UILabel()
  var followerLabel:UILabel = UILabel()
  
  var frontViewFilled = false
  
  internal var backgroundImage: UIImage? {
    didSet {
      for view in backgroundView.subviews {
        view.removeFromSuperview()
      }
      imageView = UIImageView(image: backgroundImage)
      backgroundView.addSubview(imageView);
    }
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  
  
  func setup() {
    //        backgroundView = UIView(frame: CGRectMake(Padding, 0, self.bounds.size.width - Padding * 2, self.bounds.size.height))
    backgroundView = UIView(frame: CGRect(x: Padding, y: self.bounds.height, width: self.bounds.size.width - Padding * 2, height: self.bounds.size.height))
    
    backgroundView.clipsToBounds = true
    backgroundView.layer.cornerRadius = 15
    backgroundView.layer.shadowRadius = 5
    backgroundView.layer.shadowOffset = CGSize(width: 0, height: 4)
    backgroundView.layer.shadowOpacity = 0.5
    
    //        frontView = UIView(frame: CGRectMake(0, self.bounds.size.height * 2/3, self.bounds.width, self.bounds.size.height * 1/3))
    frontView = UIView(frame: CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: self.bounds.size.height * 1/3))
    frontView.backgroundColor = UIColor.white
    frontView.layer.backgroundColor = UIColor.white.cgColor
    frontView.layer.cornerRadius = 5
    frontView.layer.shadowRadius = 5
    frontView.layer.shadowOffset = CGSize(width: 0, height: 4)
    frontView.layer.shadowOpacity = 0.5
    
    button.frame = CGRect(x: frontView.bounds.size.width - 10 - 110, y: 10, width: 110, height: 35)
    button.clickClosure = {
      print("clicked!")
      self.animate()
    }
    frontView.addSubview(button)
    
    
    channelLabel.text = "Casey Neistat"
    channelLabel.sizeToFit()
    channelLabel.frame.origin = CGPoint(x: 10, y: 10)
    channelLabel.font = UIFont.boldSystemFont(ofSize: 16)
    channelLabel.textColor = UIColor.black
    frontView.addSubview(channelLabel)
    
    followerLabel.text = "4,145,783 followers"
    followerLabel.sizeToFit()
    followerLabel.frame.origin = CGPoint(x: 10, y: channelLabel.frame.origin.x + channelLabel.frame.size.height - 2)
    followerLabel.font = UIFont.systemFont(ofSize: 14)
    followerLabel.textColor = GrayColor
    frontView.addSubview(followerLabel)
    
    scrollView.frame = CGRect(x: 0, y: followerLabel.frame.origin.y + followerLabel.frame.size.height + 5, width: frontView.frame.size.width, height: frontView.frame.size.height - (followerLabel.frame.origin.y + followerLabel.frame.size.height + 5))
    
    scrollView.contentSize = CGSize(width: frontView.frame.size.width + 150, height: 0)
    scrollView.showsHorizontalScrollIndicator = false
    frontView.addSubview(scrollView)
    
    setupCells()
    
    self.addSubview(backgroundView)
    self.insertSubview(frontView, aboveSubview: backgroundView)
  }
  
  
  
  func setupCells() {
    let width = (scrollView.frame.width - 2*CellPadding)/3
    let cell1 = videoCell(width: width, height: scrollView.frame.height, image: UIImage(named: "cell1")!, title: "Hello, world!")
    cell1.frame.origin = CGPoint(x: CellPadding, y: 0)
    scrollView.addSubview(cell1)
    
    let cell2 = videoCell(width: width, height: scrollView.frame.height, image: UIImage(named: "cell2")!, title: "Hello, world!")
    cell2.frame.origin = CGPoint(x: width + CellPadding * 2, y: 0)
    scrollView.addSubview(cell2)
    
    let cell3 = videoCell(width: width, height: scrollView.frame.height, image: UIImage(named: "cell3")!, title: "Hello, world!")
    cell3.frame.origin = CGPoint(x: width * 2 + CellPadding * 3, y: 0)
    scrollView.addSubview(cell3)
  }
  
  
  func animate() {
    if frontViewFilled == false {
      let startMask = UIBezierPath(roundedRect: button.frame, cornerRadius: 5).cgPath
      let finalMask = UIBezierPath(roundedRect: frontView.layer.bounds, cornerRadius: 5).cgPath
      let mask = CAShapeLayer()
      mask.fillColor = RedColor.cgColor
      
      frontView.layer.insertSublayer(mask, at: 0)
      mask.path = finalMask
      
      let maskAnimation = CABasicAnimation(keyPath: "path")
      maskAnimation.fromValue = startMask
      maskAnimation.toValue = finalMask
      maskAnimation.duration = 0.3
      maskAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      
      mask.add(maskAnimation, forKey: "path")
      
      let newLabel = UILabel()
      newLabel.text = "Subscribed"
      newLabel.font = UIFont.boldSystemFont(ofSize: 16)
      newLabel.textColor = UIColor.white
      newLabel.alpha = 0
      newLabel.sizeToFit()
      newLabel.frame.origin = CGPoint(x: button.frame.origin.x + 5, y: button.frame.midY - newLabel.bounds.height / 2 )
      frontView.addSubview(newLabel)
      
      UIView.animate(withDuration: 0.3, animations: {
        newLabel.alpha = 1
        newLabel.frame.origin = CGPoint(x: self.button.frame.origin.x, y: self.button.frame.midY - newLabel.bounds.height / 2 )
      })
      
      let checkMark = UIImageView(image: UIImage(named: "checkmark"))
      checkMark.frame = CGRect(x: newLabel.frame.maxX + 5, y: newLabel.frame.origin.y + 3, width: 12, height: 12)
      frontView.addSubview(checkMark)
      
      button.animateAfterTapped()
      UIView.animate(withDuration: 0.2, animations: {
        self.channelLabel.textColor = UIColor.white
      })
      
      frontViewFilled = true
    }
    
  }
  
  func present() {
    UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
      self.backgroundView.frame = CGRect(x: Padding, y: 0, width: self.bounds.size.width - Padding * 2, height: self.bounds.size.height)
    }, completion: nil)
    UIView.animate(withDuration: 0.7, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveLinear, animations: {
      self.frontView.frame = CGRect(x: 0, y: self.bounds.size.height * 2/3, width: self.bounds.width, height: self.bounds.size.height * 1/3)
    }, completion: nil)
  }
  
  
}


class videoCell: UIView {
  
  fileprivate var imageView: UIImageView = UIImageView()
  fileprivate var titleLabel: UILabel = UILabel()
  
  init(width: CGFloat, height: CGFloat, image: UIImage, title: String) {
    imageView.frame = CGRect(x: 0, y: 0, width: width, height: height * 4/5)
    imageView.image = image
    
    titleLabel.frame = CGRect(x: 0, y: height * 4/5, width: width, height: height * 1/5)
    titleLabel.text = title
    titleLabel.font = UIFont.systemFont(ofSize: 9)
    titleLabel.textColor = GrayColor
    
    super.init(frame: CGRect.zero)
    
    self.addSubview(imageView)
    self.addSubview(titleLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  
}
