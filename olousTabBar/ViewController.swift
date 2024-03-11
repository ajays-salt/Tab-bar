//
//  ViewController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = TabBarController()
        let tempView = vc.view!
        
        view.addSubview(tempView)
        addChild(vc)
        vc.didMove(toParent: self)
        overrideUserInterfaceStyle = .light
        
        
        tempView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tempView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -12),
            tempView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tempView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tempView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }


}

