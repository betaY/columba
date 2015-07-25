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
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // Display alert message with confirmation
        let myAlert = UIAlertController(title: "Congratulate", message: "Registration is sucessful. Thank you!", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
            action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    // Display alert message
    func displayMyAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
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
