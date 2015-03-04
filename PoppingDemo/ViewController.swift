//
//  ViewController.swift
//  PoppingDemo
//
//  Created by Sylvain on 04/03/2015.
//  Copyright (c) 2015 S.G. inTech. All rights reserved.
//

import UIKit

import SGiT_PoppingAnimationViewHelper

class ViewController: UIViewController {

    @IBOutlet weak var animatedBtn: UIButton!
    
    @IBOutlet var animationHelper: PoppingAnimatedViewHelper!
    
    @IBOutlet weak var speedBtn: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animatedBtn.layer.shadowColor   = UIColor.blackColor().CGColor
        animatedBtn.layer.shadowOffset  = CGSizeMake(0.0, 0.0)
        animatedBtn.layer.shadowOpacity = 1.0
        animatedBtn.layer.shadowRadius  = 0.0
        
        //
        
        animationHelper.depressDuration = speeds[0]
        animationHelper.pressDuration   = speeds[0]
        speedBtn.selectedSegmentIndex   = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let speeds = [ 0.4, 2.0, 10.0 ]
    
    @IBAction func speedChanged(sender: UISegmentedControl)
    {
        let active = speedBtn.selectedSegmentIndex
        
        animationHelper.depressDuration = speeds[active]
        animationHelper.pressDuration   = speeds[active]
    }
}

