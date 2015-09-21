//
//  UserData.swift
//  Columba
//
//  Created by Beta on 15/8/24.
//  Copyright (c) 2015年 Beta. All rights reserved.
//

import Foundation

class UserData {
    private var userEmail : String?
    private var userPassword : String?
    
    init(userEmail: String?, userPassword: String?) {
        self.userEmail = userEmail
        self.userPassword = userPassword
    }

    func setUserEmail(userEmail:String) {
        self.userEmail = userEmail
    }
    
    func setUserPassword(userPassword: String) {
        self.userPassword = userPassword
    }
    
    func getUserEmail() -> String?{
        if (self.userEmail != nil) {
            return self.userEmail!
        }
        return nil
    }
    func getUserPassword() -> String? {
        if (self.userPassword != nil) {
            return self.userPassword!
        }
        return nil
    }
    
}

var userData = UserData(userEmail: nil, userPassword: nil)
//NSUserDefaults.standardUserDefaults().setValue(userData, forKey: "userdata")
//NSUserDefaults.standardUserDefaults().synchronize()