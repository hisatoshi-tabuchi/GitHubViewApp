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
    
    func saveFavoriteRepository(_ repo: Repository) {
        let fRepo = FavoriteRepository()
        fRepo.id = repo.id
        fRepo.fullName = repo.fullName
        
        try! realm.write {
            realm.add(fRepo, update: .modified)
        }
    }
    
    func getFavoriteRepositories() -> [FavoriteRepository] {
        let favoriteRepositoriesInRealm = realm.objects(FavoriteRepository.self)
        let favoriteRepositories = Array(favoriteRepositoriesInRealm)
        
        return favoriteRepositories
    }
    
    func deleteFavoriteRepository(_ repo: Repository) {
        let targetRepo = realm.objects(FavoriteRepository.self).where {
            $0.id == repo.id
        }
        
        try! realm.write{
            realm.delete(targetRepo)
          }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
