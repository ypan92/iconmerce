//
//  SignupViewController.swift
//  iconmerce
//
//  Created by Mac on 5/8/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

@objc
protocol SignupViewControllerDelegate {
    optional func randomPrint()
    optional func closeSignupPanel()
    optional func toggleLoginPanel()
}

class SignupViewController: UIViewController {
    var delegate: SignupViewControllerDelegate?
    
    @IBOutlet var enterUsername: UITextField!
    @IBOutlet var enterPassword: UITextField!
    @IBOutlet var enterConfirmPassword: UITextField!
    
    @IBAction func signup(sender: AnyObject){
        if let username = enterUsername.text {
            print("username: " + username)
        }
        
        if let password = enterPassword.text {
            print("password: " + password )
        }
        
        if let confirm = enterConfirmPassword.text {
            
            print("confirm password: " + confirm)
        }
        
        
    }
    
    @IBAction func cancelToGally(sender: AnyObject) {
        delegate?.closeSignupPanel?()
    }
    
    @IBAction func haveAccountLogin(sender: AnyObject) {
        delegate?.closeSignupPanel?()
        delegate?.toggleLoginPanel?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    
}
