//
//  EditUserProfile.swift
//  iconmerce
//
//  Created by Mac on 5/20/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

@objc
protocol EditUserProfileDelegate {
    optional func closeEditProfileView()
}

class EditUserProfile: UIViewController {

    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    var delegate: EditUserProfileDelegate?
    var user: User?
    var icons: Icons?
    let userModel: UserLoader = UserLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textEmail.textAlignment = NSTextAlignment.Center
        textPassword.textAlignment = NSTextAlignment.Center
    }
    
    @IBAction func btnSubmit(sender: AnyObject) {
        
        print("email: " + textEmail.text!)
        if textEmail.text != "" {
            let tempUser = User()
            tempUser.email = textEmail.text
            tempUser.password = textPassword.text
            tempUser.user_id = user?.user_id
            userModel.putMethod = tempUser
            delegate?.closeEditProfileView?()
        }
        print("Submit button pressed!")
    }
    
    @IBAction func btnBack(sender: AnyObject) {
        print("Back button pressed!")
        delegate?.closeEditProfileView?()
    }
}

