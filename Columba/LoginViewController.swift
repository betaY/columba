//
//  LoginViewController.swift
//  Columba
//
//  Created by Beta on 15/7/23.
//  Copyright © 2015年 Beta. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        
//        if (userEmail.isEmpty || userPassword.isEmpty) { return; }
        
        let myUrl: NSURL! = NSURL(string: "http://beta.moe/userLogin.php")
        let request: NSMutableURLRequest! = NSMutableURLRequest(URL: myUrl)
        request.HTTPMethod = "POST"
        
        let postString = "email=\(userEmail)&password=\(userPassword)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        println("url \(myUrl)")
        println("post string \(postString)")
        println("request \(request.HTTPBody)")
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
//            println("hello ")
            
            if error != nil {
                println("error=\(error)")
                return
            }
            
//            println("response = \(response)")
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("responseString = \(responseString)")
            
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary
            let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSArray
            println("json = \(json) err = \(err)")
            println("array = \(jsonArray)")
            
            
            
            if let parseJSON = json {
                var resultValue = parseJSON["status"] as! String
                println("result: \(resultValue)")
                
                if (resultValue == "Success"){
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    var messageToDisplay:String = parseJSON["message"] as! String
//                    var myAlert = UIAlertController(title: "Alert", message: "error", preferredStyle: UIAlertControllerStyle.Alert)
//                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {action in
//                        self.dismissViewControllerAnimated(true, completion: nil)
//                    }
//
//                    myAlert.addAction(okAction)
//                    self.presentViewController(myAlert, animated: true, completion: nil)
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        var myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert)
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                        
                        myAlert.addAction(okAction)
                        self.presentViewController(myAlert, animated: true, completion: nil)
                    })

                }
                
//                if(!isUserRegistered) {
//                    messageToDisplay = parseJSON["message"] as! String
//                }
                
//                dispatch_async(dispatch_get_main_queue(), {
//                    
//                    var myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert)
//                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {action in
//                        self.dismissViewControllerAnimated(true, completion: nil)
//                    }
//                    
//                    myAlert.addAction(okAction)
//                    self.presentViewController(myAlert, animated: true, completion: nil)
//                })
            }
        }
        task.resume()
        
        
        //check userEmail and Password
//        let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
//        let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("userPassword")
//        if (userEmailStored == userEmail) {
//            if (userPasswordStored == userPassword) {
//                // Login is successful
//                
//                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
//                NSUserDefaults.standardUserDefaults().synchronize()
//                self.dismissViewControllerAnimated(true, completion: nil)
//            }
//        }
        
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
