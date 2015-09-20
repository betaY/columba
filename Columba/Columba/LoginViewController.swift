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
//    var userData: UserData?
    
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
        
        
        let myUrl: NSURL! = NSURL(string: "http://beta.moe/userLogin.php")
        let request: NSMutableURLRequest! = NSMutableURLRequest(URL: myUrl)
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
            
            let _: NSError?
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            let jsonArray = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
//            print("json = \(json) err = \(err)")
            print("array = \(jsonArray)")
            
            
            
            if let parseJSON = json {
                let resultValue = parseJSON["status"] as! String
                print("result: \(resultValue)")
                
                if (resultValue == "Success"){
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                    NSUserDefaults.standardUserDefaults().setValue("\(userEmail)", forKey: "userEmail")
                    NSUserDefaults.standardUserDefaults().setValue("\(userPassword)", forKey: "userPassword")
//                    var userData = UserData(userEmail: "\(userEmail)", userPassword: "\(userPassword)")
//                    self.userData?.setUserEmail("\(userEmail)")
//                    self.userData?.setUserPassword("\(userPassword)")
//                    userData.setUserEmail("\(userEmail)")
//                    userData.setUserPassword("\(userPassword)")
//                    NSUserDefaults.standardUserDefaults().setValue(userData, forKey: "userdata")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
//                    println("==================\(userData.getUserEmail()!) \(userData.getUserPassword()!)")
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    let messageToDisplay:String = parseJSON["message"] as! String
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        let myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert)
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                        
                        myAlert.addAction(okAction)
                        self.presentViewController(myAlert, animated: true, completion: nil)
                        self.userPasswordTextField.text = nil
                    })
                }
            }
        }
        task.resume()        
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
