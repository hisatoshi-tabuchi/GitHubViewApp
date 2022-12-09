//
//  FavoriteListViewController.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/08.
//

import UIKit

// FIXME: 密ってる、状態も依存してる
class FavoriteListViewController: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!

    lazy var gitHubVC = self.tabBarController?.viewControllers?.first as! GitHubListViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoriteTableView.reloadData()
    }
    
    private func setupUI() {
        favoriteTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
    }
}


// MARK: - UITableViewDataSource
extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitHubVC.favoriteRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath)
        cell.textLabel?.text = gitHubVC.favoriteRepositories[indexPath.row].fullName
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoriteListViewController: UITableViewDelegate {
}
