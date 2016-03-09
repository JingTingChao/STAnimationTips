//
//  GroupAnimationVC.swift
//  STAnimationTips
//
//  Created by TangJR on 3/8/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

import UIKit

class GroupAnimationVC: UIViewController {
    
    var isAnimation: Bool = false
    let scaleAnimationDuration: NSTimeInterval = 1.0
    let rotateAnimationDuration: NSTimeInterval = 3.0
    let blackView: UIView = UIView()
    let orangeView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        blackView.frame = CGRect(x: 20, y: 200, width: 100, height: 100)
        blackView.backgroundColor = UIColor.blackColor()
        view.addSubview(blackView)
        
        orangeView.frame = CGRect(x: CGRectGetWidth(UIScreen.mainScreen().bounds) - 120, y: 200, width: 100, height: 100)
        orangeView.backgroundColor = UIColor.orangeColor()
        view.addSubview(orangeView)
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        startAnimation()
    }
}

extension GroupAnimationVC {
    private func startAnimation() {
        if isAnimation {
            stopAnimation()
            return
        }
        isAnimation = true
        blackViewAnimation()
        orangeViewAnimation()
    }
    
    private func stopAnimation() {
        isAnimation = false
        blackView.layer.removeAllAnimations()
        orangeView.layer.removeAllAnimations()
    }
    
    private func blackViewAnimation() {
        let scaleGroupAnimationDuration = scaleAnimationDuration + rotateAnimationDuration / 2.0
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 0.5
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.removedOnCompletion = false
        scaleAnimation.duration = scaleAnimationDuration
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = scaleGroupAnimationDuration
        groupAnimation.repeatCount = Float.infinity
        groupAnimation.autoreverses = true
        groupAnimation.animations = [scaleAnimation]
        blackView.layer.addAnimation(groupAnimation, forKey: "scaleAnimation")
    }
    
    private func orangeViewAnimation() {
        let rotateGroupAnimationDuration = rotateAnimationDuration + scaleAnimationDuration * 2
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = -M_PI * 2
        rotateAnimation.duration = rotateAnimationDuration

        let groupAnimation = CAAnimationGroup()
        groupAnimation.beginTime = CACurrentMediaTime() + scaleAnimationDuration
        groupAnimation.duration = rotateGroupAnimationDuration
        groupAnimation.repeatCount = Float.infinity
        groupAnimation.animations = [rotateAnimation]
        orangeView.layer.addAnimation(groupAnimation, forKey: "rotateAnimation")
    }
}