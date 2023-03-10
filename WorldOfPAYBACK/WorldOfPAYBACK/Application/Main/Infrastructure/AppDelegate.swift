//
//  AppDelegate.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        ApplicationAssembly.assembleDependencies()
        MainApplicationFlowCoordinator.shared.startFlow()
        window = MainApplicationFlowCoordinator.shared.currentWindow
        
        return true
    }
}

