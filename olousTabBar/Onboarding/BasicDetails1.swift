//
//  BasicDetails1.swift
//  olousTabBar
//
//  Created by Salt Technologies on 27/03/24.
//

import UIKit
import MobileCoreServices

class BasicDetails1: UIViewController, UITextFieldDelegate {
    
    var headerView : UIView!
    var circleContainerView : UIView!
    
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
        setupHeaderView()
        setupTextFields()
        setupResumeUploadView()
        setupNextButton()
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
        profileCircleLabel.text = "1/7"
        
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
        let percentage: CGFloat = 1 / 7
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
        titleLabel.text = "Basic Details"
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
    
    func setupTextFields() {
        let fullNameLabel = UILabel()
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Full Name")
        let asterisk = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText.append(asterisk)
        fullNameLabel.attributedText = attributedText
        view.addSubview(fullNameLabel)
        
        // Full Name TextField
        let fullNameTextField = UITextField()
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
        let mobileNumberTextField = UITextField()
        mobileNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        mobileNumberTextField.borderStyle = .roundedRect
        mobileNumberTextField.placeholder = "Enter Mobile Number"
        mobileNumberTextField.keyboardType = .decimalPad // Numeric keypad
        mobileNumberTextField.delegate = self // Set delegate for this text field
        view.addSubview(mobileNumberTextField)
        
        // Total Experience Label
        let totalExperienceLabel = UILabel()
        totalExperienceLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText3 = NSMutableAttributedString(string: "Total experience (years)")
        let asterisk3 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText3.append(asterisk3)
        totalExperienceLabel.attributedText = attributedText3
        view.addSubview(totalExperienceLabel)
        
        // Total Experience TextField
        let totalExperienceTextField = UITextField()
        totalExperienceTextField.translatesAutoresizingMaskIntoConstraints = false
        totalExperienceTextField.borderStyle = .roundedRect
        totalExperienceTextField.placeholder = "Enter Total Experience"
        totalExperienceTextField.keyboardType = .decimalPad // Numeric keypad
        totalExperienceTextField.delegate = self // Set delegate for this text field
        view.addSubview(totalExperienceTextField)
        
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
            
            totalExperienceLabel.topAnchor.constraint(equalTo: mobileNumberTextField.bottomAnchor, constant: 16),
            totalExperienceLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            
            totalExperienceTextField.topAnchor.constraint(equalTo: totalExperienceLabel.bottomAnchor, constant: 8),
            totalExperienceTextField.leadingAnchor.constraint(equalTo: totalExperienceLabel.leadingAnchor),
            totalExperienceTextField.trailingAnchor.constraint(equalTo: fullNameTextField.trailingAnchor)
        ])
    }
    
    func setupResumeUploadView() {
        let uploadResumeLabel = UILabel()
        uploadResumeLabel.translatesAutoresizingMaskIntoConstraints = false
        uploadResumeLabel.text = "Upload Resume"
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
            uploadResumeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
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
        let vc = BasicDetails2()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func uploadButtonTapped() {
        // Open file picker to select a file to upload
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
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
    }
}
