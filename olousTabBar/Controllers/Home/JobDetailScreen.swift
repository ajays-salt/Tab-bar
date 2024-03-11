//
//  JobDetailScreen.swift
//  olousTabBar
//
//  Created by Salt Technologies on 11/03/24.
//

import UIKit

class JobDetailScreen: UIViewController {
    
    var scrollView : UIScrollView!
    var headerView : UIView!
    
    let jobTitle: UILabel = {
        let label = UILabel()
        label.text = "Design Coordinator"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let companyName: UILabel = {
        let label = UILabel()
        label.text = "Osumare Marketing Solutions"
        label.textColor = UIColor(hex: "#475467")
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let jobLocationLabel : UILabel = {
        let label = UILabel()
        label.text = "Pune, Maharashtra"
        label.textColor = UIColor(hex: "#475467")
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let jobExperienceLabel : UILabel = {
        let label = UILabel()
        label.tintColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let saveButton = UIButton(type: .system)
    let applyButton = UIButton(type: .system)
    
    let separatorLine1 = UIView()
    let descriptionView = UIView()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        shareButton.image = UIImage(systemName: "")
        navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc func shareButtonTapped() {
        // Handle share button tap
        print("Share button tapped")
    }
    
    func setupViews() {
        setupScrollView()
        setupHeaderView()
        setupSeparatorLine1()
        setupDescriptionView()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let extraSpaceHeight: CGFloat = 100
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    func setupHeaderView() {
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        jobTitle.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(jobTitle)
        
        NSLayoutConstraint.activate([
            jobTitle.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            jobTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            jobTitle.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 0),
            jobTitle.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        companyName.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(companyName)
        
        NSLayoutConstraint.activate([
            companyName.topAnchor.constraint(equalTo: jobTitle.bottomAnchor, constant: 4),
            companyName.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            companyName.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 0),
            companyName.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        let locationIcon : UIImageView = UIImageView()
        locationIcon.image = UIImage(named: "locationLogo")
        locationIcon.tintColor = UIColor(hex: "#667085")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(locationIcon)
        
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 16),
            locationIcon.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            locationIcon.widthAnchor.constraint(equalToConstant: 16),
            locationIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        jobLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(jobLocationLabel)
        
        NSLayoutConstraint.activate([
            jobLocationLabel.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 16),
            jobLocationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 6),
            jobLocationLabel.widthAnchor.constraint(equalToConstant: 125),
            jobLocationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
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
        jobExperienceLabel.tintColor = UIColor(hex: "#667085")
        
        headerView.addSubview(jobExperienceLabel)
        
        NSLayoutConstraint.activate([
            jobExperienceLabel.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 16),
            jobExperienceLabel.leadingAnchor.constraint(equalTo: jobLocationLabel.trailingAnchor, constant: 6),
            jobExperienceLabel.widthAnchor.constraint(equalToConstant: 100),
            jobExperienceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    
        setupSaveButton()
        setupApplyButton()
    }
    func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        saveButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        saveButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 12
        saveButton.clipsToBounds = true
        saveButton.titleLabel?.textAlignment = .center
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: jobLocationLabel.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            saveButton.widthAnchor.constraint(equalToConstant: 65),
            saveButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupApplyButton() {
        applyButton.setTitle("Apply", for: .normal)
        applyButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        applyButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        applyButton.backgroundColor = UIColor(hex: "#0079C4")
        applyButton.layer.cornerRadius = 12
        applyButton.clipsToBounds = true
        applyButton.titleLabel?.textAlignment = .center
        
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(applyButton)
        
        NSLayoutConstraint.activate([
            applyButton.topAnchor.constraint(equalTo: jobLocationLabel.bottomAnchor, constant: 20),
            applyButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 16),
            applyButton.widthAnchor.constraint(equalToConstant: 75),
            applyButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupSeparatorLine1() {
        separatorLine1.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine1.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine1)
        
        NSLayoutConstraint.activate([
            separatorLine1.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            separatorLine1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine1.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupDescriptionView() {
//        descriptionView.backgroundColor = .systemGray5
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(descriptionView)
        
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: separatorLine1.bottomAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionView.heightAnchor.constraint(equalToConstant: 254)
        ])
        
        let rolesLabel = UILabel()
        rolesLabel.text = "Roles and Responsibilities :"
        rolesLabel.font = .boldSystemFont(ofSize: 14)
        rolesLabel.tintColor = UIColor(hex: "#101828")
        
        rolesLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.addSubview(rolesLabel)
        
        NSLayoutConstraint.activate([
            rolesLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 10),
            rolesLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 16),
            rolesLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor),
            rolesLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
    
}
