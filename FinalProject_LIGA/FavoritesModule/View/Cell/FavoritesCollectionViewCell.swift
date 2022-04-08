//
//  FavoritesCollectionViewCell.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 27.03.2022.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FavoritesCollectionViewCell"
    
    private var didSelectItem: ((FavoritesMovie) -> ())?
    private let adapter = MovieCollectionViewAdapter()
    
    lazy var favoriteImage: UIImageView = {
        let favoriteImage = UIImageView()
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.contentMode = .scaleAspectFill
        favoriteImage.clipsToBounds = true
        favoriteImage.layer.cornerRadius = 10
        favoriteImage.image = UIImage(named: "car1")
        return favoriteImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(favoriteImage)
        
        NSLayoutConstraint.activate([
            favoriteImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            favoriteImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            favoriteImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoriteImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}

extension FavoritesCollectionViewCell: FavoriteCollectionViewAdapterDelegate {
    func didSelect(item: FavoritesMovie) {
        didSelectItem?(item)
    }
    
    func delete(model: FavoritesMovie) {
        
    }
}
