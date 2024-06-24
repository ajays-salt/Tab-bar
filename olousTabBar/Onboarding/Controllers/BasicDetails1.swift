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
    
    
    var isResumeUploaded = false
    
    var resumeContainer : UIView!
    var uploadLogoView : UIView!
    var clickToUploadLabel : UILabel!
    var uploadedFileView : UIView!
    
    var selectedFileURL : URL!
    
    let deleteButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(systemName: "trash")?.buttonImageResized(to: CGSize(width: 20, height: 20)) { // Adjust the size as needed
            button.setImage(image, for: .normal)
        }
        button.tintColor = UIColor(hex: "#98A2B3")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uploadButtonTapped))
        clickToUploadLabel.addGestureRecognizer(tapGesture)
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(uploadButtonTapped))
        uploadLogoView.addGestureRecognizer(tapGesture2)
    }
    
    func setupViews() {
        setupHeaderView()
        setupResumeUploadView()
        setupUploadedFileView()
        setupNextButton()
        setupBackButton()
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
        currentStepLabel.text = "STEP 1 OF 10"
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
        
        
        
        
        NSLayoutConstraint.activate([
            uploadResumeLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            uploadResumeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            resumeContainer.topAnchor.constraint(equalTo: uploadResumeLabel.bottomAnchor, constant: 8),
            resumeContainer.leadingAnchor.constraint(equalTo: uploadResumeLabel.leadingAnchor),
            resumeContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resumeContainer.heightAnchor.constraint(equalToConstant: 150), // Adjust height as needed
            
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
            formatLabel.centerXAnchor.constraint(equalTo: resumeContainer.centerXAnchor)
        ])
    }
    
    
    func setupUploadedFileView() {
        uploadedFileView = UIView()
        
        uploadedFileView.isHidden = true // Initially hidden
        uploadedFileView.layer.cornerRadius = 8
        uploadedFileView.layer.borderWidth = 1
        uploadedFileView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        uploadedFileView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uploadedFileView)
        
        let fileNameLabel = UILabel()
        fileNameLabel.text = "file"
        fileNameLabel.font = .boldSystemFont(ofSize: 16)
        fileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        uploadedFileView.addSubview(fileNameLabel)
        
        uploadedFileView.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(didTapDeleteResume), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            uploadedFileView.topAnchor.constraint(equalTo: resumeContainer.bottomAnchor, constant: 20),
            uploadedFileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            uploadedFileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            uploadedFileView.heightAnchor.constraint(equalToConstant: 40),
            
            fileNameLabel.leadingAnchor.constraint(equalTo: uploadedFileView.leadingAnchor, constant: 20),
//            fileNameLabel.centerXAnchor.constraint(equalTo: uploadedFileView.centerXAnchor),
            fileNameLabel.centerYAnchor.constraint(equalTo: uploadedFileView.centerYAnchor),
            fileNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 100),
            
            deleteButton.centerYAnchor.constraint(equalTo: uploadedFileView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: uploadedFileView.trailingAnchor, constant: -10),
            deleteButton.widthAnchor.constraint(equalToConstant: 20),
            deleteButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func didTapDeleteResume() {
        isResumeUploaded = false
        selectedFileURL = nil
        uploadedFileView.isHidden = true
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
            nextButton.topAnchor.constraint(equalTo: uploadedFileView.bottomAnchor, constant: 20),
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
        
        uploadFileToServer(fileURL: selectedFileURL)
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
        backButton.titleLabel?.font = .systemFont(ofSize: 18)
        backButton.titleLabel?.textColor = UIColor(hex: "#475467")
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: uploadedFileView.bottomAnchor, constant: 80),
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
        guard let selectedURL = urls.first else { return }
        print("Selected file URL: \(selectedURL)")
        
        selectedFileURL = selectedURL
        
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
        isResumeUploaded = true
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
                
                let vc = QualificationsVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }.resume()
    }
    
}
