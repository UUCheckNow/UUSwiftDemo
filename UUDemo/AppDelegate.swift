//
//  AppDelegate.swift
//  UUDemo
//
//  Created by lhn on 16/10/31.
//  Copyright © 2016年 UUU. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,UIScrollViewDelegate{

    var window: UIWindow?
    // UU_Mark:引导页相关
    let numPages  = 3
    var pageControl  = UIPageControl()
    var beginBtn  = UIButton()
    let pageControlWidth = 60
    // UU_Mark:标识符
    let isFirstLoad = "didFirstLoad"
    //MARK: 控件区
    var _scrollerView:UIScrollView!

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
        
        
        
        let defaults = UserDefaults.standard
        
        let hasViewedWalkthrough = defaults.bool(forKey: isFirstLoad)
        
        if hasViewedWalkthrough == false {
            
            self.setScrollerView()
        }
    
        return true
    }
    // UU_Mark:设置引导页滚动界面
    func setScrollerView() {
        _scrollerView = UIScrollView.init()
        _scrollerView.frame = kScreenBounds
        _scrollerView.delegate = self
        
        //为了能让内容横向移动 设置横向宽度为3个页面的宽度之和
        _scrollerView.contentSize = CGSize.init(width:kScreenWidth * CGFloat(numPages) , height: kScreenHeight)
        _scrollerView.isPagingEnabled = true
        _scrollerView.showsHorizontalScrollIndicator  = false
        _scrollerView.showsVerticalScrollIndicator  = false
        //        scrollsToTop是UIScrollView的一个属性，主要用于点击设备的状态栏时，是scrollsToTop == YES的控件滚动返回至顶部。
        
        //        每一个默认的UIScrollView的实例，他的scrollsToTop属性默认为YES，所以要实现某一UIScrollView的实例点击设备状态栏返回顶部，则需要关闭其他的UIScrollView的实例的scrollsToTop属性为NO。很好理解：若多个scrollView响应返回顶部的事件，系统就不知道到底要将那个scrollView返回顶部了，因此也就不做任何操作了。。。
        _scrollerView.scrollsToTop = false
        _scrollerView.bounces = false
        
        for index in 0..<numPages {
            let imageView = UIImageView.init(image: UIImage.init(named: "GuideImage\(index + 1).png"))
            imageView.frame = CGRect.init(x: kScreenWidth * CGFloat(index), y: 0, width: kScreenWidth, height: kScreenHeight)
            _scrollerView.addSubview(imageView)
        }
        
        self.window?.addSubview(_scrollerView)
        
        
        let pageControlx = kScreenWidth - CGFloat(pageControlWidth)
        
        pageControl = UIPageControl.init(frame: .init(x: pageControlx/2, y: kScreenHeight - 50.0, width:CGFloat(pageControlWidth) , height: 20))
        
        pageControl.numberOfPages = numPages
        
        pageControl.currentPage = 0
        
        self.window?.addSubview(pageControl)
        
        
        beginBtn = UIButton.init(type: .custom)
        beginBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        beginBtn.frame = CGRect.init(x: pageControlx/2, y: kScreenHeight - 80, width:CGFloat(pageControlWidth), height: 25)
        beginBtn.setTitle("点击进入", for: .normal)
        beginBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        beginBtn.layer.masksToBounds = true
        beginBtn.layer.cornerRadius = 3.0
        self.window?.addSubview(beginBtn)
        beginBtn.alpha = 0.0
        beginBtn.addTarget(self, action:#selector(touchIn(_:)), for: .touchUpInside)
        self.window?.bringSubview(toFront: pageControl)
        self.window?.bringSubview(toFront: beginBtn)
    }

    //点击进入事件
    func touchIn(_ sender:UIButton){
        print(sender.title(for: .normal))
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: isFirstLoad)
        UIView.animate(withDuration: 1.5, animations: {
            sender.alpha = 0.0
            self._scrollerView.alpha = 0.0
            self.pageControl.alpha = 0.0
            }, completion: { (YES) in
            self.pageControl.removeFromSuperview()
            sender.removeFromSuperview()
            self._scrollerView.removeFromSuperview()
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        pageControl.currentPage = Int(offset.x / kScreenWidth)
        // 因为currentPage是从0开始，所以numOfPages减1
        if pageControl.currentPage == numPages - 1 {
            UIView.animate(withDuration: 0.5) {
                self.beginBtn.alpha = 0.8
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.beginBtn.alpha = 0.0
            }
        }
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

