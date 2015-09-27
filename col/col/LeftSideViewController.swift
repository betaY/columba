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
    var manu:[String] = ["Account Setting", "Map", "SignOut"]
    var userData = NSUserDefaults.standardUserDefaults().valueForKey("userdata") as? UserData

    
    override func viewDidLoad() {
        
//        let email = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
        
        
//        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imageView.image = UIImage(named: "shimakaze")
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        self.imageView.layer.masksToBounds = true
        self.imageView.userInteractionEnabled = true
        tap.addTarget(self, action: "tappedImage")
        imageView.addGestureRecognizer(tap)
        
//        println("123123123123123\(userData.getUserEmail())")
//        if ((userData.getUserEmail()) != nil) {
//            userEmail.text = userData.getUserEmail()!
//        }
//        email = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MyCustomCell.self, forCellReuseIdentifier: "myCell")
        self.view.addSubview(tableView)
        
        super.viewDidLoad()
        
    }
    func tappedImage() {
        print("image tapped")
        userEmail.text = NSUserDefaults.standardUserDefaults().valueForKey("userEmail") as? String
        print(NSUserDefaults.standardUserDefaults().valueForKey("userEmail"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.manu.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! MyCustomCell
        
//        println(cell.myLabel.text)
        cell.textLabel?.text = self.manu[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row) {
        case 0:
            break
        case 1:
            self.performSegueWithIdentifier("mapView", sender: self)
            break;
        case 2:
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userEmail")
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userPassword")
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
