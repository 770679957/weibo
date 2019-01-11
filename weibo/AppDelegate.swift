//
//  AppDelegate.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/5.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = defaultRootViewController
        window?.makeKeyAndVisible()
        
        
        // 监听通知
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), // 通知名称，通知中心用来识别通知的
            object: nil,                           // 发送通知的对象，如果为nil，监听任何对象
            queue: nil)                           // nil，主线程
        { [weak self] (notification) -> Void in // weak self，
            let vc = notification.object != nil ? WelcomeViewController() : MainViewController()
            
            // 切换控制器
            self?.window?.rootViewController = vc
        }
        
        return true
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    //类在销毁时注销指定的通知
    deinit {
        //注销通知
        NotificationCenter.default.removeObserver(self,//监听者
        name: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification),//监听的通知
        object: nil)//发送通知的对象
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
extension AppDelegate {
    /// 判断是否新版本
    private var isNewVersion: Bool {
        // 1. 当前的版本
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let version = Double(currentVersion)!
         //print("当前版本 \(version)")
        
        // 2. `之前`的版本，把当前版本保存在用户偏好 - 如果 key 不存在，返回 0
        let sandboxVersionKey = "sandboxVersionKey"
        let sandboxVersion = UserDefaults.standard.double(forKey: sandboxVersionKey)
        //print("之前版本 \(sandboxVersion)")
        
        // 3. 保存当前版本
        UserDefaults.standard.set(version, forKey:sandboxVersionKey)
        
        return version > sandboxVersion
    }
    
    //启动的根视图控制器
    
    private var defaultRootViewController:UIViewController {
        
        //判断是否登录
        if UserAccountViewModel.sharedUserAccount.userLogon {
            return isNewVersion ? NewFeatureViewController() : WelcomeViewController()
            
            
        }
        
        return MainViewController()
        
    }
    
    
    
}

