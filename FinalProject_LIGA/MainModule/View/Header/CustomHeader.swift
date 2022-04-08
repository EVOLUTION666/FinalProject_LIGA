//
//  CustomHeader.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 26.03.2022.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.translatesAutoresizingMaskIntoConstraints = false
        labelHeader.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        labelHeader.textColor = .white
        return labelHeader
    }()
    
    static let identifier = "CustomHeader"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTile(title: String) {
        labelHeader.text = title
    }
    
    private func configureHeader() {
        contentView.addSubview(labelHeader)
        
        NSLayoutConstraint.activate([
            labelHeader.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            labelHeader.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelHeader.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            labelHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
}
