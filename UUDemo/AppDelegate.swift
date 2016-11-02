//
//  AppDelegate.swift
//  UUDemo
//
//  Created by lhn on 16/10/31.
//  Copyright © 2016年 UUU. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.、
        
        self.window = UIWindow(frame:kScreenBounds)
        self.window!.backgroundColor = UIColor.white
        
        let homeVC:UIViewController = HomeVC()
        let HomeNav = UINavigationController(rootViewController:homeVC)
        let homeImg = #imageLiteral(resourceName: "btn_home_normal")
        let homeSelectImg = #imageLiteral(resourceName: "btn_home_selected")
        HomeNav.tabBarItem = UITabBarItem(title: "推荐",image:homeImg, selectedImage:homeSelectImg.withRenderingMode(.alwaysOriginal))
        
        let attentionVC:UIViewController = AttentionVC()
        let attentionNav = UINavigationController(rootViewController:attentionVC)
        let attentionImg = #imageLiteral(resourceName: "btn_live_normal")
        let attentionSelectImg = #imageLiteral(resourceName: "btn_live_selected")
        attentionNav.tabBarItem = UITabBarItem(title:"关注",image:attentionImg,selectedImage:attentionSelectImg.withRenderingMode(.alwaysOriginal))
        
        let mineVC:UIViewController = MineVC()
        let mineNav = UINavigationController(rootViewController:mineVC)
        let mineImg = #imageLiteral(resourceName: "btn_user_normal")
        let mineSelectImg = #imageLiteral(resourceName: "btn_user_selected")
        mineNav.tabBarItem = UITabBarItem(title:"我的",image:mineImg,selectedImage:mineSelectImg.withRenderingMode(.alwaysOriginal))
        
        let tabBarArr = [HomeNav,attentionNav,mineNav]
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = tabBarArr
        self.window?.rootViewController = tabbarController
        self.window!.makeKeyAndVisible()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray], for:.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for:.selected)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

