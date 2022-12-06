//
//  GitHubAPIClient.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/05.
//

import Foundation
import Alamofire

final class GitHubAPIClient: GitHubAPIClientCollection {
    
    private var request: Alamofire.Request?
    
    // クロージャを使用した場合
    func fetchRepositories(successHandler: @escaping (_ items: [Repository]) -> Void,
                           failureHandler: () -> Void) {
        
        guard let searchRepositoryURL = URL(string: "https://api.github.com/search/repositories?q=swift") else { return }
        
        request = AF.request(searchRepositoryURL, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                
                do {
                    let searchResult  = try JSONDecoder().decode(SearchResult.self, from: data)
                    successHandler(searchResult.items)
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        request?.resume()
    }
    
    // concurrencyを利用した場合
    func fetchRepositories() async -> [Repository] {
        guard let searchRepositoryURL = URL(string: "https://api.github.com/search/repositories?q=swift") else { return [] }
        
        let dataTask = AF.request(searchRepositoryURL, method: .get).serializingDecodable(SearchResult.self)
        
        do {
            let value = try await dataTask.value
            return value.items
        } catch {
            fatalError()
        }
    }
}

