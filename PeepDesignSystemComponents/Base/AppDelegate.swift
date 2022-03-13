//
//  AppDelegate.swift
//  4PeepDesignSystem
//
//  Created by Rhullian Damião on 13/03/22.
//

import UIKit
import PeepDesignSystem

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
      return UIWindow()
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      guard let window = self.window else { fatalError("NO CONTEXT") }
      let nav = UINavigationController(rootViewController: MainListViewController())
      nav.navigationBar.isTranslucent = false
      window.rootViewController = nav
      window.makeKeyAndVisible()
      
      PeepDesignSystemInitializer.initialize()
        
      return true
    }
}
