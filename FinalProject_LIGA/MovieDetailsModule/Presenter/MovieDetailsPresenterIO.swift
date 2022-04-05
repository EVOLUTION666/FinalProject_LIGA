//
//  MovieDetailsPresenterIO.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 27.03.2022.
//

import UIKit

protocol MovieDetailsViewInput: AnyObject {
    var output: MovieDetailsViewOutput! { get set }
    func setupModel(model: MovieDetailsModel)
    func didSaveMovie()
    func didDeleteMovie()
}

protocol MovieDetailsViewOutput {
    var input: MovieDetailsViewInput? { get set }
    func didLoadViews()
    func addFavorite()
}

class MovieDetailsPresenterIO: MovieDetailsViewOutput {

    private var movie: MovieDetailsModel
    private let favoriteMovieManager: FavoritesMovieManager
    weak var input: MovieDetailsViewInput?
    
    init(view: MovieDetailsViewInput, movie: MovieDetailsModel, favoriteMovieManager: FavoritesMovieManager) {
        self.input = view
        self.movie = movie
        self.favoriteMovieManager = favoriteMovieManager
    }
    
    func didLoadViews() {
        movie.isSaved = favoriteMovieManager.fetchFavoriteMovie(byIdentifier: movie.movieId) != nil
        input?.setupModel(model: movie)
    }
    
    func addFavorite() {
        if favoriteMovieManager.fetchFavoriteMovie(byIdentifier: movie.movieId) != nil {
                self.favoriteMovieManager.deleteFavoriteMovie(id: self.movie.movieId)
                self.input?.didDeleteMovie()

        } else {
                self.favoriteMovieManager.createMovie(movie: self.movie)
                self.input?.didSaveMovie()
        }
    }
}

enum MovieDetailsBuilder {
    static func buildMovieDetailsModule(movie: MovieDetailsModel) -> UIViewController {
        let view = DetailsViewController()
        let presenter = MovieDetailsPresenterIO(view: view, movie: movie, favoriteMovieManager: FavoritesMovieManager())
        view.output = presenter
        return view
    }
}
