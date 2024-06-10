//
//  JobsCell.swift
//  olousTabBar
//
//  Created by Salt Technologies on 05/03/24.
//

import UIKit

class JobsCell: UICollectionViewCell {
    let companyLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.tintColor = .systemRed
        return imageView
    }()
    
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
    let workPlaceView = UIView()
    let workPlaceLabel : UILabel = {
        let label = UILabel()
        label.text = "NA"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let jobLocationLabel : UILabel = {
        let label = UILabel()
        label.text = "Pune, Maharashtra"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let salaryLabel : UILabel = {
        let label = UILabel()
        label.text = "NA"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let jobTypeLabel : UILabel = {
        let label = UILabel()
        label.text = "NA"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let jobExperienceLabel : UILabel = {
        let label = UILabel()
        label.text = "NA"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobPostedTime = UILabel()
    
    let saveButton = UIButton(type: .system)
    
    let appliedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Create the text part
        let appliedText = NSAttributedString(string: "Applied ", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(hex: "#067647")
        ])
        
        // Create the tickmark image part
        let tickmarkImage = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(UIColor(hex: "#067647"), renderingMode: .alwaysOriginal)
        let tickmarkAttachment = NSTextAttachment()
        tickmarkAttachment.image = tickmarkImage
        
        // Adjust the bounds of the image to match the text height
        let tickmarkImageOffsetY: CGFloat = -2.0
        tickmarkAttachment.bounds = CGRect(x: 0, y: tickmarkImageOffsetY, width: 14, height: 14)
        
        // Combine text and image into one attributed string
        let completeText = NSMutableAttributedString()
        completeText.append(appliedText)
        completeText.append(NSAttributedString(attachment: tickmarkAttachment))
        
        // Set the attributed text to the label
        label.attributedText = completeText
        
        label.isHidden = true
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
        setupCompanyLogo()
        setupJobTitleAndCompanyName()
        setupWorkplaceView()
        setupLocationView()
        setupSalary()
        setupJobtype()
        setupExperienceLabel()
        setupBottomView()
        setupSaveButton()
        setupDatePostedAndAppliedButton()
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
    
    func setupJobTitleAndCompanyName() {
        addSubview(jobTitle)
        addSubview(companyName)
        NSLayoutConstraint.activate([
            jobTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            jobTitle.leadingAnchor.constraint(equalTo: companyLogo.trailingAnchor, constant: 16),
            jobTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            companyName.topAnchor.constraint(equalTo: jobTitle.bottomAnchor, constant: 6),
            companyName.leadingAnchor.constraint(equalTo: companyLogo.trailingAnchor, constant: 16),
            companyName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func setupWorkplaceView() {
        workPlaceView.backgroundColor = UIColor(hex: "#F9FAFB")
        workPlaceView.layer.cornerRadius = 8
        workPlaceView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(workPlaceView)
        
        workPlaceView.addSubview(workPlaceLabel)
        
        NSLayoutConstraint.activate([
            workPlaceView.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 10),
            workPlaceView.leadingAnchor.constraint(equalTo: companyName.leadingAnchor),
            workPlaceView.heightAnchor.constraint(equalToConstant: 24),
            
            workPlaceLabel.centerXAnchor.constraint(equalTo: workPlaceView.centerXAnchor),
            workPlaceLabel.centerYAnchor.constraint(equalTo: workPlaceView.centerYAnchor),
        ])
        if workPlaceLabel.text?.count ?? 0 <= 14 {
            workPlaceView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
        else {
            workPlaceView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        }
    }
    
    func setupLocationView() {
        let locationIcon : UIImageView = UIImageView()
        locationIcon.image = UIImage(named: "locationLogo")
        locationIcon.tintColor = UIColor(hex: "#667085")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationIcon)
        
        jobLocationLabel.numberOfLines = 2
        addSubview(jobLocationLabel)
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: workPlaceView.bottomAnchor, constant: 10),
            locationIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            locationIcon.widthAnchor.constraint(equalToConstant: 16),
            locationIcon.heightAnchor.constraint(equalToConstant: 20),
            
            jobLocationLabel.topAnchor.constraint(equalTo: workPlaceView.bottomAnchor, constant: 10),
            jobLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
        ])
        
//        if let locationText = jobLocationLabel.text, locationText.count > 25 {
//            jobLocationLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
//        } else {
//            jobLocationLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
//        }
    }
    
    func setupSalary() {
        let rupeesIcon : UIImageView = UIImageView()
        rupeesIcon.image = UIImage(systemName: "indianrupeesign")
        rupeesIcon.tintColor = UIColor(hex: "#667085")
        rupeesIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rupeesIcon)
        
        salaryLabel.numberOfLines = 2
        addSubview(salaryLabel)
        NSLayoutConstraint.activate([
            rupeesIcon.topAnchor.constraint(equalTo: jobLocationLabel.bottomAnchor, constant: 10),
            rupeesIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            rupeesIcon.widthAnchor.constraint(equalToConstant: 14),
            rupeesIcon.heightAnchor.constraint(equalToConstant: 16),
            
            salaryLabel.topAnchor.constraint(equalTo: jobLocationLabel.bottomAnchor, constant: 10),
            salaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
        ])
        
        if let locationText = salaryLabel.text, locationText.count > 25 {
            salaryLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        } else {
            salaryLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
        }
    }
    
    func setupJobtype() {
        let clockIcon : UIImageView = UIImageView()
        clockIcon.image = UIImage(systemName: "clock")
        clockIcon.tintColor = UIColor(hex: "#667085")
        clockIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(clockIcon)
        
        jobTypeLabel.numberOfLines = 2
        addSubview(jobTypeLabel)
        NSLayoutConstraint.activate([
            clockIcon.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 10),
            clockIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            clockIcon.widthAnchor.constraint(equalToConstant: 14),
            clockIcon.heightAnchor.constraint(equalToConstant: 16),
            
            jobTypeLabel.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 10),
            jobTypeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
        ])
        
        if let locationText = jobTypeLabel.text, locationText.count > 25 {
            jobTypeLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        } else {
            jobTypeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
        }
    }
    
    func setupExperienceLabel() {
        let expIcon : UIImageView = UIImageView()
        expIcon.image = UIImage(systemName: "briefcase")
        expIcon.tintColor = UIColor(hex: "#667085")
        expIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(expIcon)
        
        jobExperienceLabel.numberOfLines = 2
        addSubview(jobExperienceLabel)
        NSLayoutConstraint.activate([
            expIcon.topAnchor.constraint(equalTo: jobTypeLabel.bottomAnchor, constant: 9),
            expIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            expIcon.widthAnchor.constraint(equalToConstant: 16),
            expIcon.heightAnchor.constraint(equalToConstant: 16),
            
            jobExperienceLabel.topAnchor.constraint(equalTo: jobTypeLabel.bottomAnchor, constant: 8),
            jobExperienceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            jobExperienceLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8)
        ])
        
        if let locationText = jobExperienceLabel.text, locationText.count > 25 {
            jobExperienceLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        } else {
            jobExperienceLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
        }
    }
    
    func setupBottomView() {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor(hex: "#F9FAFB")
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomView)
        sendSubviewToBack(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setupSaveButton() {
        
        let attributedString = NSMutableAttributedString()
        
        let symbolAttachment = NSTextAttachment()
        symbolAttachment.image = UIImage(systemName: "bookmark")?.withTintColor(UIColor(hex: "#2563EB"))
        
//        attributedString.append(NSAttributedString(string: " "))
//        
//        let textString = NSAttributedString(string: "Save")
//        attributedString.append(textString)
        
        saveButton.setAttributedTitle(attributedString, for: .normal)
        saveButton.tintColor = UIColor(hex: "#2563EB")
        
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -10),
            saveButton.widthAnchor.constraint(equalToConstant: 70),
            saveButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    func setupDatePostedAndAppliedButton() {
        jobPostedTime.text = "1h ago"
        jobPostedTime.font = .systemFont(ofSize: 12)
        jobPostedTime.textColor = UIColor(hex: "#667085")
        
        jobPostedTime.translatesAutoresizingMaskIntoConstraints = false
        addSubview(jobPostedTime)
        
        addSubview(appliedLabel)
        
        NSLayoutConstraint.activate([
            jobPostedTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            jobPostedTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            //            jobPostedTime.widthAnchor.constraint(equalToConstant: 76),
            jobPostedTime.heightAnchor.constraint(equalToConstant: 20),
            
            appliedLabel.topAnchor.constraint(equalTo: jobPostedTime.topAnchor),
            appliedLabel.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 20),
            
        ])
    }
}

