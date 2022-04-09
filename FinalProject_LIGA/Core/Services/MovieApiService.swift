//
//  MovieApiService.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 01.04.2022.
//

import Foundation

enum MovieApiUrl: String {
    case premieres = "v2.2/films/premieres"
    case topRated = "v2.2/films/top"
    case search = "v2.1/films/search-by-keyword"
    case getDetail = "v2.2/films"
}

class MovieApiService {
    
    private let apiKey = "6bfdbe92-becf-41b7-9142-9bfdeb2d32fc"
    private let baseURL = "https://kinopoiskapiunofficial.tech/api/"
    private lazy var headers: [String : String] = { return ["X-API-KEY" : self.apiKey] }()
    
    func getPremiersMovies(completion: @escaping (Movie?) -> ()) {
        NetworkService.request(urlString: "\(baseURL + MovieApiUrl.premieres.rawValue)?year=\(Date.currentYear)&month=\(Date.currentMonth.uppercased())", headers: headers) { result in
            switch result {
            case .failure(let error): print(error)
            case .success(let success): completion(success.decodedModel())
            }
        }
    }
    
    func getTopRatedMovies(completion: @escaping (Movie?) -> ()) {
        NetworkService.request(urlString: "\(baseURL + MovieApiUrl.topRated.rawValue)", headers: headers) { result in
            switch result {
            case .failure(let error): print(error)
            case .success(let success): completion(success.decodedModel())
            }
        }
    }
    
    func getDetailsById(movieID: Int, completion: @escaping (MovieDetailsResponse?)->()) {
        NetworkService.request(urlString: "\(baseURL + MovieApiUrl.getDetail.rawValue)/\(movieID)", headers: headers) { result in
            switch result {
            case .failure(let error): print(error)
            case .success(let success): completion(success.decodedModel())
            }
        }
    }
    
    func getSearchResults(searchText: String, completion: @escaping (Movie?) -> ()) {
        NetworkService.request(urlString: "\(baseURL + MovieApiUrl.search.rawValue)?keyword=\(searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")", headers: headers) { result in
            switch result {
            case .failure(let error): print(error)
            case .success(let success): completion(success.decodedModel())
            }
        }
    }
    
    static let shared = MovieApiService()
    private init () {}
}
