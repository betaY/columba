//
//  LeftSideViewController.swift
//  SliderMenu
//
//  Created by Beta on 15/7/28.
//  Copyright (c) 2015年 Beta. All rights reserved.
//

import UIKit

class LeftSideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var manu:[String] = ["Account Setting", "Sign in/Sign up"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MyCustomCell.self, forCellReuseIdentifier: "myCell")
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.manu.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! MyCustomCell
//        cell.myLabel.text = self.manu[indexPath.row]
        println(cell.myLabel?.text)
        cell.textLabel?.text = self.manu[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You select \(self.manu[indexPath.row])")
        if(self.manu[indexPath.row] == "Sign in/Sign up") {
            println(2333)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
