//
//  MovieDetailsModel.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 27.03.2022.
//

import Foundation
import UIKit

struct MovieDetailsModel {
    let movieId: Int
    let movieName: String
    let moviePosterURL: String?
    let movieData: Data?
    let movieReleaseDate: String
    let movieOverview: String
    let movieRating: String
    var isSaved = false
}
