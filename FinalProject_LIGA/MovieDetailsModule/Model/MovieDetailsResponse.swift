//
//  MovieDetailsResponse.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 09.04.2022.
//

import Foundation

struct MovieDetailsResponse: Codable {
    let kinopoiskId: Int
    let nameRu: String?
    let nameEn: String?
    let posterUrl: String?
    let ratingKinopoisk: Double?
    let description: String?
    let year: Int?
}
