//
//  FavoriteRepositoryClient.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/13.
//

import Foundation
import RealmSwift

final class FavoriteRepositoryClient: FavoriteRepositoryClientCollection {
    
    let realm = try! Realm()
    
    func saveFavoriteRepositories(with favoriteRepositories: [Repository]) {
        favoriteRepositories.forEach { repo in
            let fRepo = FavoriteRepository()
            fRepo.id = repo.id
            fRepo.fullName = repo.fullName
            
            try! realm.write {
                realm.add(fRepo, update: .modified)
            }
        }
    }
    
    func getFavoriteRepositories() -> [FavoriteRepository] {
        let favoriteRepositoriesInRealm = realm.objects(FavoriteRepository.self)
        let favoriteRepositories = Array(favoriteRepositoriesInRealm)
        
        return favoriteRepositories
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
