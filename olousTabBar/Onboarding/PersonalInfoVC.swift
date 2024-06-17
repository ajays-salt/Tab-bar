//
//  PersonalInfoVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 14/05/24.
//

import UIKit

class PersonalInfoVC: UIViewController {
    
    var headerView : UIView!
    var headerHeightConstraint: NSLayoutConstraint?
    var circleContainerView : UIView!
    var profileImageView : UIImageView!
    
    var scrollView : UIScrollView!
    
    var profilePicContainer : UIView!
    var uploadLogoView : UIView!
    var clickToUploadLabel : UILabel!
    
    var fullNameTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter Full Name"
        return tf
    }()
    var dobTF : UITextField = {
        let dobTextField = UITextField()
        dobTextField.translatesAutoresizingMaskIntoConstraints = false
        dobTextField.borderStyle = .roundedRect
        dobTextField.placeholder = "Eg. 03/07/2002"
        
        let calendarButton = UIButton(type: .custom)
        calendarButton.setImage(UIImage(systemName: "calendar"), for: .normal)
        calendarButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        calendarButton.addTarget(self, action: #selector(openDatePicker), for: .touchUpInside)
        
        dobTextField.rightView = calendarButton
        dobTextField.rightViewMode = .always
        
        return dobTextField
    }()
    var nationalityTF : UITextField = {
       let nationalityTextField = UITextField()
        nationalityTextField.translatesAutoresizingMaskIntoConstraints = false
        nationalityTextField.borderStyle = .roundedRect
        nationalityTextField.placeholder = "Eg. Indian"
        return nationalityTextField
    }()
    var genderStackView = UIStackView()
    var selectedGenderButton : UIButton?
    
    var permanentAddressTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter Permanent Address"
        return tf
    }()
    var currentAddressTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter Current Address"
        return tf
    }()
    let states = ["Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal"]
    let stateTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Select State"
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(openStatePicker), for: .touchUpInside)
        
        textField.rightView = button
        textField.rightViewMode = .always
        
        return textField
    }()
    let statePickerView = UIPickerView()
    var cityTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter City"
        return tf
    }()
    let pincodeTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Pincode"
        textField.keyboardType = .numberPad
        
        // Add done button as input accessory view
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: textField, action: #selector(resignFirstResponder))
        toolbar.setItems([flexSpace, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        
        return textField
    }()
    
    
    var uidTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter UID"
        return tf
    }()
    var passportTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter Passport"
        return tf
    }()
    var panTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter PAN"
        return tf
    }()
    
    
    var addLanguageContainer = UIView()
    
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
    let fluencyLevels = ["Beginner", "Intermediate", "Advanced", "Native"]
    let fluencyPicker = UIPickerView()
    
    lazy var addLanguageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+ Add Language", for: .normal)
        button.addTarget(self, action: #selector(addLanguageEntry), for: .touchUpInside)
        return button
    }()
    var languageCV : UICollectionView!
    var languageCVHeightConstraint: NSLayoutConstraint!
    
    
    var bottomView : UIView!
    var bottomHeightConstraint: NSLayoutConstraint?

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
        setupScrollView()
        
        setupProfileUploadView()
        setupUI()
        setupUI2()
        setupUI3()
        
        setupUI4()
        
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
        profileCircleLabel.text = "7/9"
        
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
        let percentage: CGFloat = 7 / 9
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
        titleLabel.text = "Personal Information"
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
        let steps = [("Personal Information", "Personal Details"),
                     ("Preferences", "Preferences and Headline")]
        
        let firstStepView = createStepView(steps[0].0, subtitle: steps[0].1, isActive: true)
        let secondStepView = createStepView(steps[1].0, subtitle: steps[1].1, isActive: false)
        firstStepView.translatesAutoresizingMaskIntoConstraints = false
        secondStepView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(firstStepView)
        headerView.addSubview(secondStepView)
        
        // Create and configure the current step label
        let currentStepLabel = UILabel()
        currentStepLabel.text = "STEP 7 OF 10"
        currentStepLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        currentStepLabel.textColor = .gray
        headerView.addSubview(currentStepLabel)
        currentStepLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the main step title
        let mainStepTitleLabel = UILabel()
        mainStepTitleLabel.text = "PERSONAL INFO"
        mainStepTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        headerView.addSubview(mainStepTitleLabel)
        mainStepTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress view
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(hex: "#2563EB")
        progressView.trackTintColor = UIColor(hex: "#E5E7EB")
        progressView.setProgress(0.7, animated: true)
        headerView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the progress label
        let progressLabel = UILabel()
        progressLabel.text = "70%"
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
        
        let extraSpaceHeight: CGFloat = 300
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }

    func setupProfileUploadView() {
        let uploadProfilePicLabel = UILabel()
        uploadProfilePicLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText2 = NSMutableAttributedString(string: "Upload Profile Picture")
        let asterisk2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText2.append(asterisk2)
        uploadProfilePicLabel.attributedText = attributedText2
        scrollView.addSubview(uploadProfilePicLabel)
        
        // Upload Button Container
        profilePicContainer = UIView()
        profilePicContainer.translatesAutoresizingMaskIntoConstraints = false
        profilePicContainer.layer.cornerRadius = 8 // Rounded corners
        profilePicContainer.layer.borderWidth = 1
        profilePicContainer.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        scrollView.addSubview(profilePicContainer)
        
        uploadLogoView = UIView()
        uploadLogoView.layer.borderWidth = 1
        uploadLogoView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        uploadLogoView.layer.cornerRadius = 55
        uploadLogoView.translatesAutoresizingMaskIntoConstraints = false
        profilePicContainer.addSubview(uploadLogoView)
        
        
        profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person") // System upload icon
        profileImageView.tintColor = UIColor(hex: "#344054")
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        uploadLogoView.addSubview(profileImageView)
        
        clickToUploadLabel = UILabel()
        clickToUploadLabel.isUserInteractionEnabled = true
        clickToUploadLabel.text = "Click to Upload"
        clickToUploadLabel.textColor = UIColor(hex: "#0079C4")
        clickToUploadLabel.font = .boldSystemFont(ofSize: 18)
        clickToUploadLabel.translatesAutoresizingMaskIntoConstraints = false
        profilePicContainer.addSubview(clickToUploadLabel)
        
        let dragLabel = UILabel()
        dragLabel.text = "or drag and drop"
        dragLabel.font = .boldSystemFont(ofSize: 18)
        dragLabel.translatesAutoresizingMaskIntoConstraints = false
        profilePicContainer.addSubview(dragLabel)
        
        let formatLabel = UILabel()
        formatLabel.text = ".JPG , .PNG , .JPEG"
        formatLabel.font = .systemFont(ofSize: 16)
        formatLabel.textColor = UIColor(hex: "#475467")
        formatLabel.translatesAutoresizingMaskIntoConstraints = false
        profilePicContainer.addSubview(formatLabel)
        
        NSLayoutConstraint.activate([
            uploadProfilePicLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            uploadProfilePicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            profilePicContainer.topAnchor.constraint(equalTo: uploadProfilePicLabel.bottomAnchor, constant: 8),
            profilePicContainer.leadingAnchor.constraint(equalTo: uploadProfilePicLabel.leadingAnchor),
            profilePicContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            profilePicContainer.heightAnchor.constraint(equalToConstant: 220), // Adjust height as needed
            
            uploadLogoView.centerXAnchor.constraint(equalTo: profilePicContainer.centerXAnchor),
            uploadLogoView.topAnchor.constraint(equalTo: profilePicContainer.topAnchor, constant: 20),
            uploadLogoView.heightAnchor.constraint(equalToConstant: 110),
            uploadLogoView.widthAnchor.constraint(equalToConstant: 110),
            
            profileImageView.centerXAnchor.constraint(equalTo: uploadLogoView.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: uploadLogoView.centerYAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            
            clickToUploadLabel.topAnchor.constraint(equalTo: uploadLogoView.bottomAnchor, constant: 20),
            clickToUploadLabel.leadingAnchor.constraint(equalTo: profilePicContainer.leadingAnchor, constant: 50),
            
            dragLabel.topAnchor.constraint(equalTo: uploadLogoView.bottomAnchor, constant: 20),
            dragLabel.leadingAnchor.constraint(equalTo: clickToUploadLabel.trailingAnchor, constant: 6),
            
            formatLabel.topAnchor.constraint(equalTo: clickToUploadLabel.bottomAnchor, constant: 10),
            formatLabel.centerXAnchor.constraint(equalTo: profilePicContainer.centerXAnchor),
            
        ])
        
        
    }
    
    @objc func uploadButtonTapped() {
        presentImagePicker()
    }
    
    func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.clipsToBounds = true
            profileImageView.layer.cornerRadius = 50
        }
        picker.dismiss(animated: true, completion: nil)
    }
    

    // first three textfields
    func setupUI() {
        let fullNameLabel = UILabel()
        fullNameLabel.attributedText = createAttributedText(for: "Full Name")
        fullNameLabel.font = .boldSystemFont(ofSize: 16)
        fullNameLabel.textColor = UIColor(hex: "#344054")
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(fullNameLabel)
        
        fullNameTF.delegate = self
        scrollView.addSubview(fullNameTF)
        
        
        let dobLabel = UILabel()
        dobLabel.attributedText = createAttributedText(for: "Date of Birth")
        dobLabel.font = .boldSystemFont(ofSize: 16)
        dobLabel.textColor = UIColor(hex: "#344054")
        dobLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(dobLabel)
        
        dobTF.delegate = self
        scrollView.addSubview(dobTF)
        
        
        let nationalityLabel = UILabel()
        nationalityLabel.attributedText = createAttributedText(for: "Nationality")
        nationalityLabel.font = .boldSystemFont(ofSize: 16)
        nationalityLabel.textColor = UIColor(hex: "#344054")
        nationalityLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(nationalityLabel)
        
        
        nationalityTF.delegate = self
        scrollView.addSubview(nationalityTF)
        
        // Constraints
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: profilePicContainer.bottomAnchor, constant: 20),
            fullNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            fullNameTF.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            fullNameTF.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            fullNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dobLabel.topAnchor.constraint(equalTo: fullNameTF.bottomAnchor, constant: 16),
            dobLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            
            dobTF.topAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 8),
            dobTF.leadingAnchor.constraint(equalTo: dobLabel.leadingAnchor),
            dobTF.trailingAnchor.constraint(equalTo: fullNameTF.trailingAnchor),
            
            nationalityLabel.topAnchor.constraint(equalTo: dobTF.bottomAnchor, constant: 16),
            nationalityLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),

            nationalityTF.topAnchor.constraint(equalTo: nationalityLabel.bottomAnchor, constant: 8),
            nationalityTF.leadingAnchor.constraint(equalTo: nationalityLabel.leadingAnchor),
            nationalityTF.trailingAnchor.constraint(equalTo: fullNameTF.trailingAnchor)
        ])
        
        let genderLabel : UILabel = {
            let label = UILabel()
            label.attributedText = createAttributedText(for: "Gender")
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        genderStackView.axis = .horizontal
        genderStackView.spacing = 12
        genderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let genderOptions = ["Male", "Female", "Other"]
        var i = 1
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
        
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: nationalityTF.bottomAnchor, constant: 20),
            genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            genderStackView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
            genderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    func createAttributedText(for string: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: string)
        let asterisk = NSAttributedString(string: " *", attributes: [NSAttributedString.Key.baselineOffset: -1])
        attributedText.append(asterisk)
        return attributedText
    }
    
    @objc func openDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
//        datePicker.preferredDatePickerStyle = .wheels
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .inline
        }

        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        dobTF.inputAccessoryView = toolbar
        dobTF.inputView = datePicker

        dobTF.becomeFirstResponder()
    }
    @objc func donePressed() {
        if let datePicker = dobTF.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dobTF.text = dateFormatter.string(from: datePicker.date)
        }
        dobTF.resignFirstResponder()
    }
    @objc func cancelPressed() {
        dobTF.resignFirstResponder()
    }
    
    @objc func genderOptionSelected(_ sender: UIButton) {
        selectedGenderButton?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedGenderButton?.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        selectedGenderButton = sender
    }
    
    
    // from permanent address
    func setupUI2() {
        let permanentAddressLabel : UILabel = {
            let label = UILabel()
            label.attributedText = createAttributedText(for: "Permanent Address")
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(permanentAddressLabel)
        permanentAddressTF.delegate = self
        scrollView.addSubview(permanentAddressTF)
        
        let currentAddressLabel : UILabel = {
            let label = UILabel()
            label.attributedText = createAttributedText(for: "Current Address")
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(currentAddressLabel)
        currentAddressTF.delegate = self
        scrollView.addSubview(currentAddressTF)
        
        
        let stateLabel : UILabel = {
            let label = UILabel()
            label.attributedText = createAttributedText(for: "State")
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(stateLabel)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([flexSpace, doneButton], animated: false)
        
        stateTF.inputAccessoryView = toolbar
        stateTF.inputView = statePickerView
        stateTF.delegate = self
        statePickerView.delegate = self
        statePickerView.dataSource = self
        statePickerView.tag = 2
        
        scrollView.addSubview(stateTF)
        
        let cityLabel : UILabel = {
            let label = UILabel()
            label.attributedText = createAttributedText(for: "City")
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(cityLabel)
        cityTF.delegate = self
        scrollView.addSubview(cityTF)
        
        
        let pincodeLabel : UILabel = {
            let label = UILabel()
            label.attributedText = createAttributedText(for: "PinCode")
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(pincodeLabel)
        pincodeTF.delegate = self
        scrollView.addSubview(pincodeTF)
        
        
        NSLayoutConstraint.activate([
            permanentAddressLabel.topAnchor.constraint(equalTo: genderStackView.bottomAnchor, constant: 20),
            permanentAddressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            permanentAddressTF.topAnchor.constraint(equalTo: permanentAddressLabel.bottomAnchor, constant: 8),
            permanentAddressTF.leadingAnchor.constraint(equalTo: permanentAddressLabel.leadingAnchor),
            permanentAddressTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            currentAddressLabel.topAnchor.constraint(equalTo: permanentAddressTF.bottomAnchor, constant: 20),
            currentAddressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            currentAddressTF.topAnchor.constraint(equalTo: currentAddressLabel.bottomAnchor, constant: 8),
            currentAddressTF.leadingAnchor.constraint(equalTo: currentAddressLabel.leadingAnchor),
            currentAddressTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            stateLabel.topAnchor.constraint(equalTo: currentAddressTF.bottomAnchor, constant: 20),
            stateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            stateTF.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 8),
            stateTF.leadingAnchor.constraint(equalTo: stateLabel.leadingAnchor),
            stateTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            cityLabel.topAnchor.constraint(equalTo: stateTF.bottomAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            cityTF.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            cityTF.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            cityTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            pincodeLabel.topAnchor.constraint(equalTo: cityTF.bottomAnchor, constant: 20),
            pincodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            pincodeTF.topAnchor.constraint(equalTo: pincodeLabel.bottomAnchor, constant: 8),
            pincodeTF.leadingAnchor.constraint(equalTo: pincodeLabel.leadingAnchor),
            pincodeTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    @objc func openStatePicker() {
        stateTF.becomeFirstResponder()
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    // from UID number
    func setupUI3() {
        let uidLabel : UILabel = {
            let label = UILabel()
            label.text = "UID Number"
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(uidLabel)
        uidTF.delegate = self
        scrollView.addSubview(uidTF)
        
        let passportLabel : UILabel = {
            let label = UILabel()
            label.text = "Passport Number"
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(passportLabel)
        passportTF.delegate = self
        scrollView.addSubview(passportTF)
        
        let panLabel : UILabel = {
            let label = UILabel()
            label.text = "PAN Number"
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(panLabel)
        panTF.delegate = self
        scrollView.addSubview(panTF)
        
        NSLayoutConstraint.activate([
            uidLabel.topAnchor.constraint(equalTo: pincodeTF.bottomAnchor, constant: 20),
            uidLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            uidTF.topAnchor.constraint(equalTo: uidLabel.bottomAnchor, constant: 8),
            uidTF.leadingAnchor.constraint(equalTo: uidLabel.leadingAnchor),
            uidTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            passportLabel.topAnchor.constraint(equalTo: uidTF.bottomAnchor, constant: 20),
            passportLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            passportTF.topAnchor.constraint(equalTo: passportLabel.bottomAnchor, constant: 8),
            passportTF.leadingAnchor.constraint(equalTo: passportLabel.leadingAnchor),
            passportTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            panLabel.topAnchor.constraint(equalTo: passportTF.bottomAnchor, constant: 20),
            panLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            panTF.topAnchor.constraint(equalTo: panLabel.bottomAnchor, constant: 8),
            panTF.leadingAnchor.constraint(equalTo: panLabel.leadingAnchor),
            panTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    // for languages
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
            langLabel.topAnchor.constraint(equalTo: panTF.bottomAnchor, constant: 20),
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
        
        fluencyTextField.inputView = fluencyPicker
        fluencyPicker.delegate = self
        fluencyPicker.dataSource = self
        fluencyPicker.tag = 1
        
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
        
        var height  = scrollView.contentSize.height
        scrollView.contentSize = CGSize(width: view.bounds.width, height: height + 65)
        
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
        let newEntry = Language(language: language, fluencyLevel: fluencyTextField.text!, read: true, write: true, speak: true)
        languageArray.append(newEntry)
        
//        languageTextField.text = ""
//        fluencyTextField.text = ""
        
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
        submitPersonalInfo()
    }
    
    
    
    
    func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
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


extension PersonalInfoVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return languageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "language", for: indexPath) as! LanguageCell
        cell.deleteButton.addTarget(self, action: #selector(deleteLanguageEntry), for: .touchUpInside)
        cell.languageLabel.text = languageArray[indexPath.row].language
        cell.fluencyLabel.text = languageArray[indexPath.row].fluencyLevel
        cell.deleteButton.addTarget(self, action: #selector(deleteLanguageEntry), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 50)
    }
    
    
    // picker methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return fluencyLevels.count
        } else if pickerView.tag == 2 {
            return states.count
        }
        return 0
    }
    
    // UIPickerViewDelegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return fluencyLevels[row]
        } else if pickerView.tag == 2 {
            return states[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            fluencyTextField.text = fluencyLevels[row]
            self.view.endEditing(true)
        } else if pickerView.tag == 2 {
            stateTF.text = states[row]
            self.view.endEditing(true)
        }
    }
}


extension PersonalInfoVC {
    func submitPersonalInfo() {
        // Validate the input fields
        guard let image = profileImageView.image,
              let imageData = image.jpegData(compressionQuality: 0.5)
        else {
            showAlert(withTitle: "Missing Information", message: "Please select a valid image before saving.")
            return
        }
        guard let fullName = fullNameTF.text, !fullName.isEmpty,
              let dob = dobTF.text, !dob.isEmpty,
              let nationality = nationalityTF.text, !nationality.isEmpty,
              let gender = selectedGenderButton?.titleLabel?.text, !gender.isEmpty,
              let permanentAddress = permanentAddressTF.text, !permanentAddress.isEmpty,
              let currentAddress = currentAddressTF.text, !currentAddress.isEmpty,
              let city = cityTF.text, !city.isEmpty,
              let state = stateTF.text, !state.isEmpty,
              let pincode = pincodeTF.text, !pincode.isEmpty,
              let uid = uidTF.text,
              let passport = passportTF.text,
              let pan = panTF.text
        else {
            showAlert(withTitle: "Alert!", message: "Please fill all the details")
            return
        }
        
        
        let personalInfo = UserPersonalInfo(
            name: fullName,
            panNo: pan,
            dateOfBirth: dob,
            nationality: nationality,
            passportNo: passport,
            uidNumber: uid,
            permanentAddress: permanentAddress,
            gender: gender,
            profilePicData: imageData
        )
        
        uploadPersonalInfo(userInfo: personalInfo)
        updateUserInfo()
    }
    
    func uploadPersonalInfo(userInfo: UserPersonalInfo) {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-profile-pic") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
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
        
        // Helper function to append form data
        func appendFormField(_ name: String, value: String, to data: inout Data) {
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
            data.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Append fields
        appendFormField("name", value: userInfo.name, to: &body)
        appendFormField("Pan no", value: userInfo.panNo, to: &body)
        appendFormField("dateOfBirth", value: userInfo.dateOfBirth, to: &body)
        appendFormField("nationality", value: userInfo.nationality, to: &body)
        appendFormField("passportNo", value: userInfo.passportNo, to: &body)
        appendFormField("uidNumber", value: userInfo.uidNumber, to: &body)
        appendFormField("permanentAddress", value: userInfo.permanentAddress, to: &body)
        appendFormField("gender", value: userInfo.gender, to: &body)
        
        // Append profile picture data if available
        if let profilePicData = userInfo.profilePicData {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"profilePic\"; filename=\"profilePic.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
            body.append(profilePicData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        let task = URLSession.shared.uploadTask(with: request, from: body) { (data, response, error) in
            
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
        }
        task.resume()
    }
    
    func updateUserInfo() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        guard let currentAddress = currentAddressTF.text, !currentAddress.isEmpty,
              let state = stateTF.text, !state.isEmpty,
              let city = cityTF.text, !city.isEmpty,
              let pincode = pincodeTF.text, !pincode.isEmpty else {
            
            showAlert(withTitle: "Alert!", message: "Please fill all the address details")
            return
        }

        let address = Address(address: currentAddress, state: state, city: city, pincode: pincode)
        
        let userInfoUpdate = UserLangugaeAndCurrAddress(language: languageArray, currentAddress: address)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access token not found in UserDefaults")
            return
        }
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let jsonData = try JSONEncoder().encode(userInfoUpdate)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode user info: \(error)")
            return
        }
        
        let loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        loader.startAnimating()
        view.addSubview(loader)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  !(400...599).contains(httpResponse.statusCode) else {
                print("Server Error")
                return
            }
            
            if let data = data {
                print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            }
            
            print("User info updated successfully")
            DispatchQueue.main.async {
                loader.stopAnimating()
                loader.removeFromSuperview()
                let vc = PreferencesVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        task.resume()
    }

}

struct UserLangugaeAndCurrAddress : Codable {
    let language: [Language]
    let currentAddress: Address
}
