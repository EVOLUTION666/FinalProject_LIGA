//
//  TableViewCell.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 26.03.2022.
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TableCollectionViewCell"
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: MovieModel) {
        image.loadImage(url: model.image)
    }
    
    private func configureUI() {
        contentView.addSubview(image)
        contentView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}
