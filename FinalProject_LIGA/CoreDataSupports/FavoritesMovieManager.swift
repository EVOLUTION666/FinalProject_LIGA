//
//  FavoritesMovieManager.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 02.04.2022.
//

import Foundation
import CoreData

struct FavoritesMovieManager {
    private let _favoritesMovieDataRepository = FavoritesMovieDataRepository()
    
    func createMovie(movie: FavoritesMovie) {
        _favoritesMovieDataRepository.create(favoriteMovie: movie)
    }
    
    func fetchFavoritesMovies() -> [FavoritesMovie]? {
        return _favoritesMovieDataRepository.getAll()
    }
    
    func fetchFavoriteMovie(byIdentifier id: Int) -> FavoritesMovie? {
        return _favoritesMovieDataRepository.get(byIdentifier: id)
    }
    
    func createMovie(movie: MovieDetailsModel) {
        DispatchQueue.global(qos: .utility).async {
            var imageData: Data? = nil
            
            if let url = URL(string: movie.moviePosterURL ?? "") {
                imageData = try? Data(contentsOf: url)
            }
            
            self.createMovie(movie: FavoritesMovie(movieId: movie.movieId,
                                              movieName: movie.movieName,
                                              moviePoster: imageData,
                                              movieReleaseDate: movie.movieReleaseDate,
                                              movieOverview: movie.movieOverview,
                                              movieRating: movie.movieRating))
        }
    }
    
    @discardableResult
    func deleteFavoriteMovie(id: Int) -> Bool {
        return _favoritesMovieDataRepository.delete(id: Int64(id))
    }
    
}
