//
//  SuccessViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 6/5/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    
    var user: User?
    var icons: Icons?
    var history: Icons?
    
    var itemIds: [Int] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func goToHistory(sender: AnyObject) {
        if history == nil {
            getHistory()
        }
        else {
            performSegueWithIdentifier("testSeg15", sender: nil)
        }
    }
    
    func getItemId(name: String) -> Int {
        if name == "Bright Star" {
            return 1
        }
        else if name == "Treasure" {
            return 2
        }
        else if name == "Super Charge" {
            return 3
        }
        else if name == "Exit Button" {
            return 4
        }
        else {
            return 5
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg15" {
            let dest = segue.destinationViewController as! HistoryContainerViewController
            dest.icons = icons
            dest.user = user
            if history == nil {
                getHistory()
            }
            
            for (item) in (user?.cartItems)! {
                item.id = getItemId(item.name!)
                history?.icons.append(item)
            }
            user?.cartItems.removeAll()
            
            dest.history = history
        }
    }
    
    func getHistory() {
        history = Icons()
        let baseURL = "http://default-environment.eyqmmrug4y.us-east-1.elasticbeanstalk.com/iconmerce-api/"
        if let url = NSURL(string: "\(baseURL)purchases/\((user?.user_id)!)") {
            let session = NSURLSession.sharedSession()
            let download = session.dataTaskWithURL(url) {
                [unowned self] (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                
                if let data = data {
                    self.parsePurchaseData(data)
                    var params = "";
                    for (id) in self.itemIds {
                        params += "\(id),"
                    }
                    params.removeAtIndex(params.endIndex.predecessor())
                    if let prodURL = NSURL(string: "\(baseURL)prods/\(params)") {
                        let psession = NSURLSession.sharedSession()
                        let pdownload = psession.dataTaskWithURL(prodURL) {
                            [unowned self] (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                            
                            if let data = data {
                                self.parseHistoryData(data)
                            }
                        }
                        pdownload.resume()
                    }
                }
            }
            download.resume()
        }
    }
    
    func parsePurchaseData(data: NSData) {
        let json = JSON(data: data)
        
        for (_, result) in json {
            let itemId = result["item_id"].intValue
            itemIds.append(itemId)
        }
    }
    
    func parseHistoryData(data: NSData) {
        let json = JSON(data: data)
        
        for (_, result) in json {
            let icon = Icon()
            icon.price = result["item_price"].doubleValue
            icon.name = result["item_name"].stringValue
            icon.description = result["item_desc"].stringValue
            icon.fileName = result["item_location"].stringValue
            
            history?.icons.append(icon)
        }
        
        performSegueWithIdentifier("testSeg15", sender: nil)
        
    }
}
