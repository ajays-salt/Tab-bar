//
//  BasicDetails2.swift
//  olousTabBar
//
//  Created by Salt Technologies on 27/03/24.
//

import UIKit

class HeadlineAndSummary: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var headerView : UIView!
    var headerHeightConstraint: NSLayoutConstraint?
    var circleContainerView : UIView!
    
    var scrollView : UIScrollView!
    
    var loader: LoadingView!
    var loader2: LoadingView!
    
    var resumeTextView : UITextView!
    let generateResume: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Generate Headline", for: .normal)
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.tintColor = UIColor(hex: "#0079C4")
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var summaryTextView : UITextView!
    let generateSummary: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Generate Summary", for: .normal)
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.tintColor = UIColor(hex: "#0079C4")
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    var charactersLeftLabel : UILabel = {
        let label = UILabel()
        label.text = "300 characters left"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#475467")
        return label
    }()
    
    
    var bottomView : UIView!
    var bottomHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        // Remove keyboard notifications
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            // Adjust the content inset of the scroll view
            var contentInset = scrollView.contentInset
            contentInset.bottom = keyboardHeight
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            
            // Adjust the scroll position if the text view is covered by the keyboard
            var textViewFrame: CGRect
                    
            if summaryTextView.isFirstResponder {
                textViewFrame = summaryTextView.convert(summaryTextView.bounds, to: scrollView)
                textViewFrame.size.height -= 100
            } else if resumeTextView.isFirstResponder {
                textViewFrame = resumeTextView.convert(resumeTextView.bounds, to: scrollView)
                textViewFrame.size.height -= 100
            } else {
                return
            }
            
            scrollView.scrollRectToVisible(textViewFrame, animated: true)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        // Restore the content inset of the scroll view
        var contentInset = scrollView.contentInset
        contentInset.bottom = -200
        scrollView.contentInset = contentInset
    }

    
    private func setupLoader() {
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
        label.text = "Generating resume headline"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        loader.addSubview(label)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: resumeTextView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: resumeTextView.centerYAnchor),
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
        
        loader.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = loader.bounds

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
    private func setupLoader2() {
        loader2 = LoadingView()
        loader2.isHidden = true
        loader2.backgroundColor = UIColor(hex: "#DB7F14").withAlphaComponent(0.05)
        loader2.layer.cornerRadius = 20
        
        loader2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader2)
        
        let imgView = UIImageView()
        imgView.image = UIImage(named: "AISymbol")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        loader2.addSubview(imgView)
        
        let label = UILabel()
        label.text = "Generating profile summary"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        loader2.addSubview(label)
        
        NSLayoutConstraint.activate([
            loader2.centerXAnchor.constraint(equalTo: summaryTextView.centerXAnchor),
            loader2.centerYAnchor.constraint(equalTo: summaryTextView.centerYAnchor),
            loader2.widthAnchor.constraint(equalToConstant: 300),
            loader2.heightAnchor.constraint(equalToConstant: 80),
            
            imgView.centerYAnchor.constraint(equalTo: loader2.centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: loader2.leadingAnchor, constant: 16),
            imgView.heightAnchor.constraint(equalToConstant: 40),
            imgView.widthAnchor.constraint(equalToConstant: 40),
            
            label.centerYAnchor.constraint(equalTo: loader2.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: loader2.trailingAnchor, constant: -16)
        ])
        
        loader2.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = loader2.bounds

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
        
        loader2.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func setupViews() {
        setupHeaderView()
        setupScrollView()
        
        
        
        setupUI()
        setupLoader()
        setupLoader2()
        
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
        stepsScrollView.contentOffset = CGPoint(x: 600, y: 0)
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

        var currentStepIndex = 4
        var completedStepIndex = 3
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
        currentStepLabel.text = "STEP 9 OF 10"
        currentStepLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        currentStepLabel.textColor = .gray
        headerView.addSubview(currentStepLabel)
        currentStepLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the main step title
        let mainStepTitleLabel = UILabel()
        mainStepTitleLabel.text = "HEADLINE AND SUMMARY"
        mainStepTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        headerView.addSubview(mainStepTitleLabel)
        mainStepTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress view
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(hex: "#2563EB")
        progressView.trackTintColor = UIColor(hex: "#E5E7EB")
        progressView.setProgress(0.9, animated: true)
        headerView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress label
        let progressLabel = UILabel()
        progressLabel.text = "90%"
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
        
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 210)
        headerHeightConstraint?.isActive = true
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
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -105),
        ])
        
        let extraSpaceHeight: CGFloat = 50
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height - 300
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    func setupUI() {
        let headlineLabel = UILabel()
        headlineLabel.font = .boldSystemFont(ofSize: 18)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Resume Headline")
        let asterisk = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText.append(asterisk)
        headlineLabel.attributedText = attributedText
        headlineLabel.textColor = UIColor(hex: "#101828")
        scrollView.addSubview(headlineLabel)
        
        resumeTextView = UITextView()
        resumeTextView.delegate = self
        resumeTextView.font = .systemFont(ofSize: 16)
        resumeTextView.textColor = UIColor(hex: "#344054")
        resumeTextView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        resumeTextView.layer.borderWidth = 1.0 // Border width
        resumeTextView.layer.cornerRadius = 12.0
        resumeTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Padding
        
        resumeTextView.addDoneButtonOnKeyboard()
        
        resumeTextView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(resumeTextView)
        
        generateResume.addTarget(self, action: #selector(didTapGenerateResume), for: .touchUpInside)
        
        generateResume.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(generateResume)
        
        
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            headlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            generateResume.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            generateResume.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            generateResume.widthAnchor.constraint(equalToConstant: 180),
            generateResume.heightAnchor.constraint(equalToConstant: 40),
            
            resumeTextView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 20),
            resumeTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resumeTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resumeTextView.heightAnchor.constraint(equalToConstant: 130),
        ])
        
        
        let summaryLabel = UILabel()
        summaryLabel.font = .boldSystemFont(ofSize: 18)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText2 = NSMutableAttributedString(string: "Profile Summary")
        let asterisk2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText2.append(asterisk2)
        summaryLabel.attributedText = attributedText2
        summaryLabel.textColor = UIColor(hex: "#101828")
        scrollView.addSubview(summaryLabel)
        
        summaryTextView = UITextView()
        summaryTextView.delegate = self
        summaryTextView.font = .systemFont(ofSize: 16)
        summaryTextView.textColor = UIColor(hex: "#344054")
        summaryTextView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        summaryTextView.layer.borderWidth = 1.0 // Border width
        summaryTextView.layer.cornerRadius = 12.0
        summaryTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Padding
        
        summaryTextView.addDoneButtonOnKeyboard()
        
        summaryTextView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(summaryTextView)
        
        generateSummary.addTarget(self, action: #selector(didTapGenerateSummary), for: .touchUpInside)
        generateSummary.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(generateSummary)
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: resumeTextView.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            generateSummary.topAnchor.constraint(equalTo: resumeTextView.bottomAnchor, constant: 10),
            generateSummary.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            generateSummary.widthAnchor.constraint(equalToConstant: 180),
            generateSummary.heightAnchor.constraint(equalToConstant: 40),
            
            summaryTextView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 20),
            summaryTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            summaryTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            summaryTextView.heightAnchor.constraint(equalToConstant: 190),
        ])
    }
    
    @objc func didTapGenerateResume() {
        fetchHeadline()
    }
    
    @objc func didTapGenerateSummary() {
        fetchProfileSummary()
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
            bottomView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            
            nextButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        bottomHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 100)
        bottomHeightConstraint?.isActive = true
    }
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNextButton() {
        postResumeData()
    }
    
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 300 {
            let index = textView.text.index(textView.text.startIndex, offsetBy: 300)
            textView.text = String(textView.text.prefix(upTo: index))
        }
        else {
            let remainingCharacters = 300 - textView.text.count
            charactersLeftLabel.text = "\(remainingCharacters) characters left"
        }
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spaceButton, doneButton], animated: false)
        
        return toolbar
    }
    
    @objc func doneButtonTapped() {
        resumeTextView.resignFirstResponder()
        summaryTextView.resignFirstResponder()
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

extension HeadlineAndSummary {
    
    func fetchHeadline() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/generate-headline") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
            self.resumeTextView.text = ""
            self.loader.isHidden = false
            self.loader.startAnimating()
            self.generateResume.isUserInteractionEnabled = false
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.loader.isHidden = true
                self.generateResume.isUserInteractionEnabled = true
            }
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let headlineResponse = try JSONDecoder().decode(HeadlineResponse.self, from: data)
                    DispatchQueue.main.async {
                        var s = headlineResponse.headline
                        if s.hasPrefix("\"") {
                            s = String(s.dropFirst().dropLast())
                        }
                        self.resumeTextView.text = s
                        print("Headline set to resumeTextView: \(headlineResponse.headline)")
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Failed to decode JSON: \(error)")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("Failed to fetch headline, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                }
            }
        }.resume()
    }
    
    func fetchProfileSummary() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/profile-summary") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        DispatchQueue.main.async {
            self.summaryTextView.text = ""
            self.loader2.isHidden = false
            self.loader2.startAnimating()
            self.generateSummary.isUserInteractionEnabled = false
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loader2.stopAnimating()
                self.loader2.isHidden = true
                self.generateSummary.isUserInteractionEnabled = true
            }
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let summary = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        
                        let components = summary.components(separatedBy: "\n-").map { line -> String in
                            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                            return trimmedLine.hasPrefix("---") ? String(trimmedLine.dropFirst(2)) : trimmedLine
                        }

                        let cleanedArray = components.map { string -> String in
                            if let index = string.firstIndex(of: " ") {
                                return String(string[index...].dropFirst())
                            } else {
                                return string
                            }
                        }

                        var finalString = cleanedArray.joined(separator: "")
                        
                        finalString = finalString.replacingOccurrences(of: "\\n-", with: "\n\n ") //•
                        finalString = finalString.replacingOccurrences(of: "\\n", with: "\n  ")
                        finalString = String(finalString.dropLast())
                        
                        
                        self.summaryTextView.text = finalString
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("Failed to fetch profile summary, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                }
            }
        }.resume()
    }
    
    func postResumeData() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        

        guard let headline = resumeTextView.text, !headline.isEmpty,
              let summary = summaryTextView.text, !summary.isEmpty 
        else {
            
            let alert = UIAlertController(title: "Missing Information", message: "Fill all the details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let resumeData = ResumeData(headline: headline, summary: summary)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        do {
            let jsonData = try JSONEncoder().encode(resumeData)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode resume data: \(error)")
            return
        }
        
        let loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        loader.startAnimating()
        view.addSubview(loader)

        URLSession.shared.dataTask(with: request) { data, response, error in
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
            }
            
            if let error = error {
                print("Error uploading data: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                loader.stopAnimating()
                loader.removeFromSuperview()
//                let viewController = ViewController()
//                viewController.modalPresentationStyle = .overFullScreen
//                viewController.overrideUserInterfaceStyle = .light
//                self.present(viewController, animated: true)
                
                let viewController = PreviewVC()
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }.resume()
    }

}

struct ResumeData: Codable {
    let headline: String
    let summary: String
}

struct HeadlineResponse: Codable {
    let headline: String
}

