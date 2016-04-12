//
//  IconModel.swift
//  iconmerce
//
//  Created by Yang Pan on 4/10/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import Foundation

class Icon {
    var price: Double?
    var name: String?
    var description: String?
    var fileName: String?
    var numReviews: Int?
    var avgRating: Double?
}

class Icons: NSObject {
    var icons: [Icon] = []
    dynamic var count = 0
}

class IconsLoader {
    var icons: Icons? {
        didSet {
            refreshData()
        }
    }
    
    let baseURL = "http://default-environment.eyqmmrug4y.us-east-1.elasticbeanstalk.com/iconmerce-api/"
    
    func parseJSON(data: NSData) {
        let json = JSON(data: data)
        
        for (_, result) in json {
            let icon = Icon()
            icon.price = result["item_price"].doubleValue
            icon.name = result["item_name"].stringValue
            icon.description = result["item_desc"].stringValue
            icon.fileName = result["item_location"].stringValue
            
            icons?.icons.append(icon)
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            [unowned self] in
            self.icons?.count = (self.icons?.icons.count)!
        }
    }
    
    func refreshData() {
        if let url = NSURL(string: "\(baseURL)products") {
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
