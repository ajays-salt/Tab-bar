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
//        textField.keyboardType = .decimalPad // Numeric keypad
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let currentCtcTextField : UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "E.g. 4.8"
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
        
        
        return textField
    }()
    let expectedCtcTextField : UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "E.g. 6.5"
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
        
        return textField
    }()
    
    // changes to fit this VC in User Profile VC
    var noticeOptionsScrollView = UIScrollView()
    var noticePeriodOptions = ["Immediate", "15 days", "1 Month", "2 Months", "3 Months", "More than 3 Months", ]
    var genderStackView = UIStackView()
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
    
    var addLanguageContainer = UIView()
    
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
        setupUI3()
        setupUI4()
        
        setupBottomView()
    }
    
    func setDelegates() {
        portfolioTextField.delegate = self
        currentCtcTextField.delegate = self
        expectedCtcTextField.delegate = self
        
        permanentTextField.delegate = self
        permanentPinTextField.delegate = self
        currentTextField.delegate = self
        currentPinTextField.delegate = self
    }
    
    func setupHeaderView() {
        
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 80)
        headerHeightConstraint?.isActive = true
        
        circleContainerView = UIView(frame: CGRect(x: 60, y: 60, width: 60, height: 60))
        circleContainerView.layer.cornerRadius = 30
        
        circleContainerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(circleContainerView)
        NSLayoutConstraint.activate([
            circleContainerView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            circleContainerView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            circleContainerView.widthAnchor.constraint(equalToConstant: 60),
            circleContainerView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let profileCircleLabel : UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = UIColor(hex: "#000000")
            label.font = .boldSystemFont(ofSize: 24)
            return label
        }()
        profileCircleLabel.text = "7/8"
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        circleContainerView.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: circleContainerView.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: circleContainerView.centerYAnchor)
        ])
        
        
        // Calculate the center and radius of the circle
        let center = CGPoint(x: circleContainerView.bounds.midX, y: circleContainerView.bounds.midY)
        let radius = min(circleContainerView.bounds.width, circleContainerView.bounds.height) / 2
        
        // Calculate the end angle based on the percentage (0.75 for 75%)
        let percentage: CGFloat = 7 / 8
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
            greenBorderLayer.strokeColor = UIColor(hex: "#0079C4").cgColor // Border color
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
            normalBorderLayer.strokeColor = UIColor(hex: "#D9D9D9").cgColor // Border color
            normalBorderLayer.fillColor = UIColor.clear.cgColor
            return normalBorderLayer
        }()
        circleContainerView.layer.addSublayer(normalBorderLayer)
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Preferences"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
        ])
        
        let borderView = UIView()
        borderView.backgroundColor = UIColor(hex: "#EAECF0")
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(borderView)
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -1),
            borderView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            borderView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            borderView.heightAnchor.constraint(equalToConstant: 1)
        ])
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
        
        let extraSpaceHeight: CGFloat = 450
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    func setupUI1() {
        let portfolioLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Portfolio Link")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
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
            portfolioLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
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
            
            expectedCtcLabel.topAnchor.constraint(equalTo: currentCtcTextField.bottomAnchor, constant: 10),
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
        
        
        let genderLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Gender")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
//            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        
        genderStackView.axis = .horizontal
        genderStackView.spacing = 12
        genderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let genderOptions = ["Male", "Female", "Others"]
        i = 1
        for (index, option) in genderOptions.enumerated() {
            let button = UIButton(type: .system)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            button.layer.cornerRadius = 8
            button.setTitle("  \(option)  ", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.setTitleColor(.black, for: .normal)
            
            if i == 1 {
                selectedGenderButton = button
                selectedGenderButton?.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
                selectedGenderButton?.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            }
            i = i + 1
            
            button.addTarget(self, action: #selector(genderOptionSelected(_:)), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            genderStackView.addArrangedSubview(button)
        }
        
        scrollView.addSubview(genderLabel)
        scrollView.addSubview(genderStackView)
        
        
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
            
            genderLabel.topAnchor.constraint(equalTo: noticeOptionsScrollView.bottomAnchor, constant: 20),
            genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            genderStackView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
            genderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            relocateLabel.topAnchor.constraint(equalTo: genderStackView.bottomAnchor, constant: 20),
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
    
    func setupUI3() {
        let permanentLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Permanent Address")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let permanentPinLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Pin Code")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let currentLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Current Address")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let currentPinLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Pin Code")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        [permanentLabel, permanentTextField, permanentPinLabel, permanentPinTextField, currentLabel, currentTextField, currentPinLabel, currentPinTextField].forEach { v in
            scrollView.addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            permanentLabel.topAnchor.constraint(equalTo: workTypeScrollViewBottomAnchor!, constant: 20),
            permanentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            permanentTextField.topAnchor.constraint(equalTo: permanentLabel.bottomAnchor, constant: 10),
            permanentTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            permanentTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            permanentTextField.heightAnchor.constraint(equalToConstant: 40),
            
            permanentPinLabel.topAnchor.constraint(equalTo: permanentTextField.bottomAnchor, constant: 20),
            permanentPinLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            permanentPinTextField.topAnchor.constraint(equalTo: permanentPinLabel.bottomAnchor, constant: 10),
            permanentPinTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            permanentPinTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            permanentPinTextField.heightAnchor.constraint(equalToConstant: 40),
            
            currentLabel.topAnchor.constraint(equalTo: permanentPinTextField.bottomAnchor, constant: 20),
            currentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            currentTextField.topAnchor.constraint(equalTo: currentLabel.bottomAnchor, constant: 10),
            currentTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currentTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            currentTextField.heightAnchor.constraint(equalToConstant: 40),
            
            currentPinLabel.topAnchor.constraint(equalTo: currentTextField.bottomAnchor, constant: 20),
            currentPinLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            currentPinTextField.topAnchor.constraint(equalTo: currentPinLabel.bottomAnchor, constant: 10),
            currentPinTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currentPinTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            currentPinTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    
    // This will hold your language entries
    
    let languagePicker = UIPickerView()
    let fluencyPicker = UIPickerView()
    
    let languageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Language"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let fluencyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Fluency Level"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    var languageArray: [Language] = []
    let languages = ["English", "Spanish", "French", "German"]
    let fluencyLevels = ["Beginner", "Intermediate", "Advanced", "Native"]
    struct LanguageInfo {
        var language: String
        var fluency: String
    }
    
    lazy var addLanguageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+ Add Language", for: .normal)
        button.addTarget(self, action: #selector(addLanguageEntry), for: .touchUpInside)
        return button
    }()
    var languageCV : UICollectionView!
    var languageCVHeightConstraint: NSLayoutConstraint!
    
    
    func setupUI4() {
        let langLabel = UILabel()
        langLabel.text = "Languages :"
        langLabel.font = .boldSystemFont(ofSize: 20)
        langLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(langLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        languageCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        languageCV.register(LanguageCell.self, forCellWithReuseIdentifier: "language")
        languageCV.dataSource = self
        languageCV.delegate = self
        
        languageCV.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(languageCV)
        
        NSLayoutConstraint.activate([
            langLabel.topAnchor.constraint(equalTo: currentPinTextField.bottomAnchor, constant: 20),
            langLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            languageCV.topAnchor.constraint(equalTo: langLabel.bottomAnchor, constant: 10),
            languageCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            languageCV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        languageCVHeightConstraint = languageCV.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        languageCVHeightConstraint.isActive = true
        
        
        
        
        
        addLanguageContainer.layer.borderWidth = 1
        addLanguageContainer.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        addLanguageContainer.layer.cornerRadius = 12
        addLanguageContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(addLanguageContainer)
        
        let addLangLabel = UILabel()
        addLangLabel.text = "Add Language"
        addLangLabel.font = .boldSystemFont(ofSize: 18)
        addLangLabel.translatesAutoresizingMaskIntoConstraints = false
        addLanguageContainer.addSubview(addLangLabel)
        
        addLanguageContainer.addSubview(languageTextField)
        addLanguageContainer.addSubview(fluencyTextField)
        
//        languageTextField.inputView = languagePicker
        fluencyTextField.inputView = fluencyPicker
        languagePicker.delegate = self
        languagePicker.dataSource = self
        fluencyPicker.delegate = self
        fluencyPicker.dataSource = self
        
        languageTextField.translatesAutoresizingMaskIntoConstraints = false
        fluencyTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addLanguageButton.translatesAutoresizingMaskIntoConstraints = false
        addLanguageContainer.addSubview(addLanguageButton)
        
        NSLayoutConstraint.activate([
            addLanguageContainer.topAnchor.constraint(equalTo: languageCV.bottomAnchor, constant: 20),
            addLanguageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addLanguageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addLanguageContainer.heightAnchor.constraint(equalToConstant: 120),
            
            addLangLabel.topAnchor.constraint(equalTo: addLanguageContainer.topAnchor, constant: 10),
            addLangLabel.leadingAnchor.constraint(equalTo: addLanguageContainer.leadingAnchor, constant: 10),
            
            languageTextField.topAnchor.constraint(equalTo: addLangLabel.bottomAnchor, constant: 10),
            languageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            languageTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45, constant: -10),
            
            fluencyTextField.topAnchor.constraint(equalTo: addLangLabel.bottomAnchor, constant: 10),
            fluencyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            fluencyTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45, constant: -10),
            
            addLanguageButton.topAnchor.constraint(equalTo: fluencyTextField.bottomAnchor, constant: 8),
            addLanguageButton.centerXAnchor.constraint(equalTo: fluencyTextField.centerXAnchor),
        ])
        
    }
    
    func reloadCollectionView() {
        languageCV.reloadData()
            
        // Calculate the content size
        languageCV.layoutIfNeeded()
        let contentSize = languageCV.collectionViewLayout.collectionViewContentSize
        
        // Update the height constraint based on content size
        languageCVHeightConstraint.constant = contentSize.height
        
        // Update constraints
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func addLanguageEntry() {
        
        guard let language = languageTextField.text, !language.isEmpty,
            let fluency = fluencyTextField.text, !fluency.isEmpty else {
            // Show an alert if either field is empty
            let alert = UIAlertController(title: "Missing Information", message: "Fill all the details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Create a new LanguageInfo object and append it to the array
        let newEntry = Language(language: language, proficiencyLevel: fluency, read: true, write: true, speak: true)
        languageArray.append(newEntry)
        
        // Reload the collection view to display the new entry
        reloadCollectionView()
    }
    
    @objc func deleteLanguageEntry(_ sender: UIButton) {
        // Find the collection view cell that is the parent view of the delete button
        var superView = sender.superview
        while let view = superView, !(view is UICollectionViewCell) {
            superView = view.superview
        }
        
        // Ensure we have a valid cell and can retrieve its index path
        guard let cell = superView as? UICollectionViewCell,
              let indexPath = languageCV.indexPath(for: cell) else {
            return
        }
        
        // Remove the item from the data source
        languageArray.remove(at: indexPath.row)
        
        // Remove the cell from the collection view
        languageCV.performBatchUpdates({
            languageCV.deleteItems(at: [indexPath])
        }, completion: { _ in
            // Reload collection view to recalculate heights and other layout properties if needed
            self.reloadCollectionView()
        })
    }
    
    
    @objc func noticeOptionButtonTapped(_ sender: UIButton) {
        selectedNoticeOptionsButton?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedNoticeOptionsButton?.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        selectedNoticeOptionsButton = sender
    }
    
    @objc func genderOptionSelected(_ sender: UIButton) {
        selectedGenderButton?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedGenderButton?.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        selectedGenderButton = sender
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
        let vc = HeadlineAndSummary()
        navigationController?.pushViewController(vc, animated: true)
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

extension PreferencesVC : UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return languageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "language", for: indexPath) as! LanguageCell
        cell.deleteButton.addTarget(self, action: #selector(deleteLanguageEntry), for: .touchUpInside)
        cell.languageLabel.text = languageArray[indexPath.row].language
        cell.fluencyLabel.text = languageArray[indexPath.row].proficiencyLevel
        cell.deleteButton.addTarget(self, action: #selector(deleteLanguageEntry), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 50)
    }
    
    // Within LanguageViewController

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1  // Both pickers only have one component
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === languagePicker {
            return languages.count
        } else if pickerView === fluencyPicker {
            return fluencyLevels.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView === languagePicker {
            return languages[row]
        } else if pickerView === fluencyPicker {
            return fluencyLevels[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === languagePicker {
            languageTextField.text = languages[row]
        } else if pickerView === fluencyPicker {
            fluencyTextField.text = fluencyLevels[row]
        }
        // Dismiss the picker view by resigning the text field as the first responder
        self.view.endEditing(true)
    }

}


extension PreferencesVC {
    func uploadUserProfile() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        guard let portfolio = portfolioTextField.text, !portfolio.isEmpty,
              let currentCtcText = currentCtcTextField.text, !currentCtcText.isEmpty, let currentCtc = Double(currentCtcText),
              let expectedCtcText = expectedCtcTextField.text, !expectedCtcText.isEmpty, let expectedCtc = Double(expectedCtcText),
              let permanentAddress = permanentTextField.text, !permanentAddress.isEmpty,
              let permanentPin = permanentPinTextField.text, !permanentPin.isEmpty,
              let currentAddress = currentTextField.text, !currentAddress.isEmpty,
              let currentPin = currentPinTextField.text, !currentPin.isEmpty,
              let noticePeriod = selectedNoticeOptionsButton?.titleLabel?.text,
              let gender = selectedGenderButton?.titleLabel?.text,
              let willingToRelocate = selectedRelocateButton?.titleLabel?.text,
              let currentlyEmployed = selectedEmployedButton?.titleLabel?.text,
              let preferredWorkType = selectedWorkTypeButton?.titleLabel?.text 
        else {
            showAlert()
            return
        }
        
        
        let userProfileUpdate = UserProfileUpdate(
            hobbies: "",
            preferredWorkType: preferredWorkType,
            willingToRelocate: willingToRelocate,
            gender: gender,
            noticePeriod: noticePeriod,
            currentlyEmployed: currentlyEmployed,
            permanentAddress: Address(address: permanentAddress, pinCode: permanentPin),
            currentAddress: Address(address: currentAddress, pinCode: currentPin),
            currentCtc: currentCtc,
            expectedCtc: expectedCtc,
//            language: [
//                Language(language: "English", proficiencyLevel: "Expert", read: true, write: true, speak: true)
//            ],
            language: languageArray,
            portfolio: portfolio
        )
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        
        
        do {
            let jsonData = try JSONEncoder().encode(userProfileUpdate)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode user profile to JSON: \(error)")
            return
        }
        
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
                print("User profile successfully uploaded.")
            }
        }.resume()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Missing Information", message: "Please fill in all the details.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
