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
}

class UserLoader {
    var user: User? {
        didSet {
            refreshData()
        }
    }
    
    let baseURL = "http://default-environment.eyqmmrug4y.us-east-1.elasticbeanstalk.com/iconmerce-api/"
    
    func parseJSON(data: NSData) {
        let json = JSON(data: data)
        
        for (_, result) in json {
            let status = result["status"]
            if status.error == nil {
                let user = User()
                user.username = result["username"].stringValue
                user.email = result["email"].stringValue
                user.password = result["password"].stringValue
                
                self.user = user
            }
            /*else {
                self.user = nil
            }*/
        }
    }
    
    func refreshData() {
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
