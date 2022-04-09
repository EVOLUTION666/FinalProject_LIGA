//
//  PopularMovie.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 30.03.2022.
//

import Foundation

// MARK: - PopularMovie
struct Movie: Decodable {
    let films: [PopularMovieResult]
    
    enum CodingKeys: String, CodingKey {
        case films = "films"
        case items = "items"
    }
}

extension Movie {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let films = try? container.decode([PopularMovieResult].self, forKey: .films) {
            self.films = films
        } else if let items = try? container.decode([PopularMovieResult].self, forKey: .items) {
            self.films = items
        } else {
            self.films = []
        }
    }
}

// MARK: - Result
struct PopularMovieResult: Decodable {
    let id: Int
    let releaseDate, title: String
    let posterPath: String?
    let voteAverage: String

    enum CodingKeys: String, CodingKey {
        case id = "filmId"
        case kinopoiskId = "kinopoiskId"
        case titleRu = "nameRu"
        case titleEn = "nameEn"
        case posterPath = "posterUrlPreview"
        case releaseDate = "year"
        case voteAverage = "rating"
    }
}

extension PopularMovieResult {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.releaseDate = (try? container.decode(String.self, forKey: .releaseDate)) ?? ""
        self.voteAverage = (try? container.decode(String.self, forKey: .voteAverage)) ?? "0.0"
        if let titleRu = try? container.decode(String.self, forKey: .titleRu) {
            self.title = titleRu
        } else if let titleEn = try? container.decode(String.self, forKey: .titleEn) {
            self.title = titleEn
        } else {
            self.title = ""
        }
        
        if let id = try? container.decode(Int.self, forKey: .id) {
            self.id = id
        } else if let id = try? container.decode(Int.self, forKey: .kinopoiskId) {
            self.id = id
        } else {
            self.id = 0
        }
    }
}
