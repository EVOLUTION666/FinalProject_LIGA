//
//  MovieApiService.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 01.04.2022.
//

import Foundation

enum MovieApiUrl: String {
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case search = "search/movie"
}

class MovieApiService {
    
    private let apiKey = "fceb511a86fb51d568baefc76f519b49"
    private let baseURL = "https://api.themoviedb.org/3/"
    
    func getPopularMovies(completion: @escaping (Movie?) -> ()) {
        NetworkService.request(urlString: "\(baseURL + MovieApiUrl.popular.rawValue)?api_key=\(apiKey)&language=ru-RU") { result in
            switch result {
            case .failure(let error): print(error)
            case .success(let success): completion(success.decodedModel())
            }
        }
    }
    
    func getTopRatedMovies(completion: @escaping (Movie?) -> ()) {
        NetworkService.request(urlString: "\(baseURL + MovieApiUrl.topRated.rawValue)?api_key=\(apiKey)&language=ru-RU") { result in
            switch result {
            case .failure(let error): print(error)
            case .success(let success): completion(success.decodedModel())
            }
        }
    }
    
    func getSearchResults(searchText: String, completion: @escaping (Movie?) -> ()) {
        
        print("URL----->\(baseURL + MovieApiUrl.search.rawValue)?api_key=\(apiKey)&language=ru-RU&query=\(searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")")
        
        NetworkService.request(urlString: "\(baseURL + MovieApiUrl.search.rawValue)?api_key=\(apiKey)&language=ru-RU&query=\(searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")") { result in
            switch result {
            case .failure(let error): print(error)
            case .success(let success): completion(success.decodedModel())
            }
        }
    }
    
    static let shared = MovieApiService()
    private init () {}
}
