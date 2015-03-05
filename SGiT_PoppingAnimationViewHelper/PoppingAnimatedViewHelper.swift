//
//  PoppingViewTapGestureDelegate.swift
//  me-Metrics
//
//  Created by Sylvain on 03/03/2015.
//  Copyright (c) 2015 S.G. inTech. All rights reserved.
//

import UIKit


/** Helper to animate a view with a pop effect.

    The view will be reduced by reduceFactor percent to simulate the 
    pressed effect. Then it will enlarged by growFactor to simulate the
    raise state.

    View shadow is also animated to give more substance to the object.

 */
public class PoppingAnimatedViewHelper: NSObject
{
    // MARK: Animation properties
    
    /** Duration for the animation of the normal to pressed state. */
    public var pressDuration = 0.2
    
    /** Duration for the animation between pressed to normal state. */
    public var depressDuration = 0.4
    
    /** Reduction percent for display "pressed" state.
    
        Expect to be between 0.0 and 1.0.
     */
    public var reduceFactor = CGFloat(0.9)
    
    /** Zoom percent for display "raised" state.
    
        Expect to be between 0.0 and 1.0.
    */
    public var growFactor = CGFloat(1.10)
    
    let maxRadius = CGFloat(8.0)
    let minRadius = CGFloat(0.0)
    
    // MARK: Animation public control
    
    @IBAction func pressView(sender: UIView)
    {
        let pressedTransform = CGAffineTransformMakeScale(reduceFactor, reduceFactor)
        
        UIView.animateWithDuration(
            pressDuration,
            
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
        
        UIView.animateKeyframesWithDuration(
            depressDuration,
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
                    }
                )
                tstamp += stepDuration
                
                // Step 2 - raise view and make shadow visible and grow (zoom to max)
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = raisedTransform
                    }
                )
                tstamp += stepDuration
                
                // Step 3 - revert back to zero level
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = finalTransform
                    }
                )
                tstamp += stepDuration

                // Step 4 - press again view (zoom < 1)
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = pushedTransform
                    }
                )
                tstamp += stepDuration

                // Step 5 - restore depth to zero (zoom > 1 and < max)
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = finalTransform
                    }
                )
                tstamp += stepDuration

                // Step 6 - raise view and make shadow visible and grow
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = halfRaisedTransform
                    }
                )
                tstamp += stepDuration

                // Step 7 - revert back to zero level
                UIView.addKeyframeWithRelativeStartTime(
                    tstamp,
                    relativeDuration: stepDuration,
                    animations: {
                        sender.transform = finalTransform
                    }
                )
                tstamp += stepDuration
            },
            
            completion: { (finished) in
            }

        )
    }
}


