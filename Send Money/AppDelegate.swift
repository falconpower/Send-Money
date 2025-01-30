//
//  AppDelegate.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow!
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let currentLanguage = LanguageManager.shared.currentLanguage
    Bundle.setLanguage(currentLanguage)
    let loginViewModel = LoginViewModel()
    let rootViewController = LoginViewController(viewModel: loginViewModel)
    let navigationController = UINavigationController(rootViewController: rootViewController)
    
    // Set the window's root view controller
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    return true
  }
  
}

