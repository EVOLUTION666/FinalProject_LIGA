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

extension SearchControllerAdapter: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar did begin editing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        navigationController?.navigationBar.isTranslucent = false
        print("Search bar did end editing")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.serchResult(searchResult: searchBar.text)
    }
    
}

extension SearchControllerAdapter: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
