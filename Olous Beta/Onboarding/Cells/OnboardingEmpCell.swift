//
//  OnboardingEmpCell.swift
//  olousTabBar
//
//  Created by Salt Technologies on 24/06/24.
//

import UIKit

class OnboardingEmpCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.textColor = UIColor(hex: "#101828")
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Salt Technologies"
        label.textColor = UIColor(hex: "#475467")
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let noOfYearsLabel: UILabel = {
        let label = UILabel()
        label.text = "1+ Year"
        label.textColor = UIColor(hex: "#667085")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let jobTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Full time"
        label.textColor = UIColor(hex: "#667085")
        label.font = UIFont.systemFont(ofSize: 16)
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
        separator.backgroundColor = UIColor(hex: "#EAECF0")
        
        [titleLabel, companyNameLabel, noOfYearsLabel, jobTypeLabel, editButton, deleteButton].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            companyNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            companyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            companyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            noOfYearsLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 10),
            noOfYearsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            jobTypeLabel.topAnchor.constraint(equalTo: noOfYearsLabel.topAnchor),
            jobTypeLabel.leadingAnchor.constraint(equalTo: noOfYearsLabel.trailingAnchor, constant: 10),
            
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            editButton.widthAnchor.constraint(equalToConstant: 17),
            editButton.heightAnchor.constraint(equalToConstant: 17),
            
            deleteButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            deleteButton.widthAnchor.constraint(equalToConstant: 20),
            deleteButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
