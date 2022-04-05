//
//  CDFavoriteMovies+CoreDataProperties.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 02.04.2022.
//
//

import Foundation
import CoreData


extension CDFavoriteMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavoriteMovies> {
        return NSFetchRequest<CDFavoriteMovies>(entityName: "CDFavoriteMovies")
    }

    @NSManaged public var movieName: String?
    @NSManaged public var moviePoster: Data?
    @NSManaged public var movieDateRelease: String?
    @NSManaged public var movieOverview: String?
    @NSManaged public var movieRating: String?
    @NSManaged public var id: Int64
    
    func convertToFavoriteMovie() -> FavoritesMovie {
        FavoritesMovie(movieId: Int(self.id),
                       movieName: self.movieName,
                       moviePoster: self.moviePoster,
                       movieReleaseDate: self.movieDateRelease,
                       movieOverview: self.movieOverview,
                       movieRating: self.movieRating)
    }

}

extension CDFavoriteMovies : Identifiable {

}
