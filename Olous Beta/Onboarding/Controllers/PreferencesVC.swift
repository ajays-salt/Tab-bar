//
//  PreferencesVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 17/04/24.
//

import UIKit

class PreferencesVC: UIViewController, UITextFieldDelegate {
    
    var headerView : UIView!
    var headerHeightConstraint: NSLayoutConstraint?
    var circleContainerView : UIView!
    
    var scrollView : UIScrollView!
    
    let portfolioTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Portfolio link(Github, Drive etc)"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let currentCtcTextField : UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "E.g. 4"
        textField.keyboardType = .decimalPad // Numeric keypad
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Adding flexible space
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // Adding Done button on the toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        // Assigning the toolbar as UITextField's inputAccessoryView
        textField.inputAccessoryView = toolbar
        
        textField.addTarget(self, action: #selector(limitTextFieldCharacters(_:)), for: .editingChanged)
        
        return textField
    }()
    let expectedCtcTextField : UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "E.g. 7.5"
        textField.keyboardType = .decimalPad // Numeric keypad
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Adding flexible space
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // Adding Done button on the toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        // Assigning the toolbar as UITextField's inputAccessoryView
        textField.inputAccessoryView = toolbar
        
        textField.addTarget(self, action: #selector(limitTextFieldCharacters(_:)), for: .editingChanged)
        
        return textField
    }()
    
    // changes to fit this VC in User Profile VC
    var noticeOptionsScrollView = UIScrollView()
    var noticePeriodOptions = ["Immediate", "15 days", "1 Month", "2 Months", "3 Months" ]
    var relocateStackView = UIStackView()
    var employedStackView = UIStackView()
    var workTypeScrollView = UIScrollView()
    
    var selectedNoticeOptionsButton : UIButton?
    var selectedGenderButton : UIButton?
    var selectedRelocateButton : UIButton?
    var selectedEmployedButton : UIButton?
    var selectedWorkTypeButton : UIButton?
    
    var workTypeScrollViewBottomAnchor: NSLayoutYAxisAnchor?
    
    let permanentTextField : UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "E.g Hinjewadi, Pune"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let permanentPinTextField : UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "E.g. 431504"
        textField.keyboardType = .numberPad // Numeric keypad
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Adding flexible space
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // Adding Done button on the toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        // Assigning the toolbar as UITextField's inputAccessoryView
        textField.inputAccessoryView = toolbar
        
        
        return textField
    }()
    let currentTextField : UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "E.g Hinjewadi, Pune"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let currentPinTextField : UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "E.g. 411057"
        textField.keyboardType = .numberPad // Numeric keypad
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Adding flexible space
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // Adding Done button on the toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        // Assigning the toolbar as UITextField's inputAccessoryView
        textField.inputAccessoryView = toolbar
        
        
        return textField
    }()
    
    
    var bottomView : UIView!
    var bottomHeightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        
        setupViews()
    }
    
    func setupViews() {
        setDelegates()
        setupHeaderView()
        
        setupScrollView()
        setupUI1()
        setupUI2()
        
        setupBottomView()
    }
    
    func setDelegates() {
        portfolioTextField.delegate = self
        currentCtcTextField.delegate = self
        expectedCtcTextField.delegate = self
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
        currentStepLabel.text = "STEP 8 OF 10"
        currentStepLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        currentStepLabel.textColor = .gray
        headerView.addSubview(currentStepLabel)
        currentStepLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the main step title
        let mainStepTitleLabel = UILabel()
        mainStepTitleLabel.text = "ADD PREFERENCES"
        mainStepTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        headerView.addSubview(mainStepTitleLabel)
        mainStepTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress view
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(hex: "#2563EB")
        progressView.trackTintColor = UIColor(hex: "#E5E7EB")
        progressView.setProgress(0.8, animated: true)
        headerView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress label
        let progressLabel = UILabel()
        progressLabel.text = "80%"
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
        let contentHeight = view.bounds.height - 250
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    
    func setupUI1() {
        let portfolioLabel : UILabel = {
            let label = UILabel()
            label.text = "Portfolio Link(Architects, Interior designers)"
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let currentCtcLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Current CTC(LPA)")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let expectedCtcLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Expected CTC(LPA)")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        
        [portfolioLabel,portfolioTextField, currentCtcLabel, currentCtcTextField, expectedCtcLabel, expectedCtcTextField].forEach { v in
            scrollView.addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            portfolioLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            portfolioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            portfolioTextField.topAnchor.constraint(equalTo: portfolioLabel.bottomAnchor, constant: 10),
            portfolioTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            portfolioTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            portfolioTextField.heightAnchor.constraint(equalToConstant: 40),
            
            currentCtcLabel.topAnchor.constraint(equalTo: portfolioTextField.bottomAnchor, constant: 20),
            currentCtcLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            currentCtcTextField.topAnchor.constraint(equalTo: currentCtcLabel.bottomAnchor, constant: 10),
            currentCtcTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currentCtcTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            currentCtcTextField.heightAnchor.constraint(equalToConstant: 40),
            
            expectedCtcLabel.topAnchor.constraint(equalTo: currentCtcTextField.bottomAnchor, constant: 20),
            expectedCtcLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            expectedCtcTextField.topAnchor.constraint(equalTo: expectedCtcLabel.bottomAnchor, constant: 10),
            expectedCtcTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            expectedCtcTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            expectedCtcTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupUI2() {
        let noticePLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Notice Period")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
                
        
        noticeOptionsScrollView.showsHorizontalScrollIndicator = false
        noticeOptionsScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the stack view for options
        let noticeOptionsStackView = UIStackView()
        noticeOptionsStackView.axis = .horizontal
        noticeOptionsStackView.spacing = 12
        noticeOptionsStackView.translatesAutoresizingMaskIntoConstraints = false
        noticeOptionsScrollView.addSubview(noticeOptionsStackView)
        
        // Add options buttons to the stack view
        var i = 1
        for option in noticePeriodOptions {
            let optionButton = UIButton(type: .system)
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            optionButton.layer.cornerRadius = 8
            optionButton.setTitle("  \(option)  ", for: .normal)
            optionButton.titleLabel?.font = .systemFont(ofSize: 18)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.addTarget(self, action: #selector(noticeOptionButtonTapped(_:)), for: .touchUpInside)
            if i == 1 {
                selectedNoticeOptionsButton = optionButton
                selectedNoticeOptionsButton?.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
                selectedNoticeOptionsButton?.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            }
            i = i + 1
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            noticeOptionsStackView.addArrangedSubview(optionButton)
        }
        
        scrollView.addSubview(noticePLabel)
        scrollView.addSubview(noticeOptionsScrollView)
        
        let relocateLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Willing To Relocate")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        
        relocateStackView.axis = .horizontal
        relocateStackView.spacing = 12
        relocateStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let relocateOptions = ["Yes", "No"]
        i = 1
        for (index, option) in relocateOptions.enumerated() {
            let button = UIButton(type: .system)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            button.layer.cornerRadius = 8
            button.setTitle("  \(option)  ", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.setTitleColor(.black, for: .normal)
            
            if i == 1 {
                selectedRelocateButton = button
                selectedRelocateButton?.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
                selectedRelocateButton?.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            }
            i = i + 1
            
            button.addTarget(self, action: #selector(relocateOptionSelected(_:)), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            relocateStackView.addArrangedSubview(button)
        }
        
        scrollView.addSubview(relocateLabel)
        scrollView.addSubview(relocateStackView)
        
        
        let employedLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Are you currently Employed")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        
        employedStackView.axis = .horizontal
        employedStackView.spacing = 12
        employedStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let employedOptions = ["Yes", "No"]
        i = 1
        for (index, option) in employedOptions.enumerated() {
            let button = UIButton(type: .system)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            button.layer.cornerRadius = 8
            button.setTitle("  \(option)  ", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.setTitleColor(.black, for: .normal)
            
            if i == 1 {
                selectedEmployedButton = button
                selectedEmployedButton?.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
                selectedEmployedButton?.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            }
            i = i + 1
            
            button.addTarget(self, action: #selector(employedOptionSelected(_:)), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            employedStackView.addArrangedSubview(button)
        }
        
        scrollView.addSubview(employedLabel)
        scrollView.addSubview(employedStackView)
        
        let workTypeLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Preferred Work Type")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let workTypeOptions = ["Office", "Home", "Office + Site", "On-Site"]
        
        
        workTypeScrollView.showsHorizontalScrollIndicator = false
        workTypeScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the stack view for options
        let workTypeStackView = UIStackView()
        workTypeStackView.axis = .horizontal
        workTypeStackView.spacing = 12
        workTypeStackView.translatesAutoresizingMaskIntoConstraints = false
        workTypeScrollView.addSubview(workTypeStackView)
        
        // Add options buttons to the stack view
        i = 1
        for option in workTypeOptions {
            let optionButton = UIButton(type: .system)
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            optionButton.layer.cornerRadius = 8
            optionButton.setTitle("  \(option)  ", for: .normal)
            optionButton.titleLabel?.font = .systemFont(ofSize: 18)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.addTarget(self, action: #selector(workTypeOptionSelected(_:)), for: .touchUpInside)
            if i == 1 {
                selectedWorkTypeButton = optionButton
                selectedWorkTypeButton?.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
                selectedWorkTypeButton?.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            }
            i = i + 1
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            workTypeStackView.addArrangedSubview(optionButton)
        }
        
        scrollView.addSubview(workTypeLabel)
        scrollView.addSubview(workTypeScrollView)
        
        
        NSLayoutConstraint.activate([
            noticePLabel.topAnchor.constraint(equalTo: expectedCtcTextField.bottomAnchor, constant: 20),
            noticePLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            noticeOptionsScrollView.topAnchor.constraint(equalTo: noticePLabel.bottomAnchor, constant: 10),
            noticeOptionsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noticeOptionsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noticeOptionsScrollView.heightAnchor.constraint(equalToConstant: 40),
            
            noticeOptionsStackView.topAnchor.constraint(equalTo: noticeOptionsScrollView.topAnchor),
            noticeOptionsStackView.leadingAnchor.constraint(equalTo: noticeOptionsScrollView.leadingAnchor),
            noticeOptionsStackView.trailingAnchor.constraint(equalTo: noticeOptionsScrollView.trailingAnchor),
            noticeOptionsStackView.heightAnchor.constraint(equalToConstant: 40),
            
            relocateLabel.topAnchor.constraint(equalTo: noticeOptionsScrollView.bottomAnchor, constant: 20),
            relocateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            relocateStackView.topAnchor.constraint(equalTo: relocateLabel.bottomAnchor, constant: 10),
            relocateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            employedLabel.topAnchor.constraint(equalTo: relocateStackView.bottomAnchor, constant: 20),
            employedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            employedStackView.topAnchor.constraint(equalTo: employedLabel.bottomAnchor, constant: 10),
            employedStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            workTypeLabel.topAnchor.constraint(equalTo: employedStackView.bottomAnchor, constant: 20),
            workTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            workTypeScrollView.topAnchor.constraint(equalTo: workTypeLabel.bottomAnchor, constant: 10),
            workTypeScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            workTypeScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            workTypeScrollView.heightAnchor.constraint(equalToConstant: 40),
            
            workTypeStackView.topAnchor.constraint(equalTo: workTypeScrollView.topAnchor),
            workTypeStackView.leadingAnchor.constraint(equalTo: workTypeScrollView.leadingAnchor),
            workTypeStackView.trailingAnchor.constraint(equalTo: workTypeScrollView.trailingAnchor),
            workTypeStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        workTypeScrollViewBottomAnchor = workTypeScrollView.bottomAnchor
    }
    
    
    @objc func noticeOptionButtonTapped(_ sender: UIButton) {
        selectedNoticeOptionsButton?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedNoticeOptionsButton?.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        selectedNoticeOptionsButton = sender
    }
    
    @objc func relocateOptionSelected(_ sender: UIButton) {
        selectedRelocateButton?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedRelocateButton?.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        selectedRelocateButton = sender
    }
    
    @objc func employedOptionSelected(_ sender: UIButton) {
        selectedEmployedButton?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedEmployedButton?.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        selectedEmployedButton = sender
    }
    
    @objc func workTypeOptionSelected(_ sender: UIButton) {
        selectedWorkTypeButton?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedWorkTypeButton?.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        selectedWorkTypeButton = sender
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
            
            backButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15),
            backButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            
            nextButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15),
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
        uploadUserProfile()
    }
    
    
    @objc func doneButtonAction() {
        // Dismiss the keyboard when Done is tapped
        currentCtcTextField.resignFirstResponder()
        expectedCtcTextField.resignFirstResponder()
        permanentPinTextField.resignFirstResponder()
        currentPinTextField.resignFirstResponder()
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



extension PreferencesVC {
    func uploadUserProfile() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        guard let portfolio = portfolioTextField.text,
              let currentCtcText = currentCtcTextField.text, !currentCtcText.isEmpty, let currentCtc = Double(currentCtcText),
              let expectedCtcText = expectedCtcTextField.text, !expectedCtcText.isEmpty, let expectedCtc = Double(expectedCtcText),
              let noticePeriod = selectedNoticeOptionsButton?.titleLabel?.text,
              let willingToRelocate = selectedRelocateButton?.titleLabel?.text,
              let currentlyEmployed = selectedEmployedButton?.titleLabel?.text,
              let preferredWorkType = selectedWorkTypeButton?.titleLabel?.text 
        else {
            showAlert()
            return
        }
        
        let userPreferencesUpdate = UserPreferencesUpdate(
            hobbies: "",
            preferredWorkType: preferredWorkType.trimmingCharacters(in: .whitespacesAndNewlines),
            willingToRelocate: willingToRelocate,
            noticePeriod: noticePeriod,
            currentlyEmployed: currentlyEmployed,
            currentCtc: currentCtc,
            expectedCtc: expectedCtc,
            portfolio: portfolio
        )
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        
        
        do {
            let jsonData = try JSONEncoder().encode(userPreferencesUpdate)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode user profile to JSON: \(error)")
            return
        }
        
        let loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        loader.startAnimating()
        view.addSubview(loader)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to upload user profile, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return
            }
            print(response)
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Server response: \(responseString)")
            }
            if let error = error {
                print("Error uploading user profile: \(error.localizedDescription)")
            } else {
                print("User Preferences successfully uploaded.")
            }
            DispatchQueue.main.async {
                loader.stopAnimating()
                loader.removeFromSuperview()
                let vc = HeadlineAndSummary()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }.resume()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Missing Information", message: "Please fill in all the details.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func limitTextFieldCharacters(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        let text2 = text.prefix(3)
        
        if text2.contains(".") && text.count >= 3 {
            textField.text = String(text)
            
        } else {
            if text.count > 3 {
                textField.text = String(text.prefix(3))
            }
        }
    }
}
