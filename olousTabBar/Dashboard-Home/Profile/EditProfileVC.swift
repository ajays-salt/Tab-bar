//
//  EditProfileVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 15/03/24.
//

import UIKit

class EditProfileVC: UIViewController {
    
    var scrollView : UIScrollView!
    
    let profileCircle = UIView()
    let profileCircleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#0079C4")
        label.font = .boldSystemFont(ofSize: 48)
        return label
    }()
    var profileImageView : UIImageView!
    
    let editImageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.tintColor = UIColor(hex: "#667085")
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    
    var fullNameTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter Full Name"
        return tf
    }()
    var designationTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter Designation"
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground

        navigationItem.title = "Edit Profile"
        navigationItem.hidesBackButton = true
        
        let backButtonImage = UIImage(systemName: "xmark") // Change "xmark" to any system image you prefer
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
    
        setupViews()
        
        fetchUserProfile()
    }
    
    
    
    
    
    @objc func backButtonPressed() {
        let alertController = UIAlertController(title: "Warning", message: "Do you want to proceed without editing Profile?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let proceedAction = UIAlertAction(title: "Proceed", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true) // Pop to previous view controller
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(proceedAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func setupViews() {
        setupScrollView()
        setupProfileCircleView()
        setupEditImageButton()
        
        setupUI()
        setupUI2()
        setupUI3()
        
        setupUI4()
        
        setupSaveButton()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
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
    
    
    func setupProfileCircleView() {
        profileCircle.backgroundColor = UIColor(hex: "#D7F0FF")
        profileCircle.layer.cornerRadius = 60
        
        profileCircle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(profileCircle)
        
        // Calculate initials
        let vc = ProfileController()
        let userNameLabel = vc.userNameLabel
        let arr = userNameLabel.text!.components(separatedBy: " ")
        let initials = "\(arr[0].first ?? "A")\(arr[1].first ?? "B")".uppercased()
        
        profileCircleLabel.isHidden = true
        profileCircleLabel.text = initials
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileCircleLabel)
        
        NSLayoutConstraint.activate([
            profileCircle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            profileCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.width / 2 ) - 60),
            profileCircle.widthAnchor.constraint(equalToConstant: 120),
            profileCircle.heightAnchor.constraint(equalToConstant: 120),
            
            profileCircleLabel.centerXAnchor.constraint(equalTo: profileCircle.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: profileCircle.centerYAnchor)
        ])
        
        profileImageView = UIImageView()
//        profileImageView.isHidden = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 60
        
        // Add the selected image view to the profile circle
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: profileCircle.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: profileCircle.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: profileCircle.trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: profileCircle.bottomAnchor)
        ])
    }
    
    func setupEditImageButton() {
        editImageButton.addTarget(self, action: #selector(didTapEditImageButton), for: .touchUpInside)
        editImageButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(editImageButton)
        NSLayoutConstraint.activate([
            editImageButton.topAnchor.constraint(equalTo: profileCircle.topAnchor, constant: 80),
            editImageButton.leadingAnchor.constraint(equalTo: profileCircle.leadingAnchor, constant: 80),
            editImageButton.widthAnchor.constraint(equalToConstant: 40),
            editImageButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func didTapEditImageButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileCircleLabel.isHidden = true // Hide the profile circle label
            profileCircle.backgroundColor = UIColor.clear // Clear the background color
            
            profileImageView = UIImageView(image: selectedImage)
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.clipsToBounds = true
            profileImageView.layer.cornerRadius = profileCircle.frame.width / 2
            
            // Add the selected image view to the profile circle
            profileCircle.addSubview(profileImageView)
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                profileImageView.topAnchor.constraint(equalTo: profileCircle.topAnchor),
                profileImageView.leadingAnchor.constraint(equalTo: profileCircle.leadingAnchor),
                profileImageView.trailingAnchor.constraint(equalTo: profileCircle.trailingAnchor),
                profileImageView.bottomAnchor.constraint(equalTo: profileCircle.bottomAnchor)
            ])
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //******************************* newly added changes ***********************
    func setupUI() {
        let fullNameLabel = UILabel()
        fullNameLabel.attributedText = createAttributedText(for: "Full Name")
        fullNameLabel.font = .boldSystemFont(ofSize: 16)
        fullNameLabel.textColor = UIColor(hex: "#344054")
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(fullNameLabel)
        
        fullNameTF.delegate = self
        scrollView.addSubview(fullNameTF)
        
        
        let designationLabel = UILabel()
        designationLabel.attributedText = createAttributedText(for: "Designation")
        designationLabel.font = .boldSystemFont(ofSize: 16)
        designationLabel.textColor = UIColor(hex: "#344054")
        designationLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(designationLabel)
        
        designationTF.delegate = self
        scrollView.addSubview(designationTF)
        
        
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
            fullNameLabel.topAnchor.constraint(equalTo: profileCircle.bottomAnchor, constant: 20),
            fullNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            fullNameTF.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            fullNameTF.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            fullNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            designationLabel.topAnchor.constraint(equalTo: fullNameTF.bottomAnchor, constant: 16),
            designationLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            
            designationTF.topAnchor.constraint(equalTo: designationLabel.bottomAnchor, constant: 8),
            designationTF.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            designationTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dobLabel.topAnchor.constraint(equalTo: designationTF.bottomAnchor, constant: 16),
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
        
        // Update the height constraint based on content size
        languageCVHeightConstraint.constant = contentSize.height
        print(contentSize)
        if contentSize.height > 300 {
            scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 600)
        }
        
        // Update constraints
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            if contentSize.height > 250 && contentSize.height < 450 {
                self.scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + 600)
            }
            if contentSize.height > 450 {
                self.scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + 800)
            }
            if contentSize.height < 250 {
                self.scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + 450)
            }
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
    
    
    
    
    func setupSaveButton() {
        let saveButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 24)
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        saveButton.layer.cornerRadius = 10
        saveButton.tintColor = .white
        saveButton.backgroundColor = UIColor(hex: "#0079C4")
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: view.frame.width - 36),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func didTapSaveButton() {
        submitPersonalInfo()
    }

    func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size

        let widthRatio  = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let ratio = min(widthRatio, heightRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)

        let rect = CGRect(origin: .zero, size: newSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
}

extension EditProfileVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

extension EditProfileVC {
    func fetchUserProfile() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/profile") else {
            print("Invalid URL")
            return
        }

        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Retrieve the accessToken and set the Authorization header
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Access Token not found")
            return
        }

        // Execute the network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                print(user)
                
                DispatchQueue.main.async {
                    self.fetchProfilePicture(size: "m", userID: user._id)
                    
                    self.fullNameTF.text = user.name
                    self.designationTF.text = user.designation
                    self.dobTF.text = user.dateOfBirth
                    self.nationalityTF.text = user.nationality
                    var gender = user.gender?.trimmingCharacters(in: .whitespaces)
                    for case let button as UIButton in self.genderStackView.arrangedSubviews {
                        if button.titleLabel?.text?.trimmingCharacters(in: .whitespaces) == gender {
                            self.genderOptionSelected(button)
                            break
                        }
                    }
                    
                    self.permanentAddressTF.text = user.permanentAddress
                    var currentAddress = user.currentAddress
                    self.currentAddressTF.text = currentAddress?.address
                    self.stateTF.text = currentAddress?.state
                    self.cityTF.text = currentAddress?.city
                    self.pincodeTF.text = currentAddress?.pincode
                    
                    self.uidTF.text = user.uidNumber
                    self.passportTF.text = user.passportNo
                    self.panTF.text = user.panNo
                    
                    self.languageArray = user.language ?? []
                    self.reloadCollectionView()
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }

        task.resume()
    }
    
    func fetchProfilePicture(size: String, userID: String) {
        let urlString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/profile/\(size)/\(userID)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.profileImageView.image = image
                } else {
                    print("Failed to decode image")
                }
            }
        }

        task.resume()
    }
}


extension EditProfileVC {
    
    func submitPersonalInfo() {
        // Validate the input fields
        guard let image = profileImageView.image,
              let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 800, height: 600)),
              let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        else {
            showAlert(withTitle: "Missing Information", message: "Please select a valid image before saving.")
            return
        }
        guard let fullName = fullNameTF.text, !fullName.isEmpty,
              let designation = designationTF.text, !designation.isEmpty,
              let dob = dobTF.text, !dob.isEmpty,
              let nationality = nationalityTF.text, !nationality.isEmpty,
              let gender = selectedGenderButton?.titleLabel?.text, !gender.isEmpty,
              let permanentAddress = permanentAddressTF.text, !permanentAddress.isEmpty,
              let currentAddress = currentAddressTF.text, !currentAddress.isEmpty,
              let city = cityTF.text, !city.isEmpty,
              let state = stateTF.text, !state.isEmpty,
              let pincode = pincodeTF.text, !pincode.isEmpty,
              let uid = uidTF.text, !uid.isEmpty,
              let passport = passportTF.text, !passport.isEmpty,
              let pan = panTF.text, !pan.isEmpty else {
            
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
        
        updateDesignation(designation: designation)
        uploadPersonalInfo(userInfo: personalInfo)
        updateUserInfo()
    }
    
    func updateDesignation(designation : String) {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access token not found in UserDefaults")
            return
        }
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let requestBody: [String: String] = ["designation": designation]
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode designation: \(error)")
            return
        }
        
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
            
            print("Designation updated successfully")
        }
        task.resume()
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
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                loader.stopAnimating()
                loader.removeFromSuperview()
                self.navigationController?.popViewController(animated: true)
            }
        }
        task.resume()
    }
    
}
