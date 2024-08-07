//
//  EmploymentsVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 05/04/24.
//

import UIKit

class EmploymentsVC: UIViewController, UITextFieldDelegate {
    
    var headerView : UIView!
    var circleContainerView : UIView!
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "ADD YOUR EMPLOYMENT"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hex: "#101828")
        return label
    }()
    
    var loader: LoadingView!
    
    var scrollView : UIScrollView!
    
    var employmentsCV : UICollectionView!
    var dataArray : [Employment] = []
    var employmentsCVHeightConstraint: NSLayoutConstraint!
    
    
    var companyTextField : UITextField!
    var jobTitleTextField : UITextField!
    var empPeriodTextField : UITextField!
    
    
    var startButton : UIButton!
    let startYearPlaceholder : UILabel = {
        let label = UILabel()
        label.text = "Select years"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    var startArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "30+"]
    var startTableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        tableView.isHidden = true
        return tableView
    }()
    
    var passingButton : UIButton!
    let passYearPlaceholder : UILabel = {
        let label = UILabel()
        label.text = "Select months"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    var passArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    var passTableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        tableView.isHidden = true
        return tableView
    }()
    
    var selectedEmploymentTypeOption : UIButton?
    
    
    var bottomView : UIView!
    
    var editView : UIView!
    var editExpTitleTF : UITextField!
    var editExpCompanyTF : UITextField!
    var editYearsOfExpTF : UITextField!
    var editExpPeriodTF : UITextField!
    var saveButton: UIButton!
    var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        fetchAndParseExperience()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loader = LoadingView()
        loader.isHidden = true
        loader.backgroundColor = UIColor(hex: "#DB7F14").withAlphaComponent(0.05)
        loader.layer.cornerRadius = 20
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        
        let imgView = UIImageView()
        imgView.image = UIImage(named: "AISymbol")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        loader.addSubview(imgView)
        
        let label = UILabel()
        label.text = "Employments are being generated..."
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        loader.addSubview(label)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: 300),
            loader.heightAnchor.constraint(equalToConstant: 80),
            
            imgView.centerYAnchor.constraint(equalTo: loader.centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: loader.leadingAnchor, constant: 16),
            imgView.heightAnchor.constraint(equalToConstant: 40),
            imgView.widthAnchor.constraint(equalToConstant: 40),
            
            label.centerYAnchor.constraint(equalTo: loader.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: loader.trailingAnchor, constant: -16)
        ])
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = loader.frame

        let color1 = UIColor(hex: "#5825EB").withAlphaComponent(0.11).cgColor
        let color2 = UIColor(hex: "#DB7F14").withAlphaComponent(0.11).cgColor
        
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: gradientLayer.bounds, cornerRadius: 20)
        maskLayer.path = path.cgPath
        
        // Apply the mask to the gradient layer
        gradientLayer.mask = maskLayer
        
        loader.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update gradient layer frame to match the loader's frame
        if let gradientLayer = loader.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer.frame = loader.bounds
            // Update the mask path as well
            if let maskLayer = gradientLayer.mask as? CAShapeLayer {
                let path = UIBezierPath(roundedRect: gradientLayer.bounds, cornerRadius: 20)
                maskLayer.path = path.cgPath
            }
        }
    }
    
    
    func setupViews() {
        setupHeaderView()
        setupTitle()
        setupScrollView()
        
        setupEmploymentsView()
        setupAddEmployment()
        
        setupBottomView()
        
        setupAddEmploymentView()
        setupEditViewComponents()
    }
    
    func setupHeaderView() {
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        var stepsLabel = UILabel()
        stepsLabel.text = "Steps"
        stepsLabel.textColor = UIColor(hex: "#1D2026")
        stepsLabel.font = .boldSystemFont(ofSize: 24)
        stepsLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(stepsLabel)
        
        var stepsScrollView = UIScrollView()
        stepsScrollView.showsHorizontalScrollIndicator = false
        stepsScrollView.contentSize = CGSize(width: view.frame.width * 3, height: 300)
        stepsScrollView.contentOffset = CGPoint(x: 168, y: 0)
        stepsScrollView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(stepsScrollView)

        NSLayoutConstraint.activate([
            stepsLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            stepsLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            stepsScrollView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 36),
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

        var currentStepIndex = 1
        var completedStepIndex = 0
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
        currentStepLabel.text = "STEP 3 OF 10"
        currentStepLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        currentStepLabel.textColor = .gray
        headerView.addSubview(currentStepLabel)
        currentStepLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the main step title
        let mainStepTitleLabel = UILabel()
        mainStepTitleLabel.text = "ADD EMPLOYMENT"
        mainStepTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        headerView.addSubview(mainStepTitleLabel)
        mainStepTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress view
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(hex: "#2563EB")
        progressView.trackTintColor = UIColor(hex: "#E5E7EB")
        progressView.setProgress(0.3, animated: true)
        headerView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress label
        let progressLabel = UILabel()
        progressLabel.text = "30%"
        progressLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        progressLabel.textColor = .gray
        headerView.addSubview(progressLabel)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up constraints
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            currentStepLabel.topAnchor.constraint(equalTo: stepsScrollView.bottomAnchor, constant: 20),
            currentStepLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            mainStepTitleLabel.topAnchor.constraint(equalTo: currentStepLabel.bottomAnchor, constant: 8),
            mainStepTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            progressView.topAnchor.constraint(equalTo: mainStepTitleLabel.bottomAnchor, constant: 16),
            progressView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -52),
            
            progressLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
            headerView.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 16)
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
    
    
    
    func setupTitle() {
        titleLabel.isHidden = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -50),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
        
        let extraSpaceHeight: CGFloat = 150
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
//        let contentHeight = view.bounds.height - 300
//        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    func setupEmploymentsView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        employmentsCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        employmentsCV.register(OnboardingEmpCell.self, forCellWithReuseIdentifier: "exp")
        employmentsCV.delegate = self
        employmentsCV.dataSource = self
        
        employmentsCV.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(employmentsCV)
        NSLayoutConstraint.activate([
            employmentsCV.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            employmentsCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            employmentsCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        employmentsCVHeightConstraint = employmentsCV.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        employmentsCVHeightConstraint.isActive = true
        
//        reloadCollectionView()
    }
    
    func reloadCollectionView() {
        employmentsCV.reloadData()
            
        // Calculate the content size
        employmentsCV.layoutIfNeeded()
        let contentSize = employmentsCV.collectionViewLayout.collectionViewContentSize
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentSize.height + 50)
        
        // Update the height constraint based on content size
        employmentsCVHeightConstraint.constant = contentSize.height
        
        // Update constraints
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    var addExpContainer = UIView()
    func setupAddEmployment() {
        
        let box : UIView = {
            let views = UIView()
            views.backgroundColor = UIColor(hex: "#F9FAFB")
            views.layer.borderWidth = 1 // Add border to the container
            views.layer.cornerRadius = 8 // Add corner radius for rounded corners
            views.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor // Set border color
            views.translatesAutoresizingMaskIntoConstraints = false
            return views
        }()
        scrollView.addSubview(box)
        
        let addNewExpLabel : UILabel = {
            let label = UILabel()
            label.text = "Add New Employment"
            label.font = .boldSystemFont(ofSize: 18)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        box.addSubview(addNewExpLabel)
        
        let addExpButton : UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
            button.tintColor = UIColor(hex: "#344054")
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        addExpButton.addTarget(self, action: #selector(didTapAddExperience), for: .touchUpInside)
        box.addSubview(addExpButton)
        
        NSLayoutConstraint.activate([
            box.topAnchor.constraint(equalTo: employmentsCV.bottomAnchor, constant: 50),
            box.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            box.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            box.heightAnchor.constraint(equalToConstant: 50),
            
            addNewExpLabel.topAnchor.constraint(equalTo: box.topAnchor, constant: 15),
            addNewExpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            addExpButton.centerYAnchor.constraint(equalTo: box.centerYAnchor),
            addExpButton.trailingAnchor.constraint(equalTo: box.trailingAnchor, constant: -16)
        ])
        
    }
    
    func setupAddEmploymentView() {
        addExpContainer.backgroundColor = .white
        addExpContainer.layer.cornerRadius = 12
        addExpContainer.layer.shadowOpacity = 0.25
        addExpContainer.layer.shadowRadius = 5
        addExpContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        addExpContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addExpContainer)
        
        NSLayoutConstraint.activate([
            addExpContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addExpContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addExpContainer.heightAnchor.constraint(equalToConstant: view.frame.height - 100),
            addExpContainer.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
        ])
        
        let companyLabel = UILabel()
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText2 = NSMutableAttributedString(string: "Company name")
        let asterisk2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText2.append(asterisk2)
        companyLabel.attributedText = attributedText2
        companyLabel.font = .boldSystemFont(ofSize: 16)
        companyLabel.textColor = UIColor(hex: "#344054")
        addExpContainer.addSubview(companyLabel)
        
        // company TextField
        companyTextField = UITextField()
        companyTextField.translatesAutoresizingMaskIntoConstraints = false
        companyTextField.borderStyle = .roundedRect
        companyTextField.placeholder = "E.g. Salt Technologies"
        companyTextField.delegate = self // Set delegate for this text field
        addExpContainer.addSubview(companyTextField)
        
        let jobTitleLabel = UILabel()
        jobTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText3 = NSMutableAttributedString(string: "Designation")
        let asterisk3 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText3.append(asterisk3)
        jobTitleLabel.attributedText = attributedText3
        jobTitleLabel.font = .boldSystemFont(ofSize: 16)
        jobTitleLabel.textColor = UIColor(hex: "#344054")
        addExpContainer.addSubview(jobTitleLabel)
        
        // jobTitle TextField
        jobTitleTextField = UITextField()
        jobTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        jobTitleTextField.borderStyle = .roundedRect
        jobTitleTextField.placeholder = "E.g. Civil Engineer"
        jobTitleTextField.delegate = self // Set delegate for this text field
        addExpContainer.addSubview(jobTitleTextField)
        
        
        let startYearLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Total year")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        addExpContainer.addSubview(startYearLabel)
        
        let container : UIView = {
            let views = UIView()
            views.translatesAutoresizingMaskIntoConstraints = false
            views.layer.borderWidth = 1 // Add border to the container
            views.layer.cornerRadius = 5 // Add corner radius for rounded corners
            views.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor // Set border color
            
            return views
        }()
        addExpContainer.addSubview(container)
        
        
        startYearPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(startYearPlaceholder)
        
        // Create a dropdown button
        startButton = UIButton(type: .system)
        startButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        startButton.tintColor = UIColor(hex: "#667085")
        startButton.addTarget(self, action: #selector(startDropdownButtonTapped), for: .touchUpInside)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(startButton)
        
        startTableView.delegate = self
        startTableView.dataSource = self
        startTableView.translatesAutoresizingMaskIntoConstraints = false
        addExpContainer.addSubview(startTableView)
        
        // passing year UI
        let passYearLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Months")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        addExpContainer.addSubview(passYearLabel)
        
        let container2 : UIView = {
            let views = UIView()
            views.translatesAutoresizingMaskIntoConstraints = false
            views.layer.borderWidth = 1 // Add border to the container
            views.layer.cornerRadius = 5 // Add corner radius for rounded corners
            views.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor // Set border color
            
            return views
        }()
        addExpContainer.addSubview(container2)
        
        passYearPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        container2.addSubview(passYearPlaceholder)
        
        passingButton = UIButton(type: .system)
        passingButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        passingButton.tintColor = UIColor(hex: "#667085")
        passingButton.addTarget(self, action: #selector(passDropdownButtonTapped), for: .touchUpInside)
        
        passingButton.translatesAutoresizingMaskIntoConstraints = false
        container2.addSubview(passingButton)
        
        passTableView.delegate = self
        passTableView.dataSource = self
        passTableView.translatesAutoresizingMaskIntoConstraints = false
        addExpContainer.addSubview(passTableView)
        
        
        let empPeriodLabel = UILabel()
        empPeriodLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText5 = NSMutableAttributedString(string: "Employment Period")
        let asterisk5 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText5.append(asterisk5)
        empPeriodLabel.attributedText = attributedText5
        empPeriodLabel.font = .boldSystemFont(ofSize: 16)
        empPeriodLabel.textColor = UIColor(hex: "#344054")
        addExpContainer.addSubview(empPeriodLabel)
        
        // employment period TextField
        empPeriodTextField = UITextField()
        empPeriodTextField.translatesAutoresizingMaskIntoConstraints = false
        empPeriodTextField.borderStyle = .roundedRect
        empPeriodTextField.placeholder = "E.g. 05/2022 - 01/2024"
        empPeriodTextField.delegate = self // Set delegate for this text field
        addExpContainer.addSubview(empPeriodTextField)
        
        
        let jobTypeLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Employment type")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        addExpContainer.addSubview(jobTypeLabel)
        
        let jobTypeOptions = ["Full-Time", "Part-Time", "Freelance"]
        
        let jobStackView = UIStackView()
        jobStackView.axis = .horizontal
        jobStackView.spacing = 12
        jobStackView.translatesAutoresizingMaskIntoConstraints = false
        addExpContainer.addSubview(jobStackView)
        
        // Add options buttons to the stack view
        for option in jobTypeOptions {
            let optionButton = UIButton(type: .system)
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            optionButton.layer.cornerRadius = 8
            optionButton.setTitle("  \(option)  ", for: .normal)
            optionButton.titleLabel?.font = .systemFont(ofSize: 16)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.addTarget(self, action: #selector(employmentTypeButtonTapped(_:)), for: .touchUpInside)
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            jobStackView.addArrangedSubview(optionButton)
            
            if option == "Full-Time" {
                optionButton.layer.borderColor = UIColor(hex: "#0079C4").cgColor
                optionButton.titleLabel?.textColor = UIColor(hex: "#0079C4")
                optionButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
                
                selectedEmploymentTypeOption = optionButton
            }
        }
        
        let saveEmploymentButton = UIButton()
        saveEmploymentButton.setTitle("Save", for: .normal)
        saveEmploymentButton.titleLabel?.font = .systemFont(ofSize: 20)
        saveEmploymentButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        saveEmploymentButton.backgroundColor = UIColor(hex: "#0079C4")
        saveEmploymentButton.layer.cornerRadius = 8
        saveEmploymentButton.addTarget(self, action: #selector(saveAddButtonTapped), for: .touchUpInside)
        
        saveEmploymentButton.translatesAutoresizingMaskIntoConstraints = false
        addExpContainer.addSubview(saveEmploymentButton)
        
        let cancelEducationButton = UIButton(type: .system)
        cancelEducationButton.setTitle("Cancel", for: .normal)
        cancelEducationButton.titleLabel?.font = .systemFont(ofSize: 20)
        cancelEducationButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        cancelEducationButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        cancelEducationButton.layer.borderWidth = 1
        cancelEducationButton.layer.cornerRadius = 8
        cancelEducationButton.addTarget(self, action: #selector(cancelAddButtonTapped), for: .touchUpInside)
        
        cancelEducationButton.translatesAutoresizingMaskIntoConstraints = false
        addExpContainer.addSubview(cancelEducationButton)
        
        
        addExpContainer.bringSubviewToFront(passTableView)
        addExpContainer.bringSubviewToFront(startTableView)
        
        let width = (view.frame.width - 52) / 2
        
        NSLayoutConstraint.activate([
            companyLabel.topAnchor.constraint(equalTo: addExpContainer.topAnchor, constant: 20),
            companyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            companyTextField.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            companyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            companyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            companyTextField.heightAnchor.constraint(equalToConstant: 50),
            
            jobTitleLabel.topAnchor.constraint(equalTo: companyTextField.bottomAnchor, constant: 20),
            jobTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            jobTitleTextField.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 10),
            jobTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jobTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            jobTitleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            startYearLabel.topAnchor.constraint(equalTo: jobTitleTextField.bottomAnchor, constant: 20),
            startYearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            container.topAnchor.constraint(equalTo: startYearLabel.bottomAnchor, constant: 10),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.widthAnchor.constraint(equalToConstant: width),
            container.heightAnchor.constraint(equalToConstant: 40),
            
            startYearPlaceholder.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            startYearPlaceholder.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            
            startButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            startButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            startTableView.topAnchor.constraint(equalTo: container.bottomAnchor),
            startTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startTableView.widthAnchor.constraint(equalToConstant: width),
            startTableView.heightAnchor.constraint(equalToConstant: 100),
            
            passYearLabel.topAnchor.constraint(equalTo: startYearLabel.topAnchor),
            passYearLabel.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 20),
            
            container2.topAnchor.constraint(equalTo: passYearLabel.bottomAnchor, constant: 10),
            container2.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 20),
            container2.widthAnchor.constraint(equalToConstant: width),
            container2.heightAnchor.constraint(equalToConstant: 40),
            
            passYearPlaceholder.centerYAnchor.constraint(equalTo: container2.centerYAnchor),
            passYearPlaceholder.leadingAnchor.constraint(equalTo: container2.leadingAnchor, constant: 10),
            
            passingButton.centerYAnchor.constraint(equalTo: container2.centerYAnchor),
            passingButton.trailingAnchor.constraint(equalTo: container2.trailingAnchor, constant: -10),
            
            passTableView.topAnchor.constraint(equalTo: container2.bottomAnchor),
            passTableView.leadingAnchor.constraint(equalTo: container2.leadingAnchor),
            passTableView.widthAnchor.constraint(equalToConstant: width),
            passTableView.heightAnchor.constraint(equalToConstant: 100),
            
            empPeriodLabel.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 20),
            empPeriodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            empPeriodTextField.topAnchor.constraint(equalTo: empPeriodLabel.bottomAnchor, constant: 10),
            empPeriodTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            empPeriodTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            empPeriodTextField.heightAnchor.constraint(equalToConstant: 50),
            
            jobTypeLabel.topAnchor.constraint(equalTo: empPeriodTextField.bottomAnchor, constant: 20),
            jobTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            jobStackView.topAnchor.constraint(equalTo: jobTypeLabel.bottomAnchor, constant: 10),
            jobStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            saveEmploymentButton.bottomAnchor.constraint(equalTo: addExpContainer.bottomAnchor, constant: -60),
            saveEmploymentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveEmploymentButton.widthAnchor.constraint(equalToConstant: 80),
            saveEmploymentButton.heightAnchor.constraint(equalToConstant: 40),
            
            cancelEducationButton.bottomAnchor.constraint(equalTo: saveEmploymentButton.bottomAnchor),
            cancelEducationButton.leadingAnchor.constraint(equalTo: addExpContainer.leadingAnchor, constant: 16),
            cancelEducationButton.widthAnchor.constraint(equalToConstant: 100),
            cancelEducationButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func didTapAddExperience() {
        UIView.animate(withDuration: 0.3) {
            self.addExpContainer.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 118)  // Move up by 300 points
        }
        
        addExpContainer.isUserInteractionEnabled = true
    }
    
    @objc func startDropdownButtonTapped(_ sender : UIButton) {
        print(#function)
        if sender.imageView?.image == UIImage(systemName: "chevron.down") {
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            startTableView.isHidden = false
            scrollView.bringSubviewToFront(startTableView)
        }
        else {
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            startTableView.isHidden = true
        }
        
    }
    
    @objc func passDropdownButtonTapped(_ sender : UIButton) {
        print(#function)
        if sender.imageView?.image == UIImage(systemName: "chevron.down") {
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            passTableView.isHidden = false
            scrollView.bringSubviewToFront(passTableView)
        }
        else {
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            passTableView.isHidden = true
        }
        
    }
    
    @objc func employmentTypeButtonTapped(_ sender: UIButton) {
        // Deselect previous selected button
        selectedEmploymentTypeOption?.backgroundColor = nil
        selectedEmploymentTypeOption?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedEmploymentTypeOption?.titleLabel?.textColor = nil

        // Highlight the selected button
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        sender.titleLabel?.textColor = UIColor(hex: "#0079C4")
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        
        selectedEmploymentTypeOption = sender
    }
    
    @objc func saveAddButtonTapped() {
        let cText = companyTextField.text
        let jobText = jobTitleTextField.text
        var start = startYearPlaceholder.text
        if start == "Select years" {
            start = ""
        }
        var pass = passYearPlaceholder.text
        if pass == "Select months" {
            pass = ""
        }
        let empPeriod = empPeriodTextField.text
        let jobtype = selectedEmploymentTypeOption?.titleLabel?.text
        
        var isEmpty = false
        
        [cText, jobText, start, pass, empPeriod, jobtype].forEach { x in
            if x == "" || x == "Select years" || x == "Select months" {
                isEmpty = true
                let alertController = UIAlertController(title: "Alert!", message: "Fill in all the details", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alertController.addAction(cancelAction)
                
                present(alertController, animated: true, completion: nil)
            }
        }
        
        if isEmpty {
            return
        }
        
        let firstInt = Int(start!)!
        let secondInt = Int(pass!)!
        let combined = Double(firstInt) + Double(secondInt) / 10
        
        let emp = Employment(companyName: cText!, yearsOfExperience: "\(combined)", employmentDesignation: jobText!, employmentPeriod: empPeriod!, employmentType: jobtype!)
        dataArray.append(emp)
        
        companyTextField.text = ""
        jobTitleTextField.text = ""
        startYearPlaceholder.text = "Select years"
        passYearPlaceholder.text = "Select months"
        empPeriodTextField.text = ""
        
        
        UIView.animate(withDuration: 0.3) {
            self.addExpContainer.transform = .identity
        }
        
        reloadCollectionView()
    }
    
    @objc func cancelAddButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.addExpContainer.transform = .identity
        }
    }
    
    @objc func deleteCell(_ sender : UIButton) {
        guard let cell = sender.superview as? OnboardingEmpCell, // Adjust the number of superviews according to your cell's hierarchy
            let indexPath = employmentsCV.indexPath(for: cell)
        else {
            return
        }
        
        askUserConfirmation(title: "Delete Employment", message: "Are you sure you want to delete this item?") {
            // This closure is executed if the user confirms
            self.dataArray.remove(at: indexPath.row)
            
            // Perform batch updates for animation
            self.employmentsCV.performBatchUpdates({
                self.employmentsCV.deleteItems(at: [indexPath])
            }, completion: { _ in
                self.reloadCollectionView()
            })
        }
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
    
    
    let backButton = UIButton()
    let nextButton = UIButton()
    func setupBottomView() {
        bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        
    
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 20)
        nextButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        nextButton.backgroundColor = UIColor(hex: "#0079C4")
        nextButton.layer.cornerRadius = 8
        
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(nextButton)
        
        
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 20)
        backButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        backButton.backgroundColor = UIColor(hex: "#FFFFFF")
        backButton.layer.cornerRadius = 8
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(backButton)
        
        backButton.isUserInteractionEnabled = false
        nextButton.isUserInteractionEnabled = false
        bottomView.alpha = 0.2
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5),
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
    
    
    func setupEditViewComponents() {
        // Initialize and configure editView
        editView = UIView()
        editView.backgroundColor = .white
        editView.layer.cornerRadius = 12
        editView.layer.shadowOpacity = 0.25
        editView.layer.shadowRadius = 5
        editView.layer.shadowOffset = CGSize(width: 0, height: 2)
        editView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(editView)
        
        // Set initial off-screen position
        NSLayoutConstraint.activate([
            editView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editView.heightAnchor.constraint(equalToConstant: view.frame.height - 100),
            editView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)  // Top of editView to the bottom of the main view
        ])

        // Setup text fields and labels
        let labelsTitles = ["Designation", "Company", "Years of Experience", "Employment Period"]
        let textFields = [UITextField(), UITextField(), UITextField(), UITextField()]
        var lastBottomAnchor = editView.topAnchor
        
        for (index, title) in labelsTitles.enumerated() {
            let label = UILabel()
            label.text = title
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            editView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: lastBottomAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -20)
            ])
            
            let textField = textFields[index]
            textField.borderStyle = .roundedRect
            textField.placeholder = "Enter \(title)"
            textField.translatesAutoresizingMaskIntoConstraints = false
            editView.addSubview(textField)
            
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                textField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: label.trailingAnchor)
            ])
            
            lastBottomAnchor = textField.bottomAnchor
        }
        
        editExpTitleTF = textFields[0]
        editExpTitleTF.delegate = self
        editExpCompanyTF = textFields[1]
        editExpCompanyTF.delegate = self
        editYearsOfExpTF = textFields[2]
        editYearsOfExpTF.delegate = self
        editExpPeriodTF = textFields[3]
        editExpPeriodTF.delegate = self
        
        // Setup buttons
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 20)
        saveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        saveButton.backgroundColor = UIColor(hex: "#0079C4")
        saveButton.layer.cornerRadius = 8
        saveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        
        
        
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 20)
        cancelButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        cancelButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 8
        cancelButton.addTarget(self, action: #selector(cancelEdit), for: .touchUpInside)
        
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        editView.addSubview(saveButton)
        editView.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: editView.bottomAnchor, constant: -60),
            saveButton.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -20),
            saveButton.widthAnchor.constraint(equalToConstant: 80),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            cancelButton.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalToConstant: 80),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func saveChanges() {
        guard let selectedIndexPath = employmentsCV.indexPathsForSelectedItems?.first else { return }
        
        // Ensure all fields are non-empty
        guard let companyName = editExpCompanyTF.text, !companyName.isEmpty,
              let yearsOfExperience = editYearsOfExpTF.text, !yearsOfExperience.isEmpty,
              let employmentDesignation = editExpTitleTF.text, !employmentDesignation.isEmpty,
              let employmentPeriod = editExpPeriodTF.text, !employmentPeriod.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields")
            return
        }
        
        // Create the updated employment object
        let updatedExp = Employment(companyName: companyName, yearsOfExperience: yearsOfExperience,
                                    employmentDesignation: employmentDesignation, employmentPeriod: employmentPeriod,
                                    employmentType: "") // Assuming employmentType is optional or handled elsewhere
        
        // Update the data array and reload the specific item
        dataArray[selectedIndexPath.row] = updatedExp
        employmentsCV.reloadItems(at: [selectedIndexPath])
        dismissEditView()
    }

    @objc func cancelEdit() {
        dismissEditView()
    }
    
    func dismissEditView() {
        UIView.animate(withDuration: 0.3) {
            self.editView.transform = .identity
        }
    }
    
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    @objc func didTapNextButton() {
        fetchTotalExperienceAndUploadData()
        let vc = SoftwaresVC()
        navigationController?.pushViewController(vc, animated: true)
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


extension EmploymentsVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == startTableView {
            return startArray.count
        }
        else {
            return passArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if tableView == startTableView {
            cell.textLabel?.text = startArray[indexPath.row]
        }
        else if tableView == passTableView {
            cell.textLabel?.text = passArray[indexPath.row]
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == startTableView {
            startYearPlaceholder.text = startArray[indexPath.row]
            startYearPlaceholder.textColor = UIColor.black
            startButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            startTableView.isHidden = true
        }
        if tableView == passTableView {
            passYearPlaceholder.text = passArray[indexPath.row]
            passYearPlaceholder.textColor = UIColor.black
            passingButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            passTableView.isHidden = true
        }
    }
    
    
    
    // collectionView delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exp", for: indexPath) as! OnboardingEmpCell
        let exp = dataArray[indexPath.row]
        
        cell.titleLabel.text = exp.employmentDesignation
        cell.companyNameLabel.text = exp.companyName
        cell.noOfYearsLabel.text = "\(exp.yearsOfExperience),"
        cell.jobTypeLabel.text = exp.employmentPeriod
//        exp.employmentPeriod
        
        cell.editButton.isUserInteractionEnabled = false
        cell.deleteButton.addTarget(self, action: #selector(deleteCell(_:)), for: .touchUpInside)
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        cell.layer.cornerRadius = 12
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let exp = dataArray[indexPath.row]
        editExpTitleTF.text = exp.employmentDesignation
        editExpCompanyTF.text = exp.companyName
        editYearsOfExpTF.text = exp.yearsOfExperience
        editExpPeriodTF.text = exp.employmentPeriod
        
        UIView.animate(withDuration: 0.3) {
            self.editView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 118)  // Move up by 300 points
        }
    }
}


extension EmploymentsVC {
    func fetchAndParseExperience() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/candidate/experience") else {
            print("Invalid URL")
            return
        }
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not found")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
            self.scrollView.alpha = 0
            self.loader.isHidden = false
            self.loader.startAnimating()
            print("Loader should be visible now")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "No error description")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let softwaresResponse = try decoder.decode(SoftwaresResponse.self, from: data)
                let cleanedString = softwaresResponse.softwares
                    .replacingOccurrences(of: "\\n", with: "")
                    .replacingOccurrences(of: "\\\"", with: "\"")
                    .replacingOccurrences(of: "\\", with: "") // Additional cleaning for any leftover backslashes
                
                // Regex to find the JSON array
                let regex = try NSRegularExpression(pattern: "\\[.*?\\]", options: .dotMatchesLineSeparators)
                if let match = regex.firstMatch(in: cleanedString, options: [], range: NSRange(cleanedString.startIndex..., in: cleanedString)) {
                    let range = Range(match.range, in: cleanedString)!
                    let jsonArrayString = String(cleanedString[range])
                    
                    if let jsonData = jsonArrayString.data(using: .utf8),
                       let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [Any] {
                        
//                        print(jsonObject)
                        
                        do {
                            let decoder = JSONDecoder()
                            self.dataArray = try decoder.decode([Employment].self, from: jsonData)
//                            print("Decoded data: \(self.dataArray)")
                            DispatchQueue.main.async {
                                self.reloadCollectionView()
                            }
                        } catch {
                            print("Failed to decode JSON: \(error)")
                        }
                        
                    }
                } else {
                    print("No JSON array found")
                }
            } catch {
                print("Failed to decode or clean JSON: \(error)")
            }
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.loader.isHidden = true
                self.scrollView.alpha = 1
//                print("loader stopped")
                
                self.backButton.isUserInteractionEnabled = true
                self.nextButton.isUserInteractionEnabled = true
                self.bottomView.alpha = 1
            }
        }.resume()
    }
    
    func fetchTotalExperienceAndUploadData() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/candidate/totalExperience") else {
            print("Invalid URL for fetching total experience")
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not found")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch total experience: \(error?.localizedDescription ?? "No error description")")
                return
            }

            // Parse and extract the number from the total experience string
            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON string of total experience data: \(jsonString)")
                let regex = try! NSRegularExpression(pattern: "\\d+(\\.\\d+)?")
                let results = regex.matches(in: jsonString, options: [], range: NSRange(jsonString.startIndex..., in: jsonString))
                if let match = results.first {
                    let range = Range(match.range, in: jsonString)!
                    let numberString = String(jsonString[range])
//                    print("Extracted Total Experience Number: \(numberString)")
                    self?.uploadEmploymentData(totalExperience: numberString)
                } else {
                    print("No numbers found in total experience string")
                }
            }
        }.resume()
    }


    func uploadEmploymentData(totalExperience: String) {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/update-by-resume") else {
            print("Invalid URL for updating resume")
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not found")
            return
        }
        
        guard let experienceArray = dataArray as? [Employment], !experienceArray.isEmpty else {
            print("Employment data array is empty or not properly cast.")
            return
        }

        guard let jsonData = encodeEmploymentArray(experienceArray: experienceArray, totalExperience: totalExperience) else {
            print("Failed to encode employment data")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response from server: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if httpResponse.statusCode == 200 {
                print("Data successfully uploaded")
//                if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                    print("Server response: \(responseString)")
//                }
            } else {
                print("Failed to upload data, status code: \(httpResponse.statusCode)")
//                if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                    print("Response details: \(responseString)")
//                }
            }
        }.resume()
    }

    func encodeEmploymentArray(experienceArray: [Employment], totalExperience: String) -> Data? {
        guard let firstDesignation = experienceArray.first?.employmentDesignation else {
            print("No employment designation available in the first item of the array.")
            return nil
        }

        let employmentData = EmploymentData(
            experience: experienceArray,
            designation: firstDesignation,
            totalExperience: totalExperience
        )

        do {
            let jsonData = try JSONEncoder().encode(employmentData)
            return jsonData
        } catch {
            print("Error encoding employment data to JSON: \(error)")
            return nil
        }
    }
}


struct EmploymentData: Codable {
    let experience: [Employment]
    let designation: String
    let totalExperience: String
}
