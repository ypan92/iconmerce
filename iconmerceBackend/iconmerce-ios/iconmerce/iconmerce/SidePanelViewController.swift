//
//  SidePanelViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 4/2/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

protocol SidePanelViewControllerDelegate {
    func navItemSelected(title: String)
}

class SidePanelViewController: UITableViewController {
    
    @IBOutlet weak var menuHeader: UIImageView!
    var delegate: SidePanelViewControllerDelegate?
    
    let menuTitles: [String] = ["Gallery", "Popular", "Sign Up", "Login"]
    let loggedInTitles: [String] = ["Gallery", "Popular", "Profile", "Past Purchases", "Logout"]
    
    var icons: Icons?
    
    var user: User?
    
    var iconLoader: IconsLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.tableView.separatorColor = UIColor.clearColor()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if user != nil {
            return loggedInTitles.count
        }
        return menuTitles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("navCell", forIndexPath: indexPath) as! NavCell
        if user != nil {
            cell.configureForNav(loggedInTitles[indexPath.row])
        }
        else {
            cell.configureForNav(menuTitles[indexPath.row])
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if user != nil {
            let selectedNavItem = loggedInTitles[indexPath.row]
            delegate?.navItemSelected(selectedNavItem)
            if selectedNavItem == "Gallery" {
                performSegueWithIdentifier("testSeg", sender: nil)
            }
            else if selectedNavItem == "Popular" {
                performSegueWithIdentifier("testSeg", sender: nil)
            }
            else if selectedNavItem == "Profile" {
                performSegueWithIdentifier("testSeg6", sender: nil)
            }
            else if selectedNavItem == "Past Purchases" {
                //performSegueWithIdentifier("testSeg12", sender: nil)
                if history == nil {
                    getHistory()
                }
                else {
                    performSegueWithIdentifier("testSeg12", sender: nil)
                }
            }
            else if selectedNavItem == "Logout" {
                user = nil
                performSegueWithIdentifier("testSeg4", sender: nil)
            }
        }
        else {
            let selectedNavItem = menuTitles[indexPath.row]
            delegate?.navItemSelected(selectedNavItem)
            if selectedNavItem == "Gallery" {
                performSegueWithIdentifier("testSeg", sender: nil)
            }
            else if selectedNavItem == "Popular" {
                performSegueWithIdentifier("testSeg", sender: nil)
            }
            else if selectedNavItem == "Sign Up" {
                performSegueWithIdentifier("testSeg2", sender: nil)
            }
            else if selectedNavItem == "Login" {
                performSegueWithIdentifier("testSeg4", sender: nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg" {
            let dest = segue.destinationViewController as! ContainerViewController
            dest.icons = icons
            dest.user = user
            dest.history = history
        }
        else if segue.identifier == "testSeg2" {
            let dest = segue.destinationViewController as! SignupContainerViewController
            dest.icons = icons
            dest.user = user
        }
        else if segue.identifier == "testSeg4" {
            let dest = segue.destinationViewController as! LoginContainerViewController
            dest.icons = icons
            dest.user = user
        }
        else if segue.identifier == "testSeg6" {
            let dest = segue.destinationViewController as! ProfileContainerViewController
            dest.icons = icons
            dest.user = user
            dest.history = history
        }
        else if segue.identifier == "testSeg12" {
            let dest = segue.destinationViewController as! HistoryContainerViewController
            dest.icons = icons
            dest.user = user
            dest.iconLoader = iconLoader
            dest.history = history
        }
    }
    
    var itemIds: [Int] = []
    var history: Icons?
    
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
        
        performSegueWithIdentifier("testSeg12", sender: nil)
        
        /*dispatch_async(dispatch_get_main_queue()) {
            [unowned self] in
            self.history?.count = (self.history?.icons.count)!
            self.performSegueWithIdentifier("testSeg12", sender: nil)
        }*/
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
    
}

class NavCell: UITableViewCell {
    
    @IBOutlet weak var navTitle: UILabel!
    
    func configureForNav(title: String) {
        navTitle.text = title
        self.backgroundColor = UIColor.blackColor()
        navTitle.textColor = UIColor.whiteColor()
    }
    
}
