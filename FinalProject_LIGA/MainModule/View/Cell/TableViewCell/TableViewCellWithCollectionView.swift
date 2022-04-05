//
//  TableViewCell.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 26.03.2022.
//

import UIKit

class TableViewCellWithCollectionView: UITableViewCell {
    
    static let identifier = "TableViewCellWithCollectionView"
    static let collectionCellSize: CGSize = .init(width: 200, height: 300)
    
    private var didSelectItem: ((MovieModel) -> ())?
    
    private let adapter = MovieCollectionViewAdapter()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = TableViewCellWithCollectionView.collectionCellSize
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TableCollectionViewCell.self,
                                forCellWithReuseIdentifier: TableCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .backGround
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        backgroundColor = .backGround
        adapter.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(models: [MovieModel], didSelect: ((MovieModel) -> ())?) {
        self.didSelectItem = didSelect
        adapter.models = models
    }
}

extension TableViewCellWithCollectionView: MovieCollectionViewAdapterDelegate {
    func didSelect(model: MovieModel) {
        didSelectItem?(model)
    }
}
