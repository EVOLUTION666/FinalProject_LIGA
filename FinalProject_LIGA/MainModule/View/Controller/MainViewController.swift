//
//  ViewController.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 25.03.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let adapter = MovieTableViewAdapter()
    private let manager: FavoritesMovieManager = FavoritesMovieManager()
    
    var output: MainViewOutput!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(MovieTableViewCell.self,
                           forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.register(TableViewCellWithCollectionView.self,
                           forCellReuseIdentifier: TableViewCellWithCollectionView.identifier)
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: CustomHeader.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0
        tableView.tableFooterView = nil
        tableView.delegate = adapter
        tableView.dataSource = adapter
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.setupUIView()
        title = "Movies"
        view.backgroundColor = .backGround
        view.addSubview(tableView)
        adapter.delegate = output
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension MainViewController: MainViewInput {
    func navigate(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupModel(model: [CellModel]) {
        adapter.models = model
        tableView.reloadData()
    }
}
