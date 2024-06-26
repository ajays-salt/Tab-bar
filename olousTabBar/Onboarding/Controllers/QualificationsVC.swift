//
//  QualificationsVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/04/24.
//

import UIKit

class QualificationsVC: UIViewController, UITextFieldDelegate {
    
    var headerView : UIView!
    var circleContainerView : UIView!
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "ADD YOUR QUALIFICATION"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hex: "#101828")
        return label
    }()
    
    var loader: UIActivityIndicatorView!
    
    var scrollView : UIScrollView!
    
    var employmentsCV : UICollectionView!
    var dataArray : [Education] = []
    var employmentsCVHeightConstraint: NSLayoutConstraint!
    
    
    var educationTextField : UITextField!
    var collegeTextField : UITextField!
    var marksTextField : UITextField!
    
    var passingButton : UIButton!
    let passYearPlaceholder : UILabel = {
        let label = UILabel()
        label.text = "Select Year"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    var passArray = ["2024", "2023", "2022", "2021", "2020", "2019", "2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010","2009", "2008", "2007", "2006", "2005", "2004", "2003", "2002", "2001", "2000", "1999", "1998", "1997", "1996", "1995", "1994", "1993", "1992", "1991", "1990"]
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
    var editEducationTF : UITextField!
    var editCollegeTF : UITextField!
    var editPassYearTF : UITextField!
    var editMarksTF : UITextField!
    var saveButton: UIButton!
    var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        fetchAndParseEducation()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setupGeneratingContentView()
        
        loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
//        loader.center = view.center
        loader.style = UIActivityIndicatorView.Style.large
        loader.hidesWhenStopped = true
        
        loader.translatesAutoresizingMaskIntoConstraints = false // Disable autoresizing mask
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: 60), // Set width to 40
            loader.heightAnchor.constraint(equalToConstant: 60) // Set height to 40
        ])
    }
    
    
    let generateContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    func setupGeneratingContentView() {
        generateContentView.isHidden = true
//        addGradientBorder(to: generateContentView, colors: [UIColor.red.cgColor, UIColor.blue.cgColor], width: 2)
        generateContentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(generateContentView)
        
        
        let iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "sparkles") // Use appropriate image
            imageView.tintColor = .purple
            return imageView
        }()

        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = "AI is generating content"
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.textColor = .black
            return label
        }()

        let progressLabel: UILabel = {
            let label = UILabel()
            label.text = "77%"
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.textColor = .black
            return label
        }()
        
        [iconImageView, messageLabel, progressLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            generateContentView.addSubview(view)
        }

        NSLayoutConstraint.activate([
            generateContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generateContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            generateContentView.heightAnchor.constraint(equalToConstant: 100),
            generateContentView.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            
            iconImageView.leadingAnchor.constraint(equalTo: generateContentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: generateContentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            messageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            messageLabel.centerYAnchor.constraint(equalTo: generateContentView.centerYAnchor),
            
            progressLabel.trailingAnchor.constraint(equalTo: generateContentView.trailingAnchor, constant: -16),
            progressLabel.centerYAnchor.constraint(equalTo: generateContentView.centerYAnchor)
        ])
        
        view.layoutIfNeeded()
        addGradientBorder(to: generateContentView, colors: [UIColor.red.cgColor, UIColor.blue.cgColor], width: 4)
    }
    
    func addGradientBorder(to view: UIView, colors: [CGColor], width: CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds.insetBy(dx: -width, dy: -width)
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        let shape = CAShapeLayer()
        shape.lineWidth = width
        shape.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.black.cgColor
        gradient.mask = shape
        
        view.layer.addSublayer(gradient)
        
        let animation = CABasicAnimation(keyPath: "startPoint")
        animation.fromValue = NSValue(cgPoint: CGPoint(x: 0, y: 0))
        animation.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        animation.duration = 2.0
        animation.repeatCount = .infinity
        
        gradient.add(animation, forKey: "borderAnimation")
    }



    

    
    
    
    func setupViews() {
        setupHeaderView()
        setupTitle()
        setupScrollView()
        
                
        setupEmploymentsView()
        setupAddEmploymentButton()
        
        
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
        stepsScrollView.contentOffset = CGPoint(x: 8, y: 0)
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

        var currentStepIndex = 0
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
        currentStepLabel.text = "STEP 2 OF 10"
        currentStepLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        currentStepLabel.textColor = .gray
        headerView.addSubview(currentStepLabel)
        currentStepLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the main step title
        let mainStepTitleLabel = UILabel()
        mainStepTitleLabel.text = "ADD QUALIFICATION"
        mainStepTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        headerView.addSubview(mainStepTitleLabel)
        mainStepTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress view
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(hex: "#2563EB")
        progressView.trackTintColor = UIColor(hex: "#E5E7EB")
        progressView.setProgress(0.2, animated: true)
        headerView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress label
        let progressLabel = UILabel()
        progressLabel.text = "20%"
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
        
//        // Calculate content size
//        let contentHeight = view.bounds.height - extraSpaceHeight
//        let height = scrollView.contentSize.height
//        scrollView.contentSize = CGSize(width: view.bounds.width, height: height + 100)
    }
    
    func setupEmploymentsView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        employmentsCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        employmentsCV.register(OnboardingEduCell.self, forCellWithReuseIdentifier: "edu")
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
    func setupAddEmploymentButton() {
        
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
            label.text = "Add New Qualification"
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
        
        
        
        let companyLabel : UILabel = {
            let companyLabel = UILabel()
            companyLabel.translatesAutoresizingMaskIntoConstraints = false
            let attributedText2 = NSMutableAttributedString(string: "Education name ")
            let asterisk2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText2.append(asterisk2)
            companyLabel.attributedText = attributedText2
            companyLabel.font = .boldSystemFont(ofSize: 16)
            companyLabel.textColor = UIColor(hex: "#344054")
            return companyLabel
        }()
        addExpContainer.addSubview(companyLabel)
        
        // company TextField
        educationTextField = UITextField()
        educationTextField.translatesAutoresizingMaskIntoConstraints = false
        educationTextField.borderStyle = .roundedRect
        educationTextField.placeholder = "E.g. B.Tech Civil"
        educationTextField.delegate = self // Set delegate for this text field
        addExpContainer.addSubview(educationTextField)
        
        let jobTitleLabel : UILabel = {
            let jobTitleLabel = UILabel()
            jobTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            let attributedText3 = NSMutableAttributedString(string: "Board/University ")
            let asterisk3 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText3.append(asterisk3)
            jobTitleLabel.attributedText = attributedText3
            jobTitleLabel.font = .boldSystemFont(ofSize: 16)
            jobTitleLabel.textColor = UIColor(hex: "#344054")
            return jobTitleLabel
        }()
        addExpContainer.addSubview(jobTitleLabel)
        
        // jobTitle TextField
        collegeTextField = UITextField()
        collegeTextField.translatesAutoresizingMaskIntoConstraints = false
        collegeTextField.borderStyle = .roundedRect
        collegeTextField.placeholder = "E.g. IIT Bombay"
        collegeTextField.delegate = self // Set delegate for this text field
        addExpContainer.addSubview(collegeTextField)
        
        
        let marksLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Marks Obtained ")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        addExpContainer.addSubview(marksLabel)
        
        marksTextField = UITextField()
        marksTextField.addDoneButtonOnKeyboard()
        marksTextField.translatesAutoresizingMaskIntoConstraints = false
        marksTextField.borderStyle = .roundedRect
        marksTextField.placeholder = "9.5 cgpa Or 95 %"
        marksTextField.keyboardType = .decimalPad
        marksTextField.delegate = self // Set delegate for this text field
        addExpContainer.addSubview(marksTextField)
        
        
        // passing year UI
        let passYearLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Year of Passing")
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
        
        let jobTypeOptions = ["Full-Time", "Part-Time", "Distance Learning"]
        
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
        
        
        let saveEducationButton = UIButton()
        saveEducationButton.setTitle("Save", for: .normal)
        saveEducationButton.titleLabel?.font = .systemFont(ofSize: 20)
        saveEducationButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        saveEducationButton.backgroundColor = UIColor(hex: "#0079C4")
        saveEducationButton.layer.cornerRadius = 8
        saveEducationButton.addTarget(self, action: #selector(saveAddButtonTapped), for: .touchUpInside)
        
        saveEducationButton.translatesAutoresizingMaskIntoConstraints = false
        addExpContainer.addSubview(saveEducationButton)
        
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
        
        let width = (view.frame.width - 52) / 2
        
        NSLayoutConstraint.activate([
            
            companyLabel.topAnchor.constraint(equalTo: addExpContainer.topAnchor, constant: 20),
            companyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            educationTextField.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            educationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            educationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            educationTextField.heightAnchor.constraint(equalToConstant: 50),
            
            jobTitleLabel.topAnchor.constraint(equalTo: educationTextField.bottomAnchor, constant: 20),
            jobTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            collegeTextField.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 10),
            collegeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collegeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collegeTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            marksLabel.topAnchor.constraint(equalTo: collegeTextField.bottomAnchor, constant: 20),
            marksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            marksTextField.topAnchor.constraint(equalTo: marksLabel.bottomAnchor, constant: 10),
            marksTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            marksTextField.widthAnchor.constraint(equalToConstant: width - 10),
            marksTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passYearLabel.topAnchor.constraint(equalTo: marksLabel.topAnchor),
            passYearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: width + 20),
            
            container2.topAnchor.constraint(equalTo: passYearLabel.bottomAnchor, constant: 10),
            container2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: width + 20),
            container2.widthAnchor.constraint(equalToConstant: width),
            container2.heightAnchor.constraint(equalToConstant: 40),
            
            passYearPlaceholder.centerYAnchor.constraint(equalTo: container2.centerYAnchor),
            passYearPlaceholder.leadingAnchor.constraint(equalTo: container2.leadingAnchor, constant: 10),
            
            passingButton.centerYAnchor.constraint(equalTo: container2.centerYAnchor),
            passingButton.trailingAnchor.constraint(equalTo: container2.trailingAnchor, constant: -10),
            
            passTableView.topAnchor.constraint(equalTo: container2.bottomAnchor),
            passTableView.leadingAnchor.constraint(equalTo: container2.leadingAnchor),
            passTableView.widthAnchor.constraint(equalToConstant: width),
            passTableView.heightAnchor.constraint(equalToConstant: 150),
            
            jobTypeLabel.topAnchor.constraint(equalTo: container2.bottomAnchor, constant: 20),
            jobTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            jobStackView.topAnchor.constraint(equalTo: jobTypeLabel.bottomAnchor, constant: 10),
            jobStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            saveEducationButton.bottomAnchor.constraint(equalTo: addExpContainer.bottomAnchor, constant: -60),
            saveEducationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveEducationButton.widthAnchor.constraint(equalToConstant: 80),
            saveEducationButton.heightAnchor.constraint(equalToConstant: 40),
            
            cancelEducationButton.bottomAnchor.constraint(equalTo: saveEducationButton.bottomAnchor),
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
    
    @objc func passDropdownButtonTapped(_ sender : UIButton) {
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
        let educationText = educationTextField.text
        let collegeText = collegeTextField.text
        let marks = marksTextField.text
        let pass = passYearPlaceholder.text
        let courseType = selectedEmploymentTypeOption?.titleLabel?.text
        
        var isEmpty = false
        
        [educationText, collegeText, marks, pass, courseType].forEach { x in
            if x == "" || x == "Select Year" {
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
        
        let passInt = Int(pass!)!
        
        let edu = Education(
            educationName: educationText!,
            yearOfPassing: pass!,
            boardOrUniversity: collegeText!,
            marksObtained: marks!
        )
        
        dataArray.append(edu)
        
        educationTextField.text = ""
        collegeTextField.text = ""
        marksTextField.text = ""
        passYearPlaceholder.text = "Select Year"
        
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
        guard let cell = sender.superview as? OnboardingEduCell, // Adjust the number of superviews according to your cell's hierarchy
            let indexPath = employmentsCV.indexPath(for: cell)
        else {
            return
        }
        
        askUserConfirmation(title: "Delete Education", message: "Are you sure you want to delete this item?") {
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
    
    
    let nextButton = UIButton()
    let backButton = UIButton()
    
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
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNextButton() {
        uploadEducationData()
        let vc = EmploymentsVC()
        navigationController?.pushViewController(vc, animated: true)
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
        let labelsTitles = ["Education", "College", "Passing Year", "Marks Obtained"]
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
        
        editEducationTF = textFields[0]
        editEducationTF.delegate = self
        editCollegeTF = textFields[1]
        editCollegeTF.delegate = self
        editPassYearTF = textFields[2]
        editPassYearTF.keyboardType = .numberPad
        editMarksTF = textFields[3]
        editMarksTF.keyboardType = .decimalPad
        
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
        guard let educationName = editEducationTF.text, !educationName.isEmpty,
              let yearOfPassing = editPassYearTF.text, !yearOfPassing.isEmpty,
              let boardOrUniversity = editCollegeTF.text, !boardOrUniversity.isEmpty,
              let marks = editMarksTF.text, !marks.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields before saving.")
            return
        }
        
        // Create the updated education object, assuming marksObtained is not editable or is handled differently
        let updatedEducation = Education(educationName: educationName,
                                         yearOfPassing: yearOfPassing,
                                         boardOrUniversity: boardOrUniversity,
                                         marksObtained: marks)  // Modify according to your data model if necessary
        
        // Update the data array and reload the specific item
        dataArray[selectedIndexPath.row] = updatedEducation
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

extension QualificationsVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = passArray[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        passYearPlaceholder.text = passArray[indexPath.row]
        passYearPlaceholder.textColor = UIColor.black
        passingButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        passTableView.isHidden = true
    }
    
    
    
    // collectionView delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "edu", for: indexPath) as! OnboardingEduCell
        
        let edu = dataArray[indexPath.row]
        
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
        
        cell.editButton.isUserInteractionEnabled = false
        cell.deleteButton.addTarget(self, action: #selector(deleteCell(_:)), for: .touchUpInside)
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        cell.layer.cornerRadius = 12
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let edu = dataArray[indexPath.row]
        editEducationTF.text = edu.educationName
        editCollegeTF.text = edu.boardOrUniversity
        editPassYearTF.text = edu.yearOfPassing
        editMarksTF.text = edu.marksObtained
        
        UIView.animate(withDuration: 0.3) {
            self.editView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 118)  // Move up by 300 points
        }
    }
}

extension QualificationsVC { // extension to fetch API
    
    func fetchAndParseEducation() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/candidate/qualifications") else {
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
            self.loader.startAnimating()
            self.generateContentView.isHidden = false
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
                            self.dataArray = try decoder.decode([Education].self, from: jsonData)
                            print("Decoded data: \(self.dataArray)")
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
                self.scrollView.alpha = 1
                print("loader stopped")
                
                self.backButton.isUserInteractionEnabled = true
                self.nextButton.isUserInteractionEnabled = true
                self.bottomView.alpha = 1
                
//                self.generateContentView.isHidden = true
            }
        }.resume()
    }
    
    func uploadEducationData() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not found")
            return
        }
        
        guard let jsonData = encodeEducationArray() else {
            print("Failed to encode education data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization") // Replace `accessToken` with your actual token
        request.httpBody = jsonData
        
        DispatchQueue.main.async {
            self.scrollView.alpha = 0
            self.loader.startAnimating()
            print("Loader should be visible now")
        }

        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response from server: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Data successfully uploaded")
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Server response: \(responseString)")
                }
            } else {
                print("Failed to upload data, status code: \(httpResponse.statusCode)")
                print(data , error)
            }
            
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.scrollView.alpha = 1
                print("loader stopped")
            }
        }.resume()
    }

    
    func encodeEducationArray() -> Data? {
        do {
            let educationDictionary = ["education": dataArray]
            let jsonData = try JSONEncoder().encode(educationDictionary)
            return jsonData
        } catch {
            print("Error encoding dataArray to JSON: \(error)")
            return nil
        }
    }

}

