//
//  SidePanelViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 4/2/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit
import MGSwipeTableCell

protocol ShoppingCartViewControllerDelegate {
    func navItemSelected(title: String)
}

class IconCell: MGSwipeTableCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
}

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: ShoppingCartViewControllerDelegate?
    
    var icons: Icons?
    var user: User?
    var total = 0.00
    var history: Icons?
    
    @IBOutlet weak var cartList: UITableView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var linkLogin: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var deleteHelpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        //self.tableView.separatorColor = UIColor.clearColor()
        
        //self.cartList.registerClass(IconCell.self, forCellReuseIdentifier: "cartItem")
        cartList.delegate = self
        cartList.dataSource = self
        
        if let usr = user {
            greetingLabel.text = "Welcome to your cart \(usr.username!)"
            greetingLabel.textColor = UIColor.whiteColor()
            linkLogin.enabled = false
            checkoutButton.enabled = true
            
            //var total = 0.00;
            for icon in (user?.cartItems)! {
                total += icon.price!
            }
            totalPriceLabel.text = "$\(total)"
            totalPriceLabel.textColor = UIColor.whiteColor()
            
            linkLogin.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            checkoutButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            
            deleteHelpLabel.textColor = UIColor.whiteColor()
            //deleteHelpLabel.enabled = true
        }
        else {
            greetingLabel.text = "Please log in to access your cart"
            greetingLabel.textColor = UIColor.whiteColor()
            linkLogin.enabled = true
            checkoutButton.enabled = false
            totalPriceLabel.textColor = UIColor.blackColor()
            
            checkoutButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            linkLogin.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            
            deleteHelpLabel.textColor = UIColor.blackColor()
            //deleteHelpLabel.enabled = false;
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg7" {
            let dest = segue.destinationViewController as! LoginContainerViewController
            dest.icons = icons
            dest.user = user
        }
        else if segue.identifier == "testSeg8" {
            let dest = segue.destinationViewController as! PaymentViewController
            dest.icons = icons
            dest.user = user
            dest.total = total
            dest.history = history
        }
        else if segue.identifier == "testSeg10" {
            let dest = segue.destinationViewController as! ContainerViewController
            dest.icons = icons
            dest.user = user
            dest.showCart = true
            dest.history = history
        }
    }
    
    @IBAction func goToLogin(sender: AnyObject) {
        performSegueWithIdentifier("testSeg7", sender: nil)
    }
    
    @IBAction func goToCheckout(sender: AnyObject) {
        performSegueWithIdentifier("testSeg8", sender: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*if let icons = icons {
            return icons.count
        }*/
        if let cart = user?.cartItems {
            return cart.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cartItem", forIndexPath: indexPath) as! IconCell
        //if let icon = icons?.icons[indexPath.row] {
        if let icon = user?.cartItems[indexPath.row] {
            if let file = icon.fileName {
                cell.img.image = UIImage(named: file)
            }
            if let name = icon.name {
                cell.name.text = name
            }
            if let price = icon.price {
                cell.price.text = "$\(price)"
            }
        }
        
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor(), callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            print("delete pressed")
            self.user?.cartItems.removeAtIndex(indexPath.row)
            self.performSegueWithIdentifier("testSeg10", sender: nil)
            return true
        })]
        cell.rightSwipeSettings.transition = MGSwipeTransition.Rotate3D
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
