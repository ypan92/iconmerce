//
//  CenterViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 4/2/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

@objc
protocol CenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func toggleRightPanel()
    optional func collapseSidePanels()
}

class IconCollectionViewCell: UICollectionViewCell {
    var icon: Icon?
    
    @IBOutlet weak var image: UIImageView!
}

class CenterViewController: UICollectionViewController {
    
    var loadDarkNavBar: Bool = {
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().titleTextAttributes = ["UITextAttributeTextColor": UIColor.whiteColor()]
        //UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().backgroundColor = UIColor.blackColor()
        return true
    }()
    
    var delegate: CenterViewControllerDelegate?
    
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
            collectionView?.reloadData()
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
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = icons?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("IconCell", forIndexPath: indexPath) as! IconCollectionViewCell
        
        if let icon = icons?.icons[indexPath.row] {
            cell.icon = icon
            
            if let imgName = icon.fileName {
                let image = UIImage(named: imgName)
                cell.image.image = image
            }
            
        }
        
        return cell
    }
    
}

extension CenterViewController: SidePanelViewControllerDelegate {
    func navItemSelected(title: String) {
        
    }
}
