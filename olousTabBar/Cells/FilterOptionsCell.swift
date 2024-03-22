//
//  FilterOptionsCell.swift
//  olousTabBar
//
//  Created by Salt Technologies on 22/03/24.
//

import UIKit

class FilterOptionsCell: UITableViewCell {

    let checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.backgroundColor = .systemBackground
        return button
    }()
    
    var isChecked = false
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(checkboxButton)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 25),
            checkboxButton.heightAnchor.constraint(equalToConstant: 25),
        ])
        
//        checkboxButton.addTarget(self, action: #selector(checkboxTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func checkboxTapped(_ sender: UIButton) {
        if isChecked {
            checkboxButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            checkboxButton.tintColor = .white
            checkboxButton.backgroundColor = UIColor(hex: "#0079C4")
        } else {
            checkboxButton.setImage(UIImage(systemName: ""), for: .normal)
            checkboxButton.backgroundColor = .white
        }
        
        isChecked = !isChecked
    }

}
