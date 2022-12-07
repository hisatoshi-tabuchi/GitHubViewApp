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
            .instantiateViewController(withIdentifier: "gitHubListVC") as? GitHubListViewController else { return }
        let gitHubAPIClient = GitHubAPIClient()
      
        gitHubListVC.inject(gitHubAPIClient)
        
        gitHubListVC.tabBarItem = UITabBarItem(title: "検索", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        viewControllers = [gitHubListVC]
    }
    
    func setupSecondTab() {
        // とりあえず同じVCにしてる
        guard let gitHubListVC = UIStoryboard(name: "GitHubList", bundle: nil)
            .instantiateViewController(withIdentifier: "gitHubListVC") as? GitHubListViewController else { return }
        let gitHubAPIClient = GitHubAPIClient()
      
        gitHubListVC.inject(gitHubAPIClient)
        
        gitHubListVC.tabBarItem = UITabBarItem(title: "hello", image: UIImage(systemName: "square.and.arrow.up"), tag: 0)
        viewControllers?.append(gitHubListVC)
    }
}
