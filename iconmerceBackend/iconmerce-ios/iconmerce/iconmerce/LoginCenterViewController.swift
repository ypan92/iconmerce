//
//  CenterViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 4/2/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

@objc
protocol LoginCenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func toggleRightPanel()
    optional func collapseSidePanels()
}


class LoginCenterViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var user: User?
    
    var itemIds: [Int] = []
    
    var history: Icons?
    
    let userModel: UserLoader = UserLoader()
    
    @IBAction func login(sender: AnyObject) {
        let email = emailField.text
        let password = passwordField.text
        
        let tempUser = User()
        tempUser.email = email
        tempUser.password = password
        userModel.user = tempUser
        
        while userModel.user?.username == nil {
            
        }
        if userModel.user?.username == "iconmerce:bad" {
            user = nil
        }
        else {
            user = userModel.user
            getHistory()
            while history == nil {}
        }
        
        if user != nil && self == self.navigationController!.topViewController {
            performSegueWithIdentifier("testSeg5", sender: nil)
        }
        
    }
    
    @IBAction func autoFill(sender: AnyObject) {
        emailField.text = "ypan01@outlook.com"
        passwordField.text = "pa$$word"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg5" {
            let dest = segue.destinationViewController as! ContainerViewController
            dest.user = user
            dest.icons = icons
            dest.history = history
        }
        print("in seg")
    }
    
    var loadDarkNavBar: Bool = {
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().titleTextAttributes = ["UITextAttributeTextColor": UIColor.whiteColor()]
        //UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().backgroundColor = UIColor.blackColor()
        return true
    }()
    
    var delegate: LoginCenterViewControllerDelegate?
    
    var icons: Icons? {
        didSet {
            if let oldValue = oldValue {
                unregisterObservables(oldValue)
            }
            registerObservables()
        }
    }
    
    var observablesRegistered = false
    
    func registerObservables() {
        if !observablesRegistered {
            icons?.addObserver(self, forKeyPath: "count", options: .New, context: nil)
        }
        observablesRegistered = true
    }
    
    func unregisterObservables(object: Icons?) {
        if observablesRegistered {
            icons?.removeObserver(self, forKeyPath: "count")
        }
        observablesRegistered = false
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "count" {
            //collectionView?.reloadData()
        }
    }
    
    deinit {
        unregisterObservables(icons)
    }
    
    @IBAction func menu(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
    
    @IBAction func cart(sender: AnyObject) {
        delegate?.toggleRightPanel?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func getHistory() {
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
                    if params != "" {
                        params.removeAtIndex(params.endIndex.predecessor())
                    }
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
        
        history = Icons()
        
        for (_, result) in json {
            let icon = Icon()
            icon.price = result["item_price"].doubleValue
            icon.name = result["item_name"].stringValue
            icon.description = result["item_desc"].stringValue
            icon.fileName = result["item_location"].stringValue
            icon.id = result["item_id"].intValue
            
            history?.icons.append(icon)
        }
        
    }
    
}

extension LoginCenterViewController: SidePanelViewControllerDelegate {
    func navItemSelected(title: String) {
        delegate?.collapseSidePanels?()
    }
}
