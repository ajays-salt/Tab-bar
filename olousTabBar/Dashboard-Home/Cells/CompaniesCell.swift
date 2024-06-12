//
//  CompaniesCell.swift
//  olousTabBar
//
//  Created by Ajay Sarkate on 04/03/24.
//

import UIKit

class CompaniesCell: UICollectionViewCell {
    
    let companyLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.artframe")
        return imageView
    }()
    
    let companyName: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    let jobLocationLabel : UILabel = {
        let label = UILabel()
        label.text = "Pune, Maharashtra"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Developer"
        label.textColor = UIColor(hex: "#101828")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let sectorLabel : UILabel = {
        let label = UILabel()
        label.text = "Industrial"
        label.textColor = UIColor(hex: "#101828")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let fieldLabel : UILabel = {
        let label = UILabel()
        label.text = "Structural Consultant"
        label.textColor = UIColor(hex: "#101828")
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
    
    private func setupViews() {
        setupCompanyLogoAndName()
        setupLocationView()
        
        setupCategory()
        setupSector()
        setupField()
        
        setupViewJobs()
    }
    
    func setupCompanyLogoAndName() {
        companyLogo.translatesAutoresizingMaskIntoConstraints = false
        addSubview(companyLogo)
        addSubview(companyName)
        NSLayoutConstraint.activate([
            companyLogo.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            companyLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            companyLogo.widthAnchor.constraint(equalToConstant: 48),
            companyLogo.heightAnchor.constraint(equalToConstant: 46),
            
            companyName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            companyName.leadingAnchor.constraint(equalTo: companyLogo.trailingAnchor, constant: 16)
        ])
    }
    
    func setupLocationView() {
        let locationIcon : UIImageView = UIImageView()
        locationIcon.image = UIImage(named: "locationLogo")
        locationIcon.tintColor = UIColor(hex: "#667085")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationIcon)
        
        addSubview(jobLocationLabel)
        
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 10),
            locationIcon.leadingAnchor.constraint(equalTo: companyLogo.trailingAnchor, constant: 16),
            locationIcon.widthAnchor.constraint(equalToConstant: 16),
            locationIcon.heightAnchor.constraint(equalToConstant: 20),
            
            jobLocationLabel.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 10),
            jobLocationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 8)
        ])
    }
    
    
    func setupCategory() {
        let locationIcon : UIImageView = UIImageView()
        locationIcon.image = UIImage(systemName: "square.2.layers.3d")
        locationIcon.tintColor = UIColor(hex: "#667085")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationIcon)
        
        let label = UILabel()
        label.text = "Category"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: jobLocationLabel.bottomAnchor, constant: 20),
            locationIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            locationIcon.widthAnchor.constraint(equalToConstant: 16),
            locationIcon.heightAnchor.constraint(equalToConstant: 20),
            
            label.topAnchor.constraint(equalTo: jobLocationLabel.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            
            categoryLabel.topAnchor.constraint(equalTo: jobLocationLabel.bottomAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setupSector() {
        let rupeesIcon : UIImageView = UIImageView()
        rupeesIcon.image = UIImage(systemName: "briefcase")
        rupeesIcon.tintColor = UIColor(hex: "#667085")
        rupeesIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rupeesIcon)
        
        let label = UILabel()
        label.text = "Sector"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        sectorLabel.numberOfLines = 2
        addSubview(sectorLabel)
        NSLayoutConstraint.activate([
            rupeesIcon.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            rupeesIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            rupeesIcon.widthAnchor.constraint(equalToConstant: 14),
            rupeesIcon.heightAnchor.constraint(equalToConstant: 16),
            
            label.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            
            sectorLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            sectorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120),
            sectorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
    }
    
    func setupField() {
        let clockIcon : UIImageView = UIImageView()
        clockIcon.image = UIImage(systemName: "compass.drawing")
        clockIcon.tintColor = UIColor(hex: "#667085")
        clockIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(clockIcon)
        
        let label = UILabel()
        label.text = "Field"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        fieldLabel.numberOfLines = 2
        addSubview(fieldLabel)
        NSLayoutConstraint.activate([
            clockIcon.topAnchor.constraint(equalTo: sectorLabel.bottomAnchor, constant: 10),
            clockIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            clockIcon.widthAnchor.constraint(equalToConstant: 14),
            clockIcon.heightAnchor.constraint(equalToConstant: 16),
            
            label.topAnchor.constraint(equalTo: sectorLabel.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            
            fieldLabel.topAnchor.constraint(equalTo: sectorLabel.bottomAnchor, constant: 10),
            fieldLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120),
            fieldLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    
    func setupViewJobs() {
        let view = UIView()
        view.layer.borderColor = UIColor(hex: "#2563EB").cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        let viewJobs = UILabel()
        viewJobs.text = "View Jobs"
        viewJobs.font = .boldSystemFont(ofSize: 14)
        viewJobs.textColor = UIColor(hex: "#2563EB")
        
        viewJobs.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewJobs)
        
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            view.widthAnchor.constraint(equalToConstant: 100),
            view.heightAnchor.constraint(equalToConstant: 30),
            
            viewJobs.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewJobs.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
