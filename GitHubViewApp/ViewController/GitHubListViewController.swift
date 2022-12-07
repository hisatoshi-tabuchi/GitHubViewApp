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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        repositoryTableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    private func fetchRepositoriesAndReloadData(with searchText: String) {
        guard let searchRepositoryURL = URL(string: "https://api.github.com/search/repositories?q=\(searchText)")
        else { return }
        
        Task {
            repositories = await gitHubAPIClient?.fetchRepositories(with: searchRepositoryURL) ?? []
            repositoryTableView.reloadData()
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
        let cell = repositoryTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = repositories[indexPath.row].fullName
        
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
        
        fetchRepositoriesAndReloadData(with: searchBar.text ?? "")
    }
}
