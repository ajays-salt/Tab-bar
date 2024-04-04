//
//  LanguageCell.swift
//  olousTabBar
//
//  Created by Salt Technologies on 04/04/24.
//

import UIKit

// Define Language struct
struct Language {
    let name: String
    let fluency: String
}

// Custom UITableViewCell subclass
class LanguageCell: UITableViewCell {
    
    // MARK: - Properties
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.text = "English"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fluencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Beginner"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .red
        return button
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        addSubview(languageLabel)
        addSubview(fluencyLabel)
        addSubview(deleteButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            languageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            fluencyLabel.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor, constant: 8),
            fluencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 24),
            deleteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Cell
    
    func configure(with language: Language) {
        languageLabel.text = language.name
        fluencyLabel.text = language.fluency
    }
}

