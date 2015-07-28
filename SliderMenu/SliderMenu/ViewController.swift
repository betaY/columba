//
//  ViewController.swift
//  SliderMenu
//
//  Created by Beta on 15/7/28.
//  Copyright (c) 2015年 Beta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func LeftSideButtonTapped(sender: AnyObject) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    @IBAction func RightSideButtonTapped(sender: AnyObject) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
        
    }
}

