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
    var history: Icons?
    let userModel: UserLoader = UserLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textEmail.textAlignment = NSTextAlignment.Center
        textPassword.textAlignment = NSTextAlignment.Center
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func btnSubmit(sender: AnyObject) {
        if textEmail.text != "" && textPassword.text != "" && textPassword.text != nil && textEmail.text != nil {
            let tempUser = User()
            tempUser.email = textEmail.text
            tempUser.password = textPassword.text
            tempUser.user_id = user?.user_id
            userModel.putMethod = tempUser
            user?.email = textEmail.text
            user?.password = textPassword.text
            //delegate?.closeEditProfileView?()
            performSegueWithIdentifier("testSeg20", sender: nil)
        }
        else if textEmail.text != "" && textEmail.text != nil {
            let tempUser = User()
            tempUser.email = textEmail.text
            tempUser.user_id = user?.user_id
            userModel.putMethod = tempUser
            user?.email = textEmail.text
            //delegate?.closeEditProfileView?()
            performSegueWithIdentifier("testSeg20", sender: nil)
        }
        else if textPassword.text != "" && textPassword.text != nil {
            let tempUser = User()
            tempUser.password = textPassword.text
            tempUser.user_id = user?.user_id
            userModel.putMethod = tempUser
            user?.password = textPassword.text
            //delegate?.closeEditProfileView?()
            performSegueWithIdentifier("testSeg20", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg20" {
            let dest = segue.destinationViewController as! ProfileContainerViewController
            dest.user = user
            dest.icons = icons
            dest.history = history
            
        }
    }
    
    @IBAction func btnBack(sender: AnyObject) {
        delegate?.closeEditProfileView?()
    }
}

