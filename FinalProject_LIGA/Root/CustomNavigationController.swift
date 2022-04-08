//
//  CustomNavigationController.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 03.04.2022.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32, weight: .init(rawValue: 700))]
        navBarAppearance.backgroundColor = .backGround
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .systemRed
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
    }

}
