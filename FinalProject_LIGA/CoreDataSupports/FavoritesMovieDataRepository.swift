//
//  FavoritesMovieDataRepository.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 02.04.2022.
//

import UIKit
import CoreData

protocol FavoritesMovieRepository {
    func create(favoriteMovie: FavoritesMovie)
    func getAll() -> [FavoritesMovie]?
    func get(byIdentifier id: Int) -> FavoritesMovie?
    func delete(id: Int64) -> Bool
}

struct FavoritesMovieDataRepository: FavoritesMovieRepository {
    
    func create(favoriteMovie: FavoritesMovie) {
        let cdFavoriteMovie = CDFavoriteMovies(context: PersistentStorage.shared.context)
        cdFavoriteMovie.id = Int64(favoriteMovie.movieId)
        cdFavoriteMovie.movieName = favoriteMovie.movieName
        cdFavoriteMovie.moviePoster = favoriteMovie.moviePoster
        cdFavoriteMovie.movieDateRelease = favoriteMovie.movieReleaseDate
        cdFavoriteMovie.movieOverview = favoriteMovie.movieOverview
        cdFavoriteMovie.movieRating = favoriteMovie.movieRating
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [FavoritesMovie]? {
        let result = PersistentStorage.shared.fetchManagedObjects(managedObject: CDFavoriteMovies.self)
        
        var favoritesMovies: [FavoritesMovie] = []
        result?.forEach({ (cdFavoritesMovies) in
            favoritesMovies.append(cdFavoritesMovies.convertToFavoriteMovie())
        })
        return favoritesMovies
    }
    
    func get(byIdentifier id: Int) -> FavoritesMovie? {
        let result = getCDFavoritesMovie(byIdentifier: id)
        guard result != nil else { return nil }
        return result?.convertToFavoriteMovie()
    }
    
    func delete(id: Int64) -> Bool {
        let cdFavoritesMovie = getCDFavoritesMovie(byIdentifier: Int(id))
        guard cdFavoritesMovie != nil else  { return false }
        
        PersistentStorage.shared.context.delete(cdFavoritesMovie!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    private func getCDFavoritesMovie(byIdentifier id: Int) -> CDFavoriteMovies? {
        let fetchRequest = NSFetchRequest<CDFavoriteMovies>(entityName: "CDFavoriteMovies")
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first(where: {Int(exactly: $0.id) == id})
            guard result != nil else { return nil }
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
}
