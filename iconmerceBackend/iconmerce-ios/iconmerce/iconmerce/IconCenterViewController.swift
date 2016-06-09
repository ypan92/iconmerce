//
//  CenterViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 4/2/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

@objc
protocol IconCenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func toggleRightPanel()
    optional func collapseSidePanels()
}


class IconCenterViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    
    var loadDarkNavBar: Bool = {
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().titleTextAttributes = ["UITextAttributeTextColor": UIColor.whiteColor()]
        //UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().backgroundColor = UIColor.blackColor()
        return true
    }()
    
    var delegate: IconCenterViewControllerDelegate?
    
    var icon: Icon?
    
    var user: User?
    var history: Icons?
    var reviewLoader: ReviewLoader?
    
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
    
    @IBAction func addToCart(sender: AnyObject) {
        if let usr = user {
            usr.cartItems.append(icon!)
        }
    }
    
    @IBAction func back(sender: AnyObject) {
        performSegueWithIdentifier("testSeg13", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg13" {
            let dest = segue.destinationViewController as! ContainerViewController
            dest.icons = icons
            dest.user = user
            //TODO: send history to dest for preserving cached history
            dest.history = history
        }
        else if segue.identifier == "testSeg16" {
            let dest = segue.destinationViewController as! ReviewViewController
            dest.icon = icon
            dest.icons = icons
            dest.user = user
            dest.history = history
            dest.reviewLoader = reviewLoader
        }
    }
    
    func hasBeenPurchase() -> Bool {
        for (icn) in (history?.icons)! {
            let id = getItemId(icn.name!)
            if id == icon?.id {
                return true
            }
        }
        return false
    }
    
    func getItemId(name: String) -> Int {
        if name == "Bright Star" {
            return 1
        }
        else if name == "Treasure" {
            return 2
        }
        else if name == "Super Charge" {
            return 3
        }
        else if name == "Exit Button" {
            return 4
        }
        else {
            return 5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: (icon?.fileName)!)
        image.image = img
        name.text = (icon?.name)!
        let cost = String(format:"%.2f", (icon?.price)!)
        price.text = "$\(cost)"
        info.text = (icon?.description)!
        
        if user != nil {
            if history != nil && hasBeenPurchase() == true {
                reviewButton.hidden = false
                addButton.hidden = true
            }
            else {
                reviewButton.hidden = true
                addButton.hidden = false
            }
        }
        else {
            addButton.hidden = true
            reviewButton.hidden = true
        }
        
    }
    
    
    
}

extension IconCenterViewController: SidePanelViewControllerDelegate {
    func navItemSelected(title: String) {
        delegate?.collapseSidePanels?()
    }
}
