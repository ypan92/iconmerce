//
//  EmptyPlaceHolderViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 6/7/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

class EmptyPlaceHolderViewController: UIViewController {
    
    var icon: Icon?
    var user: User?
    var history: Icons?
    var icons: Icons?
    var reviewLoader: ReviewLoader?
    
    var count = 0
    
    override func viewDidLoad() {
        reviewLoader = ReviewLoader()
        reviewLoader?.itemId = (icon?.id)!
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func timerAction() {
        count += 1
        if (count > 4) {
            performSegueWithIdentifier("testSeg19", sender: nil)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg19" {
            let dest = segue.destinationViewController as! ReviewViewController
            dest.icon = icon
            dest.user = user
            dest.history = history
            dest.icons = icons
            dest.reviewLoader = reviewLoader
        }
    }
    
}
