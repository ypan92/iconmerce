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
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var descr: UILabel!
    
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
    
    var user: User?
    var history: Icons?
    
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
    
    @IBAction func cart(sender: AnyObject) {
        delegate?.toggleRightPanel?()
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
                cell.title.text = icon.name
                cell.title.textAlignment = .Left
                if let price = icon.price {
                    cell.price.text = "$\(price)"
                }
                else {
                    cell.price.text = "$0.99"
                }
                
                cell.price.textAlignment = .Right
                
                if let descr = icon.description {
                    cell.descr.text = descr
                }
                else {
                    cell.descr.text = ""
                }
                cell.descr.font = cell.descr.font.fontWithSize(13)
            }
            
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        /*let iconSelected = icons?.icons[indexPath.row]
        performSegueWithIdentifier("testSeg3", sender: nil)*/
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            performSegueWithIdentifier("testSeg3", sender: cell)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg3" {
            let dest = segue.destinationViewController as! IconContainerViewController
            dest.icons = icons
            
            let cell = sender as! IconCollectionViewCell
            let indexPath = self.collectionView?.indexPathForCell(cell)
            let targetIcon = icons?.icons[(indexPath?.row)!]
            dest.icon = targetIcon
            
            dest.user = user
            dest.history = history
        }
    }
    
}

extension CenterViewController: SidePanelViewControllerDelegate {
    func navItemSelected(title: String) {
        
        
        
        delegate?.collapseSidePanels?()
    }
}
