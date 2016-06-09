//
//  ReviewModel.swift
//  iconmerce
//
//  Created by Yang Pan on 6/6/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import Foundation

class Review {
    var id: Int?
    var userId: Int?
    var itemId: Int?
    var rating: Int?
    var review: String?
}

class Reviews: NSObject {
    var reviews: [Review] = []
    dynamic var count = 0
}

class ReviewLoader {
    var itemId: Int? {
        didSet {
            getReviews()
        }
    }
    
    var newReview: Review? {
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
    
    var reviews: Reviews?
    
    let baseURL = "http://default-environment.eyqmmrug4y.us-east-1.elasticbeanstalk.com/iconmerce-api/"
    
    func parseData(data: NSData) {
        let json = JSON(data: data)
        
        reviews = Reviews()
        for (_, result) in json {
            let review = Review()
            review.id = result["id"].intValue
            review.userId = result["user_id"].intValue
            review.itemId = result["item_id"].intValue
            review.rating = result["rating"].intValue
            review.review = result["review"].stringValue
            
            reviews?.reviews.append(review)
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            [unowned self] in
            self.reviews?.count = (self.reviews?.reviews.count)!
        }
    }
    
    func getReviews() {
        if let url = NSURL(string: "\(baseURL)reviewsratings/\(itemId!)") {
            let session = NSURLSession.sharedSession()
            let download = session.dataTaskWithURL(url) {
                [unowned self] (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                
                if let data = data {
                    self.parseData(data)
                }
            }
            download.resume()
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
    
    private func clientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        var url = ""
        if path == "" {
            url = "\(baseURL)reviewsratings"
        }
        else {
            url = "\(baseURL)reviewsratings/"+path
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
        //let params = ["username":(postUser?.username)!, "email":(postUser?.email)!, "password":(postUser?.password)!]
        let params = ["user_id":String((newReview?.userId)!), "item_id":String((newReview?.itemId)!), "review":(newReview?.review)!, "rating":String((newReview?.rating)!)]
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
}