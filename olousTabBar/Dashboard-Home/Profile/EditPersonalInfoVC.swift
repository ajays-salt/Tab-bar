//
//  EditProfileVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 15/03/24.
//

import UIKit

class EditPersonalInfoVC: UIViewController {
    
    var scrollView : UIScrollView!
    
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
        textField.placeholder = "Select Fluency"
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

        navigationItem.title = "Edit Personal Info"
        navigationItem.hidesBackButton = true
        
        let backButtonImage = UIImage(systemName: "xmark") // Change "xmark" to any system image you prefer
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    
        setupViews()
        
        fetchUserProfile()
    }
    
    deinit {
        // Unregister from keyboard notifications
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let activeTextField = UIResponder.currentFirstResponder as? UITextField else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let textFieldFrame = activeTextField.convert(activeTextField.bounds, to: self.view)
        let textFieldBottomY = textFieldFrame.maxY
        
        let visibleHeight = self.view.frame.height - keyboardHeight
        if textFieldBottomY > visibleHeight {
            let offset = textFieldBottomY - visibleHeight + 20
            self.view.frame.origin.y = -offset
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
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
        
        let extraSpaceHeight: CGFloat = 100
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + 200
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    //******************************* newly added changes ***********************
    
    func setupUI() {
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
            dobLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            dobLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            dobTF.topAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 8),
            dobTF.leadingAnchor.constraint(equalTo: dobLabel.leadingAnchor),
            dobTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            nationalityLabel.topAnchor.constraint(equalTo: dobTF.bottomAnchor, constant: 16),
            nationalityLabel.leadingAnchor.constraint(equalTo: dobLabel.leadingAnchor),

            nationalityTF.topAnchor.constraint(equalTo: nationalityLabel.bottomAnchor, constant: 8),
            nationalityTF.leadingAnchor.constraint(equalTo: nationalityLabel.leadingAnchor),
            nationalityTF.trailingAnchor.constraint(equalTo: dobTF.trailingAnchor)
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
        
        languageTextField.delegate = self
        
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
        print("Content Size LanguageCV : " , contentSize.height)
        let x = languageArray.count
        let ans = x * 60
        
        var height  = scrollView.contentSize.height
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + CGFloat(ans) + 300)
        
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

extension EditPersonalInfoVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

extension EditPersonalInfoVC {
    
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
    
}


extension EditPersonalInfoVC {
    
    func submitPersonalInfo() {
        guard
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
        
        
        let personalInfo = PersonalInfoEditStruct(
            panNo: pan,
            dateOfBirth: dob,
            nationality: nationality,
            passportNo: passport,
            uidNumber: uid,
            permanentAddress: permanentAddress,
            gender: gender
        )
        
        uploadPersonalInfo(userInfo: personalInfo)
        updateUserInfo()
    }
    
    func uploadPersonalInfo(userInfo: PersonalInfoEditStruct) {
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
        appendFormField("Pan no", value: userInfo.panNo, to: &body)
        appendFormField("dateOfBirth", value: userInfo.dateOfBirth, to: &body)
        appendFormField("nationality", value: userInfo.nationality, to: &body)
        appendFormField("passportNo", value: userInfo.passportNo, to: &body)
        appendFormField("uidNumber", value: userInfo.uidNumber, to: &body)
        appendFormField("permanentAddress", value: userInfo.permanentAddress, to: &body)
        appendFormField("gender", value: userInfo.gender, to: &body)
        
        // Append profile picture data if available
        
        
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


extension UIResponder {
    private static weak var _currentFirstResponder: UIResponder?

    public static var currentFirstResponder: UIResponder? {
        UIResponder._currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return UIResponder._currentFirstResponder
    }

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
}
