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
    var history: Icons?
    
    var total: Double?
    
    var purchaseLoader = PurchaseLoader()
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var chargeLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentTextField.frame = CGRectMake(15, 110, CGRectGetWidth(self.view.frame) - 30, 44)
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        submitButton.enabled = false;
        chargeLabel.text = "Total Charge $\(total!)"
        errorLabel.hidden = true
    }
    
    func paymentCardTextFieldDidChange(textField: STPPaymentCardTextField) {
        submitButton.enabled = true;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    @IBAction func submit(sender: AnyObject) {
        let card = paymentTextField.cardParams
        STPAPIClient.sharedClient().createTokenWithCard(card) { (token, error) -> Void in
            if error != nil {
                print("there was an error")
                self.errorLabel.hidden = false
            }
            else if token != nil {
                print("success")
                if let cart = self.user?.cartItems {
                    for (result) in cart {
                        let purch = Purchase()
                        purch.itemId = result.id
                        purch.userId = Int((self.user?.user_id)!)
                        self.purchaseLoader.purchase = purch
                    }
                    self.performSegueWithIdentifier("testSeg14", sender: nil)
                }
            }
        }
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
            dest.history = history
        }
        else if segue.identifier == "testSeg14" {
            let dest = segue.destinationViewController as! SuccessViewController
            dest.icons = icons
            dest.user = user
            dest.history = history
        }
    }
}
