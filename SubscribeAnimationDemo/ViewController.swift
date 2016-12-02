//
//  ViewController.swift
//  SubscribeAnimationDemo
//
//  Created by QL on 16/8/27.
//  Copyright © 2016年 QL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var bounceView: BounceView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let bgImg = createImg(UIColor.blue, bounds: CGRect(x: 0, y: 0, width: 290, height: 290))
    let img = UIImage(named: "avatar")
    bounceView.backgroundImage = img
    bounceView.present()
    //bounceView.backgroundColor = UIColor.blackColor()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}


func createImg(_ color: UIColor, bounds: CGRect) -> UIImage {
  UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
  color.setFill()
  UIRectFill(bounds)
  let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
  UIGraphicsEndImageContext()
  
  return image
}

