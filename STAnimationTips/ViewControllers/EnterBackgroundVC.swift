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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        startAnimation()
    }
}

extension EnterBackgroundVC {
    private func startAnimation() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = 2.0 * M_PI
        rotateAnimation.repeatCount = Float.infinity
        rotateAnimation.duration = 2
        label.layer.addAnimation(rotateAnimation, forKey: "rotateAnimation")
    }
}