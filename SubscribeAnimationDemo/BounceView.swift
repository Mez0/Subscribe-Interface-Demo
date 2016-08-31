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
    
    private var imageView = UIView()
    private var scrollView:UIScrollView = UIScrollView()
    
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
        backgroundView = UIView(frame: CGRectMake(Padding, self.bounds.height, self.bounds.size.width - Padding * 2, self.bounds.size.height))
        
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 15
        backgroundView.layer.shadowRadius = 5
        backgroundView.layer.shadowOffset = CGSizeMake(0, 4)
        backgroundView.layer.shadowOpacity = 0.5
        
//        frontView = UIView(frame: CGRectMake(0, self.bounds.size.height * 2/3, self.bounds.width, self.bounds.size.height * 1/3))
        frontView = UIView(frame: CGRectMake(0, self.bounds.height, self.bounds.width, self.bounds.size.height * 1/3))
        frontView.backgroundColor = UIColor.whiteColor()
        frontView.layer.backgroundColor = UIColor.whiteColor().CGColor
        frontView.layer.cornerRadius = 5
        frontView.layer.shadowRadius = 5
        frontView.layer.shadowOffset = CGSizeMake(0, 4)
        frontView.layer.shadowOpacity = 0.5
        
        button.frame = CGRectMake(frontView.bounds.size.width - 10 - 110, 10, 110, 35)
        button.clickClosure = {
            print("clicked!")
            self.animate()
        }
        frontView.addSubview(button)
        
        
        channelLabel.text = "Casey Neistat"
        channelLabel.sizeToFit()
        channelLabel.frame.origin = CGPointMake(10, 10)
        channelLabel.font = UIFont.boldSystemFontOfSize(16)
        channelLabel.textColor = UIColor.blackColor()
        frontView.addSubview(channelLabel)
        
        followerLabel.text = "4,145,783 followers"
        followerLabel.sizeToFit()
        followerLabel.frame.origin = CGPointMake(10, channelLabel.frame.origin.x + channelLabel.frame.size.height - 2)
        followerLabel.font = UIFont.systemFontOfSize(14)
        followerLabel.textColor = GrayColor
        frontView.addSubview(followerLabel)
        
        scrollView.frame = CGRectMake(0, followerLabel.frame.origin.y + followerLabel.frame.size.height + 5, frontView.frame.size.width, frontView.frame.size.height - (followerLabel.frame.origin.y + followerLabel.frame.size.height + 5))
    
        scrollView.contentSize = CGSizeMake(frontView.frame.size.width + 150, 0)
        scrollView.showsHorizontalScrollIndicator = false
        frontView.addSubview(scrollView)
        
        setupCells()
        
        self.addSubview(backgroundView)
        self.insertSubview(frontView, aboveSubview: backgroundView)
    }
    
    
    
    func setupCells() {
        let width = (scrollView.frame.width - 2*CellPadding)/3
        let cell1 = videoCell(width: width, height: scrollView.frame.height, image: UIImage(named: "cell1")!, title: "Hello, world!")
        cell1.frame.origin = CGPointMake(CellPadding, 0)
        scrollView.addSubview(cell1)
        print(CGRectGetMaxX(cell1.frame))
        
        let cell2 = videoCell(width: width, height: scrollView.frame.height, image: UIImage(named: "cell2")!, title: "Hello, world!")
        cell2.frame.origin = CGPointMake(width + CellPadding * 2, 0)
        scrollView.addSubview(cell2)
        
        let cell3 = videoCell(width: width, height: scrollView.frame.height, image: UIImage(named: "cell3")!, title: "Hello, world!")
        cell3.frame.origin = CGPointMake(width * 2 + CellPadding * 3, 0)
        scrollView.addSubview(cell3)
    }
    
    
    func animate() {
        if frontViewFilled == false {
            let startMask = UIBezierPath(roundedRect: button.frame, cornerRadius: 5)
            let finalMask = UIBezierPath(roundedRect: frontView.layer.bounds, cornerRadius: 5)
            let mask = CAShapeLayer()
            mask.fillColor = RedColor.CGColor
            
            frontView.layer.insertSublayer(mask, atIndex: 0)
            mask.path = finalMask.CGPath
            
            let maskAnimation = CABasicAnimation(keyPath: "path")
            maskAnimation.fromValue = startMask.CGPath
            maskAnimation.toValue = finalMask.CGPath
            maskAnimation.duration = 0.3
            maskAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            maskAnimation.delegate = self
            
            mask.addAnimation(maskAnimation, forKey: "path")
            
            let newLabel = UILabel()
            newLabel.text = "Subscribed"
            newLabel.font = UIFont.boldSystemFontOfSize(16)
            newLabel.textColor = UIColor.whiteColor()
            newLabel.alpha = 0
            newLabel.sizeToFit()
            newLabel.frame.origin = CGPointMake(button.frame.origin.x + 5, button.frame.midY - newLabel.bounds.height / 2 )
            frontView.addSubview(newLabel)
            
            UIView.animateWithDuration(0.3, animations: {
                newLabel.alpha = 1
                newLabel.frame.origin = CGPointMake(self.button.frame.origin.x, self.button.frame.midY - newLabel.bounds.height / 2 )
            })
            
            let checkMark = UIImageView(image: UIImage(named: "checkmark"))
            checkMark.frame = CGRectMake(newLabel.frame.maxX + 5, newLabel.frame.origin.y + 3, 12, 12)
            frontView.addSubview(checkMark)
            
            button.animateAfterTapped()
            UIView.animateWithDuration(0.2) {
                self.channelLabel.textColor = UIColor.whiteColor()
            }
            
            frontViewFilled = true
        }
        
    }
    
    func present() {
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .CurveLinear, animations: {
            self.backgroundView.frame = CGRectMake(Padding, 0, self.bounds.size.width - Padding * 2, self.bounds.size.height)
            }, completion: nil)
        UIView.animateWithDuration(0.7, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .CurveLinear, animations: {
            self.frontView.frame = CGRectMake(0, self.bounds.size.height * 2/3, self.bounds.width, self.bounds.size.height * 1/3)
            }, completion: nil)
    }

    
}


class videoCell: UIView {
    
    private var imageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    
    init(width: CGFloat, height: CGFloat, image: UIImage, title: String) {
        imageView.frame = CGRectMake(0, 0, width, height * 4/5)
        imageView.image = image

        titleLabel.frame = CGRectMake(0, height * 4/5, width, height * 1/5)
        titleLabel.text = title
        titleLabel.font = UIFont.systemFontOfSize(9)
        titleLabel.textColor = GrayColor
        
        super.init(frame: CGRectZero)
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    

}
