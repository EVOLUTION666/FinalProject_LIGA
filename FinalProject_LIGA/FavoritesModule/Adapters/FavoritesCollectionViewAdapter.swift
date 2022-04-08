//
//  FavoritesCollectionViewAdapter.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 27.03.2022.
//

import UIKit

protocol FavoriteCollectionViewAdapterDelegate: AnyObject {
    func didSelect(item: FavoritesMovie)
    func delete(model: FavoritesMovie)
}

class FavoritesCollectionViewAdapter: NSObject {
    var movies: [FavoritesMovie] = []
    weak var delegate: FavoriteCollectionViewAdapterDelegate?
}

//MARK: - UICollectionViewDelegate
extension FavoritesCollectionViewAdapter: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(item: movies[indexPath.row])
    }
}

//MARK: - UICollectionViewDataSource
extension FavoritesCollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.identifier,
                                                      for: indexPath) as! FavoritesCollectionViewCell
        cell.favoriteImage.image = UIImage(data: movies[indexPath.row].moviePoster ?? Data())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let identifier = NSString(string: String(indexPath.row))
        let config = UIContextMenuConfiguration(identifier: identifier,
                                                previewProvider: nil) { _ in
            
            let delete = UIAction(title: "Remove Favorite",
                                  image: UIImage(systemName: "star.fill"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  attributes: .destructive,
                                  state: .off) { _ in
                self.delegate?.delete(model: self.movies[indexPath.row])
            }
            
            return UIMenu(title: "",
                          image: nil,
                          identifier: nil,
                          options: UIMenu.Options.displayInline,
                          children: [delete])
        }
        return config
    }
    
    func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        guard let indexString = configuration.identifier as? String, let index = Int(indexString) else { return nil }
        guard let cell = collectionView.cellForItem(at: .init(row: index, section: 0)) as? FavoritesCollectionViewCell else { return nil }
        
        let parameters = UIPreviewParameters()
        parameters.backgroundColor = .clear
        
        return UITargetedPreview(view: cell.favoriteImage, parameters: parameters)
    }
    
    func collectionView(_ collectionView: UICollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        guard let indexString = configuration.identifier as? String, let index = Int(indexString) else { return nil }
        guard let cell = collectionView.cellForItem(at: .init(row: index, section: 0)) as? FavoritesCollectionViewCell else { return nil }
        
        let parameters = UIPreviewParameters()
        parameters.backgroundColor = .clear
        
        return UITargetedPreview(view: cell.favoriteImage, parameters: parameters)
    }
}
