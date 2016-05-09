//
//  LoginViewController.swift
//  iconmerce
//
//  Created by Mac on 5/7/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

@objc
protocol LoginViewControllerDelegate {
    optional func randomPrint()
    optional func toggleLoginPanel()
    optional func closeLoginPanel()
    optional func toggleSignupPanel()
}



class LoginViewController: UIViewController {
    var delegate: LoginViewControllerDelegate?
    
    @IBOutlet var textUsername: UITextField!
    @IBOutlet var textPassword: UITextField!
    
    
    @IBAction func cancelLogin(sender: AnyObject){
        delegate?.closeLoginPanel?()
    }
    
    @IBAction func signinValidation (sender: AnyObject) {
        if let username = textUsername.text {
            print("Username: " + username)
        }
        
        if let password = textPassword.text {
            print("Password: " + password)
        }
    }
    
    @IBAction func dontHaveAccount(sender: AnyObject) {
        print("go to signup\n")
        delegate?.closeLoginPanel?()
        delegate?.toggleSignupPanel?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}