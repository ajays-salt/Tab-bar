//
//  ProjectCell.swift
//  olousTabBar
//
//  Created by Salt Technologies on 08/04/24.
//

import UIKit

class ProjectCell: UICollectionViewCell {
    
    var projectName: UILabel = {
        let label = UILabel()
        label.text = "NA"
        label.textColor = UIColor(hex: "#101828")
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let projectRole: UILabel = {
        let label = UILabel()
        label.text = "Salt Technologies"
        label.textColor = UIColor(hex: "#101828")
        label.font = UIFont.systemFont(ofSize: 18)
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
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = UIColor(hex: "#667085")
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        [projectName, projectRole, projectDescription, projectResponsibility, deleteButton].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            projectName.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            projectName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            projectName.heightAnchor.constraint(equalToConstant: 20),
            projectName.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            
            projectRole.topAnchor.constraint(equalTo: projectName.bottomAnchor, constant: 6),
            projectRole.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            projectRole.widthAnchor.constraint(lessThanOrEqualToConstant: 280),
        
            projectDescription.topAnchor.constraint(equalTo: projectRole.bottomAnchor, constant: 6),
            projectDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            projectDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            projectDescription.heightAnchor.constraint(equalToConstant: 40),
            
            projectResponsibility.topAnchor.constraint(equalTo: projectDescription.bottomAnchor, constant: 4),
            projectResponsibility.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            projectResponsibility.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            projectResponsibility.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
}
