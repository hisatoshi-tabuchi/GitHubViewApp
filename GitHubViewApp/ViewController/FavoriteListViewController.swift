//
//  FavoriteListViewController.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/08.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    private var favoriteRepositoryClient: FavoriteRepositoryClientCollection?
    private var favoriteRepositories: [FavoriteRepository] = []

    lazy var gitHubVC = self.tabBarController?.viewControllers?.first as! GitHubListViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoriteRepositories = favoriteRepositoryClient?.getFavoriteRepositories() ?? []
        favoriteTableView.reloadData()
    }
    
    private func setupUI() {
        favoriteTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
    }
    
    func inject(_ favoriteRepositoryClient: FavoriteRepositoryClientCollection) {
        self.favoriteRepositoryClient = favoriteRepositoryClient
    }
}


// MARK: - UITableViewDataSource
extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath)
        cell.textLabel?.text = favoriteRepositories[indexPath.row].fullName
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoriteListViewController: UITableViewDelegate {
}
