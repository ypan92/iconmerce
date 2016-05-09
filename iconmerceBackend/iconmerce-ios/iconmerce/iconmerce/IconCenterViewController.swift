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
    
    var loadDarkNavBar: Bool = {
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().titleTextAttributes = ["UITextAttributeTextColor": UIColor.whiteColor()]
        //UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().backgroundColor = UIColor.blackColor()
        return true
    }()
    
    var delegate: IconCenterViewControllerDelegate?
    
    var icon: Icon?
    
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
        
        /*let prc = String(format:"%.2f", (icon?.price)!)
        name.text = icon?.name
        price.text = "$\(prc)"
        des.text = icon?.description*/
        
        let img = UIImage(named: (icon?.fileName)!)
        image.image = img
        name.text = (icon?.name)!
        let cost = String(format:"%.2f", (icon?.price)!)
        price.text = "$\(cost)"
        info.text = (icon?.description)!
        
    }
    
}

extension IconCenterViewController: SidePanelViewControllerDelegate {
    func navItemSelected(title: String) {
        delegate?.collapseSidePanels?()
    }
}
