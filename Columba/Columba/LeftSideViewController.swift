//
//  LeftSideViewController.swift
//  Columba
//
//  Created by Beta on 15/8/22.
//  Copyright (c) 2015年 Beta. All rights reserved.
//

import UIKit

class LeftSideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    

    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let tap = UITapGestureRecognizer()
    var manu:[String] = ["Account Setting", "SignOut"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imageView.image = UIImage(named: "shimakaze")
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        self.imageView.layer.masksToBounds = true
        self.imageView.userInteractionEnabled = true
        tap.addTarget(self, action: "tappedImage")
        imageView.addGestureRecognizer(tap)
        
        let email = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
        self.userEmail.text = email
//        println(email)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MyCustomCell.self, forCellReuseIdentifier: "myCell")
        self.view.addSubview(tableView)
        
    }
    
    func tappedImage() {
        println("image tapped")
        let email = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
        println(email)
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
        
//        println(cell.myLabel.text)
        cell.textLabel?.text = self.manu[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row) {
        case 0:
            break
        case 1:
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.performSegueWithIdentifier("loginView", sender: self)
            
            break
        default:
            break
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
