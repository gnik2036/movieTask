//
//  AppDelegate.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppCoordinator()
        setupWindow(rootViewController: appCoordinator?.navigationController)
        return true
    }
}

private extension AppDelegate {
    func setupWindow(rootViewController: UIViewController?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator?.navigationController
        window?.makeKeyAndVisible()
        window?.tintColor = UIColor.black
    }
    
    func setupAppCoordinator() {
        appCoordinator = AppCoordinator(navigationController: UINavigationController())
        appCoordinator?.start()
    }
}
