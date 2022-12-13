//
//  FavoriteRepositoryClientCollection.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/13.
//

import Foundation

protocol FavoriteRepositoryClientCollection {
    func saveFavoriteRepository(_ repo: Repository)
    func getFavoriteRepositories() -> [FavoriteRepository]
    func deleteFavoriteRepository(_ repo: Repository)
    func deleteAll()
}
