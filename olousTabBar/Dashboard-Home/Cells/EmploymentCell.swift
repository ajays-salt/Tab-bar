//
//  EmpoymentCell.swift
//  olousTabBar
//
//  Created by Salt Technologies on 05/04/24.
//

import UIKit

class EmploymentCell: UICollectionViewCell {
    
    // MARK: - Properties
    
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
        button.setImage(UIImage(named: "pencil"), for: .normal)
        button.tintColor = UIColor(hex: "#667085")
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = UIColor(hex: "#667085")
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
        
        [titleLabel, companyNameLabel, noOfYearsLabel, jobTypeLabel, editButton, deleteButton, separator].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            companyNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            companyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            companyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            noOfYearsLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 10),
            noOfYearsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            jobTypeLabel.topAnchor.constraint(equalTo: noOfYearsLabel.topAnchor),
            jobTypeLabel.leadingAnchor.constraint(equalTo: noOfYearsLabel.trailingAnchor, constant: 10),
            
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: -8),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12),
            editButton.widthAnchor.constraint(equalToConstant: 40),
            editButton.heightAnchor.constraint(equalToConstant: 40),
            
//            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12),
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
}
