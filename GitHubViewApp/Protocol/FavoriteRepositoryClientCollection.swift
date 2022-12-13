//
//  FavoriteRepositoryClientCollection.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/13.
//

import Foundation

protocol FavoriteRepositoryClientCollection {
    func saveFavoriteRepositories(with favoriteRepositories: [Repository])
    func getFavoriteRepositories() -> [FavoriteRepository]
    func deleteAll()
}
