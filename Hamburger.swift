//
//  Hamburger.swift
//  HamburgerTest
//
//  Created by Sergey Garazha on 4/2/16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class Hamburger: UIView {

    // properties
    var ratio = 5                                   /// ratio of lines height to spaces
    override var tintColor: UIColor! {              /// color of lines
        didSet {
            top.backgroundColor = tintColor
            middle.backgroundColor = tintColor
            bottom.backgroundColor = tintColor
        }
    }
    // MARK: -
    // subviews
    private let top = UIView(frame: CGRectZero)
    private let middle = UIView(frame: CGRectZero)
    private let bottom = UIView(frame: CGRectZero)
    // constants
    private var onceToken: dispatch_once_t = 0
    private let kAnimation = "rotationAnimation"
    let animationDuration = 0.3 as NSTimeInterval
    // support ivars
    private var state = true
    private var animation: CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = M_PI*2 - M_PI/6
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        return animation
    }
    private var linesHeight = 3 as CGFloat {
        didSet {
            top.layer.cornerRadius = linesHeight/2
            middle.layer.cornerRadius = linesHeight/2
            bottom.layer.cornerRadius = linesHeight/2
            
            self.top.frame = CGRectMake(0, 0, self.bounds.width, self.linesHeight)
            self.middle.frame = CGRectMake(0, self.bounds.height/2 - self.linesHeight/2, self.bounds.width, self.linesHeight)
            self.bottom.frame = CGRectMake(0, self.bounds.height - self.linesHeight, self.bounds.width, self.linesHeight)
        }
    }
    
    // MARK: -
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    init() {
        super.init(frame: CGRectZero)
        configure()
    }
    
    func configure() {
        tintColor = UIColor.blueColor()
        
        addSubview(top)
        addSubview(middle)
        addSubview(bottom)
    }
    
    override var frame: CGRect {
        didSet {
            linesHeight = bounds.height/5
        }
    }
    
    func tap() {
        if state {
            UIView.animateWithDuration(animationDuration, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.top.frame = CGRect(x: -self.linesHeight/3, y: self.linesHeight, width: self.bounds.width, height: self.linesHeight)
                self.bottom.frame = CGRect(x: -self.linesHeight/3, y: self.bounds.height/2 + self.linesHeight/2, width: self.bounds.width, height: self.linesHeight)
                }, completion: nil)
            let animation = self.animation
            animation.toValue = M_PI*2 - M_PI/6
            self.top.layer.addAnimation(animation, forKey: kAnimation)
            animation.toValue = -(M_PI*2 - M_PI/6)
            self.bottom.layer.addAnimation(animation, forKey: kAnimation)
        } else {
            UIView.animateWithDuration(animationDuration, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.top.frame = CGRectMake(0, 0, self.bounds.width, self.linesHeight)
                self.bottom.frame = CGRectMake(0, self.bounds.height - self.linesHeight, self.bounds.width, self.linesHeight)
                }, completion: { (_) in })
            let animation = self.animation
            animation.toValue = -(M_PI*2)
            self.top.layer.addAnimation(animation, forKey: kAnimation)
            animation.toValue = M_PI*2
            self.bottom.layer.addAnimation(animation, forKey: kAnimation)
        }
        state = !state
    }
}
