//
//  AppRouter.swift
//  RunloopRSS
//
//  Created by Sergiy Kostrykin on 6/19/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit
import SVProgressHUD
import FeedKit

class AppRouter: NSObject {
    
    // MARK: - Properties
    let window: UIWindow?
    var mainController: UITabBarController?
    var detailsScreen: DetailsScreen?
    
    // MARK: - init
    init? (window: UIWindow?) {
        self.window = window
        super.init()
        if window == nil {
            print("AppRouter Error")
            return nil
        }
        customizeHUD()
        setupAppearance()
        showAppropriateView()
    }
    
    private func showAppropriateView() {
        
        let tabBarController = UITabBarController()
        var navigationControllers = [UIViewController]()

        var viewControllers = [UIViewController]()
        
        let details = DetailsScreen()
        let detailsTab = details.instantiateViewController()
        detailsTab.tabBarItem = UITabBarItem(title: "Details", image: UIImage(named: "tab_info"), selectedImage: UIImage(named: "tab_info"))
        viewControllers.append(detailsTab)
        self.detailsScreen = details

        let rssListTab = RSSListScreen(appRouter: self).instantiateViewController()
        rssListTab.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "tab_rss"), selectedImage: UIImage(named: "tab_rss"))
        viewControllers.append(rssListTab)
        
        for controller in viewControllers {
            let navigation = UINavigationController(rootViewController: controller)
            navigation.setNavigationBarHidden(true, animated: false)
            navigationControllers.append(navigation)
        }
        tabBarController.viewControllers = navigationControllers
        animateTransition(to: tabBarController)
        mainController = tabBarController
    }
    
    func customizeHUD() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultMaskType(.black)
    }
    
    class func showHUD() {
        SVProgressHUD.show()
    }
    
    class func hideHUD() {
        SVProgressHUD.dismiss()
    }
    
    func showFeedItemDetail(feedItem: RSSFeedItem) {
        mainController?.selectedIndex = 0
        detailsScreen?.reload(rssItem: feedItem)
    }


    
    private func animateTransition(to controller: UIViewController) {
        guard let window = window else {
            return
        }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = controller
        }, completion: { completed in
        })
    }
    
    
    
    private func setupAppearance() {
        let backButtonImage: UIImage? = {
            let backIcon = UIImage(named: "back")!
            let leftOffset: CGFloat = 8.0
            let size = CGSize(width: backIcon.size.width + leftOffset, height: backIcon.size.height + 15)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            backIcon.draw(at: CGPoint(x: leftOffset, y: 3))
            let res = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return res
        }()
        
        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        UINavigationBar.appearance().tintColor = .white
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: -60, vertical: -60), for: .default)
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().tintColor = UIColor.black
    }
    
    
    
}
