//
//  PoppingViewTapGestureDelegate.swift
//  me-Metrics
//
//  Created by Sylvain on 03/03/2015.
//  Copyright (c) 2015 S.G. inTech. All rights reserved.
//

import UIKit

class PoppingAnimatedViewHelper: NSObject
{
    enum Durations: Double
    {
        case press = 0.15
        case depress = 0.4
    }
    
    let maxRadius = CGFloat(8.0)
    let minRadius = CGFloat(0.0)
    
    let reduceFactor = CGFloat(0.9)
    let growFactor = CGFloat(1.10)
    
    
    
    @IBAction func pressView(sender: UIView)
    {
        let pressedTransform = CGAffineTransformMakeScale(reduceFactor, reduceFactor)
        
        UIView.animateWithDuration(
            Durations.press.rawValue,
            
            delay: 0.0,
            
            options: UIViewAnimationOptions.CurveEaseOut,
            
            animations: {
                sender.transform = pressedTransform;
            },
            
            completion: { (finished) in
            }
        )
    }

    
    
    @IBAction func depressView(sender: UIView)
    {
        let halfRaiseFactor = 1.0 + (growFactor - 1.0) / 2.0
        
        // Highest point
        let raisedTransform     = CGAffineTransformMakeScale(growFactor, growFactor)
        // Halfway between reference altitude and highest
        let halfRaisedTransform = CGAffineTransformMakeScale(halfRaiseFactor, halfRaiseFactor)
        // Pushed back
        let pushedTransform     = CGAffineTransformMakeScale(reduceFactor, reduceFactor)
        // t the reference altitude
        var finalTransform      = CGAffineTransformIdentity
        
        // Animations for the view shadow 
        // Shadow is made bigger when view is higher
        
        let animateShadowUp = CABasicAnimation(keyPath: "shadowRadius")
        
        animateShadowUp.fromValue = minRadius
        animateShadowUp.toValue   = maxRadius
        animateShadowUp.duration  = Durations.depress.rawValue

        let animateShadowDown = CABasicAnimation(keyPath: "shadowRadius")
        
        animateShadowDown.fromValue = animateShadowUp.toValue
        animateShadowDown.toValue   = animateShadowUp.fromValue
        animateShadowDown.duration  = Durations.depress.rawValue
        
        // Animation for view shadow opacity
        // Shadow is more transparent as view is higher
        
        let animateShadowUpOpacity = CABasicAnimation(keyPath: "shadowOpacity")
        
        animateShadowUpOpacity.fromValue = sender.layer.shadowOpacity
        animateShadowUpOpacity.toValue   = 0.8
        animateShadowUpOpacity.duration  = Durations.depress.rawValue
        
        let animateShadowDownOpacity = CABasicAnimation(keyPath: "shadowOpacity")
        
        animateShadowDownOpacity.fromValue = animateShadowUpOpacity.toValue
        animateShadowDownOpacity.toValue   = animateShadowUpOpacity.fromValue
        animateShadowDownOpacity.duration  = Durations.depress.rawValue
        

        UIView.animateKeyframesWithDuration(
            Durations.depress.rawValue,
            delay: 0.0,
            options: UIViewKeyframeAnimationOptions.CalculationModeCubic,
            
            animations: {
                var tstamp = 0.0;
                let stepDuration = 1.0 / 7.0
                
                // Step 1 - restore depth to zero (zoom = 1)
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = finalTransform
                        //sender.layer.addAnimation(animateShadowDown, forKey: "shadowLower")
                        //sender.layer.addAnimation(animateShadowDownOpacity, forKey: "shadowLowerOpacity")
                    }
                )
                tstamp += stepDuration
                
                // Step 2 - raise view and make shadow visible and grow (zoom to max)
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = raisedTransform
                        sender.layer.shadowRadius  = 10.0
                        sender.layer.shadowOffset  = CGSizeMake(0.0, 10.0)

                        //sender.layer.addAnimation(animateShadowUp, forKey: "shadowGrowing")
                        //sender.layer.addAnimation(animateShadowUpOpacity, forKey: "shadowGrowingOpacity")
                    }
                )
                tstamp += stepDuration
                
                // Step 3 - revert back to zero level
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = finalTransform
                        sender.layer.shadowRadius  = 0.0
                        sender.layer.shadowOffset  = CGSizeMake(0.0, 0.0)
                        //sender.layer.addAnimation(animateShadowDown, forKey: "shadowLower")
                        //sender.layer.addAnimation(animateShadowDownOpacity, forKey: "shadowLowerOpacity")
                    }
                )
                tstamp += stepDuration

                // Step 4 - press again view (zoom < 1)
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = pushedTransform
                        //sender.layer.addAnimation(animateShadowDown, forKey: "shadowLower")
                        //sender.layer.addAnimation(animateShadowDownOpacity, forKey: "shadowLowerOpacity")
                    }
                )
                tstamp += stepDuration

                // Step 5 - restore depth to zero (zoom > 1 and < max)
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = finalTransform
                        //sender.layer.addAnimation(animateShadowDown, forKey: "shadowLower")
                        //sender.layer.addAnimation(animateShadowDownOpacity, forKey: "shadowLowerOpacity")
                    }
                )
                tstamp += stepDuration

                // Step 6 - raise view and make shadow visible and grow
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = halfRaisedTransform
                        sender.layer.shadowRadius  = 5.0
                        sender.layer.shadowOffset  = CGSizeMake(0.0, 5.0)
                        //sender.layer.addAnimation(animateShadowUp, forKey: "shadowGrowing")
                        //sender.layer.addAnimation(animateShadowUpOpacity, forKey: "shadowGrowingOpacity")
                    }
                )
                tstamp += stepDuration

                // Step 7 - revert back to zero level
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = finalTransform
                        sender.layer.shadowRadius  = 0.0
                        sender.layer.shadowOffset  = CGSizeMake(0.0, 0.0)
                        //sender.layer.addAnimation(animateShadowDown, forKey: "shadowLower")
                        //sender.layer.addAnimation(animateShadowDownOpacity, forKey: "shadowLowerOpacity")
                    }
                )
                tstamp += stepDuration
            },
            
            completion: { (finished) in
            }

        )
    }
}


