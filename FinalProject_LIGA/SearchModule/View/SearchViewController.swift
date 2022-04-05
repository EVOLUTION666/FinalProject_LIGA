//
//  SearchViewController.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 27.03.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let adapter = SearchControllerAdapter()
    private let tableViewAdapter = SearchTableViewAdapter()
    
    var output: SearchViewOutput!
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie..."
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .prominent
        definesPresentationContext = true
        searchController.searchResultsUpdater = adapter
        searchController.searchBar.delegate = adapter
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = tableViewAdapter
        tableView.dataSource = tableViewAdapter
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegate = output
        tableViewAdapter.delegate = output
        view.addSubview(tableView)
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureUI() {
        view.backgroundColor = .backGround
        navigationItem.searchController = searchController
    }
}

extension SearchViewController: SearchViewInput {
    func navigate(viewController: UIViewController) {
        view.endEditing(true)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didSearch(searchResults: [MovieModel]) {
        tableViewAdapter.searchArray = searchResults
        tableView.reloadData()
    }
}
