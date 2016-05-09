//
//  SidePanelViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 4/2/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

protocol ShoppingCartViewControllerDelegate {
    func navItemSelected(title: String)
}

class ShoppingCartViewController: UIViewController {
    
    var delegate: ShoppingCartViewControllerDelegate?
    
    var icons: Icons?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        //self.tableView.separatorColor = UIColor.clearColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
}
