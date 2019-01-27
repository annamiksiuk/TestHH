//
//  MainViewController.swift
//  TestHH
//
//  Created by Anna Miksiuk on 26.01.2019.
//  Copyright © 2019 Anna Miksiuk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    // MARK: - Self initializations
    
    private func commonInit() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blackCustom, NSAttributedString.Key.font: UIFont.SFUITextMedium(size: 17), NSAttributedString.Key.kern: -0.42]
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.view.tintColor = .darkSkyBlueTwo
        navigationController?.navigationBar.shadowImage = UIImage(named: "navBarBorderImage")
    }
}
