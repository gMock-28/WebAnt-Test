//
//  MainTabBarController.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 24.10.2021.
//

import UIKit
import SwiftUI

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newVC = NewPhotosViewController() // = NewCollectionViewController.loadFromStoryBoard()
        
        tabBar.tintColor = .gray
        tabBar.tintColor = UIColor(red:0.992, green:0.176, blue:0.333, alpha:1.00)
        
        viewControllers = [
            generateViewControllerWithNavigationBar(rootViewController: newVC,
                                                    imageResourceName: "newspaper",
                                                    title: "New")
//            generateViewController(rootViewController: ViewController(),
//                                   imageResourceName: "flame",
//                                   title: "Popular")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController,
                                        imageResourceName: String,
                                        title: String) -> UIViewController {
        let viewController = rootViewController
        viewController.tabBarItem.image = UIImage(systemName: imageResourceName)
        viewController.tabBarItem.title = title
        
        return viewController
    }
    
    private func generateViewControllerWithNavigationBar(rootViewController: UIViewController,
                                                         imageResourceName: String,
                                                         title: String) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = UIImage(systemName: imageResourceName)
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
}



//let netWorker = NewCollectionNetworkServices()
//
//netWorker.getNewPage(url: "http://gallery.dev.webant.ru/api/photos") { (response) in
//    print(response!)
//}
