//
//  ViewController.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/05.
//

import UIKit

final class GitHubListViewController: UIViewController {
    
    @IBOutlet weak private var repositoryTableView: UITableView!
    @IBOutlet weak private var repositorySearchBar: UISearchBar!
    
    private var repositories: [Repository] = []
    private var gitHubAPIClient: GitHubAPIClientCollection?
    
    var favoriteRepositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        repositoryTableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryTableViewCell")
    }
    
    private func fetchRepositoriesAndReloadData(with searchText: String) {
        guard let searchRepositoryURL = URL(string: "https://api.github.com/search/repositories?q=\(searchText)")
        else { return }
        
        Task {
            repositories = await gitHubAPIClient?.fetchRepositories(with: searchRepositoryURL) ?? []
            await updateStatusIfLikedRepository()
            repositoryTableView.reloadData()
        }
    }
    
    private func updateStatusIfLikedRepository() async {
        for i in 0 ..< repositories.count {
            if favoriteRepositories.contains(where: {$0 == repositories[i]}) {
                repositories[i].isLiked.toggle()
            }
        }
    }
    
    func inject(_ gitHubAPIClient: GitHubAPIClientCollection) {
        self.gitHubAPIClient = gitHubAPIClient
    }
}

// MARK: - UITableViewDataSource
extension GitHubListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repositoryTableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as! RepositoryTableViewCell
        let repository = repositories[indexPath.row]
        
        cell.setup(name: repository.fullName, isLiked: repository.isLiked) { [unowned self] in
            
            self.repositories[indexPath.row].isLiked.toggle()
            
            // TODO: 綺麗にしたい
            // favoriteRepositoryの更新をしている
            if self.repositories[indexPath.row].isLiked {
                self.favoriteRepositories.append(self.repositories[indexPath.row])
            } else {
                self.favoriteRepositories.removeAll(where: { $0.id == self.repositories[indexPath.row].id})
            }
            
            self.repositoryTableView.reloadRows(at: [indexPath], with: .none)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GitHubListViewController: UITableViewDelegate {
}

// MARK: - UISearchBarDelegate
extension GitHubListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを閉じる
        view.endEditing(true)
        // 検索結果を表示する
        fetchRepositoriesAndReloadData(with: searchBar.text ?? "")
    }
}
