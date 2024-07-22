//
//  StatusCell.swift
//  Olous Beta
//
//  Created by Salt Technologies on 19/07/24.
//

import UIKit

class StatusCell: UICollectionViewCell {
    
    var jobTitle: UILabel = {
        let label = UILabel()
        label.text = "Valuation Analyst"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var companyName: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var scoreView = UIView()
    var scoreLabel : UILabel = {
        let label = UILabel()
        label.text = "30% matched"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var statusView = UIView()
    var statusLabel : UILabel = {
        let label = UILabel()
        label.text = "Pending"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var appliedTime : UILabel = {
        var label = UILabel()
        label.text = "1h ago"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(hex: "#667085")
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
        setupStatusViews()
        setupAppliedTime()
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
        let label : UILabel = {
            let label = UILabel()
            label.text = "Score :"
            label.textColor = UIColor(hex: "#667085")
            label.font = .systemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        addSubview(label)
        
        scoreView.backgroundColor = UIColor(hex: "#F9FAFB")
        scoreView.layer.cornerRadius = 8
        scoreView.layer.borderWidth = 1
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scoreView)
        
        scoreView.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 15),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            scoreView.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 12),
            scoreView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10),
            scoreView.heightAnchor.constraint(equalToConstant: 26),
            
            scoreLabel.centerXAnchor.constraint(equalTo: scoreView.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: scoreView.centerYAnchor),
            scoreView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        
        let label2 : UILabel = {
            let label = UILabel()
            label.text = "View Status :"
            label.textColor = UIColor(hex: "#667085")
            label.font = .systemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        addSubview(label2)
        
        statusView.backgroundColor = UIColor(hex: "#F3F4F6")
        statusView.layer.cornerRadius = 8
        statusView.layer.borderWidth = 1
        statusView.layer.borderColor = UIColor(hex: "#E5E7EB").cgColor
        statusView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(statusView)
        
        statusView.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: 15),
            label2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            statusView.topAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: 12),
            statusView.leadingAnchor.constraint(equalTo: label2.trailingAnchor, constant: 10),
            statusView.heightAnchor.constraint(equalToConstant: 26),
            
            statusLabel.centerXAnchor.constraint(equalTo: statusView.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: statusView.centerYAnchor),
            statusView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setupAppliedTime() {
        addSubview(appliedTime)
        
        NSLayoutConstraint.activate([
            appliedTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            appliedTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            //            jobPostedTime.widthAnchor.constraint(equalToConstant: 76),
            appliedTime.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
