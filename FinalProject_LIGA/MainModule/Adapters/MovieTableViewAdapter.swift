//
//  MovieTableViewAdapter.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 26.03.2022.
//

import UIKit

protocol MovieTableViewAdapterDelegate: AnyObject {
    func didSelect(item: MovieModel)
}

class MovieTableViewAdapter: NSObject {
    weak var delegate: MovieTableViewAdapterDelegate?
    var models = [CellModel]()
}

// MARK: - UITableViewDelegate
extension MovieTableViewAdapter: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
}

// MARK: - UITableViewDataSource
extension MovieTableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section] {
        case .list(let models): return models.count
        case .collectionView: return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.section] {
        case .list(let models):
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
            cell.configure(model: model)
            return cell
        case .collectionView(let models):
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellWithCollectionView.identifier, for: indexPath) as! TableViewCellWithCollectionView
            cell.configure(models: models) { [weak self] model in
                self?.delegate?.didSelect(item: model)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = models[indexPath.section]
        switch type {
        case .collectionView:
            break
        case .list(models: let models):
            delegate?.didSelect(item: models[indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch models[indexPath.section] {
        case .collectionView:
            return TableViewCellWithCollectionView.collectionCellSize.height
        case .list:
            return 180
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                CustomHeader.identifier) as! CustomHeader
        if section == 0 {
            header.setTile(title: "Premieres")
        } else if section == 1 {
            header.setTile(title: "Top Rated Movies")
        }
        return header
    }
}
