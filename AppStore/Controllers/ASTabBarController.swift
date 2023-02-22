//
//  TabBarController.swift
//  AppStore
//
//  Created by Kirill Karpovich on 20.02.23.
//

import UIKit

class ASTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        viewControllers = [
            createNavController(viewController: ASAppsPageVC(), title: "Apps", imageName: "apps"),
            createNavController(viewController: ASSearchVC(), title: "Search", imageName: "search"),
            createNavController(viewController: ASTodayVC(), title: "Today", imageName: "today_icon")
        ]
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String) ->  UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        
        return navController
    }
}
