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
        guard let gitHubListVC = UIStoryboard(name: "GitHubList", bundle: nil)
            .instantiateViewController(withIdentifier: "gitHubList") as? GitHubListViewController else { return }
        let gitHubAPIClient = GitHubAPIClient()
      
        gitHubListVC.inject(gitHubAPIClient)
        
        gitHubListVC.tabBarItem = UITabBarItem(title: "検索", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        viewControllers = [gitHubListVC]
    }
    
    func setupSecondTab() {
        guard let favoriteListVC = UIStoryboard(name: "FavoriteList", bundle: nil)
            .instantiateViewController(withIdentifier: "FavoriteList") as? FavoriteListViewController else { return }

        favoriteListVC.tabBarItem = UITabBarItem(title: "お気に入り", image: UIImage(systemName: "heart.fill"), tag: 1)
        viewControllers?.append(favoriteListVC)
    }
}
