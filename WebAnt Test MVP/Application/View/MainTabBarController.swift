//
//  MainTabBarController.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 24.10.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        
        let newVC = NewPhotosViewController()
        let popularVC = PopularPhotosViewController()
        
        tabBar.tintColor = .gray
        tabBar.tintColor = UIColor(red:0.992, green:0.176, blue:0.333, alpha:1.00)
        
        viewControllers = [
            generateViewControllerWithNavigationBar(rootViewController: newVC,
                                                    imageResourceName: "doc.text.image",
                                                    title: "New"),
            generateViewControllerWithNavigationBar(rootViewController: popularVC,
                                                    imageResourceName: "flame",
                                                    title: "Popular")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController,
                                        imageResourceName: String,
                                        title: String) -> UIViewController {
        let viewController = rootViewController
        if #available(iOS 13.0, *) {
            viewController.tabBarItem.image = UIImage(systemName: imageResourceName)
        } else {
            viewController.tabBarItem.image = UIImage(named: imageResourceName)
        }
        viewController.tabBarItem.title = title
        
        return viewController
    }
    
    private func generateViewControllerWithNavigationBar(rootViewController: UIViewController,
                                                         imageResourceName: String,
                                                         title: String) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        if #available(iOS 13.0, *) {
            navigationVC.tabBarItem.image = UIImage(systemName: imageResourceName)
        } else {
            navigationVC.tabBarItem.image = UIImage(named: imageResourceName)
        }
        
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
}
