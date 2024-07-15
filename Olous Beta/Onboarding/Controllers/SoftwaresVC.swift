//
//  SoftwaresVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 03/04/24.
//


// copied from skillsVC so naming will be same with that

import UIKit

class SoftwaresVC: UIViewController, UITextFieldDelegate {

    var headerView : UIView!
    var circleContainerView : UIView!
    
    var loader: LoadingView!
    
    var scrollView : UIScrollView!
    
    let skillsTextField = UITextField()
    var skillsArray = ["Java", "C", "C++", "C#", "Swift", "Tekla", "iOS", "UIKit", "Programming", "C-Sharp", "Programming2", "Programming3"]
    var filteredSkillsArray : [String] = []
    let skillsTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()
    
    var addedSkillsView : UICollectionView!
    var addedSkillsArray : [String] = []
    var addedSkillsHashSet = Set<String>()
    var addedSkillsViewHeightConstraint: NSLayoutConstraint!
    
    let suggestionsLabel : UILabel = {
        let label = UILabel()
        label.text = "Suggestions :"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(hex: "#667085")
        return label
    }()
    var suggestedSkillsView : UICollectionView!
    var suggestedSkillsHashSet = Set<String>()
    var suggestedSkillsArray : [String] = []
    var suggestedSkillsViewHeightConstraint: NSLayoutConstraint!
    
    var bottomView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        skillsTextField.delegate = self
        skillsTableView.delegate = self
        skillsTableView.dataSource = self
        
        fetchAndProcessSoftwares()
        
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
        label.text = "Softwares are being generated..."
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
        setupScrollView()
        
        setupUI()
        setupAddedSkillsView()
        setupSuggestedSkillsView()
        
        setupBottomView()
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
        currentStepLabel.text = "STEP 4 OF 10"
        currentStepLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        currentStepLabel.textColor = .gray
        headerView.addSubview(currentStepLabel)
        currentStepLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the main step title
        let mainStepTitleLabel = UILabel()
        mainStepTitleLabel.text = "ADD SOFTWARE"
        mainStepTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        headerView.addSubview(mainStepTitleLabel)
        mainStepTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress view
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(hex: "#2563EB")
        progressView.trackTintColor = UIColor(hex: "#E5E7EB")
        progressView.setProgress(0.4, animated: true)
        headerView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress label
        let progressLabel = UILabel()
        progressLabel.text = "40%"
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
    
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
        
        let extraSpaceHeight: CGFloat = 50
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
//        let contentHeight = view.bounds.height + extraSpaceHeight
//        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    func setupUI() {
//        let titleLabel : UILabel =  {
//            let label = UILabel()
//            label.text = "SOFTWARE"
//            label.font = .boldSystemFont(ofSize: 20)
//            label.textColor = UIColor(hex: "#101828")
//            label.translatesAutoresizingMaskIntoConstraints = false
//            return label
//        }()
//        scrollView.addSubview(titleLabel)
        
//        let skillsLabel : UILabel = {
//            let label = UILabel()
//            let attributedText1 = NSMutableAttributedString(string: "Softwares")
//            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
//            attributedText1.append(asterisk1)
//            label.attributedText = attributedText1
//            label.font = .boldSystemFont(ofSize: 16)
//            label.textColor = UIColor(hex: "#344054")
//            label.translatesAutoresizingMaskIntoConstraints = false
//            return label
//        }()
//        scrollView.addSubview(skillsLabel)
        
        skillsTextField.placeholder = "Add Softwares"
        skillsTextField.borderStyle = .roundedRect
        skillsTextField.layer.borderWidth = 1
        skillsTextField.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        skillsTextField.layer.cornerRadius = 8
        skillsTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(skillsTextField)
        
        skillsTableView.layer.borderWidth = 1
        skillsTableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        skillsTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(skillsTableView)
        scrollView.bringSubviewToFront(skillsTableView)
        
        
        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
//            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            
//            skillsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            skillsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            
//            skillsTextField.topAnchor.constraint(equalTo: skillsLabel.bottomAnchor, constant: 10),
            skillsTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            skillsTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skillsTextField.heightAnchor.constraint(equalToConstant: 50),
            
            skillsTableView.topAnchor.constraint(equalTo: skillsTextField.bottomAnchor, constant: 10),
            skillsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skillsTableView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func setupAddedSkillsView() {
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        addedSkillsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addedSkillsView.register(Skill_Software_Cell.self, forCellWithReuseIdentifier: "skill1")
        addedSkillsView.delegate = self
        addedSkillsView.dataSource = self
        
        addedSkillsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(addedSkillsView)
        NSLayoutConstraint.activate([
            addedSkillsView.topAnchor.constraint(equalTo: skillsTextField.bottomAnchor, constant: 20),
            addedSkillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addedSkillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        addedSkillsViewHeightConstraint = addedSkillsView.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        addedSkillsViewHeightConstraint.isActive = true
        
//        reloadAddedSkills()
    }
    
    func reloadAddedSkills() {
        addedSkillsView.reloadData()
            
        // Calculate the content size
        addedSkillsView.layoutIfNeeded()
        let contentSize = addedSkillsView.collectionViewLayout.collectionViewContentSize
        let contentSize2 = suggestedSkillsView.collectionViewLayout.collectionViewContentSize
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentSize.height + contentSize2.height + 100)
        
        // Update the height constraint based on content size
        addedSkillsViewHeightConstraint.constant = contentSize.height
        
        // Update constraints
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    func setupSuggestedSkillsView() {
        suggestionsLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(suggestionsLabel)
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        suggestedSkillsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        suggestedSkillsView.register(Skill_Software_Cell.self, forCellWithReuseIdentifier: "skill1")
        suggestedSkillsView.delegate = self
        suggestedSkillsView.dataSource = self
        
        suggestedSkillsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(suggestedSkillsView)
        
        NSLayoutConstraint.activate([
            suggestionsLabel.topAnchor.constraint(equalTo:addedSkillsView.bottomAnchor, constant: 20),
            suggestionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            suggestedSkillsView.topAnchor.constraint(equalTo: suggestionsLabel.bottomAnchor, constant: 10),
            suggestedSkillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            suggestedSkillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        suggestedSkillsViewHeightConstraint = suggestedSkillsView.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        suggestedSkillsViewHeightConstraint.isActive = true
        
//        reloadSuggestedSkills()
    }
    
    func reloadSuggestedSkills() {
        suggestedSkillsView.reloadData()
            
        // Calculate the content size
        suggestedSkillsView.layoutIfNeeded()
        let contentSize = addedSkillsView.collectionViewLayout.collectionViewContentSize
        let contentSize2 = suggestedSkillsView.collectionViewLayout.collectionViewContentSize
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentSize.height + contentSize2.height + 100)
        
        // Update the height constraint based on content size
        suggestedSkillsViewHeightConstraint.constant = contentSize2.height
        
        // Update constraints
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == skillsTextField {
            let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            filterSkills(with: searchText)
        }
        
        return true
    }
    
    func filterSkills(with searchText: String) {
        filteredSkillsArray = skillsArray.filter { $0.lowercased().hasPrefix(searchText.lowercased()) }
        
        // If there are no matching skills, add a special row to prompt the user to add the skill
        if filteredSkillsArray.isEmpty && !searchText.isEmpty {
            filteredSkillsArray.append("\(searchText)")
        }
        
        // Show or hide the table view based on the filtered skills count
        skillsTableView.isHidden = filteredSkillsArray.isEmpty
        
        if !skillsTableView.isHidden {
            scrollView.bringSubviewToFront(skillsTableView)
        }
        
        skillsTableView.reloadData()
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
    
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNextButton() {
        uploadAddedSkills()
        let vc = ProjectsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard when the return key is tapped
        skillsTableView.isHidden = true
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard when the user taps outside of the text field
        view.endEditing(true)
    }
}

extension SoftwaresVC : UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == suggestedSkillsView {
            return suggestedSkillsArray.count
        }
        return addedSkillsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skill1", for: indexPath) as! Skill_Software_Cell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        if collectionView == addedSkillsView {
            cell.textLabel.text = "  \(addedSkillsArray[indexPath.row])"
            cell.symbolLabel.text = "  X"
            cell.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            cell.textLabel.textColor = UIColor(hex: "#0079C4")
            cell.symbolLabel.textColor = UIColor(hex: "#0079C4")
        }
        else {
            if addedSkillsHashSet.contains(suggestedSkillsArray[indexPath.row]) {
                cell.layer.borderColor = UIColor(hex: "#0079C4").cgColor
                cell.textLabel.textColor = UIColor(hex: "#0079C4")
                cell.symbolLabel.textColor = UIColor(hex: "#0079C4")
            }
            else {
                cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
                cell.textLabel.textColor = UIColor(hex: "#98A2B3")
                cell.symbolLabel.textColor = UIColor(hex: "#344054")
            }
            
            cell.textLabel.text = " +"
            cell.textLabel.font = .boldSystemFont(ofSize: 20)
            cell.symbolLabel.text =  " \(suggestedSkillsArray[indexPath.row])"
            cell.symbolLabel.font = .systemFont(ofSize: 16)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var text = ""
        var width : CGFloat
        if collectionView == addedSkillsView {
            text = addedSkillsArray[indexPath.row]
            width = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width
        }
        else {
            text = suggestedSkillsArray[indexPath.row]
            width = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width + 2
        }
        // Adjust spacing
        return CGSize(width: width + 40, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == addedSkillsView {
            let t = addedSkillsArray[indexPath.row]
            addedSkillsArray.remove(at: indexPath.row)
            addedSkillsHashSet.remove(t)
            suggestedSkillsArray.append(t)
            if suggestedSkillsArray.contains(t) {
                reloadSuggestedSkills()
            }
            reloadAddedSkills()
        }
        else {
            let t = suggestedSkillsArray[indexPath.row]
            if !addedSkillsHashSet.contains(t) {
                addedSkillsArray.append(t)
                addedSkillsHashSet.insert(t)
                
                suggestedSkillsArray.remove(at: indexPath.row)
                
                reloadAddedSkills()
                reloadSuggestedSkills()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredSkillsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = filteredSkillsArray[indexPath.row]
        cell.selectionStyle = .none
        if addedSkillsHashSet.contains(filteredSkillsArray[indexPath.row]) {
            cell.backgroundColor = UIColor(hex: "#EAECF0")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if addedSkillsHashSet.contains(filteredSkillsArray[indexPath.row]) == false {
            
            addedSkillsArray.append(filteredSkillsArray[indexPath.row])
            addedSkillsHashSet.insert(filteredSkillsArray[indexPath.row])
            
            reloadAddedSkills()
            reloadSuggestedSkills()
            
            skillsTextField.text = nil
            skillsTableView.isHidden = true
        }
    }
}

extension SoftwaresVC {
    struct SoftwareFetchResponse: Codable {
        let softwareSuggestions: String
        let softwares: String
    }

    // Fetch and process softwares from API
    func fetchAndProcessSoftwares() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/candidate/softwares") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Include accessToken for Authorization
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
            self.scrollView.alpha = 0
            self.loader.isHidden = false
            self.loader.startAnimating()
            print("Loader should be visible now")
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                // Decode the JSON into the SoftwareFetchResponse struct
                let response = try JSONDecoder().decode(SoftwareFetchResponse.self, from: data)
//                print("Software Suggestions: \(response.softwareSuggestions)")
//                print("Softwares: \(response.softwares)")
//                
//                print("Space")
                
                let processedSoftwares = self.processSoftwareString(softwareString: response.softwares)
//                print("Processed Softwares: \(processedSoftwares)")
                let pss = self.processSoftwareString(softwareString: response.softwareSuggestions)
//                print("Processed Suggestions: \(pss)")
                
                self.addedSkillsArray = processedSoftwares
                self.suggestedSkillsArray = pss
                DispatchQueue.main.async {
                    self.reloadAddedSkills()
                    self.reloadSuggestedSkills()
                }
                
            } catch {
                print("Failed to decode or process data: \(error)")
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
    
    // Function to process the software string
    func processSoftwareString(softwareString: String) -> [String] {
        // Check if the string is in JSON-like array format
        if softwareString.hasPrefix("[") {
            // Attempt to parse it as JSON
            if let data = softwareString.data(using: .utf8),
               let jsonArray = try? JSONDecoder().decode([String].self, from: data) {
                return jsonArray.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            }
        }
        
        // Normalize the string by removing newline characters
        let normalizedString = softwareString.replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\"", with: "") // Remove quotes
        
        // Split the string based on commas if not JSON
        return normalizedString.components(separatedBy: ", ")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
    func parseNumberedSoftwareSuggestions(suggestions: String) -> [String] {
        // Split the string into individual lines assuming each new line is a separate suggestion
        let lines = suggestions.components(separatedBy: .newlines)
        
        // Use a regular expression to extract the software name after the number and period
        let regexPattern = "\\d+\\.\\s*(.+)"
        
        var softwareNames = [String]()
        
        for line in lines {
            if let regex = try? NSRegularExpression(pattern: regexPattern),
               let match = regex.firstMatch(in: line, range: NSRange(line.startIndex..., in: line)),
               let range = Range(match.range(at: 1), in: line) {
                let name = line[range].trimmingCharacters(in: .whitespacesAndNewlines)
                softwareNames.append(name)
            }
        }
        
        return softwareNames
    }
    
    func uploadAddedSkills() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
        
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        // Prepare the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Include accessToken for Authorization if needed
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Prepare the JSON body
        let json: [String: Any] = ["softwares": addedSkillsArray]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            print("Failed to encode softwares to JSON: \(error)")
            return
        }
        
        // Perform the URLSession task
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
            guard let data = data, error == nil else {
                print("Error in URLSession data task: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Successfully uploaded softwares")
            } else {
                print("Failed to upload softwares with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
            
            // You might want to handle the response data if needed
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response JSON: \(json)")
                }
            } catch {
                print("Failed to parse response data: \(error)")
            }
        }.resume()
    }
}
