//
//  HomeController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class HomeController: UIViewController {
   
    
// ************************************** Variables ***************************************
    
    
    let scrollView = UIScrollView()
    
    var headerView : UIView = UIView()
    var olousLogo : UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "OlousLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let welcomeLabel : UILabel = {
        let label = UILabel()
        label.text = "Welcome Ajay"
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = UIColor(hex: "#101828")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var jobSearchSection : UIView = UIView()
    var jobSearchInnerSection : UIView = UIView()
    var jobSearchIS2 : UIView = UIView()
    
    let jobsTextField = UITextField()
    let locationTextField = UITextField()
    
    
    let userProfileView = UIView()
    let profileCircleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#0079C4")
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    let percentLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "75%"
        label.textColor = UIColor(hex: "#219653")
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Ajay Sarkate"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hex: "#101828")
        label.numberOfLines = 2
        return label
    }()
    let designationLabel : UILabel = {
        let label = UILabel()
        label.text = "Designation"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#475467")
        return label
    }()
    let locationLabel : UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#475467")
        return label
    }()
    var profileImageView : UIImageView!
    
    
    var recommendedJobsView = UIView()
    var recommendedJobsCollectionVC : UICollectionView!
    var jobs: [Job] = []
    var viewAllJobsButton : UIButton = {
        let button = UIButton()
        button.setTitle("View all", for: .normal)
        button.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        return button
    }()
    
    
    let separatorLine2 = UIView()
    
    
    var topCompaniesView = UIView()
    var companiesCollectionVC : UICollectionView!
    var viewAllCompaniesButton : UIButton = {
        let button = UIButton()
        button.setTitle("View all", for: .normal)
        button.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        return button
    }()
    
    
    var appliedJobs : [String] = []
    
// *********************** View Did Load ***************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        fetchUserProfile()
        fetchRecommendedJobs()
        fetchTotalAppliedJobIDs()
        
        setupViews()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupViews() {
        
        setupScrollView()
        setupWelcomeLabel()
        setupJobSearchSection()
        setupJobSearchInnerSection()
        
        setupUserProfileSection()
        
        setupRecommendedJobsView()
        setupNoJobsImageView()
        
        setupTopCompaniesView()
        
        setupProfileInfoView()
    }
    
    
// ************************************ Functions *******************************************
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        let extraSpaceHeight: CGFloat = 180
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    func setupWelcomeLabel() {
        scrollView.addSubview(welcomeLabel)
        
        let ready = UILabel()
        ready.text = "Ready to find the perfect match?"
        ready.textColor = UIColor(hex: "#344054")
        ready.font = .systemFont(ofSize: 18)
        ready.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(ready)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ready.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5),
            ready.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    func setupJobSearchSection() {
        jobSearchSection.backgroundColor = UIColor(hex: "#1E293B")
        jobSearchSection.layer.cornerRadius = 8
        jobSearchSection.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(jobSearchSection)
        
        let ready = UILabel()
        ready.text = "Let's find your dream job"
        ready.textColor = UIColor(hex: "#FFFFFF")
        ready.font = .boldSystemFont(ofSize: 20)
        ready.translatesAutoresizingMaskIntoConstraints = false
        
        jobSearchSection.addSubview(ready)
        
        NSLayoutConstraint.activate([
            jobSearchSection.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            jobSearchSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jobSearchSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            jobSearchSection.heightAnchor.constraint(equalToConstant: 232),
            
            ready.topAnchor.constraint(equalTo: jobSearchSection.topAnchor, constant: 16),
            ready.leadingAnchor.constraint(equalTo: jobSearchSection.leadingAnchor, constant: 16),
        ])
    }
        
    func setupJobSearchInnerSection() {
        jobSearchInnerSection.backgroundColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.06)
        jobSearchInnerSection.layer.cornerRadius = 12
        jobSearchInnerSection.layer.borderWidth = 1
        let borderColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.06)
        jobSearchInnerSection.layer.borderColor = borderColor.cgColor
        
        jobSearchInnerSection.translatesAutoresizingMaskIntoConstraints = false
        jobSearchSection.addSubview(jobSearchInnerSection)
        
        
        var searchIcon : UIImageView = UIImageView()
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.tintColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.6)
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(searchIcon)
        
        
        let placeholderText = "Enter Job Title (Required)"
        let placeholderColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.64)
        jobsTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        
        jobsTextField.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(jobsTextField)
        
        NSLayoutConstraint.activate([
            jobSearchInnerSection.topAnchor.constraint(equalTo: jobSearchSection.topAnchor, constant: 56),
            jobSearchInnerSection.leadingAnchor.constraint(equalTo: jobSearchSection.leadingAnchor, constant: 16),
            jobSearchInnerSection.trailingAnchor.constraint(equalTo: jobSearchSection.trailingAnchor, constant: -16),
            jobSearchInnerSection.heightAnchor.constraint(equalToConstant: 45),
            
            searchIcon.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 12),
            searchIcon.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 16),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22),
            
            jobsTextField.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 10),
            jobsTextField.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 46),
            jobsTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            jobsTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
        jobSearchIS2.backgroundColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.06)
        jobSearchIS2.layer.cornerRadius = 12
        jobSearchIS2.layer.borderWidth = 1
        jobSearchIS2.layer.borderColor = borderColor.cgColor
        
        jobSearchIS2.translatesAutoresizingMaskIntoConstraints = false
        jobSearchSection.addSubview(jobSearchIS2)
        
        
        var locationIcon : UIImageView = UIImageView()
        locationIcon.image = UIImage(named: "location-dot")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        jobSearchIS2.addSubview(locationIcon)
        
        
        let placeholderText2 = "City, state or zip code"
        let placeholderColor2 = UIColor(hex: "#FFFFFF").withAlphaComponent(0.64)
        locationTextField.attributedPlaceholder = NSAttributedString(string: placeholderText2, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor2])
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        jobSearchIS2.addSubview(locationTextField)
        
        NSLayoutConstraint.activate([
            jobSearchIS2.topAnchor.constraint(equalTo: jobSearchInnerSection.bottomAnchor, constant: 10),
            jobSearchIS2.leadingAnchor.constraint(equalTo: jobSearchSection.leadingAnchor, constant: 16),
            jobSearchIS2.trailingAnchor.constraint(equalTo: jobSearchSection.trailingAnchor, constant: -16),
            jobSearchIS2.heightAnchor.constraint(equalToConstant: 45),
            
            locationIcon.topAnchor.constraint(equalTo: jobSearchIS2.topAnchor, constant: 12),
            locationIcon.leadingAnchor.constraint(equalTo: jobSearchIS2.leadingAnchor, constant: 18),
            locationIcon.widthAnchor.constraint(equalToConstant: 21),
            locationIcon.heightAnchor.constraint(equalToConstant: 26),
            
            locationTextField.topAnchor.constraint(equalTo: jobSearchIS2.topAnchor, constant: 10),
            locationTextField.leadingAnchor.constraint(equalTo: jobSearchIS2.leadingAnchor, constant: 47),
            locationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            locationTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
        setupSearchJobsButton()
    }
    
    var jobSearchButton : UIButton = {
        let button = UIButton()
        button.setTitle("Search Jobs", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#0079C4")
        button.layer.cornerRadius = 12
        return button
    }()
    func setupSearchJobsButton() {
        jobSearchButton.addTarget(self, action: #selector(didTapSearchJobs), for: .touchUpInside)
        
        jobSearchButton.translatesAutoresizingMaskIntoConstraints = false
        jobSearchSection.addSubview(jobSearchButton)
        
        NSLayoutConstraint.activate([
            jobSearchButton.topAnchor.constraint(equalTo: jobSearchIS2.bottomAnchor, constant: 18),
            jobSearchButton.leadingAnchor.constraint(equalTo: jobSearchSection.leadingAnchor, constant: 16),
            jobSearchButton.trailingAnchor.constraint(equalTo: jobSearchSection.trailingAnchor, constant: -16),
            jobSearchButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    @objc func didTapSearchJobs() {
        guard let jobTitle = jobsTextField.text, !jobTitle.isEmpty else {
            let alert = UIAlertController(title: "Missing Information", message: "Fill all the details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        let jobResultVC = JobSearchResult()
        jobResultVC.jobTitle = jobTitle
        jobResultVC.jobLocation = locationTextField.text!
        
        navigationController?.pushViewController(jobResultVC, animated: true)
    }
    
    
    
    func setupUserProfileSection() {
        
        userProfileView.layer.borderColor = UIColor(hex: "##EAECF0").cgColor
        userProfileView.layer.borderWidth = 1
        userProfileView.layer.cornerRadius = 8
        
        userProfileView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(userProfileView)
        NSLayoutConstraint.activate([
            userProfileView.topAnchor.constraint(equalTo: jobSearchSection.bottomAnchor, constant: 20),
            userProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userProfileView.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            userProfileView.heightAnchor.constraint(equalToConstant: 210)
        ])
        
    }
    
    func setupProfileInfoView() {
        let circleContainerView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        circleContainerView.backgroundColor = UIColor(hex: "#D7F0FF")
        circleContainerView.layer.cornerRadius = 50
        
        circleContainerView.translatesAutoresizingMaskIntoConstraints = false
        userProfileView.addSubview(circleContainerView)
        NSLayoutConstraint.activate([
            circleContainerView.topAnchor.constraint(equalTo: userProfileView.topAnchor, constant: 24),
            circleContainerView.leadingAnchor.constraint(equalTo: userProfileView.leadingAnchor, constant: 16),
            circleContainerView.widthAnchor.constraint(equalToConstant: 100),
            circleContainerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileCircleLabel.isHidden = true
        circleContainerView.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: circleContainerView.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: circleContainerView.centerYAnchor)
        ])
        
        profileImageView = UIImageView()
//        profileImageView.isHidden = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50
        
        // Add the selected image view to the profile circle
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        circleContainerView.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: circleContainerView.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: circleContainerView.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: circleContainerView.trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: circleContainerView.bottomAnchor)
        ])
        
        
        
        let percentView = UIView()
        percentView.backgroundColor = UIColor(hex: "#E2FFEE")
        percentView.layer.cornerRadius = 14
        
        percentView.translatesAutoresizingMaskIntoConstraints = false
        userProfileView.addSubview(percentView)
        NSLayoutConstraint.activate([
            percentView.topAnchor.constraint(equalTo: circleContainerView.bottomAnchor, constant: -18),
            percentView.centerXAnchor.constraint(equalTo: circleContainerView.centerXAnchor),
            percentView.widthAnchor.constraint(equalToConstant: 50),
            percentView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentView.addSubview(percentLabel)
        NSLayoutConstraint.activate([
            percentLabel.centerXAnchor.constraint(equalTo: percentView.centerXAnchor),
            percentLabel.centerYAnchor.constraint(equalTo: percentView.centerYAnchor)
        ])
        
        
        // Calculate the center and radius of the circle
        let center = CGPoint(x: circleContainerView.bounds.midX, y: circleContainerView.bounds.midY)
        let radius = min(circleContainerView.bounds.width, circleContainerView.bounds.height) / 2
        
        // Calculate the end angle based on the percentage (0.75 for 75%)
        let text = percentLabel.text
        let percentString = text!.split(separator: "%").first
        let percentNumber = Int(percentString!)
        
        let percentage: CGFloat = CGFloat(percentNumber!) / 100.0
        let greenEndAngle = CGFloat.pi * 2 * percentage + CGFloat.pi / 2
        let normalEndAngle = CGFloat.pi * 2 + CGFloat.pi / 2

        // Create a circular path for the green layer
        let greenPath = UIBezierPath(arcCenter: center,
                                     radius: radius,
                                     startAngle: CGFloat.pi / 2,
                                     endAngle: greenEndAngle,
                                     clockwise: true)

        let greenBorderLayer : CAShapeLayer = {
            let greenBorderLayer = CAShapeLayer()
            greenBorderLayer.path = greenPath.cgPath
            greenBorderLayer.lineWidth = 6 // Border width
            greenBorderLayer.strokeColor = UIColor(hex: "#27AE60").cgColor // Border color
            greenBorderLayer.fillColor = UIColor.clear.cgColor
            return greenBorderLayer
        }()
        circleContainerView.layer.addSublayer(greenBorderLayer)
        
        
        // regular border without green color
        let normalPath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: greenEndAngle,
                                      endAngle: normalEndAngle,
                                      clockwise: true)

        // Create shape layer for the normal circle border
        let normalBorderLayer : CAShapeLayer = {
            let normalBorderLayer = CAShapeLayer()
            normalBorderLayer.path = normalPath.cgPath
            normalBorderLayer.lineWidth = 6 // Border width
            normalBorderLayer.strokeColor = UIColor(hex: "#EAECF0").cgColor // Border color
            normalBorderLayer.fillColor = UIColor.clear.cgColor
            return normalBorderLayer
        }()
        circleContainerView.layer.addSublayer(normalBorderLayer)
        
        
        // ************************************ right side info of circleView **********************************************
        
        

        

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 14

        // Add subviews to stack view
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(designationLabel)
        stackView.addArrangedSubview(locationLabel)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        userProfileView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: userProfileView.topAnchor, constant: 22),
            stackView.leadingAnchor.constraint(equalTo: circleContainerView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        
        let buttonContainerView = UIView()
        buttonContainerView.translatesAutoresizingMaskIntoConstraints = false
        userProfileView.addSubview(buttonContainerView)
        
        let updateProfilButton: UIButton = {
            let button = UIButton()
            let title = NSAttributedString(string: " Complete my profile ",
                                           attributes: [.font: UIFont.systemFont(ofSize: 18),
                                                        .foregroundColor: UIColor(hex: "#FFFFFF")])
            button.setAttributedTitle(title, for: .normal)
            button.backgroundColor = UIColor(hex: "#2563EB")
            button.layer.cornerRadius = 12
            button.addTarget(self, action: #selector(didTapUpdateProfile), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        buttonContainerView.addSubview(updateProfilButton)

        // Apply constraints to updateProfilButton within the container view
        NSLayoutConstraint.activate([
            buttonContainerView.heightAnchor.constraint(equalToConstant: 44),
            buttonContainerView.bottomAnchor.constraint(equalTo: userProfileView.bottomAnchor, constant: -16),
            buttonContainerView.leadingAnchor.constraint(equalTo: userProfileView.leadingAnchor, constant: 20),
            buttonContainerView.widthAnchor.constraint(equalToConstant: view.frame.width - 72),
            
            updateProfilButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor),
            updateProfilButton.centerYAnchor.constraint(equalTo: buttonContainerView.centerYAnchor),
            updateProfilButton.widthAnchor.constraint(equalToConstant: view.frame.width - 72),
            updateProfilButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
    }

    @objc func didTapUpdateProfile() {
        tabBarController?.selectedIndex = 3
        UIView.transition(with: tabBarController!.view!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }

    
    
    func setupRecommendedJobsView() {
        recommendedJobsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(recommendedJobsView)
        
        NSLayoutConstraint.activate([
            recommendedJobsView.topAnchor.constraint(equalTo: userProfileView.bottomAnchor, constant: 20),
            recommendedJobsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recommendedJobsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recommendedJobsView.heightAnchor.constraint(equalToConstant: 328)
        ])
        
        let label = UILabel()
        label.text = "Recommended Jobs"
        label.font = .boldSystemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        recommendedJobsView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: recommendedJobsView.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: recommendedJobsView.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        viewAllJobsButton.addTarget(self, action: #selector(didTapViewAllJobs), for: .touchUpInside)
        viewAllJobsButton.translatesAutoresizingMaskIntoConstraints = false
        recommendedJobsView.addSubview(viewAllJobsButton)
        
        NSLayoutConstraint.activate([
            viewAllJobsButton.topAnchor.constraint(equalTo: recommendedJobsView.topAnchor, constant: 0),
            viewAllJobsButton.leadingAnchor.constraint(equalTo: recommendedJobsView.leadingAnchor, constant: view.frame.width - 93),
            viewAllJobsButton.widthAnchor.constraint(equalToConstant: 73),
            viewAllJobsButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        setupRecommendedJobsCollectionVC()
    }
    
    @objc func didTapViewAllJobs() {
        tabBarController?.selectedIndex = 1
        UIView.transition(with: tabBarController!.view!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func setupRecommendedJobsCollectionVC() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        recommendedJobsCollectionVC = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recommendedJobsCollectionVC.register(JobsCell.self, forCellWithReuseIdentifier: "id2")
        recommendedJobsCollectionVC.showsHorizontalScrollIndicator = false
        
        recommendedJobsCollectionVC.dataSource = self
        recommendedJobsCollectionVC.delegate = self
        
        recommendedJobsCollectionVC.translatesAutoresizingMaskIntoConstraints = false
        recommendedJobsView.addSubview(recommendedJobsCollectionVC)
        
        NSLayoutConstraint.activate([
            recommendedJobsCollectionVC.topAnchor.constraint(equalTo: recommendedJobsView.topAnchor, constant: 40),
            recommendedJobsCollectionVC.leadingAnchor.constraint(equalTo: recommendedJobsView.leadingAnchor, constant: 16),
            recommendedJobsCollectionVC.trailingAnchor.constraint(equalTo: recommendedJobsView.trailingAnchor),
            recommendedJobsCollectionVC.bottomAnchor.constraint(equalTo: recommendedJobsView.bottomAnchor, constant: -19)
        ])
    }
    
    var noJobsImageView = UIImageView()
    
    private func setupNoJobsImageView() {
        noJobsImageView = UIImageView()
        noJobsImageView.image = UIImage(named: "no-jobs")  // Ensure you have this image in your assets
        
        noJobsImageView.translatesAutoresizingMaskIntoConstraints = false
        noJobsImageView.isHidden = true  // Hide it by default
        view.addSubview(noJobsImageView)

        NSLayoutConstraint.activate([
            noJobsImageView.topAnchor.constraint(equalTo: recommendedJobsView.topAnchor, constant: 50),
            noJobsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noJobsImageView.widthAnchor.constraint(equalToConstant: 300),
            noJobsImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    
    
    func setupTopCompaniesView() {
        
        topCompaniesView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(topCompaniesView)
        
        NSLayoutConstraint.activate([
            topCompaniesView.topAnchor.constraint(equalTo: recommendedJobsView.bottomAnchor, constant: 20),
            topCompaniesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topCompaniesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topCompaniesView.heightAnchor.constraint(equalToConstant: 261)
        ])
        
        let label = UILabel()
        label.text = "Top Companies"
        label.font = .boldSystemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        topCompaniesView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topCompaniesView.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: topCompaniesView.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: 170),
            label.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        viewAllCompaniesButton.addTarget(self, action: #selector(didTapViewAllCompanies), for: .touchUpInside)
        viewAllCompaniesButton.translatesAutoresizingMaskIntoConstraints = false
        topCompaniesView.addSubview(viewAllCompaniesButton)
        
        NSLayoutConstraint.activate([
            viewAllCompaniesButton.topAnchor.constraint(equalTo: topCompaniesView.topAnchor, constant: 0),
            viewAllCompaniesButton.leadingAnchor.constraint(equalTo: topCompaniesView.leadingAnchor, constant: view.frame.width - 93),
            viewAllCompaniesButton.widthAnchor.constraint(equalToConstant: 73),
            viewAllCompaniesButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        setupCompaniesCollectionVC()
    }
    
    @objc func didTapViewAllCompanies() {
        tabBarController?.selectedIndex = 2
        UIView.transition(with: tabBarController!.view!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func setupCompaniesCollectionVC() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        companiesCollectionVC = UICollectionView(frame: .zero, collectionViewLayout: layout)
        companiesCollectionVC.register(CompaniesCell.self, forCellWithReuseIdentifier: "id")
        companiesCollectionVC.showsHorizontalScrollIndicator = false
        
        companiesCollectionVC.dataSource = self
        companiesCollectionVC.delegate = self
        
        companiesCollectionVC.translatesAutoresizingMaskIntoConstraints = false
        topCompaniesView.addSubview(companiesCollectionVC)
        
        NSLayoutConstraint.activate([
            companiesCollectionVC.topAnchor.constraint(equalTo: topCompaniesView.topAnchor, constant: 60),
            companiesCollectionVC.leadingAnchor.constraint(equalTo: topCompaniesView.leadingAnchor, constant: 16),
            companiesCollectionVC.trailingAnchor.constraint(equalTo: topCompaniesView.trailingAnchor),
            companiesCollectionVC.bottomAnchor.constraint(equalTo: topCompaniesView.bottomAnchor, constant: -19)
        ])
    }
}



extension HomeController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == companiesCollectionVC {
            return 10
        }
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == companiesCollectionVC {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! CompaniesCell
            cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 12
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id2", for: indexPath) as! JobsCell
            let job = jobs[indexPath.row]
            
            if appliedJobs.contains(job.id) {
                cell.appliedLabel.isHidden = false
            }
            
            cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 12
            
            cell.jobTitle.text = job.title
            cell.companyName.text = job.companyName ?? job.company?.name
            
            
            if job.workPlace == "office based" {
                cell.workPlaceLabel.text = "Office Based"
                cell.workPlaceView.backgroundColor = UIColor(hex: "#FEF3F2")
                cell.workPlaceLabel.textColor = UIColor(hex: "#D92D20")
            }
            else {
                cell.workPlaceLabel.text = "Hybrid(Office + Site)"
                cell.workPlaceView.backgroundColor = UIColor(hex: "#ECFDF3")
                cell.workPlaceLabel.textColor = UIColor(hex: "#067647")
                
                if let widthConstraint = cell.workPlaceView.constraints.first(where: { $0.firstAttribute == .width }) {
                    cell.workPlaceView.removeConstraint(widthConstraint)
                }
                let widthConstraint = cell.workPlaceView.widthAnchor.constraint(equalToConstant: 160)
                widthConstraint.isActive = true
            }
            
            cell.jobLocationLabel.text = "\(job.location?.city ?? ""), \(job.location?.state ?? "")"
            
            var text = "\(job.salaryRangeFrom ?? "NA") - \(job.salaryRangeTo ?? "NA")"
            if text.hasSuffix("LPA") {
                cell.salaryLabel.text = text
            }
            else {
                cell.salaryLabel.text = "\(text) LPA"
            }
            
            cell.jobTypeLabel.text = job.jobType
            
            
            let s = getTimeAgoString(from: job.createdAt ?? "")
            cell.jobPostedTime.text = s
            
            let expText = attributedStringForExperience("\(job.minExperience ?? "nil") - \(job.maxExperience ?? "nil")")
            cell.jobExperienceLabel.attributedText = expText
            
            // Fetch company logo asynchronously
            let baseURLString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/company-pic?logo="
            let companyLogoURLString = baseURLString + (job.company?.logo ?? "")
            if let companyLogoURL = URL(string: companyLogoURLString) {
                URLSession.shared.dataTask(with: companyLogoURL) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.companyLogo.image = image
                        }
                    }
                }.resume()
            }
            
            cell.saveButton.isHidden = true
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == companiesCollectionVC {
            return .init(width: 228, height: 182)
        }
        return .init(width: view.frame.width - 80, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recommendedJobsCollectionVC {
            tabBarController?.selectedIndex = 1
            UIView.transition(with: tabBarController!.view!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        else {
            tabBarController?.selectedIndex = 2
            UIView.transition(with: tabBarController!.view!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    
    func getTimeAgoString(from createdAt: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = dateFormatter.date(from: createdAt) else {
            return "Invalid date"
        }
        
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: now)
        
        if let year = components.year, year > 0 {
            return "\(year) year\(year == 1 ? "" : "s") ago"
        } else if let month = components.month, month > 0 {
            return "\(month) month\(month == 1 ? "" : "s") ago"
        } else if let day = components.day, day > 0 {
            return "\(day) day\(day == 1 ? "" : "s") ago"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour) hour\(hour == 1 ? "" : "s") ago"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute) minute\(minute == 1 ? "" : "s") ago"
        } else {
            return "Just now"
        }
    }
    
    func attributedStringForExperience(_ experience: String) -> NSAttributedString {
        // Create a mutable attributed string
        let attributedString = NSMutableAttributedString()
        
//        attributedString.append(NSAttributedString(string: "|"))
//        attributedString.append(NSAttributedString(string: "  "))
        
        let symbolAttachment = NSTextAttachment()
        symbolAttachment.image = UIImage(systemName: "briefcase")?.withTintColor(UIColor(hex: "#667085"))
        
        let symbolString = NSAttributedString(attachment: symbolAttachment)
//        attributedString.append(symbolString)
        
//        attributedString.append(NSAttributedString(string: "      "))
        attributedString.append(NSAttributedString(string: experience))
        if !experience.hasSuffix("years") {
            attributedString.append(NSAttributedString(string: " years"))
        }
        
//        let textString = NSAttributedString(string: "1-5 years")
//        attributedString.append(textString)

        return attributedString
    }
}


extension HomeController {
    
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
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Raw response data: \(responseString)")
//            }
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
//                print("User fetched: \(user)")
                
                let percent = self.calculateProfileCompletion(for: user)
                let initialsOfName = self.extractInitials(from: user.name)
                let userName = user.name ?? ""
                
                DispatchQueue.main.async {
                    self.welcomeLabel.text = "Welcome \(userName.components(separatedBy: " ").first ?? "" )"
                    self.percentLabel.text = "\(percent)%"
                    self.profileCircleLabel.text = initialsOfName
                    self.userNameLabel.text = userName
                    self.designationLabel.text = "\(user.designation!)"
                    self.locationLabel.text = "\(user.currentAddress?.city ?? ""), \(user.currentAddress?.state ?? "")"
                    self.fetchProfilePicture(size: "m", userID: user._id)
                }
            } catch {
                print("Failed to decode JSON: \(error)")
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
    
    func calculateProfileCompletion(for user: User) -> Int {
        var totalCount = 0
        var filledCount = 0

        // Reflecting over User properties
        let mirror = Mirror(reflecting: user)

        for child in mirror.children {
            totalCount += 1
            if let value = child.value as? String, !value.isEmpty {
                filledCount += 1
            } else if let array = child.value as? [Any], !array.isEmpty {
                filledCount += 1
            } else if let array = child.value as? [Language], !array.isEmpty {
                filledCount += 1
            } else if let address = child.value as? Address, address.address != nil && !address.address.isEmpty, address.pincode != nil && !address.pincode.isEmpty {
                filledCount += 1
            } else if let boolValue = child.value as? Bool {
                if boolValue {
                    filledCount += 1
                }
            } else if let intValue = child.value as? Int, intValue != 0 {
                filledCount += 1
            }
        }

        let completionPercentage = (filledCount * 100) / totalCount
        return completionPercentage
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
//                    print("Image Fetched Successfully")
                } else {
                    print("Failed to decode image")
                }
            }
        }

        task.resume()
    }


    func fetchRecommendedJobs() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/recommended-jobs") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw response data: \(responseString)")
            }
            
            do {
                // Decode directly as an array of dictionaries
                if let jobArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    
                    // Map dictionaries to Job objects
                    let decoder = JSONDecoder()
                    let jobData = try JSONSerialization.data(withJSONObject: jobArray, options: [])
                    let jobs = try decoder.decode([Job].self, from: jobData)
                    
                    // Update the jobs array on the main thread
                    DispatchQueue.main.async {
                        self.jobs = jobs
                        print(jobs.count)
                        if jobs.count == 0 {
                            self.noJobsImageView.isHidden = false
                        }
                        self.recommendedJobsCollectionVC.reloadData()
                    }
                }
            } catch {
                print("Failed to decode Recommended JSON: \(error)")
            }
            DispatchQueue.main.async {
                if self.jobs.count == 0 {
                    self.noJobsImageView.isHidden = false
                }
            }
        }
        task.resume()
    }
    
    func fetchTotalAppliedJobIDs() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/appliedJobs") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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
            
            // Print the raw response data as a string
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Raw response data: \(responseString)")
//            }

            do {
                // Decode the JSON response as a dictionary with jobIds array
                let responseDict = try JSONDecoder().decode([String: [String]].self, from: data)
                
                if let jobIds = responseDict["jobIds"] {
                    print("Job IDs: \(jobIds)")
                    
                    // Process the job IDs as needed
                    DispatchQueue.main.async {
                        self.appliedJobs = jobIds
                        self.recommendedJobsCollectionVC.reloadData()
                    }
                } else {
                    print("Failed to find job IDs in the response")
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        task.resume()
    }
}

// dimag kam nhi kr rha bc

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        // Replace specific color if it matches the old color
        if hexSanitized.lowercased() == "0079c4" {
            hexSanitized = "0056E2"
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
