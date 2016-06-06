

import UIKit

enum SlideOutState6 {
    case BothCollapsed
    case LeftPanelExpanded
    case RightPanelExpanded
}

class HistoryContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: HistoryCenterViewController!
    
    var currentState: SlideOutState6 = .BothCollapsed
    var leftViewController: SidePanelViewController?
    var rightViewController: ShoppingCartViewController?
    
    let centerPanelExpandedOffset: CGFloat = 60
    
    var icons: Icons?
    
    var user: User?
    
    var history: Icons?
    
    var iconLoader: IconsLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        centerViewController = UIStoryboard.historyCenterViewController()
        centerViewController.delegate = self
        centerViewController.icons = icons
        centerViewController.user = user
        centerViewController.iconLoader = iconLoader
        centerViewController.history = history
        
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        //centerNavigationController.navigationBar.backgroundColor = UIColor.blackColor()
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMoveToParentViewController(self)
        
        //let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        //centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension HistoryContainerViewController: HistoryCenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(notAlreadyExpanded)
    }
    
    func toggleRightPanel() {
        let notAlreadyExpanded = (currentState != .RightPanelExpanded)
        if notAlreadyExpanded {
            addRightPanelViewController()
        }
        animateRightPanel(notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        if leftViewController == nil {
            leftViewController = UIStoryboard.leftViewController()
            leftViewController?.icons = icons
            leftViewController?.user = user
            leftViewController?.history = history
            addChildSidePanelController(leftViewController!)
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        view.insertSubview(sidePanelController.view, atIndex: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
    
    func addChildShoppingCartController(sidePanelController: ShoppingCartViewController) {
        view.insertSubview(sidePanelController.view, atIndex: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
    
    func addRightPanelViewController() {
        if rightViewController == nil {
            rightViewController = UIStoryboard.rightViewController()
            rightViewController?.icons = icons
            rightViewController?.user = user
            rightViewController?.history = history
            addChildShoppingCartController(rightViewController!)
        }
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .LeftPanelExpanded
            animateCenterPanelXPosition(CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
        }
        else {
            animateCenterPanelXPosition(0) { finished in
                self.currentState = .BothCollapsed
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil
            }
        }
    }
    
    func animateRightPanel(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .RightPanelExpanded
            animateCenterPanelXPosition(-CGRectGetWidth(centerNavigationController.view.frame) + centerPanelExpandedOffset)
        }
        else {
            animateCenterPanelXPosition(0) { finished in
                self.currentState = .BothCollapsed
                self.rightViewController!.view.removeFromSuperview()
                self.rightViewController = nil
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func leftViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LeftViewController") as? SidePanelViewController
    }
    
    class func rightViewController() -> ShoppingCartViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("RightViewController") as? ShoppingCartViewController
    }
    
    class func historyCenterViewController() -> HistoryCenterViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("HistoryCenterViewController") as? HistoryCenterViewController
    }
    
}

