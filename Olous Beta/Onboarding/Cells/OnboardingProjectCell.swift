//
//  OnboardingProjectCell.swift
//  olousTabBar
//
//  Created by Salt Technologies on 24/06/24.
//

import UIKit

class OnboardingProjectCell: UICollectionViewCell {
    var projectName: UILabel = {
        let label = UILabel()
        label.text = "NA"
        label.textColor = UIColor(hex: "#101828")
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let projectRole: UILabel = {
        let label = UILabel()
        label.text = "Salt Technologies"
        label.textColor = UIColor(hex: "#101828")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let projectDescription: UILabel = {
        let label = UILabel()
        label.text = "Salt Technologies"
        label.textColor = UIColor(hex: "#101828")
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    let projectResponsibility: UILabel = {
        let label = UILabel()
        label.text = "Salt Technologies"
        label.textColor = UIColor(hex: "#101828")
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(named: "pencil")?.buttonImageResized(to: CGSize(width: 20, height: 20)) { // Adjust the size as needed
            button.setImage(image, for: .normal)
        }
        button.tintColor = UIColor(hex: "#98A2B3")
        
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(systemName: "trash")?.buttonImageResized(to: CGSize(width: 24, height: 24)) { // Adjust the size as needed
            button.setImage(image, for: .normal)
        }
        button.tintColor = UIColor(hex: "#98A2B3")
        return button
    }()
    
    let separator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        separator.backgroundColor = UIColor(hex: "#EAECF0")
        
        let role : UILabel = {
            let label = UILabel()
            label.text = "Role"
            label.textColor = UIColor(hex: "#475467")
            label.font = .systemFont(ofSize: 14)
            
            return label
        }()
        let resp : UILabel = {
            let label = UILabel()
            label.text = "Responsibility"
            label.textColor = UIColor(hex: "#475467")
            label.font = .systemFont(ofSize: 14)
            
            return label
        }()
        let desc : UILabel = {
            let label = UILabel()
            label.text = "Description"
            label.textColor = UIColor(hex: "#475467")
            label.font = .systemFont(ofSize: 14)
            
            return label
        }()
        
        [projectName, projectRole, projectDescription, projectResponsibility, editButton, deleteButton, role, resp, desc].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            projectName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            projectName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            projectName.heightAnchor.constraint(equalToConstant: 20),
            projectName.widthAnchor.constraint(lessThanOrEqualToConstant: 310),
            
            role.topAnchor.constraint(equalTo: projectName.bottomAnchor, constant: 10),
            role.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            projectRole.topAnchor.constraint(equalTo: role.bottomAnchor, constant: 6),
            projectRole.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            projectRole.widthAnchor.constraint(lessThanOrEqualToConstant: 310),
            
            desc.topAnchor.constraint(equalTo: projectRole.bottomAnchor, constant: 10),
            desc.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        
            projectDescription.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 6),
            projectDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            projectDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            projectDescription.heightAnchor.constraint(equalToConstant: 40),
            
            resp.topAnchor.constraint(equalTo: projectDescription.bottomAnchor, constant: 10),
            resp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            projectResponsibility.topAnchor.constraint(equalTo: resp.bottomAnchor, constant: 4),
            projectResponsibility.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            projectResponsibility.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            projectResponsibility.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13),
            editButton.widthAnchor.constraint(equalToConstant: 20),
            editButton.heightAnchor.constraint(equalToConstant: 20),
            
            deleteButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            deleteButton.widthAnchor.constraint(equalToConstant: 24),
            deleteButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}
