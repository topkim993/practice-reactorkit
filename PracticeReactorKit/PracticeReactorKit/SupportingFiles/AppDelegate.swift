//
//  AppDelegate.swift
//  PracticeReactorKit
//
//  Created by 김정상 on 2022/12/07.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window
    window.rootViewController = ViewController()
    window.makeKeyAndVisible()
    self.window = window
    return true
  }
}

