//
//  BasicDetails1.swift
//  olousTabBar
//
//  Created by Salt Technologies on 27/03/24.
//

import Foundation
import UIKit
import MobileCoreServices

class BasicDetails1: UIViewController, UITextFieldDelegate {
    
    var headerView : UIView!
    var circleContainerView : UIView!
    
    var fullNameTextField : UITextField!
    var mobileNumberTextField : UITextField!
    
    var isResumeUploaded = false
    
    var resumeContainer : UIView!
    var uploadLogoView : UIView!
    var clickToUploadLabel : UILabel!
    var uploadedFileView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uploadButtonTapped))
        clickToUploadLabel.addGestureRecognizer(tapGesture)
    }
    
    func setupViews() {
        setupHeaderView2()
//        setupTextFields()
        setupResumeUploadView()
        setupNextButton()
        setupBackButton()
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
        profileCircleLabel.text = "1/9"
        
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
        let percentage: CGFloat = 1 / 9
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
        titleLabel.text = "Upload Resume"
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
    
    
    func setupHeaderView2() {
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        var stepsLabel = UILabel()
        stepsLabel.text = "Steps"
        stepsLabel.textColor = UIColor(hex: "#1D2026")
        stepsLabel.font = .boldSystemFont(ofSize: 24)
        stepsLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(stepsLabel)
        
        var blueCircle1 = UIView()
        blueCircle1.layer.cornerRadius = 4
        blueCircle1.backgroundColor = UIColor(hex: "#2563EB")
        blueCircle1.translatesAutoresizingMaskIntoConstraints = false
        var blueCircle2 = UIView()
        blueCircle2.layer.cornerRadius = 8
        blueCircle2.backgroundColor = UIColor(hex: "#2563EB").withAlphaComponent(0.5)
        blueCircle2.translatesAutoresizingMaskIntoConstraints = false
        
        var line = UIView()
        line.backgroundColor = UIColor(hex: "#2563EB")
        line.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(line)
        
        
        headerView.addSubview(blueCircle2)
        headerView.addSubview(blueCircle1)
        NSLayoutConstraint.activate([
            stepsLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            stepsLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            blueCircle2.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 46),
            blueCircle2.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            blueCircle2.widthAnchor.constraint(equalToConstant: 16),
            blueCircle2.heightAnchor.constraint(equalToConstant: 16),
            
            blueCircle1.centerXAnchor.constraint(equalTo: blueCircle2.centerXAnchor),
            blueCircle1.centerYAnchor.constraint(equalTo: blueCircle2.centerYAnchor),
            blueCircle1.widthAnchor.constraint(equalToConstant: 8),
            blueCircle1.heightAnchor.constraint(equalToConstant: 8),
            
            line.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 53),
            line.leadingAnchor.constraint(equalTo: blueCircle2.trailingAnchor, constant: 10),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.widthAnchor.constraint(equalToConstant: 150),
        ])
        
        var highlightCircle1 = UIView()
        highlightCircle1.layer.cornerRadius = 4
        highlightCircle1.backgroundColor = UIColor(hex: "#D0D5DD")
        highlightCircle1.translatesAutoresizingMaskIntoConstraints = false
        var highlightCircle2 = UIView()
        highlightCircle2.layer.cornerRadius = 8
        highlightCircle2.backgroundColor = UIColor(hex: "#EAECF0")
        highlightCircle2.translatesAutoresizingMaskIntoConstraints = false
        
        var line1 = UIView()
        line1.backgroundColor = UIColor(hex: "#EAECF0")
        line1.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(line1)
        
        
        headerView.addSubview(highlightCircle2)
        headerView.addSubview(highlightCircle1)
        NSLayoutConstraint.activate([
            
            highlightCircle2.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 46),
            highlightCircle2.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 204),
            highlightCircle2.widthAnchor.constraint(equalToConstant: 16),
            highlightCircle2.heightAnchor.constraint(equalToConstant: 16),
            
            highlightCircle1.centerXAnchor.constraint(equalTo: highlightCircle2.centerXAnchor),
            highlightCircle1.centerYAnchor.constraint(equalTo: highlightCircle2.centerYAnchor),
            highlightCircle1.widthAnchor.constraint(equalToConstant: 8),
            highlightCircle1.heightAnchor.constraint(equalToConstant: 8),
            
            line1.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 53),
            line1.leadingAnchor.constraint(equalTo: highlightCircle2.trailingAnchor, constant: 10),
            line1.heightAnchor.constraint(equalToConstant: 2),
            line1.widthAnchor.constraint(equalToConstant: 150),
        ])

        
    
        // Create step views
        let steps = [("Add Basics", "Resume and Qualification"),
                     ("Experience", "Experience and Software")]
        
        let firstStepView = createStepView(steps[0].0, subtitle: steps[0].1, isActive: true)
        let secondStepView = createStepView(steps[1].0, subtitle: steps[1].1, isActive: false)
        firstStepView.translatesAutoresizingMaskIntoConstraints = false
        secondStepView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(firstStepView)
        headerView.addSubview(secondStepView)
        
        // Create and configure the current step label
        let currentStepLabel = UILabel()
        currentStepLabel.text = "STEP 1 OF 9"
        currentStepLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        currentStepLabel.textColor = .gray
        headerView.addSubview(currentStepLabel)
        currentStepLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the main step title
        let mainStepTitleLabel = UILabel()
        mainStepTitleLabel.text = "ADD RESUME"
        mainStepTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        headerView.addSubview(mainStepTitleLabel)
        mainStepTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress view
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(hex: "#2563EB")
        progressView.trackTintColor = UIColor(hex: "#E5E7EB")
        progressView.setProgress(0.1, animated: true)
        headerView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress label
        let progressLabel = UILabel()
        progressLabel.text = "10%"
        progressLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        progressLabel.textColor = .gray
        headerView.addSubview(progressLabel)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up constraints
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            firstStepView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 62),
            firstStepView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            secondStepView.topAnchor.constraint(equalTo: firstStepView.topAnchor),
            secondStepView.leadingAnchor.constraint(equalTo: firstStepView.trailingAnchor, constant: 190),
            
            currentStepLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 130),
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
    
    
    func createStepView(_ title: String, subtitle: String, isActive: Bool) -> UIView {
        let view = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = isActive ? UIColor(hex: "#101828") : .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.textColor = .gray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }
    
    
    func setupTextFields() {
        let fullNameLabel = UILabel()
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Full Name")
        let asterisk = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText.append(asterisk)
        fullNameLabel.attributedText = attributedText
        view.addSubview(fullNameLabel)
        
        // Full Name TextField
        fullNameTextField = UITextField()
        fullNameTextField.translatesAutoresizingMaskIntoConstraints = false
        fullNameTextField.borderStyle = .roundedRect
        fullNameTextField.placeholder = "Enter Full Name"
        view.addSubview(fullNameTextField)
        
        // Mobile Number Label
        let mobileNumberLabel = UILabel()
        mobileNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText2 = NSMutableAttributedString(string: "Mobile Number")
        let asterisk2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText2.append(asterisk2)
        mobileNumberLabel.attributedText = attributedText2
        view.addSubview(mobileNumberLabel)
        
        // Mobile Number TextField
        mobileNumberTextField = UITextField()
        mobileNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        mobileNumberTextField.borderStyle = .roundedRect
        mobileNumberTextField.placeholder = "Enter Mobile Number"
        mobileNumberTextField.keyboardType = .decimalPad // Numeric keypad
        mobileNumberTextField.delegate = self // Set delegate for this text field
        view.addSubview(mobileNumberTextField)
        
        // Total Experience Label
//        let totalExperienceLabel = UILabel()
//        totalExperienceLabel.translatesAutoresizingMaskIntoConstraints = false
//        let attributedText3 = NSMutableAttributedString(string: "Total experience (years)")
//        let asterisk3 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
//        attributedText3.append(asterisk3)
//        totalExperienceLabel.attributedText = attributedText3
//        view.addSubview(totalExperienceLabel)
        
        // Total Experience TextField
//        let totalExperienceTextField = UITextField()
//        totalExperienceTextField.translatesAutoresizingMaskIntoConstraints = false
//        totalExperienceTextField.borderStyle = .roundedRect
//        totalExperienceTextField.placeholder = "Enter Total Experience"
//        totalExperienceTextField.keyboardType = .decimalPad // Numeric keypad
//        totalExperienceTextField.delegate = self // Set delegate for this text field
//        view.addSubview(totalExperienceTextField)
        
        // Constraints
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            fullNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            fullNameTextField.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            fullNameTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            fullNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            mobileNumberLabel.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 16),
            mobileNumberLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            
            mobileNumberTextField.topAnchor.constraint(equalTo: mobileNumberLabel.bottomAnchor, constant: 8),
            mobileNumberTextField.leadingAnchor.constraint(equalTo: mobileNumberLabel.leadingAnchor),
            mobileNumberTextField.trailingAnchor.constraint(equalTo: fullNameTextField.trailingAnchor),
            
//            totalExperienceLabel.topAnchor.constraint(equalTo: mobileNumberTextField.bottomAnchor, constant: 16),
//            totalExperienceLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
//            
//            totalExperienceTextField.topAnchor.constraint(equalTo: totalExperienceLabel.bottomAnchor, constant: 8),
//            totalExperienceTextField.leadingAnchor.constraint(equalTo: totalExperienceLabel.leadingAnchor),
//            totalExperienceTextField.trailingAnchor.constraint(equalTo: fullNameTextField.trailingAnchor)
        ])
    }
    
    func setupResumeUploadView() {
        let uploadResumeLabel = UILabel()
        uploadResumeLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText2 = NSMutableAttributedString(string: "Upload Resume")
        let asterisk2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText2.append(asterisk2)
        uploadResumeLabel.attributedText = attributedText2
        view.addSubview(uploadResumeLabel)
        
        // Upload Button Container
        resumeContainer = UIView()
        resumeContainer.translatesAutoresizingMaskIntoConstraints = false
        resumeContainer.layer.cornerRadius = 8 // Rounded corners
        resumeContainer.layer.borderWidth = 1
        resumeContainer.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        view.addSubview(resumeContainer)
        
        uploadLogoView = UIView()
        uploadLogoView.layer.borderWidth = 1
        uploadLogoView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        uploadLogoView.layer.cornerRadius = 8
        uploadLogoView.translatesAutoresizingMaskIntoConstraints = false
        resumeContainer.addSubview(uploadLogoView)
        
        
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(systemName: "icloud.and.arrow.up") // System upload icon
        logoImageView.tintColor = UIColor(hex: "#344054")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        uploadLogoView.addSubview(logoImageView)
        
        clickToUploadLabel = UILabel()
        clickToUploadLabel.isUserInteractionEnabled = true
        clickToUploadLabel.text = "Click to Upload"
        clickToUploadLabel.textColor = UIColor(hex: "#0079C4")
        clickToUploadLabel.font = .boldSystemFont(ofSize: 18)
        clickToUploadLabel.translatesAutoresizingMaskIntoConstraints = false
        resumeContainer.addSubview(clickToUploadLabel)
        
        let dragLabel = UILabel()
        dragLabel.text = "or drag and drop"
        dragLabel.font = .boldSystemFont(ofSize: 18)
        dragLabel.translatesAutoresizingMaskIntoConstraints = false
        resumeContainer.addSubview(dragLabel)
        
        let formatLabel = UILabel()
        formatLabel.text = "DOC, DOCx, PDF, RTF(Max: 2 MB)"
        formatLabel.font = .systemFont(ofSize: 16)
        formatLabel.textColor = UIColor(hex: "#475467")
        formatLabel.translatesAutoresizingMaskIntoConstraints = false
        resumeContainer.addSubview(formatLabel)
        
        uploadedFileView = UIView()
        
        uploadedFileView.isHidden = true // Initially hidden
        uploadedFileView.backgroundColor = UIColor(hex: "#EAECF0")
        uploadedFileView.layer.cornerRadius = 8
        uploadedFileView.translatesAutoresizingMaskIntoConstraints = false
        resumeContainer.addSubview(uploadedFileView)
        
        let fileNameLabel = UILabel()
        fileNameLabel.text = "file"
        fileNameLabel.font = .boldSystemFont(ofSize: 18)
        fileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        uploadedFileView.addSubview(fileNameLabel)
        
        
        NSLayoutConstraint.activate([
            uploadResumeLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            uploadResumeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            resumeContainer.topAnchor.constraint(equalTo: uploadResumeLabel.bottomAnchor, constant: 8),
            resumeContainer.leadingAnchor.constraint(equalTo: uploadResumeLabel.leadingAnchor),
            resumeContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resumeContainer.heightAnchor.constraint(equalToConstant: 220), // Adjust height as needed
            
            uploadLogoView.centerXAnchor.constraint(equalTo: resumeContainer.centerXAnchor),
            uploadLogoView.topAnchor.constraint(equalTo: resumeContainer.topAnchor, constant: 20),
            uploadLogoView.heightAnchor.constraint(equalToConstant: 50),
            uploadLogoView.widthAnchor.constraint(equalToConstant: 50),
            
            logoImageView.centerXAnchor.constraint(equalTo: uploadLogoView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: uploadLogoView.centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 30),
            logoImageView.widthAnchor.constraint(equalToConstant: 30),
            
            clickToUploadLabel.topAnchor.constraint(equalTo: uploadLogoView.bottomAnchor, constant: 20),
            clickToUploadLabel.leadingAnchor.constraint(equalTo: resumeContainer.leadingAnchor, constant: 50),
            
            dragLabel.topAnchor.constraint(equalTo: uploadLogoView.bottomAnchor, constant: 20),
            dragLabel.leadingAnchor.constraint(equalTo: clickToUploadLabel.trailingAnchor, constant: 6),
            
            formatLabel.topAnchor.constraint(equalTo: clickToUploadLabel.bottomAnchor, constant: 10),
            formatLabel.centerXAnchor.constraint(equalTo: resumeContainer.centerXAnchor),
            
            uploadedFileView.topAnchor.constraint(equalTo: formatLabel.bottomAnchor, constant: 20),
            uploadedFileView.leadingAnchor.constraint(equalTo: resumeContainer.leadingAnchor, constant: 16),
            uploadedFileView.trailingAnchor.constraint(equalTo: resumeContainer.trailingAnchor, constant: -16),
            uploadedFileView.heightAnchor.constraint(equalToConstant: 40),
            
            fileNameLabel.centerXAnchor.constraint(equalTo: uploadedFileView.centerXAnchor),
            fileNameLabel.centerYAnchor.constraint(equalTo: uploadedFileView.centerYAnchor)
        ])
        
        
    }
    
    func setupNextButton() {
        let nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 20)
        nextButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        nextButton.backgroundColor = UIColor(hex: "#0079C4")
        nextButton.layer.cornerRadius = 8
        
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: resumeContainer.bottomAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    @objc func didTapNextButton() {
        if isResumeUploaded == false {
            // Handle validation failure
                let alertController = UIAlertController(title: "Alert!", message: "Please upload Resume", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let vc = QualificationsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupBackButton() {
        let backButton = UIButton()
        let attributedString = NSMutableAttributedString()
        
        // Add back arrow symbol
        let backArrowImage = UIImage(systemName: "arrow.left")!
        let tintedImage = backArrowImage.withTintColor(UIColor(hex: "#475467"), renderingMode: .alwaysOriginal)
        let backArrowAttachment = NSTextAttachment()
        backArrowAttachment.image = tintedImage
        let backArrowString = NSAttributedString(attachment: backArrowAttachment)
        attributedString.append(backArrowString)
        
        // Add space
        attributedString.append(NSAttributedString(string: " "))
        
        // Add "back to login" text
        let backToLoginString = NSAttributedString(string: "Back to Login")
        attributedString.append(backToLoginString)
        
        // Set attributed title for button
        backButton.setAttributedTitle(attributedString, for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 20)
        backButton.titleLabel?.textColor = UIColor(hex: "#475467")
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: resumeContainer.bottomAnchor, constant: 200),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func didTapBackButton() {
        let vc = LoginVC()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.isHidden = true
        present(navVC, animated: true)
    }
    
    
    @objc func uploadButtonTapped() {
        presentDocumentPicker()
    }
    
    func presentDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
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

extension BasicDetails1: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // Handle the selected document here
        guard let selectedFileURL = urls.first else { return }
        print("Selected file URL: \(selectedFileURL)")
        
        // Extract file name from the URL
        let fileName = selectedFileURL.lastPathComponent
        
        // Update the label in the uploadedFileView
        for subview in uploadedFileView.subviews {
            if let fileNameLabel = subview as? UILabel {
                fileNameLabel.text = fileName
                break
            }
        }
        
        // Make the uploadedFileView visible
        uploadedFileView.isHidden = false
        
        uploadFileToServer(fileURL: selectedFileURL)
    }
    
    func uploadFileToServer(fileURL: URL) {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
        
        let serverURL = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/onBoarding")!
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"

        // Retrieve access token from UserDefaults
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access token not found in UserDefaults")
            return
        }

        // Correctly add the access token in the Authorization header
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        // Create multipart form data
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()

        // Add file data
        do {
            let fileData = try Data(contentsOf: fileURL)
            let fileName = fileURL.lastPathComponent
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"resume\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
            body.append(fileData)
            body.append("\r\n".data(using: .utf8)!)
        } catch {
            print("Error reading file data: \(error)")
            return
        }

        // Add end boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        // Create URLSessionUploadTask using the corrected method
        URLSession.shared.uploadTask(with: request, from: body) { (data, response, error) in
            DispatchQueue.main.async {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  !(400...599).contains(httpResponse.statusCode) else {
                print("Server Error")
                return
            }
            print(httpResponse)

            if let data = data {
                print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            }

            print("File uploaded successfully")
            self.isResumeUploaded = true
        }.resume()
    }

}
