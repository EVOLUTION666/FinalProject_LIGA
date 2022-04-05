//
//  SearchPresenterIO.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 02.04.2022.
//

import UIKit

enum SearchMovieBuilder {
    static func buildSearchMovie() -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchMoviePresenter(view: view, movieApiService: MovieApiService.shared)
        view.output = presenter
        return view
    }
}

protocol SearchViewInput: AnyObject {
    var output: SearchViewOutput! { get set }
    func didSearch(searchResults: [MovieModel])
    func navigate(viewController: UIViewController)
}

protocol SearchViewOutput: SearchControllerAdapterDelegate, SearchTableViewAdapterDelegate {
    var input: SearchViewInput! { get set }
}

class SearchMoviePresenter: SearchViewOutput {

    weak var input: SearchViewInput!
    private let movieApiService: MovieApiService
    
    init(view: SearchViewInput, movieApiService: MovieApiService) {
        self.input = view
        self.movieApiService = movieApiService
    }
    
    func didSelect(selectedMovie: MovieModel) {
        let movieDetail = MovieDetailsBuilder.buildMovieDetailsModule(movie: .init(movieId: selectedMovie.id, movieName: selectedMovie.name ?? "", moviePosterURL: selectedMovie.image, movieData: nil, movieReleaseDate: selectedMovie.date ?? "", movieOverview: selectedMovie.description ?? "", movieRating: selectedMovie.rating ?? ""))
        input.navigate(viewController: movieDetail)
    }
    
    func serchResult(searchResult: String?) {
        if let text = searchResult {
            movieApiService.getSearchResults(searchText: text) { movies in
                let searchMovies = movies?.results.map { item in
                    MovieModel(id: item.id, image: item.posterPath ?? "", rating: String(item.voteAverage), name: item.title, date: item.releaseDate, description: item.overview)
                }
                DispatchQueue.main.async {
                    self.input.didSearch(searchResults: searchMovies ?? [])
                }
            }
        }
    }
}

