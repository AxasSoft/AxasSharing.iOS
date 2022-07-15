//
//  AppDelegate.swift
//  House
//
//  Created by Сергей Майбродский on 15.07.2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if (UserDefaults.standard.value(forKey: "isRegistration") == nil) {
            UserDefaults.standard.set(false, forKey: "isRegistration")
            UserDefaults.standard.set(false, forKey: "isOnNotification")
            UserDefaults.standard.set(false, forKey: "hasSubscription")
            UserDefaults.standard.set("Light", forKey: "colorTheme")
            UserDefaults.standard.set(0, forKey: "id")
            UserDefaults.standard.set("", forKey: "phone")
            UserDefaults.standard.set("", forKey: "name")
            UserDefaults.standard.set("", forKey: "avatar")
            UserDefaults.standard.set("", forKey: "google")
            UserDefaults.standard.set("", forKey: "apple")
            UserDefaults.standard.set(0, forKey: "weight")
            UserDefaults.standard.set(0, forKey: "height")
            UserDefaults.standard.set("", forKey: "accessToken")
            UserDefaults.standard.set("", forKey: "refreshToken")
            UserDefaults.standard.set("", forKey: "firebaseToken")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

