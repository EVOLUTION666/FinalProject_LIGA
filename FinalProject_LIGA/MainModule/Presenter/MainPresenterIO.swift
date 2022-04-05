//
//  MainPresenterIO.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 26.03.2022.
//

import Foundation
import UIKit

protocol MainViewInput: AnyObject {
    var output: MainViewOutput! { get set }
    func setupModel(model: [CellModel])
    func navigate(viewController: UIViewController)
}
protocol MainViewOutput: MovieTableViewAdapterDelegate {
    var input: MainViewInput? { get set }
    func setupUIView()
}

class MainPresenter: MainViewOutput {
    
    private var popularMovies = [PopularMovieResult]()
    private var models = [CellModel]()
    
    func setupUIView() {
        getPopularMovies()
        getTopRatedMovies()
    }
    
    weak var input: MainViewInput?
    private let movieApiService: MovieApiService
    
    init(view: MainViewInput, movieApiService: MovieApiService) {
        self.input = view
        self.movieApiService = movieApiService
        
    }
    
    private func getPopularMovies() {
        MovieApiService.shared.getPopularMovies { [weak self] popularMovie in
            DispatchQueue.main.async {
                guard let self = self else { return }
                guard let popularMovie = popularMovie else { return }
                
                let collectionModels = popularMovie.results.map({
                    MovieModel(id: $0.id, image: $0.posterPath ?? "", rating: String($0.voteAverage), name: $0.title, date: $0.releaseDate, description: $0.overview)
                })
                self.models.insert(.collectionView(models: collectionModels), at: 0)
                self.input?.setupModel(model: self.models)
            }
        }
    }
    
    private func getTopRatedMovies() {
        MovieApiService.shared.getTopRatedMovies { [weak self] topRatedMovie in
            DispatchQueue.main.async {
                guard let self = self else { return }
                guard let topRatedMovie = topRatedMovie else { return }
                
                let collectionModels = topRatedMovie.results.map({
                    MovieModel(id: $0.id, image: $0.posterPath ?? "", rating: String($0.voteAverage), name: $0.title, date: $0.releaseDate, description: $0.overview)
                })
                self.models.append(.list(models: collectionModels))
                self.input?.setupModel(model: self.models)
            }
        }
    }
    
}

enum MainModuleBuilder {
    static func buildMainModule() -> UIViewController {
        let view = ViewController()
        let presenter = MainPresenter(view: view, movieApiService: MovieApiService.shared)
        view.output = presenter
        return view
    }
}

extension MainPresenter: MovieTableViewAdapterDelegate {
    func didSelect(item: MovieModel) {
        let viewController = MovieDetailsBuilder.buildMovieDetailsModule(movie: .init(movieId: item.id, movieName: item.name ?? "", moviePosterURL: item.image, movieData: nil, movieReleaseDate: item.date ?? "", movieOverview: item.description ?? "", movieRating: item.rating ?? ""))
        input?.navigate(viewController: viewController)
    }
}