//
//  ViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 4/2/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

enum SlideOutState4 {
    case BothCollapsed
    case LeftPanelExpanded
    case RightPanelExpanded
}

class LoginContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: LoginCenterViewController!
    
    var currentState: SlideOutState4 = .BothCollapsed
    var leftViewController: SidePanelViewController?
    
    let centerPanelExpandedOffset: CGFloat = 60
    
    var icons: Icons?
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        centerViewController = UIStoryboard.loginCenterViewController()
        centerViewController.delegate = self
        centerViewController.icons = icons
        
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

extension LoginContainerViewController: LoginCenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(notAlreadyExpanded)
    }
    
    func toggleRightPanel() {
        //unimplemented
    }
    
    func addLeftPanelViewController() {
        if leftViewController == nil {
            leftViewController = UIStoryboard.leftViewController()
            leftViewController?.icons = icons
            leftViewController?.user = user
            addChildSidePanelController(leftViewController!)
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        view.insertSubview(sidePanelController.view, atIndex: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
    
    func addRightPanelViewController() {
        //unimplemented
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
        //unimplemented
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
    
    class func rightViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("RightViewController") as? SidePanelViewController
    }
    
    class func loginCenterViewController() -> LoginCenterViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LoginCenterViewController") as? LoginCenterViewController
    }
    
}

