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
    private var favoriteRepositoryClient: FavoriteRepositoryClientCollection?
    
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
            await updateIsLikedStatusIfNeed()
            repositoryTableView.reloadData()
        }
    }
    
    /// お気に入り登録リポジトリであればステータス更新
    private func updateIsLikedStatusIfNeed() async {
        let fRepoInRealm = favoriteRepositoryClient!.getFavoriteRepositories()
        
        for i in 0 ..< repositories.count {
            if fRepoInRealm.contains(where: {$0.id == repositories[i].id}) {
                repositories[i].isLiked.toggle()
            }
        }
    }
    
    func inject(gitHubAPIClient: GitHubAPIClientCollection, favoriteRepositoryClient: FavoriteRepositoryClientCollection) {
        self.gitHubAPIClient = gitHubAPIClient
        self.favoriteRepositoryClient = favoriteRepositoryClient
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
            
            // favoriteRepositoryの更新をしている(よき書き方あれば…）
            if self.repositories[indexPath.row].isLiked {
                self.favoriteRepositoryClient?.saveFavoriteRepository(self.repositories[indexPath.row])
            } else {
                self.favoriteRepositoryClient?.deleteFavoriteRepository(self.repositories[indexPath.row])
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
