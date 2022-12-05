//
//  ViewController.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/05.
//

import UIKit

final class GitHubListViewController: UIViewController {
    
    @IBOutlet weak private var repositoryTableView: UITableView!
    
    private var repositories: [Repository] = []
    private var gitHubAPIClient: GitHubAPIClientCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAndReloadData()
    }
    
    private func setupUI() {
        repositoryTableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    private func fetchAndReloadData(){
        gitHubAPIClient?.fetchRepositories { [weak self] items in
            self?.repositories = items
            self?.repositoryTableView.reloadData()
        } failureHandler: {
            // エラーハンドリング
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
