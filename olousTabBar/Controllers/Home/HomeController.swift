//
//  HomeController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
// ************************************** Variables ***************************************
    
    
    let scrollView = UIScrollView()
    var jobsArray : [String] = ["a", "ab", "abc", "y", "yz"];
    
    var headerView : UIView = UIView()
    var olousLogo : UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "OlousLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var notificationBellIcon : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "bell")
        imgView.tintColor = UIColor(hex: "#000000")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    var jobSearchSection : UIView = UIView()
    
    var jobSearchInnerSection : UIView = UIView()
    
    let jobsTextField = UITextField()
    let locationTextField = UITextField()
    
    let scrollSection = UIView()
    var horizontalScrollView : UIScrollView!
    let firstView = UIView()
    let secondView = UIView()
    let thirdView = UIView()
    
    let separatorLine = UIView()
    
    var recommendedJobsView = UIView()
    var recommendedJobsCollectionVC : UICollectionView!
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
    
    
// *********************** View Did Load ***************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        setupHeaderView()
        setupOlousLogo()
        setupBellIcon()
        setupScrollView()
        setupJobSearchSection()
        setupJobSearchInnerSection()
        
        setupHorizontalScroll()
        
        setupSeparatorView1()
        
        setupRecommendedJobsView()
        
        
        
        setupSeparatorView2()
        setupTopCompaniesView()
        
        setupFirstView()
        setupSecondView()
        setupThirdView()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    
// ************************************ Functions *******************************************
    
    func setupHeaderView() {
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupOlousLogo() {
        olousLogo.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(olousLogo)
        
        NSLayoutConstraint.activate([
            olousLogo.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            olousLogo.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            olousLogo.widthAnchor.constraint(equalToConstant: 150),
            olousLogo.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupBellIcon() {
        notificationBellIcon.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(notificationBellIcon)
        NSLayoutConstraint.activate([
            notificationBellIcon.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 4),
            notificationBellIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            notificationBellIcon.widthAnchor.constraint(equalToConstant: 30),
            notificationBellIcon.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        let extraSpaceHeight: CGFloat = 100
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }

    func setupJobSearchSection() {
        jobSearchSection.backgroundColor = UIColor(hex: "#0079C4")
        // #007AFF systemBlue
        jobSearchSection.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(jobSearchSection)
        
        NSLayoutConstraint.activate([
            jobSearchSection.topAnchor.constraint(equalTo: scrollView.topAnchor),
            jobSearchSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            jobSearchSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            jobSearchSection.heightAnchor.constraint(equalToConstant: 164)
        ])
    }
    
    func setupJobSearchInnerSection() {
        jobSearchInnerSection.backgroundColor = .systemBackground
        jobSearchInnerSection.layer.cornerRadius = 12
        jobSearchInnerSection.translatesAutoresizingMaskIntoConstraints = false
        jobSearchSection.addSubview(jobSearchInnerSection)
        
        NSLayoutConstraint.activate([
            jobSearchInnerSection.topAnchor.constraint(equalTo: jobSearchSection.topAnchor, constant: 32),
            jobSearchInnerSection.leadingAnchor.constraint(equalTo: jobSearchSection.leadingAnchor, constant: 16),
            jobSearchInnerSection.trailingAnchor.constraint(equalTo: jobSearchSection.trailingAnchor, constant: -16),
            jobSearchInnerSection.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let searchIcon : UIImageView = UIImageView()
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.tintColor = UIColor(hex: "#667085")
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(searchIcon)
        
        NSLayoutConstraint.activate([
            searchIcon.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 14),
            searchIcon.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 16),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor(hex: "#EAECF0")
        jobSearchInnerSection.addSubview(separatorLine)
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorLine.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor).isActive = true
        separatorLine.trailingAnchor.constraint(equalTo: jobSearchInnerSection.trailingAnchor).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: jobSearchInnerSection.bottomAnchor, constant: -49).isActive = true
        
        
        jobsTextField.placeholder = "Enter Job Title"
        jobsTextField.isUserInteractionEnabled = false
        jobsTextField.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(jobsTextField)
        
        NSLayoutConstraint.activate([
            jobsTextField.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 14),
            jobsTextField.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 46),
            jobsTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            jobsTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let locationIcon : UIImageView = UIImageView()
        locationIcon.image = UIImage(named: "locationLogo")
        locationIcon.tintColor = UIColor(hex: "#667085")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(locationIcon)
        
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 63),
            locationIcon.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 18),
            locationIcon.widthAnchor.constraint(equalToConstant: 21),
            locationIcon.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        locationTextField.placeholder = "Enter Location"
        locationTextField.isUserInteractionEnabled = false
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(locationTextField)
        
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 63),
            locationTextField.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 47),
            locationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            locationTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapJobSearchInnerSection))
        jobSearchInnerSection.addGestureRecognizer(tap)
    }
    
    @objc func didTapJobSearchInnerSection() {
        let jobSearchVC = JobSearchScreen()
        navigationController?.pushViewController(jobSearchVC, animated: true)
    }
    
    
    
    func setupHorizontalScroll() {
        scrollSection.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(scrollSection)
        NSLayoutConstraint.activate([
            scrollSection.topAnchor.constraint(equalTo: jobSearchSection.bottomAnchor, constant: 0),
            scrollSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollSection.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        horizontalScrollView = UIScrollView()
        horizontalScrollView.showsHorizontalScrollIndicator = false
        let contentWidth = (view.frame.width - 48) * CGFloat(3) + 16 * CGFloat(3) + 16// Total width of subviews including spacing
        horizontalScrollView.contentSize = CGSize(width: contentWidth, height: 150)
        
        horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollSection.addSubview(horizontalScrollView)
        NSLayoutConstraint.activate([
            horizontalScrollView.topAnchor.constraint(equalTo: scrollSection.topAnchor, constant: 0),
            horizontalScrollView.leadingAnchor.constraint(equalTo: scrollSection.leadingAnchor),
            horizontalScrollView.trailingAnchor.constraint(equalTo: scrollSection.trailingAnchor),
            horizontalScrollView.widthAnchor.constraint(equalToConstant: view.frame.width * 3),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        firstView.backgroundColor = UIColor(hex: "#F0F9FF")
        firstView.layer.borderColor = UIColor(hex: "#DEF2FF").cgColor
        firstView.layer.borderWidth = 1
        firstView.layer.cornerRadius = 8
        
        firstView.translatesAutoresizingMaskIntoConstraints = false
        horizontalScrollView.addSubview(firstView)
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor, constant: 16),
            firstView.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor, constant: 16),
            firstView.widthAnchor.constraint(equalToConstant: view.frame.width - 48),
            firstView.heightAnchor.constraint(equalToConstant: 148)
        ])
        
        
        secondView.backgroundColor = UIColor(hex: "#FFFAEB")
        secondView.layer.borderWidth = 1
        secondView.layer.borderColor = UIColor(hex: "#FEF0C7").cgColor
        secondView.layer.cornerRadius = 8
        
        secondView.translatesAutoresizingMaskIntoConstraints = false
        horizontalScrollView.addSubview(secondView)
        NSLayoutConstraint.activate([
            secondView.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor, constant: 16),
            secondView.leadingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: 16),
            secondView.widthAnchor.constraint(equalToConstant: view.frame.width - 48),
            secondView.heightAnchor.constraint(equalToConstant: 148)
        ])
        
        thirdView.backgroundColor = UIColor(hex: "#ECFDF3")
        thirdView.layer.borderWidth = 1
        thirdView.layer.borderColor = UIColor(hex: "#DCFAE6").cgColor
        thirdView.layer.cornerRadius = 8
        
        thirdView.translatesAutoresizingMaskIntoConstraints = false
        horizontalScrollView.addSubview(thirdView)
        NSLayoutConstraint.activate([
            thirdView.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor, constant: 16),
            thirdView.leadingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: 16),
            thirdView.widthAnchor.constraint(equalToConstant: view.frame.width - 48),
            thirdView.heightAnchor.constraint(equalToConstant: 148)
        ])
    }
    
    func setupFirstView() {
        let circleContainerView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        circleContainerView.backgroundColor = UIColor(hex: "#D7F0FF")
        circleContainerView.layer.cornerRadius = 50
        
        circleContainerView.translatesAutoresizingMaskIntoConstraints = false
        firstView.addSubview(circleContainerView)
        NSLayoutConstraint.activate([
            circleContainerView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 24),
            circleContainerView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 16),
            circleContainerView.widthAnchor.constraint(equalToConstant: 100),
            circleContainerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let profileCircleLabel : UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = UIColor(hex: "#0079C4")
            label.font = .boldSystemFont(ofSize: 40)
            return label
        }()
        profileCircleLabel.text = "AS"
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        circleContainerView.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: circleContainerView.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: circleContainerView.centerYAnchor)
        ])
        
        
        let percentLabel : UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = "75%"
            label.textColor = UIColor(hex: "#219653")
            label.font = .boldSystemFont(ofSize: 16)
            return label
        }()
        
        let percentView = UIView()
        percentView.backgroundColor = UIColor(hex: "#E2FFEE")
        percentView.layer.cornerRadius = 14
        
        percentView.translatesAutoresizingMaskIntoConstraints = false
        firstView.addSubview(percentView)
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
        let percentage: CGFloat = 0.75
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
        
        let userNameLabel : UILabel = {
            let label = UILabel()
            label.text = "Hi, Ajay Sarkate"
            label.font = .boldSystemFont(ofSize: 18)
            label.textColor = UIColor(hex: "#101828")
            return label
        }()
        
        let pendingLabel : UILabel = {
            let label = UILabel()
            let attributedString = NSMutableAttributedString(string: "5 pending actions")
            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#EB5757"), range: NSRange(location: 0, length: 1))
            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#344054"), range: NSRange(location: 1, length: attributedString.length - 1))
        
            label.attributedText = attributedString
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        
        let updateProfilButton : UIButton = {
            let button = UIButton()
            
            let title = NSAttributedString(string: "   Update your profile   ",
                                                attributes: [.font: UIFont.boldSystemFont(ofSize: 18),
                                                             .foregroundColor: UIColor(hex: "#00629E")])
            button.setAttributedTitle(title, for: .normal)
            button.backgroundColor = UIColor(hex: "#D7F0FF")
            button.layer.cornerRadius = 12
            button.addTarget(self, action: #selector(didTapUpdateProfile), for: .touchUpInside)
            return button
        }()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        // Add subviews to stack view
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(pendingLabel)
        stackView.addArrangedSubview(updateProfilButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        firstView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: circleContainerView.trailingAnchor, constant: 16)
        ])
    }
    
    func setupSecondView() {
        let circleContainerView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        circleContainerView.backgroundColor = UIColor(hex: "#FFE28F")
        circleContainerView.layer.opacity = 0.4
        circleContainerView.layer.cornerRadius = 50
        
        circleContainerView.translatesAutoresizingMaskIntoConstraints = false
        secondView.addSubview(circleContainerView)
        NSLayoutConstraint.activate([
            circleContainerView.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 24),
            circleContainerView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 16),
            circleContainerView.widthAnchor.constraint(equalToConstant: 100),
            circleContainerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let profileCircleLabel : UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 40)
            return label
        }()
        profileCircleLabel.text = "48"
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        secondView.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: circleContainerView.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: circleContainerView.centerYAnchor)
        ])
        
        
        let recruiterActionsLabel : UILabel = {
            let label = UILabel()
            let attributedString = NSMutableAttributedString(string: "Recruiter actions on your profile")
//            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#EB5757"), range: NSRange(location: 0, length: 1))
            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#344054"), range: NSRange(location: 0, length: attributedString.length ))
        
            label.attributedText = attributedString
            label.font = .systemFont(ofSize: 18)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let viewDetailsButton : UIButton = {
            let button = UIButton()
            
            let title = NSAttributedString(string: "   View details   ",
                                                attributes: [.font: UIFont.boldSystemFont(ofSize: 18),
                                                             .foregroundColor: UIColor(hex: "#00629E")])
            button.setAttributedTitle(title, for: .normal)
            button.backgroundColor = UIColor(hex: "#D7F0FF")
            button.layer.cornerRadius = 12
            button.addTarget(self, action: #selector(didTapViewActionDetails), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        secondView.addSubview(recruiterActionsLabel)
        secondView.addSubview(viewDetailsButton)
        NSLayoutConstraint.activate([
            recruiterActionsLabel.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 30),
            recruiterActionsLabel.leadingAnchor.constraint(equalTo: circleContainerView.trailingAnchor, constant: 16),
            recruiterActionsLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -16),
            
            viewDetailsButton.topAnchor.constraint(equalTo: recruiterActionsLabel.bottomAnchor, constant: 20),
            viewDetailsButton.leadingAnchor.constraint(equalTo: circleContainerView.trailingAnchor, constant: 16)
        ])
    }
    
    func setupThirdView() {
        let circleContainerView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        circleContainerView.backgroundColor = UIColor(hex: "#CEF4DE")
        circleContainerView.layer.opacity = 0.4
        circleContainerView.layer.cornerRadius = 50
        
        circleContainerView.translatesAutoresizingMaskIntoConstraints = false
        thirdView.addSubview(circleContainerView)
        NSLayoutConstraint.activate([
            circleContainerView.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 24),
            circleContainerView.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 16),
            circleContainerView.widthAnchor.constraint(equalToConstant: 100),
            circleContainerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let profileCircleLabel : UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 40)
            return label
        }()
        profileCircleLabel.text = "128"
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdView.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: circleContainerView.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: circleContainerView.centerYAnchor)
        ])
        
        
        let searchAppearanceLabel : UILabel = {
            let label = UILabel()
            let attributedString = NSMutableAttributedString(string: "Search appearance")
//            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#EB5757"), range: NSRange(location: 0, length: 1))
            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#344054"), range: NSRange(location: 0, length: attributedString.length ))
        
            label.attributedText = attributedString
            label.font = .systemFont(ofSize: 18)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let viewDetailsButton : UIButton = {
            let button = UIButton()
            
            let title = NSAttributedString(string: "   View details   ",
                                                attributes: [.font: UIFont.boldSystemFont(ofSize: 18),
                                                             .foregroundColor: UIColor(hex: "#00629E")])
            button.setAttributedTitle(title, for: .normal)
            button.backgroundColor = UIColor(hex: "#D7F0FF")
            button.layer.cornerRadius = 12
            button.addTarget(self, action: #selector(didTapViewSearchAppearanceDetails), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        thirdView.addSubview(searchAppearanceLabel)
        thirdView.addSubview(viewDetailsButton)
        NSLayoutConstraint.activate([
            searchAppearanceLabel.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 30),
            searchAppearanceLabel.leadingAnchor.constraint(equalTo: circleContainerView.trailingAnchor, constant: 16),
            searchAppearanceLabel.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -16),
            
            viewDetailsButton.topAnchor.constraint(equalTo: searchAppearanceLabel.bottomAnchor, constant: 20),
            viewDetailsButton.leadingAnchor.constraint(equalTo: circleContainerView.trailingAnchor, constant: 16)
        ])
    }
    
    @objc func didTapUpdateProfile() {
        tabBarController?.selectedIndex = 3
        UIView.transition(with: tabBarController!.view!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    @objc func didTapViewActionDetails() {
        
    }
    @objc func didTapViewSearchAppearanceDetails() {
        
    }
    
    func setupSeparatorView1() {
        
        separatorLine.backgroundColor = UIColor(hex: "#F9FAFB")
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: scrollSection.bottomAnchor),
            separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 8)
        ])
        
    }
    
    
    func setupRecommendedJobsView() {
        recommendedJobsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(recommendedJobsView)
        
        NSLayoutConstraint.activate([
            recommendedJobsView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 16),
            recommendedJobsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recommendedJobsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recommendedJobsView.heightAnchor.constraint(equalToConstant: 278)
        ])
        
        let label = UILabel()
        label.text = "Recommended Jobs"
        label.font = .boldSystemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        recommendedJobsView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: recommendedJobsView.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: recommendedJobsView.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        viewAllJobsButton.addTarget(self, action: #selector(didTapViewAllJobs), for: .touchUpInside)
        viewAllJobsButton.translatesAutoresizingMaskIntoConstraints = false
        recommendedJobsView.addSubview(viewAllJobsButton)
        
        NSLayoutConstraint.activate([
            viewAllJobsButton.topAnchor.constraint(equalTo: recommendedJobsView.topAnchor, constant: 10),
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
            recommendedJobsCollectionVC.topAnchor.constraint(equalTo: recommendedJobsView.topAnchor, constant: 60),
            recommendedJobsCollectionVC.leadingAnchor.constraint(equalTo: recommendedJobsView.leadingAnchor, constant: 16),
            recommendedJobsCollectionVC.trailingAnchor.constraint(equalTo: recommendedJobsView.trailingAnchor),
            recommendedJobsCollectionVC.bottomAnchor.constraint(equalTo: recommendedJobsView.bottomAnchor, constant: -19)
        ])
    }
    
    
    func setupSeparatorView2() {
        
        separatorLine2.backgroundColor = UIColor(hex: "#F9FAFB")
        
        separatorLine2.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine2)
        
        NSLayoutConstraint.activate([
            separatorLine2.topAnchor.constraint(equalTo: recommendedJobsView.bottomAnchor),
            separatorLine2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine2.heightAnchor.constraint(equalToConstant: 8)
        ])
        
    }
    
    
    func setupTopCompaniesView() {
        
        topCompaniesView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(topCompaniesView)
        
        NSLayoutConstraint.activate([
            topCompaniesView.topAnchor.constraint(equalTo: separatorLine2.bottomAnchor, constant: 28),
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
            label.topAnchor.constraint(equalTo: topCompaniesView.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: topCompaniesView.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: 170),
            label.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        viewAllCompaniesButton.addTarget(self, action: #selector(didTapViewAllCompanies), for: .touchUpInside)
        viewAllCompaniesButton.translatesAutoresizingMaskIntoConstraints = false
        topCompaniesView.addSubview(viewAllCompaniesButton)
        
        NSLayoutConstraint.activate([
            viewAllCompaniesButton.topAnchor.constraint(equalTo: topCompaniesView.topAnchor, constant: 10),
            viewAllCompaniesButton.leadingAnchor.constraint(equalTo: topCompaniesView.leadingAnchor, constant: view.frame.width - 93),
            viewAllCompaniesButton.widthAnchor.constraint(equalToConstant: 73),
            viewAllCompaniesButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        setupCompaniesCollectionVC()
    }
    @objc func didTapViewAllCompanies() {
        print(#function)
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == companiesCollectionVC {
            return 10
        }
        return 5
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
            cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 12
            cell.saveButton.isHidden = true
            cell.jobExperienceLabel.isHidden = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == companiesCollectionVC {
            return .init(width: 228, height: 182)
        }
        return .init(width: 306, height: 198)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recommendedJobsCollectionVC {
            tabBarController?.selectedIndex = 1
            UIView.transition(with: tabBarController!.view!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
   
}



extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
