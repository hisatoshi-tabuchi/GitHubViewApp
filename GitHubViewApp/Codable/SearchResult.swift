//
//  SearchResult.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/05.
//

import Foundation

struct SearchResult: Decodable {
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
