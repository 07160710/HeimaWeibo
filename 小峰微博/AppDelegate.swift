//
//  AppDelegate.swift
//  小峰微博
//
//  Created by Student on 17/9/7.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //window?.rootViewController=MainViewController()
        //window?.rootViewController=NewFeatureViewController()
        //window?.rootViewController=WelcomeViewController()
        window?.rootViewController=defaultRootViewController
        
        window?.backgroundColor=UIColor.white
        
        
        // 监听通知
        NotificationCenter.default.addObserver(
            forName:NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), // 通知名称，通知中心用来识别通知的
            object: nil,                      // 发送通知的对象，如果为nil，监听任何对象
            queue: nil)                       // nil，主线程.队列:表示决定block在哪个线程中去执行，nil表示在发布通知的线程中执行
        { [weak self] (notification) -> Void in // weak self，闭包直接或间接被self调用
            let vc = notification.object != nil ? WelcomeViewController() : MainViewController()
            
            // 切换控制器
            self?.window?.rootViewController = vc
        }
        return true
    }
    
    deinit {
        // 注销通知 - 注销指定的通知
        NotificationCenter.default.removeObserver(self,   // 监听者
            name: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification),           // 监听的通知
            object: nil)                                            // 发送通知的对象
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
extension AppDelegate
{
    public var isNewVersion:Bool
    {//当前的版本－－  info.plist
        let currentVersion=Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let version=Double(currentVersion)!
        print("当前版本\(version)")
        //"之前"的版本，把当前版本保存在用户偏好－－如果key不存在则返回0
        let sandboxVerdionKey="sandboxVersionKey"
        let sandboxVersion=UserDefaults.standard.double(forKey: sandboxVerdionKey)
        print("之前版本\(sandboxVersion)")
        //保存当前版本
        UserDefaults.standard.set(version,forKey: sandboxVerdionKey)
        return version>sandboxVersion
        
        
    }
    public var defaultRootViewController:UIViewController
    {
        if UserAccountViewModel.sharedUserAccount.userLogin{
            
            return isNewVersion ? NewFeatureViewController() : WelcomeViewController()
        }
        return MainViewController()
    }
}


