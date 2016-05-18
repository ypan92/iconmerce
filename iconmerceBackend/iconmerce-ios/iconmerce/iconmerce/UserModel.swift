//
//  UserModel.swift
//  iconmerce
//
//  Created by Yang Pan on 5/8/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import Foundation

class User {
    var username: String?
    var email: String?
    var password: String?
    var cartItems: [Icon] = []
}

class UserLoader {
    var user: User? {
        didSet {
            refreshData()
        }
    }
    
    /*var postUser: User? {
        didSet {
            postData()
        }
    }*/
    
    let baseURL = "http://default-environment.eyqmmrug4y.us-east-1.elasticbeanstalk.com/iconmerce-api/"
    
    func parseJSON(data: NSData) {
        let json = JSON(data: data)
        
        print("user: \(json["username"].stringValue)")
        print("email: \(json["email"].stringValue)")
        
        let status = json["status"]
        if status.error != nil {
            let user = User()
            user.username = json["username"].stringValue
            user.password = json["password"].stringValue
            user.email = json["email"].stringValue
            self.user = user
        }
        else {
            self.user?.username = "iconmerce:bad"
        }
    }
    
    func refreshData() {
        if user?.email != "" && user?.password != "" && user?.email != nil && user?.password != nil {
            if let url = NSURL(string: "\(baseURL)user/\((user?.email)!)/\((user?.password)!)") {
                let session = NSURLSession.sharedSession()
                let download = session.dataTaskWithURL(url) {
                    [unowned self] (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                    
                    if let data = data {
                        self.parseJSON(data)
                        
                    }
                }
                download.resume()
            }
        }
    }
    
    /*func postData() {
        if let request = NSMutableURLRequest(URL: "\(baseURL)user")
    }*/
}
