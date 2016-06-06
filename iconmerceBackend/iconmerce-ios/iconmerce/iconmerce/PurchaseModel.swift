//
//  TransactionModel.swift
//  iconmerce
//
//  Created by Yang Pan on 6/5/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import Foundation

class Purchase {
    var id: Int?
    var userId: Int?
    var itemId: Int?
}

class PurchaseLoader {
    
    let baseURL = "http://default-environment.eyqmmrug4y.us-east-1.elasticbeanstalk.com/iconmerce-api/"
    
    var purchase: Purchase? {
        didSet {
            postPurchase() { (success, message) in
                if success {
                    print("Success")
                } else {
                    print("There was some error!")
                    print(message)
                }
                
            }
        }
    }
    
    
    func postPurchase(completion: (success: Bool, message: String?) -> ()) {
        let params = ["user_id":(purchase?.userId)!, "item_id":(purchase?.itemId)!]
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
    
    private func dataTask(request: NSMutableURLRequest, method: String, completion: (success: Bool, object: AnyObject?) -> ()) {
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
        dataTask(request, method: "PUT", completion: completion)
    }
    
    private func get(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "GET", completion: completion)
    }
    
    private func clientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        var url = ""
        if path == "" {
            url = "\(baseURL)purchases"
        }
        else {
            url = "\(baseURL)purchases/"+path
        }
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        if let params = params {
            var paramString = ""
            for (key, value) in params {
                let escapedKey = key.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
                let val = String(value)
                let escapedValue = val.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
                paramString += "\(escapedKey!)=\(escapedValue!)&"
            }
            let paramStringCleaned = String(paramString.characters.dropLast());
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = paramStringCleaned.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        return request
    }
    
}
