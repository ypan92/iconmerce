//
//  ProfileContainerViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 5/16/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

enum SlideOutState5 {
    case BothCollapsed
    case LeftPanelExpanded
    case RightPanelExpanded
    case EditPanelExpanded
}

class ProfileContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: ProfileCenterViewController!
    
    var currentState: SlideOutState5 = .BothCollapsed
    var leftViewController: SidePanelViewController?
    var rightViewController: ShoppingCartViewController?
    var profileViewController: EditUserProfile?
    
    let centerPanelExpandedOffset: CGFloat = 60
    
    var icons: Icons?
    
    var user: User?
    
    var history: Icons?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        centerViewController = UIStoryboard.profileCenterViewController()
        centerViewController.delegate = self
        centerViewController.icons = icons
        centerViewController.user = user
        
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

extension ProfileContainerViewController: ProfileCenterViewControllerDelegate, EditUserProfileDelegate {
    
    func closeEditProfileView() {
        animateEditPanelViewController(false)
    }
    
    func toggleEditProfile() {
        let notAlreadyExpanded = (currentState != .EditPanelExpanded)
        
        if notAlreadyExpanded {
          addEditPanelViewController()
        }
        
        animateEditPanelViewController(notAlreadyExpanded)
    }
    
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
    
    func addEditPanelViewController() {
        if profileViewController == nil {
            profileViewController = UIStoryboard.profileViewController()
            profileViewController?.delegate = self
            profileViewController?.user = user
            profileViewController?.icons = icons
            profileViewController?.history = history
            addChildProfilePanelController(profileViewController!)
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        view.insertSubview(sidePanelController.view, atIndex: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
    
    func addChildProfilePanelController(profilePanel: EditUserProfile) {
        view.insertSubview(profilePanel.view, atIndex: 0)
        addChildViewController(profilePanel)
        profilePanel.didMoveToParentViewController(self)
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
    
    func animateEditPanelViewController(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .EditPanelExpanded
            animateEditProfileYPosition(CGRectGetHeight(centerNavigationController.view.frame))
        } else {
            animateEditProfileYPosition(0) { finished in
                self.currentState = .BothCollapsed
                self.profileViewController!.view.removeFromSuperview()
                self.profileViewController = nil
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
    
    func animateEditProfileYPosition(targetPosition:CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.y = targetPosition
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
    
    class func profileViewController() -> EditUserProfile? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("profile") as? EditUserProfile
    }
    
    class func profileCenterViewController() -> ProfileCenterViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("ProfileCenterViewController") as? ProfileCenterViewController
    }
    
}


