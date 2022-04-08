//
//  TabBarController.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 25.03.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllersConfiguration()
        tabBarConfiguration()
    }
    
    private func tabBarConfiguration() {
        tabBar.unselectedItemTintColor = .white
        tabBar.backgroundColor = UIColor(red: 21/255, green: 21/255, blue: 23/255, alpha: 1)
        tabBar.tintColor = .red
        tabBar.layer.cornerRadius = 25
        tabBar.isTranslucent = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.shadowColor = UIColor.red.cgColor
        tabBar.layer.shadowOpacity = 0.7
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 8
        tabBar.layer.borderWidth = 1
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let path = UIBezierPath(roundedRect: tabBar.bounds, cornerRadius: tabBar.layer.cornerRadius)
        tabBar.layer.shadowPath = path.cgPath
    }
    
    func viewControllersConfiguration() {
        viewControllers = [
            createNavController(for: MainModuleBuilder.buildMainModule(), title: "Main", image: UIImage(systemName: "film")!),
            createNavController(for: SearchMovieBuilder.buildSearchMovie(), title: "Search", image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: FavoritesModuleBuilder.buildFavoritesModule(), title: "Favorites", image: UIImage(systemName: "star.fill")!),
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UINavigationController {
        let navController = CustomNavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
}

