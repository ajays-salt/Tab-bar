//
//  BasicDetails2.swift
//  olousTabBar
//
//  Created by Salt Technologies on 27/03/24.
//

import UIKit

class BasicDetails2: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var headerView : UIView!
    var circleContainerView : UIView!
    
    var scrollView : UIScrollView!
    
    var textView : UITextView!
    var charactersLeftLabel : UILabel = {
        let label = UILabel()
        label.text = "300 characters left"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#475467")
        return label
    }()
    
    var locationsTextField : UITextField!
    var selectedOptions: Set<String> = []
    
    var selectedGenderIndex: Int?
    
    var bottomView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        
        setupViews()
    }
    
    func setupViews() {
        setupHeaderView()
        setupScrollView()
        setupUI()
        setupUI2()
        setupBottomView()
    }
    
    func setupHeaderView() {
        
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        
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
        profileCircleLabel.text = "2/7"
        
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
        let percentage: CGFloat = 2 / 7
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
        titleLabel.text = "Resume Headline"
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
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -105),
        ])
        
        let extraSpaceHeight: CGFloat = 50
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    func setupUI() {
        let topLabel = UILabel()
        topLabel.text = "Add headline & preferences"
        topLabel.font = .boldSystemFont(ofSize: 20)
        topLabel.textColor = UIColor(hex: "#101828")
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(topLabel)
        
        let headlineLabel = UILabel()
        headlineLabel.font = .systemFont(ofSize: 18)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Resume headline")
        let asterisk = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText.append(asterisk)
        headlineLabel.attributedText = attributedText
        headlineLabel.textColor = UIColor(hex: "#344054")
        scrollView.addSubview(headlineLabel)
        
        textView = UITextView()
        textView.delegate = self
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = UIColor(hex: "#344054")
        textView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        textView.layer.borderWidth = 1.0 // Border width
        textView.layer.cornerRadius = 12.0
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Padding
        textView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(textView)
        
        charactersLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(charactersLeftLabel)
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            headlineLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            headlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            textView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 200),
            
            charactersLeftLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            charactersLeftLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    
    func setupUI2() {
        let preferredLocationsLabel = UILabel()
        preferredLocationsLabel.text = "Preferred work locations"
        preferredLocationsLabel.font = .boldSystemFont(ofSize: 20)
        preferredLocationsLabel.textColor = UIColor(hex: "#344054")
        
        preferredLocationsLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(preferredLocationsLabel)
        
        
        locationsTextField = UITextField()
        locationsTextField.delegate = self
        locationsTextField.borderStyle = .roundedRect
        locationsTextField.placeholder = "E.g. Pune, Mumbai, Bangalore"
        locationsTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(locationsTextField)
        
        var suggestionsLabel = UILabel()
        suggestionsLabel.text = "Suggestions :"
        suggestionsLabel.font = .systemFont(ofSize: 16)
        suggestionsLabel.textColor = UIColor(hex: "#667085")
        suggestionsLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(suggestionsLabel)
        
        let options = ["Pune", "Mumbai", "Bangalore", "Gurugram", "Noida", "Delhi", "Hyderabad", "Kolkata"]
        
        
        
        let optionsScrollView = UIScrollView()
        optionsScrollView.showsHorizontalScrollIndicator = false
        optionsScrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(optionsScrollView)
        
        // Create and configure the stack view for options
        let optionsStackView = UIStackView()
        optionsStackView.axis = .horizontal
        optionsStackView.spacing = 12
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        optionsScrollView.addSubview(optionsStackView)
        
        // Add options buttons to the stack view
        for option in options {
            let optionButton = UIButton(type: .system)
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            optionButton.layer.cornerRadius = 8
            optionButton.setTitle("  \(option)  ", for: .normal)
            optionButton.titleLabel?.font = .systemFont(ofSize: 18)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            optionsStackView.addArrangedSubview(optionButton)
        }
        
        let salaryLabel = UILabel()
        salaryLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText3 = NSMutableAttributedString(string: "Preferred Salary")
        let asterisk3 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText3.append(asterisk3)
        salaryLabel.attributedText = attributedText3
        salaryLabel.font = .boldSystemFont(ofSize: 20)
        salaryLabel.textColor = UIColor(hex: "#344054")
        scrollView.addSubview(salaryLabel)
        
        let perYear = UILabel()
        perYear.text = "(per year)"
        perYear.font = .systemFont(ofSize: 16)
        perYear.textColor = UIColor(hex: "#344054")
        perYear.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(perYear)
        
        // Total Experience TextField
        let salaryTextField = UITextField()
        salaryTextField.translatesAutoresizingMaskIntoConstraints = false
        salaryTextField.borderStyle = .roundedRect
        salaryTextField.placeholder = "E.g. ₹ 6,00,000"
        salaryTextField.keyboardType = .decimalPad // Numeric keypad
        salaryTextField.delegate = self // Set delegate for this text field
        scrollView.addSubview(salaryTextField)
        
        let genderLabel = UILabel()
        genderLabel.text = "Gender"
        genderLabel.font = .boldSystemFont(ofSize: 20)
        genderLabel.textColor = UIColor(hex: "#344054")
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(genderLabel)
        
        let genderStackView = UIStackView()
        genderStackView.axis = .horizontal
        genderStackView.spacing = 12
        genderStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(genderStackView)
        
        let genderOptions = ["Male", "Female", "Others"]
        selectedGenderIndex = -1
        
        for (index, option) in genderOptions.enumerated() {
            let button = UIButton(type: .system)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            button.layer.cornerRadius = 8
            button.setTitle("  \(option)  ", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.setTitleColor(.black, for: .normal)
            
            button.addTarget(self, action: #selector(genderOptionSelected(_:)), for: .touchUpInside)
            button.tag = index + 1
            
            button.translatesAutoresizingMaskIntoConstraints = false
            genderStackView.addArrangedSubview(button)
        }
        
        
        NSLayoutConstraint.activate([
            preferredLocationsLabel.topAnchor.constraint(equalTo: charactersLeftLabel.bottomAnchor, constant: 20),
            preferredLocationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            locationsTextField.topAnchor.constraint(equalTo: preferredLocationsLabel.bottomAnchor, constant: 10),
            locationsTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationsTextField.heightAnchor.constraint(equalToConstant: 50),
            
            suggestionsLabel.topAnchor.constraint(equalTo: locationsTextField.bottomAnchor, constant: 10),
            suggestionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            optionsScrollView.topAnchor.constraint(equalTo: suggestionsLabel.bottomAnchor, constant: 10),
            optionsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            optionsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            optionsScrollView.heightAnchor.constraint(equalToConstant: 60),
            optionsStackView.topAnchor.constraint(equalTo: optionsScrollView.topAnchor),
            optionsStackView.leadingAnchor.constraint(equalTo: optionsScrollView.leadingAnchor),
            optionsStackView.trailingAnchor.constraint(equalTo: optionsScrollView.trailingAnchor),
            optionsStackView.heightAnchor.constraint(equalToConstant: 40),
            
            salaryLabel.topAnchor.constraint(equalTo: optionsScrollView.bottomAnchor, constant: 10),
            salaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            perYear.topAnchor.constraint(equalTo: salaryLabel.topAnchor, constant: 4),
            perYear.leadingAnchor.constraint(equalTo: salaryLabel.trailingAnchor, constant: 8),
            
            salaryTextField.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 10),
            salaryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            salaryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            salaryTextField.heightAnchor.constraint(equalToConstant: 60),
            
            genderLabel.topAnchor.constraint(equalTo: salaryTextField.bottomAnchor, constant: 20),
            genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            genderStackView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
            genderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    @objc func optionButtonTapped(_ sender: UIButton) {
        sender.backgroundColor = UIColor(hex: "#EAECF0")
        guard let title = sender.currentTitle?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        if !selectedOptions.contains(title) {
            if let currentText = locationsTextField.text {
                if currentText.isEmpty {
                    locationsTextField.text = title
                } else {
                    locationsTextField.text = "\(currentText), \(title)"
                }
            } else {
                locationsTextField.text = title
            }
            selectedOptions.insert(title)
        }
    }
    
    @objc func genderOptionSelected(_ sender: UIButton) {
        let index = sender.tag
        
        if selectedGenderIndex == -1 {
            selectedGenderIndex = index
        }
        else {
            
            let previousButton = sender.superview?.viewWithTag(selectedGenderIndex!) as? UIButton
            print(previousButton)
            previousButton?.backgroundColor = .clear
        }
        
        sender.backgroundColor = UIColor(hex: "#EAECF0")
        
        selectedGenderIndex = index
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
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            
            backButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            
            nextButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNextButton() {
        let vc = EmploymentVC()
        navigationController?.pushViewController(vc, animated: true)
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


