//
//  ViewController.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/05.
//

import UIKit

class GitHubListViewController: UIViewController {
    
    @IBOutlet weak var repositoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repositoryTableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
}

// MARK: - UITableViewDataSource
extension GitHubListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repositoryTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = "test"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GitHubListViewController: UITableViewDelegate {
}