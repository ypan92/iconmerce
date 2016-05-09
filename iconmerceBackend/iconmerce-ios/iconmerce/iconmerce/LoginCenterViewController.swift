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
    
    let userModel: UserLoader = UserLoader()
    
    @IBAction func login(sender: AnyObject) {
        let email = emailField.text
        let password = passwordField.text
        
        let tempUser = User()
        tempUser.email = email
        tempUser.password = password
        userModel.user = tempUser
        
        user = userModel.user
        
        if user != nil {
            performSegueWithIdentifier("testSeg5", sender: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg5" {
            let dest = segue.destinationViewController as! ContainerViewController
            dest.user = user
            dest.icons = icons
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension LoginCenterViewController: SidePanelViewControllerDelegate {
    func navItemSelected(title: String) {
        delegate?.collapseSidePanels?()
    }
}
