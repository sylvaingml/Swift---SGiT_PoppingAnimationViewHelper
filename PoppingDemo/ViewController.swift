//
//  ViewController.swift
//  PoppingDemo
//
//  Created by Sylvain on 04/03/2015.
//  Copyright (c) 2015 S.G. inTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animatedBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animatedBtn.layer.shadowOpacity = 1.0
        animatedBtn.layer.shadowColor   = UIColor.blueColor().CGColor
        animatedBtn.layer.shadowRadius  = 0.0
        animatedBtn.layer.shadowOffset  = CGSizeMake(0.0, 0.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

