//
//  ApplicationStatusVC.swift
//  Olous Beta
//
//  Created by Salt Technologies on 19/07/24.
//

import UIKit

class ApplicationStatusVC: UIViewController {
    
    var contentView = UIView()
    
    
    
    var filterView = UIView()
    var isFiltersVisible = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground

        navigationItem.title = "Application Status"
        
        let image = UIImage(systemName: "slider.horizontal.3")
        let filterButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapFilterIcon))
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        setupViews()
    }
    
    func setupViews() {
        setupContentView()
        setupFilterView()
    }
    
    func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func setupFilterView() {
        filterView.backgroundColor = UIColor(hex: "#F3F4F6")
        filterView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterView)
        
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            filterView.leadingAnchor.constraint(equalTo: view.trailingAnchor),
            filterView.widthAnchor.constraint(equalToConstant: view.frame.width - 100),
            filterView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc func didTapFilterIcon() {
        if !isFiltersVisible {
            UIView.animate(withDuration: 0.36) {
                self.filterView.transform = CGAffineTransform(translationX: -self.view.frame.width + 100, y: 0)
            }
            isFiltersVisible = true
        }
        else {
            UIView.animate(withDuration: 0.36) {
                self.filterView.transform = .identity
            }
            isFiltersVisible = false
        }
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
}
