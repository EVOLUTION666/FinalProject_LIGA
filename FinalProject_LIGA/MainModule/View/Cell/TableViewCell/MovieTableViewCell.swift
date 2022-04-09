//
//  MovieTableViewCell.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 26.03.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieTableViewCell"
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var backView: UIView = {
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.clipsToBounds = true
        backView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        backView.layer.cornerRadius = 10
        backView.backgroundColor = .backView
        return backView
    }()
    
    private lazy var movieName: UILabel = {
        let movieName = UILabel()
        movieName.translatesAutoresizingMaskIntoConstraints = false
        movieName.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        movieName.numberOfLines = 0
        movieName.textColor = UIColor.white
        return movieName
    }()
    
    private lazy var movieDate: UILabel = {
        let movieDate = UILabel()
        movieDate.translatesAutoresizingMaskIntoConstraints = false
        movieDate.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        movieDate.numberOfLines = 0
        movieDate.textColor = UIColor.systemRed
        return movieDate
    }()
    
    private lazy var movieRating: UILabel = {
        let movieRating = UILabel()
        movieRating.translatesAutoresizingMaskIntoConstraints = false
        movieRating.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        movieRating.numberOfLines = 0
        movieRating.textColor = UIColor.systemRed
        movieRating.textAlignment = .right
        return movieRating
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .backGround
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
    }
    
    func configure(model: MovieModel) {
        movieImageView.loadImage(url: model.image, placeholder: UIImage(named: "not-found"))
        movieName.text = model.name
        movieDate.text = model.date
        movieRating.text = model.rating == "null" ? "0.0" : model.rating
    }
    
    private func setupUI() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(backView)
        backView.addSubview(movieName)
        backView.addSubview(movieDate)
        backView.addSubview(movieRating)
        
        movieDate.setContentHuggingPriority(.defaultLow, for: .horizontal)
        movieRating.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            movieImageView.widthAnchor.constraint(equalToConstant: 120),
            
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            backView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            backView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28),
            
            movieName.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16),
            movieName.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            movieName.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            
            movieDate.topAnchor.constraint(greaterThanOrEqualTo: movieName.bottomAnchor, constant: 8),
            movieDate.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            movieDate.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -16),
            
            movieRating.topAnchor.constraint(greaterThanOrEqualTo: movieName.bottomAnchor, constant: 8),
            movieRating.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            movieRating.leadingAnchor.constraint(equalTo: movieDate.trailingAnchor, constant: 8),
            movieRating.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -16),
            movieRating.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
}
