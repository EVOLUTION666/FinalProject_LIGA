//
//  SearchTableViewAdapter.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 02.04.2022.
//

import UIKit

protocol SearchTableViewAdapterDelegate: AnyObject {
    func didSelect(selectedMovie: MovieModel)
}

class SearchTableViewAdapter: NSObject {
    var searchArray = [MovieModel]()
    weak var delegate: SearchTableViewAdapterDelegate?
}

extension SearchTableViewAdapter: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension SearchTableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(model: searchArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(selectedMovie: searchArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}
