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
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Salt Technologies"
        label.textColor = UIColor(hex: "#101828")
        label.font = UIFont.systemFont(ofSize: 18)
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
        
        [titleLabel, companyNameLabel, noOfYearsLabel, jobTypeLabel, deleteButton].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
//        addSubview(titleLabel)
//        addSubview(companyNameLabel)
//        addSubview(noOfYearsLabel)
//        addSubview(jobTypeLabel)
//        addSubview(deleteButton)
//        
//        // Constraints
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        noOfYearsLabel.translatesAutoresizingMaskIntoConstraints = false
//        jobTypeLabel.translatesAutoresizingMaskIntoConstraints = false
//        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            companyNameLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 6),
            companyNameLabel.widthAnchor.constraint(equalToConstant: 150),
            
            noOfYearsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            noOfYearsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            jobTypeLabel.topAnchor.constraint(equalTo: noOfYearsLabel.topAnchor),
            jobTypeLabel.leadingAnchor.constraint(equalTo: noOfYearsLabel.trailingAnchor, constant: 10),
            
//            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
}
