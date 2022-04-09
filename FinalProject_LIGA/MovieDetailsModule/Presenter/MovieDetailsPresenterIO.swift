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
    func setDefaultSettings(isSaved: Bool)
}

protocol MovieDetailsViewOutput {
    var input: MovieDetailsViewInput? { get set }
    func didLoadViews()
    func addFavorite()
}

class MovieDetailsPresenterIO: MovieDetailsViewOutput {
    private let movieID: Int
    private let favoriteMovieManager: FavoritesMovieManager
    private let movieApiService: MovieApiService
    private var movie: MovieDetailsModel?
    weak var input: MovieDetailsViewInput?
    
    init(view: MovieDetailsViewInput, movieID: Int, favoriteMovieManager: FavoritesMovieManager, movieApiService: MovieApiService) {
        self.input = view
        self.movieID = movieID
        self.favoriteMovieManager = favoriteMovieManager
        self.movieApiService = movieApiService
    }
    
    init(view: MovieDetailsViewInput, movie: MovieDetailsModel, favoriteMovieManager: FavoritesMovieManager, movieApiService: MovieApiService) {
        self.input = view
        self.movieID = movie.movieId
        self.movie = movie
        self.favoriteMovieManager = favoriteMovieManager
        self.movieApiService = movieApiService
    }
    
    func didLoadViews() {
        input?.setDefaultSettings(isSaved: favoriteMovieManager.fetchFavoriteMovie(byIdentifier: movieID) != nil)
        movie?.isSaved = favoriteMovieManager.fetchFavoriteMovie(byIdentifier: movieID) != nil
        loadData()
    }
    
    func addFavorite() {
        if favoriteMovieManager.fetchFavoriteMovie(byIdentifier: movieID) != nil {
            self.favoriteMovieManager.deleteFavoriteMovie(id: self.movieID)
            self.input?.didDeleteMovie()
            
        } else {
            guard let movie = movie else {
                return
            }
            self.favoriteMovieManager.createMovie(movie: movie)
            self.input?.didSaveMovie()
        }
    }
    
    private func loadData() {
        if let movie = movie {
            input?.setupModel(model: movie)
            return
        }
        movieApiService.getDetailsById(movieID: movieID) { movie in
            DispatchQueue.main.async {
                guard let movie = movie else {
                    return
                }

                var model = MovieDetailsModel(movieId: movie.kinopoiskId, movieName: movie.nameRu ?? "", moviePosterURL: movie.posterUrl, movieData: nil, movieReleaseDate: String(movie.year ?? 0), movieOverview: movie.description ?? "", movieRating: String(movie.ratingKinopoisk ?? 0.0))
                model.isSaved = false// self.favoriteMovieManager.fetchFavoriteMovie(byIdentifier: self.movieID) != nil
                self.movie = model
                self.input?.setupModel(model: model)
            }
        }
    }
}

enum MovieDetailsBuilder {
    static func buildMovieDetailsModule(movieID: Int) -> UIViewController {
        let view = DetailsViewController()
        let presenter = MovieDetailsPresenterIO(view: view, movieID: movieID, favoriteMovieManager: FavoritesMovieManager(), movieApiService: MovieApiService.shared)
        view.output = presenter
        return view
    }
    
    static func buildMovieDetailsModule(movie: MovieDetailsModel) -> UIViewController {
        let view = DetailsViewController()
        let presenter = MovieDetailsPresenterIO(view: view, movie: movie, favoriteMovieManager: FavoritesMovieManager(), movieApiService: MovieApiService.shared)
        view.output = presenter
        return view
    }
}
