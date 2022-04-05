//
//  FavoritesPresenterIO.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 26.03.2022.
//

import UIKit

protocol FavoritesViewInput: AnyObject {
    var output: FavoritesViewOutput! { get set }
    func setupMovies(favoritesMovies: [FavoritesMovie])
    func navigate(viewController: UIViewController)
}

protocol FavoritesViewOutput: FavoriteCollectionViewAdapterDelegate {
    var input: FavoritesViewInput? { get set }
    func getFavoritesMoviesFromCD()
}

class FavoritesPresenter: FavoritesViewOutput {
    private var favoritesMovies: [FavoritesMovie] = []
    private var selectedMovie: FavoritesMovie?
    private let favoriteMovieManager: FavoritesMovieManager!
    
    weak var input: FavoritesViewInput?
    
    init(view: FavoritesViewInput, favoriteMovieManager: FavoritesMovieManager) {
        input = view
        self.favoriteMovieManager = favoriteMovieManager
    }
    
    func getFavoritesMoviesFromCD() {
        self.favoritesMovies = favoriteMovieManager.fetchFavoritesMovies() ?? []
        input?.setupMovies(favoritesMovies: favoritesMovies)
    }
    
    func delete(model: FavoritesMovie) {
        self.favoriteMovieManager.deleteFavoriteMovie(id: model.movieId)
        getFavoritesMoviesFromCD()
    }
}

enum FavoritesModuleBuilder {
    static func buildFavoritesModule() -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter.init(view: view, favoriteMovieManager: FavoritesMovieManager())
        view.output = presenter
        return view
    }
}

extension FavoritesPresenter: FavoriteCollectionViewAdapterDelegate {
    func didSelect(item: FavoritesMovie) {
        let detailtsViewController = MovieDetailsBuilder.buildMovieDetailsModule(movie: .init(movieId: item.movieId, movieName: item.movieName ?? "", moviePosterURL: nil, movieData: item.moviePoster, movieReleaseDate: item.movieReleaseDate ?? "", movieOverview: item.movieOverview ?? "", movieRating: item.movieRating ?? ""))
        input?.navigate(viewController: detailtsViewController)
    }
}
