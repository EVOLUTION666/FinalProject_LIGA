//
//  PopularMovie.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 30.03.2022.
//

import Foundation

// MARK: - PopularMovie
struct Movie: Codable {
    let results: [PopularMovieResult]
}

// MARK: - Result
struct PopularMovieResult: Codable {
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let releaseDate, title: String
    let posterPath: String?
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
