//
//  OnboardingEduCellCollectionViewCell.swift
//  olousTabBar
//
//  Created by Salt Technologies on 24/06/24.
//

import UIKit

class OnboardingEduCell: UICollectionViewCell {
    let educationLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.textColor = UIColor(hex: "#101828")
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let collegeLabel: UILabel = {
        let label = UILabel()
        label.text = "Salt Technologies"
        label.textColor = UIColor(hex: "#475467")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let passYearLabel: UILabel = {
        let label = UILabel()
        label.text = "1+ Year"
        label.textColor = UIColor(hex: "#667085")
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let courseTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Full time"
        label.textColor = UIColor(hex: "#667085")
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(named: "pencil")?.buttonImageResized(to: CGSize(width: 17, height: 17)) { // Adjust the size as needed
            button.setImage(image, for: .normal)
        }
        button.tintColor = UIColor(hex: "#98A2B3")
        
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(systemName: "trash")?.buttonImageResized(to: CGSize(width: 20, height: 20)) { // Adjust the size as needed
            button.setImage(image, for: .normal)
        }
        button.tintColor = UIColor(hex: "#98A2B3")
        return button
    }()
    
    let separator = UIView()
    
    
    // **************************************************************************************************************************
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        
        separator.backgroundColor = UIColor(hex: "#EAECF0")
        
        [educationLabel, collegeLabel, passYearLabel, courseTypeLabel, editButton, deleteButton].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            educationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            educationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            educationLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -30),
            
            collegeLabel.topAnchor.constraint(equalTo: educationLabel.bottomAnchor, constant: 8),
            collegeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            collegeLabel.widthAnchor.constraint(equalToConstant: 150),
            collegeLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -30),
            
            passYearLabel.topAnchor.constraint(equalTo: collegeLabel.bottomAnchor, constant: 8),
            passYearLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            courseTypeLabel.topAnchor.constraint(equalTo: passYearLabel.topAnchor),
            courseTypeLabel.leadingAnchor.constraint(equalTo: passYearLabel.trailingAnchor, constant: 6),
            
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            editButton.widthAnchor.constraint(equalToConstant: 17),
            editButton.heightAnchor.constraint(equalToConstant: 17),
            
            deleteButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            deleteButton.widthAnchor.constraint(equalToConstant: 20),
            deleteButton.heightAnchor.constraint(equalToConstant: 20),
            
//            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
//            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
//            separator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
//            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

}
