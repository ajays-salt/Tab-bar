//
//  AddLanguageView.swift
//  olousTabBar
//
//  Created by Salt Technologies on 03/04/24.
//

import UIKit

class AddLanguageView: UIView {
    
    // Labels for displaying "Language" and "Fluency"
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Language"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = UIColor(hex: "#344054")
        return label
    }()
    let container1 : UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.borderWidth = 1 // Add border to the container
        container.layer.cornerRadius = 5 // Add corner radius for rounded corners
        container.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor // Set border color
        
        return container
    }()
    
    private let fluencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fluency"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = UIColor(hex: "#344054")
        return label
    }()
    let container2 : UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.borderWidth = 1 // Add border to the container
        container.layer.cornerRadius = 5 // Add corner radius for rounded corners
        container.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor // Set border color
        
        return container
    }()
    
    var selectLanguageButton : UIButton!
    
    // Custom initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    // Setup subviews and constraints
    private func setupSubviews() {
        addSubview(languageLabel)
        addSubview(fluencyLabel)
        
        addSubview(container1)
        addSubview(container2)
        
        selectLanguageButton = UIButton(type: .system)
        selectLanguageButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        selectLanguageButton.tintColor = UIColor(hex: "#667085")
        selectLanguageButton.translatesAutoresizingMaskIntoConstraints = false
        container1.addSubview(selectLanguageButton)
        
        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            languageLabel.topAnchor.constraint(equalTo: topAnchor),
            
            fluencyLabel.topAnchor.constraint(equalTo: topAnchor),
            fluencyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 186),
            fluencyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            container1.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 10),
            container1.leadingAnchor.constraint(equalTo: leadingAnchor), // Replace view with self
            container1.widthAnchor.constraint(equalToConstant: 166), // Replace view with self
            container1.heightAnchor.constraint(equalToConstant: 50),
            
            container2.topAnchor.constraint(equalTo: container1.topAnchor, constant: 0),
            container2.leadingAnchor.constraint(equalTo: container1.trailingAnchor, constant: 20),
            container2.widthAnchor.constraint(equalToConstant: 166), // Replace view with self
            container2.heightAnchor.constraint(equalToConstant: 50),
            
            selectLanguageButton.centerYAnchor.constraint(equalTo: container1.centerYAnchor),
            selectLanguageButton.trailingAnchor.constraint(equalTo: container1.trailingAnchor, constant: -10),
            selectLanguageButton.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        container1.backgroundColor = .green
        container2.backgroundColor = .blue
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

