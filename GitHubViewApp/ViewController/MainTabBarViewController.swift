//
//  MainTabBarViewController.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/07.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirstTab()
        setupSecondTab()
    }
    
    func setupFirstTab() {
        let gitHubListVC = UIStoryboard(name: "GitHubList", bundle: nil)
            .instantiateViewController(withIdentifier: "gitHubList") as! GitHubListViewController
        let gitHubAPIClient = GitHubAPIClient()
        let favoriteRepositoryClient = FavoriteRepositoryClient()
        
        gitHubListVC.inject(gitHubAPIClient: gitHubAPIClient,favoriteRepositoryClient: favoriteRepositoryClient)
        
        gitHubListVC.tabBarItem = UITabBarItem(title: "検索", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        viewControllers = [gitHubListVC]
    }
    
    func setupSecondTab() {
        let favoriteListVC = UIStoryboard(name: "FavoriteList", bundle: nil)
            .instantiateViewController(withIdentifier: "FavoriteList") as! FavoriteListViewController
        let favoriteRepositoryClient = FavoriteRepositoryClient()
        
        favoriteListVC.inject(favoriteRepositoryClient)
        
        favoriteListVC.tabBarItem = UITabBarItem(title: "お気に入り", image: UIImage(systemName: "heart.fill"), tag: 1)
        viewControllers?.append(favoriteListVC)
    }
}
