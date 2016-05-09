//
//  SidePanelViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 4/2/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

protocol SidePanelViewControllerDelegate {
    func navItemSelected(title: String)
}

class SidePanelViewController: UITableViewController {
    
    @IBOutlet weak var menuHeader: UIImageView!
    var delegate: SidePanelViewControllerDelegate?
    
    let menuTitles: [String] = ["Gallery", "Popular", "Sign Up", "Login"]
    let loggedInTitles: [String] = ["Gallery", "Popular", "Profile", "Past Purchases"]
    
    var icons: Icons?
    
    var loggedIn: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.tableView.separatorColor = UIColor.clearColor()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("navCell", forIndexPath: indexPath) as! NavCell
        cell.configureForNav(menuTitles[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedNavItem = menuTitles[indexPath.row]
        delegate?.navItemSelected(selectedNavItem)
        if selectedNavItem == "Gallery" {
            performSegueWithIdentifier("testSeg", sender: nil)
        }
        else if selectedNavItem == "Popular" {
            performSegueWithIdentifier("testSeg", sender: nil)
        }
        else if selectedNavItem == "Sign Up" {
            performSegueWithIdentifier("testSeg2", sender: nil)
        }
        else if selectedNavItem == "Login" {
            performSegueWithIdentifier("testSeg4", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg" {
            let dest = segue.destinationViewController as! ContainerViewController
            dest.icons = icons
        }
        else if segue.identifier == "testSeg2" {
            let dest = segue.destinationViewController as! SignupContainerViewController
            dest.icons = icons
        }
        else if segue.identifier == "testSeg4" {
            let dest = segue.destinationViewController as! LoginContainerViewController
            dest.icons = icons
        }
    }
    
}

class NavCell: UITableViewCell {
    
    @IBOutlet weak var navTitle: UILabel!
    
    func configureForNav(title: String) {
        navTitle.text = title
        self.backgroundColor = UIColor.blackColor()
        navTitle.textColor = UIColor.whiteColor()
    }
    
}
