//
//  DetailsViewController.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 27.03.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let manager: FavoritesMovieManager = FavoritesMovieManager()
    var output: MovieDetailsViewOutput!
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private lazy var backGroundImage: UIImageView = {
        let backGroundImage = UIImageView()
        return backGroundImage
    }()
    
    private lazy var blureView: UIVisualEffectView = {
        let blureEffect = UIBlurEffect(style: .light)
        let blureView = UIVisualEffectView(effect: blureEffect)
        return blureView
    }()
    
    private lazy var posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.layer.cornerRadius = 20
        posterImage.clipsToBounds = true
        return posterImage
    }()
    
    private lazy var movieName: UILabel = {
        let movieName = UILabel()
        movieName.translatesAutoresizingMaskIntoConstraints = false
        movieName.numberOfLines = 0
        movieName.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        movieName.textColor = .black
        return movieName
    }()
    
    private lazy var ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.textAlignment = .right
        ratingLabel.textColor = .black
        return ratingLabel
    }()
    
    private lazy var ratingImage: UIImageView = {
        let ratingImage = UIImageView()
        ratingImage.translatesAutoresizingMaskIntoConstraints = false
        ratingImage.image = UIImage(systemName: "star.fill")
        ratingImage.tintColor = .systemRed
        return ratingImage
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let releaseDateLabel = UILabel()
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.text = "Release Date:"
        releaseDateLabel.textColor = .black
        return releaseDateLabel
    }()
    
    private lazy var releaseTextDate: UILabel = {
        let releaseTextDate = UILabel()
        releaseTextDate.translatesAutoresizingMaskIntoConstraints = false
        releaseTextDate.textAlignment = .right
        releaseTextDate.textColor = .black
        return releaseTextDate
    }()
    
    private lazy var dateImage: UIImageView = {
        let dateImage = UIImageView()
        dateImage.translatesAutoresizingMaskIntoConstraints = false
        dateImage.image = UIImage(systemName: "calendar")
        dateImage.tintColor = .systemRed
        return dateImage
    }()
    
    private lazy var overViewLabel: UILabel = {
        let overViewLabel = UILabel()
        overViewLabel.translatesAutoresizingMaskIntoConstraints = false
        overViewLabel.text = "Overview:"
        overViewLabel.textColor = .black
        return overViewLabel
    }()
    
    private lazy var overViewTextLabel: UILabel = {
        let overViewTextLabel = UILabel()
        overViewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        overViewTextLabel.numberOfLines = 0
        overViewTextLabel.textAlignment = .justified
        overViewTextLabel.textColor = .black
        return overViewTextLabel
    }()
    
    private lazy var generalStackView: UIStackView = {
        let generalStackView = UIStackView(arrangedSubviews: [backgroundPosterView, nameStackView, releaseDateStackView, overViewStackView])
        generalStackView.distribution = .fill
        generalStackView.axis = .vertical
        generalStackView.spacing = 20
        generalStackView.translatesAutoresizingMaskIntoConstraints = false
        return generalStackView
    }()
    
    private lazy var nameStackView: UIStackView = {
        let nameStackView = UIStackView(arrangedSubviews: [movieName, ratingLabel, ratingImage])
        nameStackView.axis = .horizontal
        nameStackView.distribution = .fill
        nameStackView.alignment = .center
        nameStackView.spacing = 10
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        return nameStackView
    }()
    
    private lazy var releaseDateStackView: UIStackView = {
        let releaseDateStackView = UIStackView(arrangedSubviews: [releaseDateLabel, releaseTextDate, dateImage])
        releaseDateStackView.axis = .horizontal
        releaseDateStackView.distribution = .fill
        releaseDateStackView.spacing = 10
        releaseDateStackView.translatesAutoresizingMaskIntoConstraints = false
        return releaseDateStackView
    }()
    
    private lazy var overViewStackView: UIStackView = {
        let overViewStackView = UIStackView(arrangedSubviews: [overViewLabel, overViewTextLabel])
        overViewStackView.axis = .vertical
        overViewStackView.distribution = .fill
        overViewStackView.spacing = 10
        overViewStackView.translatesAutoresizingMaskIntoConstraints = false
        return overViewStackView
    }()
    
    private lazy var backgroundPosterView: UIView = {
        let backgroundPosterView = UIView()
        backgroundPosterView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundPosterView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backGround
        setupUI()
        output.didLoadViews()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backGroundImage.frame = view.bounds
        blureView.frame = view.bounds
        scrollView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - (tabBarController?.tabBar.frame.height ?? 0))
    }
    
    
    @objc func didTapFavoritesButton() {
        output.addFavorite()
    }
    
    private func setupUI() {
        view.addSubview(backGroundImage)
        view.addSubview(blureView)
        view.addSubview(scrollView)
        backgroundPosterView.addSubview(posterImage)
        scrollView.addSubview(generalStackView)
        
        generalStackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        generalStackView.isLayoutMarginsRelativeArrangement = true
        
        movieName.setContentHuggingPriority(.required, for: .vertical)
        movieName.setContentCompressionResistancePriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: generalStackView.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: generalStackView.bottomAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: generalStackView.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: generalStackView.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            posterImage.topAnchor.constraint(equalTo: backgroundPosterView.topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: backgroundPosterView.bottomAnchor),
            posterImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            posterImage.heightAnchor.constraint(equalTo: posterImage.widthAnchor, multiplier: 750/500),
            posterImage.centerXAnchor.constraint(equalTo: backgroundPosterView.centerXAnchor),
            
            ratingLabel.widthAnchor.constraint(equalToConstant: 30),
            
            ratingImage.widthAnchor.constraint(equalToConstant: 20),
            ratingImage.heightAnchor.constraint(equalToConstant: 20),
            
            releaseDateLabel.widthAnchor.constraint(equalToConstant: 150),
            
            dateImage.widthAnchor.constraint(equalToConstant: 20),
            dateImage.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

extension DetailsViewController: MovieDetailsViewInput {
    func setDefaultSettings(isSaved: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: isSaved ? "star.fill" : "star"), style: .plain, target: self, action: #selector(didTapFavoritesButton))
    }
    
    func didSaveMovie() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(didTapFavoritesButton))
    }
    
    func didDeleteMovie() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didTapFavoritesButton))
    }
    
    func setupModel(model: MovieDetailsModel) {
        if let data = model.movieData {
            posterImage.image = UIImage(data: data)
            backGroundImage.image = UIImage(data: data)
        } else if let url = model.moviePosterURL {
            posterImage.loadImage(url: url)
            backGroundImage.loadImage(url: url)
            if url == "" {
                blureView.alpha = 0
            }
        }
        
        movieName.text = model.movieName
        ratingLabel.text = model.movieRating
        releaseTextDate.text = model.movieReleaseDate
        overViewTextLabel.text = model.movieOverview
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: model.isSaved ? "star.fill" : "star"), style: .plain, target: self, action: #selector(didTapFavoritesButton))
    }
}
