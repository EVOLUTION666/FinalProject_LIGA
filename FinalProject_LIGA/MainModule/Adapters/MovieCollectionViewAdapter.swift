//
//  MovieCollectionViewAdapter.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 26.03.2022.
//

import UIKit

protocol MovieCollectionViewAdapterDelegate: AnyObject {
    func didSelect(model: MovieModel)
}

class MovieCollectionViewAdapter: NSObject {
    weak var delegate: MovieCollectionViewAdapterDelegate?
    var models = [MovieModel]()
}

//MARK: - UICollectionViewDelegate
extension MovieCollectionViewAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(model: models[indexPath.row])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

//MARK: - UICollectionViewDataSource
extension MovieCollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCollectionViewCell.identifier, for: indexPath) as! TableCollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
}
