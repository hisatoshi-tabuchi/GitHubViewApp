//
//  FavoriteRepository.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/13.
//

import Foundation
import RealmSwift

class FavoriteRepository: Object {
    @Persisted(primaryKey: true)  var id = 0
    @Persisted var fullName = ""
}
