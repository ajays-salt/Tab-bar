//
//  LanguageCell.swift
//  olousTabBar
//
//  Created by Salt Technologies on 04/04/24.
//

import UIKit

class LanguageCell: UICollectionViewCell {
    static let identifier = "language"
    
    let languageLabelContainer = UIView()
    let languageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Language"
        return label
    }()
    
    let fluencyLabelContainer = UIView()
    let fluencyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Fluency"
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .red
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Setup the label containers for borders
        [languageLabelContainer, fluencyLabelContainer].forEach { container in
            container.layer.borderWidth = 1
            container.layer.borderColor = UIColor.gray.cgColor
            container.layer.cornerRadius = 5
            container.clipsToBounds = true
            addSubview(container)
        }
        
        languageLabelContainer.addSubview(languageLabel)
        fluencyLabelContainer.addSubview(fluencyLabel)
        addSubview(deleteButton)
    }
    
    private func setupConstraints() {
        languageLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        fluencyLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        fluencyLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            languageLabelContainer.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            languageLabelContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            languageLabelContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            languageLabelContainer.heightAnchor.constraint(equalToConstant: 40),
            
            languageLabel.topAnchor.constraint(equalTo: languageLabelContainer.topAnchor),
            languageLabel.leadingAnchor.constraint(equalTo: languageLabelContainer.leadingAnchor),
            languageLabel.trailingAnchor.constraint(equalTo: languageLabelContainer.trailingAnchor),
            languageLabel.bottomAnchor.constraint(equalTo: languageLabelContainer.bottomAnchor),
            
            fluencyLabelContainer.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            fluencyLabelContainer.leadingAnchor.constraint(equalTo: languageLabelContainer.trailingAnchor, constant: 10),
            fluencyLabelContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            fluencyLabelContainer.heightAnchor.constraint(equalToConstant: 40),
            
            fluencyLabel.topAnchor.constraint(equalTo: fluencyLabelContainer.topAnchor),
            fluencyLabel.leadingAnchor.constraint(equalTo: fluencyLabelContainer.leadingAnchor),
            fluencyLabel.trailingAnchor.constraint(equalTo: fluencyLabelContainer.trailingAnchor),
            fluencyLabel.bottomAnchor.constraint(equalTo: fluencyLabelContainer.bottomAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            deleteButton.leadingAnchor.constraint(equalTo: fluencyLabelContainer.trailingAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
