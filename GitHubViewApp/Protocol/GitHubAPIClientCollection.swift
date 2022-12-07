//
//  GitHubAPIClientCollection.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/05.
//

import Foundation

protocol GitHubAPIClientCollection {
    func fetchRepositories(successHandler: @escaping (_ items: [Repository]) -> Void,
                           failureHandler: () -> Void)
    
    func fetchRepositories(with searchRepositoryURL: URL) async -> [Repository]
}
