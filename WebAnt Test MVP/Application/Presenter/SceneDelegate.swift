//
//  SceneDelegate.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 24.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let backButtonBackgroundImage = UIImage(systemName: "arrow.backward")
        let navAppearance = UINavigationBarAppearance()
        navAppearance.backgroundColor = .white
        navAppearance.setBackIndicatorImage(backButtonBackgroundImage, transitionMaskImage: backButtonBackgroundImage)
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 47/255.0, green: 23/255.0, blue: 103/255.0, alpha: 1/1.0)]
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 47/255.0, green: 23/255.0, blue: 103/255.0, alpha: 1/1.0)]
        navAppearance.shadowColor = .white

        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance.copy()
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance.copy()
        
        let tabAppearance = UITabBarAppearance()
        tabAppearance.backgroundColor = .white
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        } else {
            // Fallback on earlier versions
        }
        UITabBar.appearance().standardAppearance = tabAppearance.copy()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let viewController = MainTabBarController()
        
        window.rootViewController = viewController
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    
    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

