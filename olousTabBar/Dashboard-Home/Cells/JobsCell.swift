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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let companyName: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let jobLocationLabel : UILabel = {
        let label = UILabel()
        label.text = "Pune, Maharashtra"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobExperienceLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#475467")
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
        setupJobTitle()
        setupCompanyName()
        setupLocationView()
        setupExperienceLabel()
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
    
    func setupSaveButton() {
        
        let attributedString = NSMutableAttributedString()
        
        let symbolAttachment = NSTextAttachment()
        symbolAttachment.image = UIImage(systemName: "bookmark")?.withTintColor(UIColor(hex: "#475467"))
        
        let symbolString = NSAttributedString(attachment: symbolAttachment)
        attributedString.append(symbolString)
        
        attributedString.append(NSAttributedString(string: " "))
        
        let textString = NSAttributedString(string: "Save")
        attributedString.append(textString)
        
        saveButton.setAttributedTitle(attributedString, for: .normal)
        saveButton.tintColor = UIColor(hex: "#475467")
        
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 270),
            saveButton.widthAnchor.constraint(equalToConstant: 70),
            saveButton.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func setupJobTitle() {
        addSubview(jobTitle)
        NSLayoutConstraint.activate([
            jobTitle.topAnchor.constraint(equalTo: topAnchor, constant: 74),
            jobTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            //            jobTitle.widthAnchor.constraint(equalToConstant: 196),
            jobTitle.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupCompanyName() {
        addSubview(companyName)
        NSLayoutConstraint.activate([
            companyName.topAnchor.constraint(equalTo: topAnchor, constant: 98),
            companyName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            companyName.widthAnchor.constraint(equalToConstant: 232),
            companyName.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func setupLocationView() {
        let locationIcon : UIImageView = UIImageView()
        locationIcon.image = UIImage(named: "locationLogo")
        locationIcon.tintColor = UIColor(hex: "#667085")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationIcon)
        
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: topAnchor, constant: 128),
            locationIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            locationIcon.widthAnchor.constraint(equalToConstant: 16),
            locationIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        jobLocationLabel.numberOfLines = 2
        addSubview(jobLocationLabel)
        NSLayoutConstraint.activate([
            jobLocationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 128),
            jobLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            //            jobLocationLabel.widthAnchor.constraint(equalToConstant: 125),
//            jobLocationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        if let locationText = jobLocationLabel.text, locationText.count > 25 {
            // If text exceeds 20 characters, set a fixed width of 150
            jobLocationLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        } else {
            // If text is within 20 characters, don't set a fixed width
            jobLocationLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
        }
    }
    
    func setupExperienceLabel() {
        let attributedString = NSMutableAttributedString()
        
        attributedString.append(NSAttributedString(string: "|"))
        
        attributedString.append(NSAttributedString(string: "  "))
        
        let symbolAttachment = NSTextAttachment()
        symbolAttachment.image = UIImage(systemName: "briefcase")?.withTintColor(UIColor(hex: "#667085"))
        
        let symbolString = NSAttributedString(attachment: symbolAttachment)
        attributedString.append(symbolString)
        
        attributedString.append(NSAttributedString(string: " "))
        
        let textString = NSAttributedString(string: "1-5 years")
        attributedString.append(textString)
        
        jobExperienceLabel.attributedText = attributedString
        jobExperienceLabel.font = .systemFont(ofSize: 14)
        jobExperienceLabel.tintColor = UIColor(hex: "#667085")
        
        jobExperienceLabel.numberOfLines = 2
        addSubview(jobExperienceLabel)
        
        NSLayoutConstraint.activate([
            jobExperienceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 126),
            jobExperienceLabel.leadingAnchor.constraint(equalTo: jobLocationLabel.trailingAnchor, constant: 8),
            jobExperienceLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8)
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
            jobPostedTime.topAnchor.constraint(equalTo: topAnchor, constant: 166),
            jobPostedTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            //            jobPostedTime.widthAnchor.constraint(equalToConstant: 76),
            jobPostedTime.heightAnchor.constraint(equalToConstant: 20),
            
            appliedLabel.topAnchor.constraint(equalTo: jobPostedTime.topAnchor),
            appliedLabel.leadingAnchor.constraint(equalTo: jobPostedTime.trailingAnchor, constant: 20),
            
        ])
    }
}

