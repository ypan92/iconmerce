//
//  PaymentViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 5/17/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit
import Stripe

class PaymentViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    let paymentTextField = STPPaymentCardTextField()
    
    var icons: Icons?
    var user: User?
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentTextField.frame = CGRectMake(15, 110, CGRectGetWidth(self.view.frame) - 30, 44)
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        submitButton.enabled = false;
    }
    
    func paymentCardTextFieldDidChange(textField: STPPaymentCardTextField) {
        submitButton.enabled = true;
    }
    
    @IBAction func goBack(sender: AnyObject) {
        performSegueWithIdentifier("testSeg9", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg9" {
            let dest = segue.destinationViewController as! ContainerViewController
            dest.icons = icons
            dest.user = user
            dest.showCart = true
        }
    }
}
