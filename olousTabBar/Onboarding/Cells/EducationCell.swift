//
//  EducationCell.swift
//  olousTabBar
//
//  Created by Salt Technologies on 12/04/24.
//

import UIKit

class EducationCell: UICollectionViewCell {
    
    let educationLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.textColor = UIColor(hex: "#101828")
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let collegeLabel: UILabel = {
        let label = UILabel()
        label.text = "Salt Technologies"
        label.textColor = UIColor(hex: "#101828")
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let passYearLabel: UILabel = {
        let label = UILabel()
        label.text = "1+ Year"
        label.textColor = UIColor(hex: "#667085")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let courseTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Full time"
        label.textColor = UIColor(hex: "#667085")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = UIColor(hex: "#667085")
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        
        [educationLabel, collegeLabel, passYearLabel, courseTypeLabel, deleteButton].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            educationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            educationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            collegeLabel.topAnchor.constraint(equalTo: educationLabel.topAnchor),
            collegeLabel.leadingAnchor.constraint(equalTo: educationLabel.trailingAnchor, constant: 6),
            collegeLabel.widthAnchor.constraint(equalToConstant: 150),
            
            passYearLabel.topAnchor.constraint(equalTo: educationLabel.bottomAnchor, constant: 10),
            passYearLabel.leadingAnchor.constraint(equalTo: educationLabel.leadingAnchor),
            
            courseTypeLabel.topAnchor.constraint(equalTo: passYearLabel.topAnchor),
            courseTypeLabel.leadingAnchor.constraint(equalTo: passYearLabel.trailingAnchor, constant: 6),
            
//            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
