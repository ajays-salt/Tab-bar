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
        setupHeaderView()
        setupScrollView()
        
        setupResumeUploadView()
        setupUI()
        setupUI2()
        setupUI3()
        
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

    func setupResumeUploadView() {
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
    
    // UI from gender options
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
//        uploadUserProfile()
        let vc = PreferencesVC()
        navigationController?.pushViewController(vc, animated: true)
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


extension PersonalInfoVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    // UIPickerViewDelegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stateTF.text = states[row]
    }
}
