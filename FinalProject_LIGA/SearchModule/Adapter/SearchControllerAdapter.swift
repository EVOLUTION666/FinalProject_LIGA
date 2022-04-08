//
//  SearchControllerAdapter.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 27.03.2022.
//

import UIKit

protocol SearchControllerAdapterDelegate: AnyObject {
    func serchResult(searchResult: String?)
}

class SearchControllerAdapter: NSObject {
    weak var delegate: SearchControllerAdapterDelegate?
}

//MARK: - UISearchBarDelegate
extension SearchControllerAdapter: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.serchResult(searchResult: searchBar.text)
    }
}
