//
//  EmployentVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 28/03/24.
//

import UIKit

class EmploymentVC: UIViewController, UITextFieldDelegate {

    var headerView : UIView!
    var circleContainerView : UIView!
    
    var scrollView : UIScrollView!
    
    var employmentStatusView : UIView!
    var selectedYesNoIndex: Int?
    
    var addEmploymentView : UIView!
    var bottomView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        
        setupViews()
    }
    
    func setupViews() {
        setupHeaderView()
        setupEmploymentStatusView()
        
        setupScrollView()
        setupContentView()
        
        setupAddEmployment()
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
        profileCircleLabel.text = "3/7"
        
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
        let percentage: CGFloat = 3 / 7
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
    
    func setupEmploymentStatusView() {
        // Create and configure the label
        employmentStatusView = UIView()
        employmentStatusView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(employmentStatusView)
        
        let label = UILabel()
        label.text = "ADD YOUR EMPLOYMENT"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hex: "#101828")
        label.translatesAutoresizingMaskIntoConstraints = false
        employmentStatusView.addSubview(label)
        
        let employmentStatusLabel = UILabel()
        employmentStatusLabel.text = "Are you currently employed?"
        employmentStatusLabel.font = .boldSystemFont(ofSize: 18)
        employmentStatusLabel.textColor = UIColor(hex: "#344054")
        employmentStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        employmentStatusView.addSubview(employmentStatusLabel)
        
        selectedYesNoIndex = -1
        
        // Create and configure the "Yes" button
        let yesButton = UIButton()
        yesButton.layer.borderWidth = 1
        yesButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        yesButton.layer.cornerRadius = 8
        yesButton.setTitle("  Yes  ", for: .normal)
        yesButton.titleLabel?.font = .systemFont(ofSize: 18)
        yesButton.setTitleColor(.black, for: .normal)
        yesButton.tag = 1
        yesButton.addTarget(self, action: #selector(didTapYesNoButton), for: .touchUpInside)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        employmentStatusView.addSubview(yesButton)
        
        // Create and configure the "No" button
        let noButton = UIButton()
        noButton.layer.borderWidth = 1
        noButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        noButton.layer.cornerRadius = 8
        noButton.setTitle("  No  ", for: .normal)
        noButton.titleLabel?.font = .systemFont(ofSize: 18)
        noButton.setTitleColor(.black, for: .normal)
        noButton.tag = 2
        noButton.addTarget(self, action: #selector(didTapYesNoButton), for: .touchUpInside)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        employmentStatusView.addSubview(noButton)
        
        // Add constraints for the label
        NSLayoutConstraint.activate([
            employmentStatusView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            employmentStatusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            employmentStatusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            employmentStatusView.heightAnchor.constraint(equalToConstant: 130),
            
            label.topAnchor.constraint(equalTo: employmentStatusView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: employmentStatusView.leadingAnchor, constant: 16),
            
            employmentStatusLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            employmentStatusLabel.leadingAnchor.constraint(equalTo: employmentStatusView.leadingAnchor, constant: 16),
            
            yesButton.topAnchor.constraint(equalTo: employmentStatusLabel.bottomAnchor, constant: 10),
            yesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            yesButton.widthAnchor.constraint(equalToConstant: 60),
        
            noButton.topAnchor.constraint(equalTo: employmentStatusLabel.bottomAnchor, constant: 10),
            noButton.leadingAnchor.constraint(equalTo: yesButton.trailingAnchor, constant: 20),
            noButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    @objc func didTapYesNoButton(_ sender: UIButton) {
        let index = sender.tag
        
        if selectedYesNoIndex == -1 {
            selectedYesNoIndex = index
        }
        else {
            
            let previousButton = sender.superview?.viewWithTag(selectedYesNoIndex!) as? UIButton
            previousButton?.backgroundColor = .clear
        }
        
        sender.backgroundColor = UIColor(hex: "#EAECF0")
        selectedYesNoIndex = index
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: employmentStatusView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170),
        ])
        
        let extraSpaceHeight: CGFloat = 50
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }

    
    func setupContentView() {
        let contentView = createContentView()
        contentView.backgroundColor = UIColor(hex: "#EAECF0")
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 400),
        ])
        
        let expandButton = UIButton()
        expandButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        expandButton.imageView?.tintColor = UIColor(hex: "#667085")
        expandButton.addTarget(self, action: #selector(didTapExpandButton), for: .touchUpInside)
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(expandButton)
        
        let totalExperienceLabel = UILabel()
        totalExperienceLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText1 = NSMutableAttributedString(string: "Total experience (years)")
        let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText1.append(asterisk1)
        totalExperienceLabel.attributedText = attributedText1
        totalExperienceLabel.font = .boldSystemFont(ofSize: 16)
        totalExperienceLabel.textColor = UIColor(hex: "#344054")
        contentView.addSubview(totalExperienceLabel)
        
        // Total Experience TextField
        let totalExperienceTextField = UITextField()
        totalExperienceTextField.translatesAutoresizingMaskIntoConstraints = false
        totalExperienceTextField.borderStyle = .roundedRect
        totalExperienceTextField.placeholder = "Enter Total Experience"
        totalExperienceTextField.keyboardType = .decimalPad // Numeric keypad
        totalExperienceTextField.delegate = self // Set delegate for this text field
        contentView.addSubview(totalExperienceTextField)
        
        let companyLabel = UILabel()
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText2 = NSMutableAttributedString(string: "Current company")
        let asterisk2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText2.append(asterisk2)
        companyLabel.attributedText = attributedText2
        companyLabel.font = .boldSystemFont(ofSize: 16)
        companyLabel.textColor = UIColor(hex: "#344054")
        contentView.addSubview(companyLabel)
        
        // Total Experience TextField
        let companyTextField = UITextField()
        companyTextField.translatesAutoresizingMaskIntoConstraints = false
        companyTextField.borderStyle = .roundedRect
        companyTextField.placeholder = "E.g. Salt Technologies"
        companyTextField.delegate = self // Set delegate for this text field
        contentView.addSubview(companyTextField)
        
        let jobTitleLabel = UILabel()
        jobTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText3 = NSMutableAttributedString(string: "Current job title")
        let asterisk3 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText3.append(asterisk3)
        jobTitleLabel.attributedText = attributedText3
        jobTitleLabel.font = .boldSystemFont(ofSize: 16)
        jobTitleLabel.textColor = UIColor(hex: "#344054")
        contentView.addSubview(jobTitleLabel)
        
        // Total Experience TextField
        let jobTitleTextField = UITextField()
        jobTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        jobTitleTextField.borderStyle = .roundedRect
        jobTitleTextField.placeholder = "E.g. Civil Engineer"
        jobTitleTextField.delegate = self // Set delegate for this text field
        contentView.addSubview(jobTitleTextField)
        
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText4 = NSMutableAttributedString(string: "Current city")
        let asterisk4 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText4.append(asterisk4)
        cityLabel.attributedText = attributedText4
        cityLabel.font = .boldSystemFont(ofSize: 16)
        cityLabel.textColor = UIColor(hex: "#344054")
        contentView.addSubview(cityLabel)
        
        // Total Experience TextField
        let cityTextField = UITextField()
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.borderStyle = .roundedRect
        cityTextField.placeholder = "Mention the city you live in"
        cityTextField.delegate = self // Set delegate for this text field
        contentView.addSubview(cityTextField)
        
        NSLayoutConstraint.activate([
            expandButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            expandButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            expandButton.widthAnchor.constraint(equalToConstant: 30),
            expandButton.heightAnchor.constraint(equalToConstant: 30),
            
            totalExperienceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            totalExperienceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            totalExperienceTextField.topAnchor.constraint(equalTo: totalExperienceLabel.bottomAnchor, constant: 10),
            totalExperienceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            totalExperienceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            totalExperienceTextField.heightAnchor.constraint(equalToConstant: 50),
            
            companyLabel.topAnchor.constraint(equalTo: totalExperienceTextField.bottomAnchor, constant: 20),
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
            
            cityLabel.topAnchor.constraint(equalTo: jobTitleTextField.bottomAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            cityTextField.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cityTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func didTapExpandButton(_ sender : UIButton) {
        if sender.image(for: .normal) == UIImage(systemName: "chevron.down") {
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
        else {
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        guard let superview = sender.superview else { return }
        
        // Toggle the superview height
        let newHeight: CGFloat = superview.frame.height == 50 ? 400 : 50
        superview.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = newHeight
            }
        }
        
        // Animate the change
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func createContentView() -> UIScrollView {
        let contentView = UIScrollView()
        
        let extraSpaceHeight: CGFloat = 50
        // Add extra space at the bottom
        contentView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        contentView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
        
        return contentView
    }
    
    
    func setupAddEmployment() {
        
        let borderView = UIView()
        borderView.backgroundColor = UIColor(hex: "#EAECF0")
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(borderView)
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 1),
            borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            borderView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        addEmploymentView = UIView()
        addEmploymentView.layer.borderWidth = 1
        addEmploymentView.layer.cornerRadius = 8
        addEmploymentView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        
        addEmploymentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addEmploymentView)
        
        
        
        NSLayoutConstraint.activate([
            addEmploymentView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 15),
            addEmploymentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addEmploymentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addEmploymentView.heightAnchor.constraint(equalToConstant: 50),
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
            bottomView.topAnchor.constraint(equalTo: addEmploymentView.bottomAnchor),
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
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNextButton() {
        print(#function)
//        let vc = EmploymentVC()
//        navigationController?.pushViewController(vc, animated: true)
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
