//
//  AppDelegate.swift
//  AlbumList
//
//  Created by Bowie Tso on 28/3/2023.
//

import UIKit
import SwiftyUserDefaults

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    class func sharedInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setLanguage()
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


    private func setLanguage() {
        guard Defaults[\.LANGUAGE] != nil else {
            Defaults[\.LANGUAGE] = Locale.current.languageCode == "zh" ? "tc" : "en"
            return
        }
    }
}

func startMainStoryboard(completion: (() -> Void)? = nil) {
    AppDelegate.sharedInstance().window?.switchRootViewController(to: R.storyboard.main().instantiateInitialViewController()!,
                                                                  animated: false,
                                                                  duration: 0,
                                                                  options: [],
                                                                  completion)
}
