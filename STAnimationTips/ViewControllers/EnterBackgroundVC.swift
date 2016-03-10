//
//  EnterBackgroundVC.swift
//  STAnimationTips
//
//  Created by TangJR on 3/10/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

import UIKit

class EnterBackgroundVC: UIViewController {

    @IBOutlet weak var label: UILabel!
    let RotateAnimationKey = "rotateAnimation"
    var rotateAnimation: CAAnimation?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        setupNotification()
        
        
        
        imageView.animationDuration = 100
//        imageView.animationImages = 
    }
    
    private func setupNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForegroundNotification", name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationDidEnterBackgroundNotification", name: UIApplicationDidEnterBackgroundNotification, object: nil)
    }
    
    func applicationWillEnterForegroundNotification() {
        if let rotateAnimation = rotateAnimation {
            label.layer.addAnimation(rotateAnimation, forKey: RotateAnimationKey)
        }
        rotateAnimation = nil
    }

    func applicationDidEnterBackgroundNotification() {
        rotateAnimation = label.layer.animationForKey(RotateAnimationKey)
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        startAnimation()
    }
}

extension EnterBackgroundVC {
    private func pauseLayer() {
        let pausedTime = label.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        label.layer.speed = 0.0
        label.layer.timeOffset = pausedTime
    }

    private func resumeLayer() {
        let pausedTime = label.layer.timeOffset
        label.layer.speed = 1.0;
        label.layer.timeOffset = 0.0;
        label.layer.beginTime = 0.0;
        let timeSincePause = label.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        label.layer.beginTime = timeSincePause;
    }
}

extension EnterBackgroundVC {
    private func startAnimation() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = 2.0 * M_PI
        rotateAnimation.repeatCount = Float.infinity
        rotateAnimation.duration = 2
        label.layer.addAnimation(rotateAnimation, forKey: RotateAnimationKey)
    }
}