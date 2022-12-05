//
//  Repository.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/05.
//

import Foundation

struct Repository: Decodable {
    let fullName: String
    let htmlURL: String
    let description: String? // nilが返却される可能性があるためオプショナルとする(cf. https://docs.github.com/ja/rest/search)
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case htmlURL = "html_url"
        case description
    }
}
