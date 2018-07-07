//
//  AppDelegate.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 4/29/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit
import Auth0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    //-- Auth0 --//
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return Auth0.resumeAuth(url, options: options)
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
        // If there are no images in the database, display other view controller //
        /*
         // Empty state //
         if self.mockImageCells.count == 0 {
         let emptyLabel = UILabel(frame: CGRect(x: 0, y: (UIScreen.main.bounds.height / 2), width: UIScreen.main.bounds.width, height: 25))
         emptyLabel.text = "No one has posted any images :("
         
         // Set id to remove empty label //
         emptyLabel.tag = 404
         
         self.view.addSubview(emptyLabel)
         } else {
         // Lets check for our empty state label //
         if let emptyView = self.view.viewWithTag(404) {
         emptyView.removeFromSuperview()
         }
         }
        */
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

