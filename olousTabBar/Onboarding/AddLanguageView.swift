//
//  AddLanguageView.swift
//  olousTabBar
//
//  Created by Salt Technologies on 03/04/24.
//

import UIKit

class AddLanguageView: UIView {
    
    // Labels for displaying "Language" and "Fluency"
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Language"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = UIColor(hex: "#344054")
        return label
    }()
    let container1 : UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.borderWidth = 1 // Add border to the container
        container.layer.cornerRadius = 5 // Add corner radius for rounded corners
        container.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor // Set border color
        
        return container
    }()
    let languagePlaceholder : UILabel = {
        let label = UILabel()
        label.text = "Select Language"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    var selectLanguageButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = UIColor(hex: "#667085")
        return button
    }()
    var languageArray = ["English", "Hindi", "Marathi", "Puneri Marathi"]
    var languageTableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        tableView.isHidden = true
        return tableView
    }()
    
    private let fluencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fluency"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = UIColor(hex: "#344054")
        return label
    }()
    let container2 : UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.borderWidth = 1 // Add border to the container
        container.layer.cornerRadius = 5 // Add corner radius for rounded corners
        container.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor // Set border color
        
        return container
    }()
    let fluencyPlaceholder : UILabel = {
        let label = UILabel()
        label.text = "Select Fluency"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    var selectFluencyButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = UIColor(hex: "#667085")
        return button
    }()
    var fluencyArray = ["Beginner", "Professional", "Native", "Kuch nhi aata"]
    var fluencyTableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        tableView.isHidden = true
        return tableView
    }()
    
    
    // Custom initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        languageTableView.delegate = self
        languageTableView.dataSource = self
        
        fluencyTableView.delegate = self
        fluencyTableView.dataSource = self
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    // Setup subviews and constraints
    private func setupSubviews() {
        addSubview(languageLabel)
        addSubview(fluencyLabel)
        
        addSubview(container1)
        addSubview(container2)
        
        [selectLanguageButton, languagePlaceholder].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            container1.addSubview(v)
        }
        languageTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(languageTableView)
        
        
        [selectFluencyButton, fluencyPlaceholder].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            container2.addSubview(v)
        }
        fluencyTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(fluencyTableView)
        
        
        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            languageLabel.topAnchor.constraint(equalTo: topAnchor),
            
            fluencyLabel.topAnchor.constraint(equalTo: topAnchor),
            fluencyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 186),
            fluencyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            container1.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 10),
            container1.leadingAnchor.constraint(equalTo: leadingAnchor), // Replace view with self
            container1.widthAnchor.constraint(equalToConstant: 166), // Replace view with self
            container1.heightAnchor.constraint(equalToConstant: 50),
            
            container2.topAnchor.constraint(equalTo: container1.topAnchor, constant: 0),
            container2.leadingAnchor.constraint(equalTo: container1.trailingAnchor, constant: 20),
            container2.widthAnchor.constraint(equalToConstant: 176), // Replace view with self
            container2.heightAnchor.constraint(equalToConstant: 50),
            
            languagePlaceholder.centerYAnchor.constraint(equalTo: container1.centerYAnchor),
            languagePlaceholder.leadingAnchor.constraint(equalTo: container1.leadingAnchor, constant: 10),
            
            selectLanguageButton.centerYAnchor.constraint(equalTo: container1.centerYAnchor),
            selectLanguageButton.trailingAnchor.constraint(equalTo: container1.trailingAnchor, constant: -5),
            selectLanguageButton.widthAnchor.constraint(equalToConstant: 30),
            
            languageTableView.topAnchor.constraint(equalTo: container1.bottomAnchor, constant: 10),
            languageTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            languageTableView.widthAnchor.constraint(equalToConstant: 166),
            languageTableView.heightAnchor.constraint(equalToConstant: 100),
            
            fluencyPlaceholder.centerYAnchor.constraint(equalTo: container2.centerYAnchor),
            fluencyPlaceholder.leadingAnchor.constraint(equalTo: container2.leadingAnchor, constant: 10),
            
            selectFluencyButton.centerYAnchor.constraint(equalTo: container2.centerYAnchor),
            selectFluencyButton.trailingAnchor.constraint(equalTo: container2.trailingAnchor, constant: -10),
            selectFluencyButton.widthAnchor.constraint(equalToConstant: 30),
            
            fluencyTableView.topAnchor.constraint(equalTo: container2.bottomAnchor, constant: 10),
            fluencyTableView.leadingAnchor.constraint(equalTo: container2.leadingAnchor),
            fluencyTableView.widthAnchor.constraint(equalToConstant: 176),
            fluencyTableView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        selectLanguageButton.addTarget(self, action: #selector(selectLanguageButtonTapped(_:)), for: .touchUpInside)
        selectFluencyButton.addTarget(self, action: #selector(selectFluencyButtonTapped(_:)), for: .touchUpInside)
    }
    @objc func selectLanguageButtonTapped(_ sender : UIButton) {
        if sender.imageView?.image == UIImage(systemName: "chevron.down") {
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            languageTableView.isHidden = false
//            scrollView.bringSubviewToFront(startTableView)
        }
        else {
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            languageTableView.isHidden = true
        }
    }
    
    @objc func selectFluencyButtonTapped(_ sender : UIButton) {
        if sender.imageView?.image == UIImage(systemName: "chevron.down") {
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            fluencyTableView.isHidden = false
//            scrollView.bringSubviewToFront(startTableView)
        }
        else {
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            fluencyTableView.isHidden = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension AddLanguageView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case languageTableView:
            return languageArray.count
        case fluencyTableView:
            return fluencyArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if tableView == languageTableView {
            cell.textLabel?.text = languageArray[indexPath.row]
        }
        else {
            cell.textLabel?.text = fluencyArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == languageTableView {
            languagePlaceholder.text = languageArray[indexPath.row]
            languagePlaceholder.textColor = .black
            languageTableView.isHidden = true
            selectLanguageButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        else {
            fluencyPlaceholder.text = fluencyArray[indexPath.row]
            fluencyPlaceholder.textColor = .black
            fluencyTableView.isHidden = true
            selectFluencyButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

