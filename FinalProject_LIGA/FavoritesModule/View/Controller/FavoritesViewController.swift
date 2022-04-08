//
//  FavoritesViewController.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 25.03.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let adapter = FavoritesCollectionViewAdapter()
    private let cellSizeMultiplier: CGFloat = 750/500
    var output: FavoritesViewOutput!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let width = view.frame.width / 2
        layout.itemSize = CGSize(width: (view.frame.width / 2), height: width * cellSizeMultiplier)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FavoritesCollectionViewCell.self,
                                forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegate = output
        view.backgroundColor = .backGround
        view.addSubview(collectionView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.getFavoritesMoviesFromCD()
    }
}

extension FavoritesViewController: FavoritesViewInput {
    func navigate(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupMovies(favoritesMovies: [FavoritesMovie]) {
        adapter.movies = favoritesMovies
        collectionView.reloadData()
    }
}
