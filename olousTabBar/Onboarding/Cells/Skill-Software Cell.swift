//
//  Skill-Software Cell.swift
//  olousTabBar
//
//  Created by Salt Technologies on 04/04/24.
//

import UIKit

class Skill_Software_Cell: UICollectionViewCell {
    // Label to display text
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Label to display symbol
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        // Add textLabel to the cell
        addSubview(textLabel)
        
        // Add symbolLabel to the cell
        addSubview(symbolLabel)
        
        // Set constraints for textLabel
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Set constraints for symbolLabel
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: topAnchor),
            symbolLabel.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            symbolLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            symbolLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

