//
//  AppDelegate.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/8/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let primaryColor = UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0)
    let iconColor = UIColor.whiteColor()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Parse.enableLocalDatastore()
        
        /**
        // Initialize Parse Production
        Parse.setApplicationId("MiZYFPmMpo5lE7mkch6IGYHHd3hYaFz1UOXTMSI0", clientKey: "yzcLFEPJEjua3oIWOjInSq5KRSbIZvsVoEkgFbgm")
        */
        
        // Initialize Parse Development
        Parse.setApplicationId("nDOkjWgJ1Vd7DsubqnaYi16xyQl6TdigrBGk8F4V", clientKey: "VUPexMW9AQUWAeMdynl5TVOOBjGB08q2CjVEL3zu")
        
        // Set default ACL to user only access.
        PFACL.setDefaultACL(PFACL(), withAccessForCurrentUser: true)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        setAppStyle()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setAppStyle() {
        let navBarAppearance = UINavigationBar.appearance()
        
        navBarAppearance.barTintColor = primaryColor
        navBarAppearance.tintColor = iconColor
        
        let toolBarApperance = UIToolbar.appearance()
        
        toolBarApperance.barTintColor = primaryColor
        toolBarApperance.tintColor = iconColor
    }


}

