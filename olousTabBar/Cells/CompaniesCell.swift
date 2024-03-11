//
//  CompaniesCell.swift
//  olousTabBar
//
//  Created by Ajay Sarkate on 04/03/24.
//

import UIKit

class CompaniesCell: UICollectionViewCell {
    // Customize your cell as needed
    let companyName: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.artframe")
        return imageView
    }()
    
    let jobLocationLabel : UILabel = {
        let label = UILabel()
        label.text = "Pune, Maharashtra"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
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
        setupCompanyName()
        setupCompanyLogo()
        setupLocationView()
    }
    
    func setupCompanyLogo() {
        companyLogo.translatesAutoresizingMaskIntoConstraints = false
        addSubview(companyLogo)
        NSLayoutConstraint.activate([
            companyLogo.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            companyLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            companyLogo.widthAnchor.constraint(equalToConstant: 48),
            companyLogo.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    func setupCompanyName() {
        addSubview(companyName)
        NSLayoutConstraint.activate([
            companyName.topAnchor.constraint(equalTo: topAnchor, constant: 74),
            companyName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            companyName.widthAnchor.constraint(equalToConstant: 196),
            companyName.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupLocationView() {
        let locationIcon : UIImageView = UIImageView()
        locationIcon.image = UIImage(named: "locationLogo")
        locationIcon.tintColor = UIColor(hex: "#667085")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationIcon)
        
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: topAnchor, constant: 108),
            locationIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            locationIcon.widthAnchor.constraint(equalToConstant: 16),
            locationIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        addSubview(jobLocationLabel)
        NSLayoutConstraint.activate([
            jobLocationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 108),
            jobLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            jobLocationLabel.widthAnchor.constraint(equalToConstant: 125),
            jobLocationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let viewJobs = UILabel()
        viewJobs.text = "View Jobs"
        viewJobs.font = .boldSystemFont(ofSize: 14)
        viewJobs.textColor = UIColor(hex: "#0079C4")
        
        viewJobs.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewJobs)
        NSLayoutConstraint.activate([
            viewJobs.topAnchor.constraint(equalTo: topAnchor, constant: 146),
            viewJobs.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            viewJobs.widthAnchor.constraint(equalToConstant: 76),
            viewJobs.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
