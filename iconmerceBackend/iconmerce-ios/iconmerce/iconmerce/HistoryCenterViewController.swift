

import UIKit

@objc
protocol HistoryCenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func toggleRightPanel()
    optional func collapseSidePanels()
}

class HistoryCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
}

class HistoryCenterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var loadDarkNavBar: Bool = {
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().titleTextAttributes = ["UITextAttributeTextColor": UIColor.whiteColor()]
        //UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().backgroundColor = UIColor.blackColor()
        return true
    }()
    
    var delegate: HistoryCenterViewControllerDelegate?
    
    var user: User?
    
    @IBOutlet weak var historyList: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var icons: Icons? {
        didSet {
            if let oldValue = oldValue {
                unregisterObservables(oldValue)
            }
            registerObservables()
        }
    }
    
    var history: Icons? = Icons()
    
    var iconLoader: IconsLoader?
    
    let userLoader = UserLoader()
    
    var observablesRegistered = false
    //var observablesRegistered2 = false
    
    func registerObservables() {
        if !observablesRegistered {
            icons?.addObserver(self, forKeyPath: "count", options: .New, context: nil)
        }
        observablesRegistered = true
    }
    
    /*func registerObservables2() {
        if !observablesRegistered2 {
            history?.addObserver(self, forKeyPath: "count", options: .New, context: nil)
        }
        observablesRegistered2 = true
    }*/
    
    func unregisterObservables(object: Icons?) {
        if observablesRegistered {
            icons?.removeObserver(self, forKeyPath: "count")
        }
        observablesRegistered = false
    }
    
    /*func unregisterObservables2(object: Icons?) {
        if observablesRegistered2 {
            history?.removeObserver(self, forKeyPath: "count")
        }
        observablesRegistered2 = false
    }*/
    
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
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = history?.icons.count {
            return count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = historyList.dequeueReusableCellWithIdentifier("historyItem", forIndexPath: indexPath) as! HistoryCell
        
        if let historyItem = history?.icons[indexPath.row] {
            if let file = historyItem.fileName {
                cell.img.image = UIImage(named: file)
            }
            if let name = historyItem.name {
                cell.name.text = name
            }
        }
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //performSegueWithIdentifier("reviewDetails", sender: indexPath)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg11" {
            let dest = segue.destinationViewController as! LoginContainerViewController
            dest.icons = icons
            dest.user = user
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Past Purchases for \((user?.username)!)"
        //iconLoader.history = Icons()
        //history = iconLoader.history
        //history = iconLoader?.history
        //getHistory()
        
        //self.historyList.registerClass(HistoryCell.self, forCellReuseIdentifier: "historyItem")
        historyList.delegate = self
        historyList.dataSource = self
    }
    
    
}

extension HistoryCenterViewController: SidePanelViewControllerDelegate {
    func navItemSelected(title: String) {
        delegate?.collapseSidePanels?()
    }
}
