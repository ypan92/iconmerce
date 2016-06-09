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
    var user_id: String?
}

class UserLoader {
    var user: User? {
        didSet {
            refreshData()
        }
    }
    
    var putMethod: User? {
        didSet {
            update()
        }
    }
    
    var postUser: User? {
        didSet {
            postData() { (success, message) in
                if success {
                    print("Success")
                } else {
                    print("There was some error!")
                    print(message)
                }

            }
        }
    }
    
    let baseURL = "http://default-environment.eyqmmrug4y.us-east-1.elasticbeanstalk.com/iconmerce-api/"
    
    func parseJSON(data: NSData) {
        let json = JSON(data: data)
        
        //print("user: \(json["username"].stringValue)")
        //print("email: \(json["email"].stringValue)")
        //print("user_id: \(json["user_id"].stringValue)")
        
        let status = json["status"]
        if status.error != nil {
            let user = User()
            user.username = json["username"].stringValue
            user.password = json["password"].stringValue
            user.email = json["email"].stringValue
            user.user_id = json["user_id"].stringValue
            self.user = user
        }
        else {
            self.user?.username = "iconmerce:bad"
        }
    }
    
    func refreshData() {
        if user?.email != nil && user?.password != nil {
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
    
    func update() {
        if let emailOBJ = putMethod?.email {
            print("Updating to email: " + emailOBJ)
        }
        
        if let passwordOBJ = putMethod?.password {
            print("Updating to password: " + passwordOBJ)
        }
        
        if let user_idOBJ = putMethod?.user_id {
            print("Updating user id: " + user_idOBJ)
        }
        
        var newEmail = ""
        if putMethod?.email != nil {
            newEmail = (putMethod?.email)!
        }
        var newPass = ""
        if putMethod?.password != nil {
            newPass = (putMethod?.password)!
        }
        updateEmail(newEmail, password: newPass) { (success, message) in
            if success {
                print("Success")
            } else {
                print("There was some error!")
                print(message)
            }
        }
    }

    private func dataTask(request: NSMutableURLRequest, method: String, completion: (success: Bool, object: AnyObject?) -> ()) {
        print("Data Task")
        request.HTTPMethod = method
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let data = data {
                let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                if let response = response as? NSHTTPURLResponse where 200...299 ~= response.statusCode {
                    completion(success: true, object: json)
                } else {
                    completion(success: false, object: json)
                }
            }
            }.resume()
    }
    
    private func post(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "POST", completion: completion)
    }
    
    private func put(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        print("PUT method")
        dataTask(request, method: "PUT", completion: completion)
    }
    
    private func get(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "GET", completion: completion)
    }
    
    private func clientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        print("client URL Request")
        var url = ""
        if path == "" {
            url = "\(baseURL)user"
        }
        else {
            url = "\(baseURL)user/"+path
        }
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        if let params = params {
            var paramString = ""
            for (key, value) in params {
                let escapedKey = key.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
                let escapedValue = value.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
                paramString += "\(escapedKey!)=\(escapedValue!)&"
            }
            let paramStringCleaned = String(paramString.characters.dropLast());
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = paramStringCleaned.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        return request
    }
    
    func postData(completion: (success: Bool, message: String?) -> ()) {
        let params = ["username":(postUser?.username)!, "email":(postUser?.email)!, "password":(postUser?.password)!]
        post(clientURLRequest("", params: params)) { (success, object) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if success {
                    completion(success: true, message: nil)
                } else {
                    var message = "there was an error"
                    if let object = object, let passedMessage = object["message"] as? String {
                        message = passedMessage
                    }
                    completion(success: true, message: message)
                }
            })
        }
    }
    
    func updateEmail(email: String, password: String, completion: (success: Bool, message: String?) -> ()) {
        let emailObject = ["email": email]
        let passwordObject = ["password": password]
        let emailAndPassword = ["email":email, "password":password]
        
        if putMethod?.email != "" && putMethod?.password != "" {
            put(clientURLRequest("\((putMethod?.user_id)!)", params: emailAndPassword)) { (success, object) -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if success {
                        completion(success: true, message: nil)
                    } else {
                        var message = "there was an error"
                        if let object = object, let passedMessage = object["message"] as? String {
                            message = passedMessage
                        }
                        completion(success: true, message: message)
                    }
                })
            }
        }
        
        else if putMethod?.email != "" {
            print("Updating Email")
            put(clientURLRequest("\((putMethod?.user_id)!)", params: emailObject)) { (success, object) -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if success {
                        completion(success: true, message: nil)
                    } else {
                        var message = "there was an error"
                        if let object = object, let passedMessage = object["message"] as? String {
                            message = passedMessage
                        }
                        completion(success: true, message: message)
                    }
                })
            }
        }
        
        else if putMethod?.password != "" {
            print("Updating password")
            put(clientURLRequest("\((putMethod?.user_id)!)", params: passwordObject)) { (success, object) -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if success {
                        completion(success: true, message: nil)
                    } else {
                        var message = "there was an error"
                        if let object = object, let passedMessage = object["message"] as? String {
                            message = passedMessage
                        }
                        completion(success: true, message: message)
                    }
                })
            }
        }
    }
    
}
