//
//  Repository.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/05.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let fullName: String
    let htmlURL: String
    let description: String? // nilが返却される可能性があるためオプショナルとする(cf. https://docs.github.com/ja/rest/search)
    var isLiked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case htmlURL = "html_url"
        case description
    }
    
    // idでイコール判定する
    static func == (lhs: Repository, rhs: Repository) -> Bool{
        return lhs.id == rhs.id
    }
}
