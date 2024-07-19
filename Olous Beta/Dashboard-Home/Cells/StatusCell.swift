//
//  StatusCell.swift
//  Olous Beta
//
//  Created by Salt Technologies on 19/07/24.
//

import UIKit

class StatusCell: UICollectionViewCell {
    
    let jobTitle: UILabel = {
        let label = UILabel()
        label.text = "Valuation Analyst"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let companyName: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreView = UIView()
    let scoreLabel : UILabel = {
        let label = UILabel()
        label.text = "NA"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusView = UIView()
    let statusLabel : UILabel = {
        let label = UILabel()
        label.text = "NA"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        setupJobTitleAndCompanyName()
    }
    
    func setupJobTitleAndCompanyName() {
        addSubview(jobTitle)
        addSubview(companyName)
        NSLayoutConstraint.activate([
            jobTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            jobTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            jobTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            companyName.topAnchor.constraint(equalTo: jobTitle.bottomAnchor, constant: 6),
            companyName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            companyName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func setupStatusViews() {
        scoreView.backgroundColor = UIColor(hex: "#F9FAFB")
        scoreView.layer.cornerRadius = 8
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scoreView)
        
        scoreView.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreView.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 8),
            scoreView.leadingAnchor.constraint(equalTo: companyName.leadingAnchor),
            scoreView.heightAnchor.constraint(equalToConstant: 20),
            
            scoreLabel.centerXAnchor.constraint(equalTo: scoreView.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: scoreView.centerYAnchor),
            scoreView.widthAnchor.constraint(equalToConstant: 160)
        ])
        
    }
}
