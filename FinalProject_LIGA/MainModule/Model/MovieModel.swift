//
//  Models.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 26.03.2022.
//

import Foundation

enum CellModel {
    case collectionView(models: [MovieModel])
    case list(models: [MovieModel])
}

struct MovieModel {
    let id: Int
    let image: String
    let rating: String?
    let name: String?
    let date: String?
    let description: String?
}
