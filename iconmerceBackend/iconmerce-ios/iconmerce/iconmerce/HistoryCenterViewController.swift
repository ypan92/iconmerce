

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
    
    var count = 0
    
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
    var reviewLoader = ReviewLoader()
    
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
        reviewLoader.itemId = history?.icons[indexPath.row].id!
        //let timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        //performSegueWithIdentifier("reviewDetails", sender: indexPath)
        
        historyList.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func timerAction() {
        count += 1
        if count > 1 && count < 3 {
            performSegueWithIdentifier("reviewDetails", sender: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        count = 0
        let indexPath = historyList.indexPathForSelectedRow
        if indexPath != nil {
            historyList.deselectRowAtIndexPath(indexPath!, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg11" {
            let dest = segue.destinationViewController as! LoginContainerViewController
            dest.icons = icons
            dest.user = user
        }
        else if segue.identifier == "reviewDetails" {
            let dest = segue.destinationViewController as! ReviewViewController
            dest.icons = icons
            dest.user = user
            dest.history = history
            dest.icon = history?.icons[(historyList.indexPathForSelectedRow?.row)!]

            dest.reviewLoader = reviewLoader
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
