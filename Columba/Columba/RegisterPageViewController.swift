//
//  RegisterPageViewController.swift
//  Columba
//
//  Created by Beta on 15/7/23.
//  Copyright © 2015年 Beta. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text;
        let userRepeatPassword = repeatPasswordTextField.text
        
        // Check for empty fields
        if (userEmail!.isEmpty || userPassword!.isEmpty ||
            userRepeatPassword!.isEmpty) {
                
                // Display an alert message
                displayMyAlertMessage("All fields are required");
                return;
        }
        
        // Chekc if password match
        if (userPassword != userRepeatPassword) {
            displayMyAlertMessage("Password do not match");
        }
        
        // Store data
//        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
//        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword")
//        NSUserDefaults.standardUserDefaults().synchronize()

        // Send user data to server side
        let myUrl:NSURL! = NSURL(string: "http://beta.moe/userRegister.php")
        let request: NSMutableURLRequest! = NSMutableURLRequest(URL: myUrl!)

        request.HTTPMethod = "POST"
        
        let postString = "email=\(userEmail)&password=\(userPassword)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        print("url \(myUrl)")
        print("post string \(postString)")
        print("request \(request.HTTPBody)")
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
//            println("hello ")
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
//            println("response = \(response)")
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
            let err: NSError? = nil;
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            let jsonArray = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            print("json = \(json) err = \(err)")
            print("array = \(jsonArray)")
            
            if let parseJSON = json {
                let resultValue = parseJSON["status"] as? String
                print("result: \(resultValue)")
                
                var isUserRegistered: Bool = false
                if(resultValue=="Success"){
                    isUserRegistered = true
                }
                var messageToDisplay:String = parseJSON["message"] as! String
                if(!isUserRegistered) {
                    messageToDisplay = parseJSON["message"] as! String
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {action in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                })
            }
        }
        task.resume()
        
        
        
        
        // Display alert message with confirmation
//        let myAlert = UIAlertController(title: "Congratulate", message: "Registration is sucessful. Thank you!", preferredStyle: UIAlertControllerStyle.Alert)
//        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
//            action in
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
//        myAlert.addAction(okAction)
//        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    // Display alert message
    func displayMyAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    @IBAction func backLogIn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
