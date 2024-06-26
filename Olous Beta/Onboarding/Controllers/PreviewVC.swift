//
//  PreviewVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 23/05/24.
//


import UIKit

class PreviewVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    var topHeaderView = UIView()
    
    let scrollView = UIScrollView()
    
    var headerView = UIView()
    
    let profileCircle = UIView()
    var profileImageView : UIImageView!
    
    let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Ajay Sarkate"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()
    let jobTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.textColor = UIColor(hex: "#475467")
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    let locationLabel : UILabel = {
        let label = UILabel()
        label.text = "Pune, Maharashtra"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    
    var contactInfoView = UIView()
    var emailLabel : UILabel!
    var mobileLabel : UILabel!
    
    
    var headlineView = UIView()
    let headlineLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "#475467")
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let summaryLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "#475467")
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var empView = UIView()
    
    
    var projectView = UIView()
    
    
    var educationView = UIView()
    
    
    var softwareView = UIView()
    
    
    var skillsView = UIView()
    
    
    var personalInfoView = UIView()
    
    
    var preferenceView = UIView()
    
    
//   *************************************************  New changes in this controller ******************************************************
    
    var employmentCV : UICollectionView!
    var empDataArray : [Employment] = []
    var employmentCVHeightConstraint: NSLayoutConstraint!
    
    
    var educationCV : UICollectionView!
    var eduDataArray : [Education] = []
    var educationCVHeightConstraint: NSLayoutConstraint!
    
    
    var projectCV : UICollectionView!
    var projectDataArray : [Project] = []
    var projectCVHeightConstraint: NSLayoutConstraint!
    
    
    let preferencesVC = PreferencesVC()
    let headlineVC = HeadlineAndSummary()
    
    var softwaresArray : [String] = []
    var skillsArray : [String] = []
    
    
    var bottomView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
//        fetchUserProfile()
                
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUserProfile()
    }
    
    
    func setupViews() {
        setupTopHeaderView()
        
        setupScrollView()
        
        setupHeaderView()
        
        setupContactInfo()
        
        setupHeadline()
        
        setupEmploymentView()
        
        setupProjectView()
        
        setupEducationView()
        
        setupSoftwares()
        
        setupSkills()
        
        setupPersonalInfoView()
        
        setupPreferencesView()
        
        setupBottomView()
    }
    
    func setupTopHeaderView() {
        topHeaderView = UIView()
        topHeaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topHeaderView)
        
        var stepsLabel = UILabel()
        stepsLabel.text = "Steps"
        stepsLabel.textColor = UIColor(hex: "#1D2026")
        stepsLabel.font = .boldSystemFont(ofSize: 24)
        stepsLabel.translatesAutoresizingMaskIntoConstraints = false
        topHeaderView.addSubview(stepsLabel)
        
        var stepsScrollView = UIScrollView()
        stepsScrollView.showsHorizontalScrollIndicator = false
        stepsScrollView.contentSize = CGSize(width: view.frame.width * 3, height: 300)
        stepsScrollView.contentOffset = CGPoint(x: 600, y: 0)
        stepsScrollView.translatesAutoresizingMaskIntoConstraints = false
        topHeaderView.addSubview(stepsScrollView)

        NSLayoutConstraint.activate([
            stepsLabel.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 0),
            stepsLabel.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: 16),
            
            stepsScrollView.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 36),
            stepsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stepsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stepsScrollView.heightAnchor.constraint(equalToConstant: 70)
        ])

        // Create step views
        let currentStepColor = UIColor(hex: "#2563EB")
        let completedStepColor = UIColor(hex: "#0B945B") // Green color for completed steps
        let upcomingStepColor = UIColor(hex: "#D0D5DD") // Gray color for upcoming steps

        let steps = [
            ("Add Basics", "Resume and Qualification"),
            ("Experience", "Experience and Software"),
            ("Projects", "Projects and Skills"),
            ("Personal Information", "Personal Details"),
            ("Preferences", "Preferences and Headline"),
            ("Preview", "Preview and Publish")
        ]

        var currentStepIndex = 5
        var completedStepIndex = 4
        var previousStepView: UIView?
        
        for (index, step) in steps.enumerated() {
            let isActive = index == currentStepIndex // Assuming you have the index of the current step
            
            let color: UIColor
            if isActive {
                color = currentStepColor
            } else if index <= completedStepIndex {
                color = completedStepColor
            } else {
                color = upcomingStepColor
            }
            
            let stepView = createStepView(title: step.0, subtitle: step.1, color: color)
            stepView.translatesAutoresizingMaskIntoConstraints = false
            stepsScrollView.addSubview(stepView)
            
            // Set constraints for stepView
            NSLayoutConstraint.activate([
                stepView.topAnchor.constraint(equalTo: stepsScrollView.topAnchor, constant: 0),
                stepView.widthAnchor.constraint(equalToConstant: 160),
                stepView.heightAnchor.constraint(equalToConstant: 260),
            ])
            
            // Align stepView horizontally to the previous stepView or to the scrollView's leading anchor
            if let previousStepView = previousStepView {
                stepView.leadingAnchor.constraint(equalTo: previousStepView.trailingAnchor, constant: 4).isActive = true
            } else {
                stepView.leadingAnchor.constraint(equalTo: stepsScrollView.leadingAnchor, constant: 16).isActive = true
            }
            
            previousStepView = stepView
        }
        
        // Add trailing constraint to scrollView's content view to ensure scrolling works correctly
        if let previousStepView = previousStepView {
            stepsScrollView.trailingAnchor.constraint(equalTo: previousStepView.trailingAnchor, constant: 16).isActive = true
        }
        
        // Create and configure the current step label
        let currentStepLabel = UILabel()
        currentStepLabel.text = "STEP 10 OF 10"
        currentStepLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        currentStepLabel.textColor = .gray
        topHeaderView.addSubview(currentStepLabel)
        currentStepLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the main step title
        let mainStepTitleLabel = UILabel()
        mainStepTitleLabel.text = "PREVIEW AND PUBLISH"
        mainStepTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        topHeaderView.addSubview(mainStepTitleLabel)
        mainStepTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress view
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(hex: "#0B945B")
        progressView.trackTintColor = UIColor(hex: "#E5E7EB")
        progressView.setProgress(0.99, animated: true)
        topHeaderView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress label
        let progressLabel = UILabel()
        progressLabel.text = "99%"
        progressLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        progressLabel.textColor = .gray
        topHeaderView.addSubview(progressLabel)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up constraints
        NSLayoutConstraint.activate([
            topHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            currentStepLabel.topAnchor.constraint(equalTo: stepsScrollView.bottomAnchor, constant: 20),
            currentStepLabel.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: 16),
            
            mainStepTitleLabel.topAnchor.constraint(equalTo: currentStepLabel.bottomAnchor, constant: 8),
            mainStepTitleLabel.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: 16),
            
            progressView.topAnchor.constraint(equalTo: mainStepTitleLabel.bottomAnchor, constant: 16),
            progressView.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: -52),
            
            progressLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: -16),
            
            topHeaderView.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 16)
        ])
    }
    
    func createStepView(title: String, subtitle: String, color: UIColor) -> UIView {
        let stepView = UIView()
        stepView.translatesAutoresizingMaskIntoConstraints = false
        
        var circle1 = UIView()
        circle1.layer.cornerRadius = 4
        circle1.backgroundColor = color
        circle1.translatesAutoresizingMaskIntoConstraints = false
        var circle2 = UIView()
        circle2.layer.cornerRadius = 8
        circle2.backgroundColor = color.withAlphaComponent(0.5)
        circle2.translatesAutoresizingMaskIntoConstraints = false
        
        var line = UIView()
        line.backgroundColor = color
        line.translatesAutoresizingMaskIntoConstraints = false
        stepView.addSubview(line)
        
        
        stepView.addSubview(circle2)
        stepView.addSubview(circle1)
        NSLayoutConstraint.activate([
            circle2.topAnchor.constraint(equalTo: stepView.topAnchor, constant: 8),
            circle2.leadingAnchor.constraint(equalTo: stepView.leadingAnchor, constant: 8),
            circle2.widthAnchor.constraint(equalToConstant: 16),
            circle2.heightAnchor.constraint(equalToConstant: 16),
            
            circle1.centerXAnchor.constraint(equalTo: circle2.centerXAnchor),
            circle1.centerYAnchor.constraint(equalTo: circle2.centerYAnchor),
            circle1.widthAnchor.constraint(equalToConstant: 8),
            circle1.heightAnchor.constraint(equalToConstant: 8),
            
            line.topAnchor.constraint(equalTo: stepView.topAnchor, constant: 15),
            line.leadingAnchor.constraint(equalTo: circle2.trailingAnchor, constant: 10),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.widthAnchor.constraint(equalToConstant: 120),
        ])
        
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = UIColor(hex: "#344054") // White text color for better visibility
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.textColor = UIColor(hex: "#475467") // White text color for better visibility
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stepView.addSubview(titleLabel)
        stepView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: stepView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: stepView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: stepView.trailingAnchor, constant: 0),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: stepView.leadingAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: stepView.trailingAnchor, constant: 0),
        ])
        
        return stepView
    }
    
    
    func setupScrollView() {
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topHeaderView.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
        
        let extraSpaceHeight: CGFloat = 2500
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    
    func setupHeaderView() {
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        headerView.layer.cornerRadius = 12
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        profileCircle.backgroundColor = UIColor(hex: "#D7F0FF")
        profileCircle.layer.cornerRadius = 50
        
        profileCircle.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(profileCircle)
        NSLayoutConstraint.activate([
            profileCircle.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            profileCircle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            profileCircle.widthAnchor.constraint(equalToConstant: 100),
            profileCircle.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        
        profileImageView = UIImageView()
//        profileImageView.isHidden = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50
        
        // Add the selected image view to the profile circle
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: profileCircle.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: profileCircle.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: profileCircle.trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: profileCircle.bottomAnchor)
        ])
        
        
        [userNameLabel, jobTitleLabel, locationLabel].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: profileCircle.topAnchor, constant: 0),
            userNameLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
//            userNameLabel.heightAnchor.constraint(equalToConstant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            jobTitleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 12),
            jobTitleLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
            jobTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            locationLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    
    func setupContactInfo() {
        contactInfoView.layer.borderWidth = 1
        contactInfoView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        contactInfoView.layer.cornerRadius = 12
        
        contactInfoView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contactInfoView)
        
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Contact Info"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        contactInfoView.addSubview(label)
        
        let mailIcon : UIImageView = UIImageView()
        mailIcon.image = UIImage(systemName: "envelope")
        mailIcon.tintColor = UIColor(hex: "#98A2B3")
        mailIcon.translatesAutoresizingMaskIntoConstraints = false
        contactInfoView.addSubview(mailIcon)
        
        let email = createStaticLabel()
        email.text = "Email"
        contactInfoView.addSubview(email)
        emailLabel = createDynamicLabel()
        emailLabel.numberOfLines = 2
        contactInfoView.addSubview(emailLabel)
        
        let phoneIcon : UIImageView = UIImageView()
        phoneIcon.image = UIImage(systemName: "phone")
        phoneIcon.tintColor = UIColor(hex: "#98A2B3")
        phoneIcon.translatesAutoresizingMaskIntoConstraints = false
        contactInfoView.addSubview(phoneIcon)
        
        let mobile = createStaticLabel()
        mobile.text = "Phone"
        contactInfoView.addSubview(mobile)
        mobileLabel = createDynamicLabel()
        contactInfoView.addSubview(mobileLabel)
        
        NSLayoutConstraint.activate([
            contactInfoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            contactInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contactInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contactInfoView.heightAnchor.constraint(equalToConstant: 200),
            
            label.topAnchor.constraint(equalTo: contactInfoView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: contactInfoView.leadingAnchor, constant: 20),
            
            mailIcon.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            mailIcon.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            
            email.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            email.leadingAnchor.constraint(equalTo: mailIcon.trailingAnchor, constant: 10),
            
            emailLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: contactInfoView.trailingAnchor, constant: -10),
            
            phoneIcon.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            phoneIcon.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            
            mobile.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            mobile.leadingAnchor.constraint(equalTo: phoneIcon.trailingAnchor, constant: 10),
            
            mobileLabel.topAnchor.constraint(equalTo: mobile.bottomAnchor, constant: 10),
            mobileLabel.leadingAnchor.constraint(equalTo: mobile.leadingAnchor),
            mobileLabel.trailingAnchor.constraint(equalTo: contactInfoView.trailingAnchor, constant: -10),
        ])
    }
    
    
    func setupHeadline() {
        headlineView.layer.borderWidth = 1
        headlineView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        headlineView.layer.cornerRadius = 12
        
        headlineView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headlineView)
        
        
        let headline : UILabel = {
            let label = UILabel()
            label.text = "Headline"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        headlineView.addSubview(headline)
        
        headlineView.addSubview(headlineLabel)
        
        let summary : UILabel = {
            let label = UILabel()
            label.text = "Summary"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        headlineView.addSubview(summary)
        
        headlineView.addSubview(summaryLabel)
        
        
        NSLayoutConstraint.activate([
            headlineView.topAnchor.constraint(equalTo: contactInfoView.bottomAnchor, constant: 20),
            headlineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headlineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            headline.topAnchor.constraint(equalTo: headlineView.topAnchor, constant: 20),
            headline.leadingAnchor.constraint(equalTo: headlineView.leadingAnchor, constant: 20),
            
            headlineLabel.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 10),
            headlineLabel.leadingAnchor.constraint(equalTo: headline.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: headlineView.trailingAnchor, constant: -10),
            
            summary.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 20),
            summary.leadingAnchor.constraint(equalTo: headlineView.leadingAnchor, constant: 20),
            
            summaryLabel.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: 10),
            summaryLabel.leadingAnchor.constraint(equalTo: summary.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: headlineView.trailingAnchor, constant: -10),
            
            headlineView.bottomAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10)
        ])
        
        
    }
    
    
    func setupEmploymentView() {
        empView.layer.borderWidth = 1
        empView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        empView.layer.cornerRadius = 12
        
        empView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(empView)
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Employment"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        empView.addSubview(label)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        employmentCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        employmentCV.register(EmploymentCell.self, forCellWithReuseIdentifier: "exp")
        employmentCV.delegate = self
        employmentCV.dataSource = self
        
        employmentCV.translatesAutoresizingMaskIntoConstraints = false
        empView.addSubview(employmentCV)
        
        employmentCVHeightConstraint = employmentCV.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        employmentCVHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            empView.topAnchor.constraint(equalTo: headlineView.bottomAnchor, constant: 20),
            empView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            empView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: empView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: empView.leadingAnchor, constant: 20),
            
            employmentCV.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            employmentCV.leadingAnchor.constraint(equalTo: empView.leadingAnchor, constant: 20),
            employmentCV.trailingAnchor.constraint(equalTo: empView.trailingAnchor, constant: -20),
            
            empView.bottomAnchor.constraint(equalTo: employmentCV.bottomAnchor, constant: 20)
        ])
    }
    
    func reloadEmploymentsCollectionView() {
        employmentCV.reloadData()
            
        // Calculate the content size
        employmentCV.layoutIfNeeded()
        let contentSize = employmentCV.collectionViewLayout.collectionViewContentSize
        employmentCVHeightConstraint.constant = contentSize.height
        
        updateScrollViewContentSize()
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    var totalExperience : Double!
    
    
    func setupProjectView() {
        projectView.layer.borderWidth = 1
        projectView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        projectView.layer.cornerRadius = 12
        
        projectView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(projectView)
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Project"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        projectView.addSubview(label)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        projectCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        projectCV.register(ProjectCell.self, forCellWithReuseIdentifier: "project")
        projectCV.delegate = self
        projectCV.dataSource = self
        
        projectCV.translatesAutoresizingMaskIntoConstraints = false
        projectView.addSubview(projectCV)
        
        NSLayoutConstraint.activate([
            projectView.topAnchor.constraint(equalTo: empView.bottomAnchor, constant: 20),
            projectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            projectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: projectView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: projectView.leadingAnchor, constant: 20),
            
            projectCV.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            projectCV.leadingAnchor.constraint(equalTo: projectView.leadingAnchor, constant: 20),
            projectCV.trailingAnchor.constraint(equalTo: projectView.trailingAnchor, constant: -20),
            
            projectView.bottomAnchor.constraint(equalTo: projectCV.bottomAnchor, constant: 20)
        ])
        
        projectCVHeightConstraint = projectCV.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        projectCVHeightConstraint.isActive = true
    }
    
    func reloadProjectCollectionView() {
        projectCV.reloadData()
        projectCV.layoutIfNeeded()
        
        let contentSize = projectCV.collectionViewLayout.collectionViewContentSize
        projectCVHeightConstraint.constant = contentSize.height
        
        updateScrollViewContentSize()
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func setupEducationView() {
        educationView.layer.borderWidth = 1
        educationView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        educationView.layer.cornerRadius = 12
        
        educationView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(educationView)
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Education"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        educationView.addSubview(label)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        educationCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        educationCV.register(EducationCell.self, forCellWithReuseIdentifier: "edu")
        educationCV.delegate = self
        educationCV.dataSource = self
        
        educationCV.translatesAutoresizingMaskIntoConstraints = false
        educationView.addSubview(educationCV)
        
        NSLayoutConstraint.activate([
            educationView.topAnchor.constraint(equalTo: projectView.bottomAnchor, constant: 20),
            educationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            educationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: educationView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: educationView.leadingAnchor, constant: 20),
            
            educationCV.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            educationCV.leadingAnchor.constraint(equalTo: educationView.leadingAnchor, constant: 20),
            educationCV.trailingAnchor.constraint(equalTo: educationView.trailingAnchor, constant: -20),
            
            educationView.bottomAnchor.constraint(equalTo: educationCV.bottomAnchor, constant: 20)
        ])
        
        educationCVHeightConstraint = educationCV.heightAnchor.constraint(equalToConstant: 0) // Initial height
        educationCVHeightConstraint.isActive = true
    }
    
    func reloadEducationCollectionView() {
        educationCV.reloadData()
        educationCV.layoutIfNeeded()
        
        let contentSize = educationCV.collectionViewLayout.collectionViewContentSize
        educationCVHeightConstraint.constant = contentSize.height
        
        updateScrollViewContentSize()
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    
    
    func setupSoftwares() {
        softwareView.layer.borderWidth = 1
        softwareView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        softwareView.layer.cornerRadius = 12
        
        softwareView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(softwareView)
        
        NSLayoutConstraint.activate([
            softwareView.topAnchor.constraint(equalTo: educationView.bottomAnchor, constant: 20),
            softwareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            softwareView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func addLabelsInSoftwares() {
        if let existingHeightConstraint = softwareView.constraints.first(where: { $0.firstAttribute == .height }) {
            existingHeightConstraint.isActive = false
        }
        for subview in softwareView.subviews {
            subview.removeFromSuperview()
        }
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Softwares"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        softwareView.addSubview(label)
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: softwareView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: softwareView.leadingAnchor, constant: 20)
        ])
        
        
        var currentX: CGFloat = 20
        var currentY: CGFloat = 60
        let spacing: CGFloat = 10
        let maxWidth: CGFloat = view.bounds.width - 72  // Adjust for left and right padding
        
        for string in softwaresArray {
            let label = PaddedLabel()
            label.text = string
            label.font = .systemFont(ofSize: 16)
            label.backgroundColor = .white
            label.textColor = UIColor(hex: "#475467")
            label.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            
            // Ensure the label fits the text with padding
            let labelSize = label.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
            
            // Check if the label fits in the current line
            if currentX + labelSize.width > maxWidth {
                // Move to the next line
                currentX = 20
                currentY += labelSize.height + spacing
            }
            
            label.frame = CGRect(origin: CGPoint(x: currentX, y: currentY), size: labelSize)
            softwareView.addSubview(label)
            
            // Update currentX to the next position
            currentX += labelSize.width + spacing
        }
        // Calculate new height
        let newHeight = currentY + 28
        
        // Create and activate the new height constraint
        let newHeightConstraint = softwareView.heightAnchor.constraint(equalToConstant: newHeight + 20)
        newHeightConstraint.isActive = true
        
        softwareView.setNeedsLayout()
        softwareView.layoutIfNeeded()
        
        if newHeight > 250 {
            let contentHeight = scrollView.contentSize.height + 200
            scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
        }
        if newHeight > 500 {
            let contentHeight = scrollView.contentSize.height + 500
            scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
        }
    }
    
    
    
    func setupSkills() {
        skillsView.layer.borderWidth = 1
        skillsView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        skillsView.layer.cornerRadius = 12
        
        skillsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(skillsView)
        
        NSLayoutConstraint.activate([
            skillsView.topAnchor.constraint(equalTo: softwareView.bottomAnchor, constant: 20),
            skillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func addLabelsInSkills() {
        
        if let existingHeightConstraint = skillsView.constraints.first(where: { $0.firstAttribute == .height }) {
            existingHeightConstraint.isActive = false
        }
        for subview in skillsView.subviews {
            subview.removeFromSuperview()
        }
        
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Skills"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        skillsView.addSubview(label)
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: skillsView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: skillsView.leadingAnchor, constant: 20)
        ])
        
        
        var currentX: CGFloat = 20
        var currentY: CGFloat = 60
        let spacing: CGFloat = 10
        let maxWidth: CGFloat = view.bounds.width - 32  // Adjust for left and right padding
        
        for string in skillsArray {
            let label = PaddedLabel()
            label.text = string
            label.font = .systemFont(ofSize: 16)
            label.backgroundColor = .white
            label.textColor = UIColor(hex: "#475467")
            label.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            
            // Ensure the label fits the text with padding
            let labelSize = label.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
            
            // Check if the label fits in the current line
            if currentX + labelSize.width > maxWidth {
                // Move to the next line
                currentX = 20
                currentY += labelSize.height + spacing
            }
            
            label.frame = CGRect(origin: CGPoint(x: currentX, y: currentY), size: labelSize)
            skillsView.addSubview(label)
            
            // Update currentX to the next position
            currentX += labelSize.width + spacing
        }
        
        // Calculate new height
        let newHeight = currentY + 28
        
        // Create and activate the new height constraint
        let newHeightConstraint = skillsView.heightAnchor.constraint(equalToConstant: newHeight + 20)
        newHeightConstraint.isActive = true
        
        skillsView.setNeedsLayout()
        skillsView.layoutIfNeeded()
        
//        print("New Height : " , newHeight)
        if newHeight > 250 {
            let contentHeight = scrollView.contentSize.height + 200
            scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
        }
        if newHeight > 500 {
            let contentHeight = scrollView.contentSize.height + 500
            scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
        }
    }
    
    
    
    
    
    
    var dobLabel : UILabel!
    var nationalityLabel : UILabel!
    var genderLabel : UILabel!
    var permanentAddressLabel : UILabel!
    var currentAddressLabel : UILabel!
    var stateLabel : UILabel!
    var cityLabel : UILabel!
    var pincodeLabel : UILabel!
    var uidLabel : UILabel!
    var passportLabel : UILabel!
    var pancardLabel : UILabel!
    var languageLabel : UILabel!
    
    func setupPersonalInfoView() {
        personalInfoView.layer.borderWidth = 1
        personalInfoView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        personalInfoView.layer.cornerRadius = 12
        
        personalInfoView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(personalInfoView)
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Personal Info"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        personalInfoView.addSubview(label)
        
        
        NSLayoutConstraint.activate([
            personalInfoView.topAnchor.constraint(equalTo: skillsView.bottomAnchor, constant: 20),
            personalInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            personalInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: personalInfoView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: personalInfoView.leadingAnchor, constant: 20)
        ])
        
        var dob = createStaticLabel()
        dob.text = "Date of Birth"
        personalInfoView.addSubview(dob)
        dobLabel = createDynamicLabel()
        personalInfoView.addSubview(dobLabel)
        
        var nationality = createStaticLabel()
        nationality.text = "Nationality"
        personalInfoView.addSubview(nationality)
        nationalityLabel = createDynamicLabel()
        personalInfoView.addSubview(nationalityLabel)
        
        var gender = createStaticLabel()
        gender.text = "Gender"
        personalInfoView.addSubview(gender)
        genderLabel = createDynamicLabel()
        personalInfoView.addSubview(genderLabel)
        
        var permanent = createStaticLabel()
        permanent.text = "Permanent Address"
        personalInfoView.addSubview(permanent)
        permanentAddressLabel = createDynamicLabel()
        permanentAddressLabel.numberOfLines = 0
        personalInfoView.addSubview(permanentAddressLabel)
        
        var current = createStaticLabel()
        current.text = "Current Address"
        personalInfoView.addSubview(current)
        currentAddressLabel = createDynamicLabel()
        currentAddressLabel.numberOfLines = 0
        personalInfoView.addSubview(currentAddressLabel)
        
        var state = createStaticLabel()
        state.text = "State"
        personalInfoView.addSubview(state)
        stateLabel = createDynamicLabel()
        stateLabel.numberOfLines = 0
        personalInfoView.addSubview(stateLabel)
        
        var city = createStaticLabel()
        city.text = "City"
        personalInfoView.addSubview(city)
        cityLabel = createDynamicLabel()
        personalInfoView.addSubview(cityLabel)
        
        var pin = createStaticLabel()
        pin.text = "Pin Code"
        personalInfoView.addSubview(pin)
        pincodeLabel = createDynamicLabel()
        personalInfoView.addSubview(pincodeLabel)
        
        var uid = createStaticLabel()
        uid.text = "UID Number"
        personalInfoView.addSubview(uid)
        uidLabel = createDynamicLabel()
        personalInfoView.addSubview(uidLabel)
        
        var passport = createStaticLabel()
        passport.text = "Passport Number"
        personalInfoView.addSubview(passport)
        passportLabel = createDynamicLabel()
        personalInfoView.addSubview(passportLabel)
        
        var pan = createStaticLabel()
        pan.text = "PanCard Number"
        personalInfoView.addSubview(pan)
        pancardLabel = createDynamicLabel()
        personalInfoView.addSubview(pancardLabel)
        
        var lang = createStaticLabel()
        lang.text = "Languages"
        personalInfoView.addSubview(lang)
        languageLabel = createDynamicLabel()
        languageLabel.numberOfLines = 0
        personalInfoView.addSubview(languageLabel)
        
        
        NSLayoutConstraint.activate([
            dob.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            dob.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            dob.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dobLabel.topAnchor.constraint(equalTo: dob.bottomAnchor, constant: 10),
            dobLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            nationality.topAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 20),
            nationality.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            nationalityLabel.topAnchor.constraint(equalTo: nationality.bottomAnchor, constant: 10),
            nationalityLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            gender.topAnchor.constraint(equalTo: nationalityLabel.bottomAnchor, constant: 20),
            gender.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            genderLabel.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 10),
            genderLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            permanent.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20),
            permanent.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            permanentAddressLabel.topAnchor.constraint(equalTo: permanent.bottomAnchor, constant: 10),
            permanentAddressLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            permanentAddressLabel.trailingAnchor.constraint(equalTo: dob.trailingAnchor),
            
            current.topAnchor.constraint(equalTo: permanentAddressLabel.bottomAnchor, constant: 20),
            current.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            currentAddressLabel.topAnchor.constraint(equalTo: current.bottomAnchor, constant: 10),
            currentAddressLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            currentAddressLabel.trailingAnchor.constraint(equalTo: dob.trailingAnchor),
            
            state.topAnchor.constraint(equalTo: currentAddressLabel.bottomAnchor, constant: 20),
            state.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            stateLabel.topAnchor.constraint(equalTo: state.bottomAnchor, constant: 10),
            stateLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            city.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 20),
            city.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            cityLabel.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 10),
            cityLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            pin.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            pin.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            pincodeLabel.topAnchor.constraint(equalTo: pin.bottomAnchor, constant: 10),
            pincodeLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            uid.topAnchor.constraint(equalTo: pincodeLabel.bottomAnchor, constant: 20),
            uid.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            uidLabel.topAnchor.constraint(equalTo: uid.bottomAnchor, constant: 10),
            uidLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            passport.topAnchor.constraint(equalTo: uidLabel.bottomAnchor, constant: 20),
            passport.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            passportLabel.topAnchor.constraint(equalTo: passport.bottomAnchor, constant: 10),
            passportLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            pan.topAnchor.constraint(equalTo: passportLabel.bottomAnchor, constant: 20),
            pan.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            pancardLabel.topAnchor.constraint(equalTo: pan.bottomAnchor, constant: 10),
            pancardLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            lang.topAnchor.constraint(equalTo: pancardLabel.bottomAnchor, constant: 20),
            lang.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            languageLabel.topAnchor.constraint(equalTo: lang.bottomAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            languageLabel.trailingAnchor.constraint(equalTo: dob.trailingAnchor),
            
            personalInfoView.bottomAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 20)
        ])
    }
    
    

    
    
    
    var portfolioLabel : UILabel!
    var currCtcLabel : UILabel!
    var expectedCtcLabel : UILabel!
    var noticePeriodLabel : UILabel!
    var willingToRelocate : UILabel!
    var currentlyEmployed : UILabel!
    var worktypeLabel : UILabel!
    
    func setupPreferencesView() {
        preferenceView.layer.borderWidth = 1
        preferenceView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        preferenceView.layer.cornerRadius = 12
        
        preferenceView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(preferenceView)
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Preferences"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        preferenceView.addSubview(label)
        
        NSLayoutConstraint.activate([
            preferenceView.topAnchor.constraint(equalTo: personalInfoView.bottomAnchor, constant: 20),
            preferenceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            preferenceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: preferenceView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: preferenceView.leadingAnchor, constant: 20)
        ])
        
        
        var pfLabel = createStaticLabel()
        pfLabel.text = "Portfolio Link"
        preferenceView.addSubview(pfLabel)
        
        portfolioLabel = createDynamicLabel()
        portfolioLabel.numberOfLines = 0
        preferenceView.addSubview(portfolioLabel)
        
        var ccLabel = createStaticLabel()
        ccLabel.text = "Current CTC"
        preferenceView.addSubview(ccLabel)
        
        currCtcLabel = createDynamicLabel()
        scrollView.addSubview(currCtcLabel)
        
        var ecLabel = createStaticLabel()
        ecLabel.text = "Expected CTC"
        preferenceView.addSubview(ecLabel)
        
        expectedCtcLabel = createDynamicLabel()
        preferenceView.addSubview(expectedCtcLabel)
        
        var npLabel = createStaticLabel()
        npLabel.text = "Notice Period"
        preferenceView.addSubview(npLabel)
        noticePeriodLabel = createDynamicLabel()
        preferenceView.addSubview(noticePeriodLabel)
        
        
        var wtrLabel = createStaticLabel()
        wtrLabel.text = "Willing to Relocate"
        preferenceView.addSubview(wtrLabel)
        willingToRelocate = createDynamicLabel()
        preferenceView.addSubview(willingToRelocate)
        
        var ceLabel = createStaticLabel()
        ceLabel.text = "Currently Employed"
        preferenceView.addSubview(ceLabel)
        currentlyEmployed = createDynamicLabel()
        preferenceView.addSubview(currentlyEmployed)
        
        var pwtLabel = createStaticLabel()
        pwtLabel.text = "Preferred Work Type"
        preferenceView.addSubview(pwtLabel)
        worktypeLabel = createDynamicLabel()
        preferenceView.addSubview(worktypeLabel)
        
        NSLayoutConstraint.activate([
            pfLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            pfLabel.leadingAnchor.constraint(equalTo: preferenceView.leadingAnchor, constant: 20),
            portfolioLabel.topAnchor.constraint(equalTo: pfLabel.bottomAnchor, constant: 10),
            portfolioLabel.leadingAnchor.constraint(equalTo: pfLabel.leadingAnchor),
            portfolioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            ccLabel.topAnchor.constraint(equalTo: portfolioLabel.bottomAnchor, constant: 20),
            ccLabel.leadingAnchor.constraint(equalTo: pfLabel.leadingAnchor),
            currCtcLabel.topAnchor.constraint(equalTo: ccLabel.bottomAnchor, constant: 10),
            currCtcLabel.leadingAnchor.constraint(equalTo: ccLabel.leadingAnchor),
            
            ecLabel.topAnchor.constraint(equalTo: currCtcLabel.bottomAnchor, constant: 20),
            ecLabel.leadingAnchor.constraint(equalTo: ccLabel.leadingAnchor),
            expectedCtcLabel.topAnchor.constraint(equalTo: ecLabel.bottomAnchor, constant: 10),
            expectedCtcLabel.leadingAnchor.constraint(equalTo: ecLabel.leadingAnchor),
            
            npLabel.topAnchor.constraint(equalTo: expectedCtcLabel.bottomAnchor, constant: 20),
            npLabel.leadingAnchor.constraint(equalTo: ecLabel.leadingAnchor),
            noticePeriodLabel.topAnchor.constraint(equalTo: npLabel.bottomAnchor, constant: 10),
            noticePeriodLabel.leadingAnchor.constraint(equalTo: npLabel.leadingAnchor),
            
            wtrLabel.topAnchor.constraint(equalTo: noticePeriodLabel.bottomAnchor, constant: 20),
            wtrLabel.leadingAnchor.constraint(equalTo:noticePeriodLabel.leadingAnchor),
            willingToRelocate.topAnchor.constraint(equalTo: wtrLabel.bottomAnchor, constant: 10),
            willingToRelocate.leadingAnchor.constraint(equalTo: wtrLabel.leadingAnchor),
            
            ceLabel.topAnchor.constraint(equalTo: willingToRelocate.bottomAnchor, constant: 20),
            ceLabel.leadingAnchor.constraint(equalTo: wtrLabel.leadingAnchor),
            currentlyEmployed.topAnchor.constraint(equalTo: ceLabel.bottomAnchor, constant: 10),
            currentlyEmployed.leadingAnchor.constraint(equalTo: ceLabel.leadingAnchor),
            
            pwtLabel.topAnchor.constraint(equalTo: currentlyEmployed.bottomAnchor, constant: 20),
            pwtLabel.leadingAnchor.constraint(equalTo: ceLabel.leadingAnchor),
            worktypeLabel.topAnchor.constraint(equalTo: pwtLabel.bottomAnchor, constant: 10),
            worktypeLabel.leadingAnchor.constraint(equalTo: pwtLabel.leadingAnchor),
            
            preferenceView.bottomAnchor.constraint(equalTo: worktypeLabel.bottomAnchor, constant: 20)
        ])
    }
    
    
    
    
    
    func setupBottomView() {
        bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        
        let nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 20)
        nextButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        nextButton.backgroundColor = UIColor(hex: "#0079C4")
        nextButton.layer.cornerRadius = 8
        
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(nextButton)
        
        let backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 20)
        backButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        backButton.backgroundColor = UIColor(hex: "#FFFFFF")
        backButton.layer.cornerRadius = 8
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        
        backButton.isUserInteractionEnabled = true
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(backButton)
        
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            
            backButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15),
            backButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            
            nextButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    @objc func didTapNextButton() {
        setOnboardingTrue()
    }
    
    
    
    
    
    // ******************* Common Methods ***********************************
    
    
    func updateScrollViewContentSize() {
        let combinedContentHeight = employmentCVHeightConstraint.constant + educationCVHeightConstraint.constant + projectCVHeightConstraint.constant
        // Add other collection view heights if there are more
        let extraSpaceHeight: CGFloat = 1000 // Change this if you need more space at the bottom
        
        let totalContentHeight = combinedContentHeight + extraSpaceHeight
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: totalContentHeight)
    }
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    func askUserConfirmation(title: String, message: String, confirmedAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // 'Yes' action
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            confirmedAction()  // Perform the action passed in the closure
        }
        
        // 'No' action
        let noAction = UIAlertAction(title: "No", style: .cancel)

        alertController.addAction(yesAction)
        alertController.addAction(noAction)

        present(alertController, animated: true)
    }
    
    func createStaticLabel() -> UILabel {
        var label = UILabel()
        label.font =  .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#667085")
        return label
    }
    
    func createDynamicLabel() -> UILabel {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#344054")
        return label
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard when the return key is tapped
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard when the user taps outside of the text field
        view.endEditing(true)
    }
}






extension PreviewVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case employmentCV:
                return empDataArray.count
            case educationCV:
                return eduDataArray.count
            case projectCV:
                return projectDataArray.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == employmentCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exp", for: indexPath) as! EmploymentCell
            let exp = empDataArray[indexPath.row]
            
            cell.titleLabel.text = exp.employmentDesignation
            cell.companyNameLabel.text = exp.companyName
            cell.noOfYearsLabel.text = "\(exp.yearsOfExperience),"
            cell.jobTypeLabel.text = exp.employmentPeriod
            
            cell.editButton.isHidden = true
            cell.deleteButton.isHidden = true
            
//            cell.layer.borderWidth = 1
//            cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
//            cell.layer.cornerRadius = 12
            
            return cell
        }
        if collectionView == educationCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "edu", for: indexPath) as! EducationCell
            
            let edu = eduDataArray[indexPath.row]
            
            cell.educationLabel.text = edu.educationName
            cell.collegeLabel.text = edu.boardOrUniversity ?? "nil"
            cell.passYearLabel.text = "\(edu.yearOfPassing ?? "nil"),"
            let m = edu.marksObtained ?? ""
            if m.hasSuffix("%") {
                cell.courseTypeLabel.text = m
            }
            else {
                cell.courseTypeLabel.text = "\(m)%"
            }
            
            cell.editButton.isHidden = true
            cell.deleteButton.isHidden = true
            
//            cell.layer.borderWidth = 1
//            cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
//            cell.layer.cornerRadius = 12
        
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "project", for: indexPath) as! ProjectCell
            let project = projectDataArray[indexPath.row]
            
            cell.projectName.text = project.projectName
            cell.projectRole.text = project.role
            cell.projectDescription.text = project.description
            cell.projectResponsibility.text = project.responsibility
            
            cell.deleteButton.isHidden = true
            cell.editButton.isHidden = true
            
//            cell.layer.borderWidth = 1
//            cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
//            cell.layer.cornerRadius = 12
        
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == projectCV {
            let project = projectDataArray[indexPath.row]

            let padding: CGFloat = 6 // Adjust padding as necessary
            let labelWidth = collectionView.bounds.width - (padding * 2)

            let descriptionFont = UIFont.systemFont(ofSize: 14)
            let responsibilityFont = UIFont.systemFont(ofSize: 14)
            let fixedHeightFont = UIFont.systemFont(ofSize: 18) // Assuming the single-line labels use this

            // Calculate maximum heights for the labels with limited lines
            let maxLines: CGFloat = 3
            let descriptionHeight = min(descriptionFont.lineHeight * maxLines, project.description.heightWithConstrainedWidth(width: labelWidth, font: descriptionFont))
            let responsibilityHeight = min(responsibilityFont.lineHeight * maxLines, project.responsibility.heightWithConstrainedWidth(width: labelWidth, font: responsibilityFont))

            // Add heights for the fixed single-line labels
            let fixedHeight = fixedHeightFont.lineHeight // Since they are single line, we can use line height directly

            // Calculate total height
            let totalHeight = descriptionHeight + responsibilityHeight + (fixedHeight * 2) + (padding * 3) // Adjust number of paddings as needed

            return CGSize(width: view.frame.width - 72, height: totalHeight + 90)
        }
        else if collectionView == employmentCV {
            return CGSize(width: view.frame.width - 72, height: 100)
        }
        else {
            return CGSize(width: view.frame.width - 72, height: 90)
        }
    }
}

// Extension for APIs
extension PreviewVC {
    
    func fetchUserProfile() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/profile") else {
            print("Invalid URL")
            return
        }

        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Retrieve the accessToken and set the Authorization header
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Access Token not found")
            return
        }

        // Execute the network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                print("User fetched: \(user.hasCompletedOnboarding)")
                
                let initialsOfName = self.extractInitials(from: user.name)
                let userName = user.name ?? ""
                
                DispatchQueue.main.async {
                    self.userNameLabel.text = "\(userName)"
                    self.jobTitleLabel.text = user.designation
                    self.locationLabel.text = user.currentAddress?.city ?? "cityNil"
                    
                    self.fetchProfilePicture(size: "m", userID: user._id)
                    
                    self.emailLabel.text = user.email
                    self.mobileLabel.text = user.mobile
                    
                    self.headlineLabel.text = user.headline
                    self.summaryLabel.text = user.summary
                    
                    self.dobLabel.text = user.dateOfBirth
                    self.nationalityLabel.text = user.nationality
                    self.genderLabel.text = user.gender?.trimmingCharacters(in: .whitespaces)
                    self.permanentAddressLabel.text = user.permanentAddress
                    self.currentAddressLabel.text = user.currentAddress?.address
                    self.stateLabel.text = user.currentAddress?.state
                    self.cityLabel.text = user.currentAddress?.city
                    self.pincodeLabel.text = user.currentAddress?.pincode
                    self.uidLabel.text = user.uidNumber ?? "UID nil"
                    self.passportLabel.text = user.passportNo ?? "Passport nil"
                    self.pancardLabel.text = user.panNo ?? "PAN nil"
                    
                    var a : [String] = []
                    for s in user.language! {
                        a.append(s.language)
                    }
                    self.languageLabel.text = a.joined(separator: ", ")
                    
                    
                    self.empDataArray = user.experience!
                    self.reloadEmploymentsCollectionView()
                    
                    self.eduDataArray = user.education!
                    self.reloadEducationCollectionView()
                    
                    self.projectDataArray = user.projects!
                    self.reloadProjectCollectionView()
                    
                    
                    self.preferencesVC.portfolioTextField.text = user.portfolio
                    self.preferencesVC.currentCtcTextField.text = user.currentCtc
                    self.preferencesVC.expectedCtcTextField.text = user.expectedCtc
                    
                    
                    
                    self.portfolioLabel.text = user.portfolio
                    self.currCtcLabel.text = user.currentCtc
                    self.expectedCtcLabel.text = user.expectedCtc
            
                    self.noticePeriodLabel.text = user.noticePeriod?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.willingToRelocate.text = user.willingToRelocate?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.currentlyEmployed.text = user.currentlyEmployed?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.worktypeLabel.text = user.preferredWorkType?.trimmingCharacters(in: .whitespacesAndNewlines)
                    
//                    for s in user.softwares! {
//                        self.softwaresArray.append(s)
//                    }
                    
                   
                    self.softwaresArray = user.softwares!
                    self.addLabelsInSoftwares()
                    
                    
                    self.skillsArray = user.skills!
                    self.addLabelsInSkills()
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }

        task.resume()
    }
    
    func fetchProfilePicture(size: String, userID: String) {
        let urlString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/profile/\(size)/\(userID)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    // Use the image in your app, e.g., assign it to an UIImageView
                    self.profileImageView.image = image
                    print("Image Fetched Successfully")
                } else {
                    print("Failed to decode image")
                }
            }
        }

        task.resume()
    }
    
    private func extractInitials(from name: String?) -> String {
        guard let name = name, !name.isEmpty else { return "" }
        let parts = name.split(separator: " ").map(String.init)
        let initials = parts.compactMap { $0.first }.prefix(2)
        return initials.map(String.init).joined().uppercased()
    }
    
    func setOnboardingTrue() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let hasCompletedOnboarding: [String: Bool] = ["hasCompletedOnboarding": true]
        
        do {
            let jsonData = try JSONEncoder().encode(hasCompletedOnboarding)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode user profile to JSON: \(error)")
            return
        }
        
        let loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        
        DispatchQueue.main.async {
            loader.startAnimating()
            self.view.addSubview(loader)
            self.scrollView.alpha = 0.1
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to upload user profile, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return
            }
            
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Server response: \(responseString)")
            }
            if let error = error {
                print("Error uploading user profile: \(error.localizedDescription)")
            } else {
                print("User Preferences successfully uploaded.")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                loader.stopAnimating()
                loader.removeFromSuperview()
                self.scrollView.alpha = 1
                
                let viewController = ViewController()
                viewController.modalPresentationStyle = .overFullScreen
                viewController.overrideUserInterfaceStyle = .light
                self.present(viewController, animated: true)
            }
        }.resume()
    }
}



