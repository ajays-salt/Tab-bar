//
//  ForgotPassword3.swift
//  olousTabBar
//
//  Created by Salt Technologies on 06/05/24.
//

import UIKit

class ForgotPassword3: UIViewController {
    
    var headerView : UIView!
    
    var keyLogoView : UIView!
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email :"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    
    let passwordToggleVisibilityButton = UIButton(type: .custom)
    let confirmPasswordToggleVisibilityButton = UIButton(type: .custom)
    
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset Password", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = UIColor(hex: "#0079C4")
        button.layer.cornerRadius = 8
//        button.addTarget(self, action: #selector(sendOtpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backToLogin : UIButton = {
        let button = UIButton()
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
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.titleLabel?.textColor = UIColor(hex: "#475467")
        
        button.addTarget(self, action: #selector(didTapBackToLogin), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground

        setupViews()
    }
    
    func setupViews() {
        setupHeaderView()
        setupPasswordFields()
        setupUI()
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
            headerView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        let olousLogo : UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "OlousLogo")
            return imageView
        }()
        
        olousLogo.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(olousLogo)
        NSLayoutConstraint.activate([
            olousLogo.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            olousLogo.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            olousLogo.widthAnchor.constraint(equalToConstant: 116),
            olousLogo.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        keyLogoView = UIView()
        keyLogoView.layer.borderWidth = 1
        keyLogoView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        keyLogoView.layer.cornerRadius = 12
        
        let imgView = UIImageView(image: UIImage(named: "key-01"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        keyLogoView.addSubview(imgView)
        
        keyLogoView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(keyLogoView)
        
        NSLayoutConstraint.activate([
            keyLogoView.topAnchor.constraint(equalTo: olousLogo.bottomAnchor, constant: 30),
            keyLogoView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            keyLogoView.widthAnchor.constraint(equalToConstant: 50),
            keyLogoView.heightAnchor.constraint(equalToConstant: 50),
            
            imgView.centerXAnchor.constraint(equalTo: keyLogoView.centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: keyLogoView.centerYAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 30),
            imgView.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        let headLabel : UILabel = {
            let label = UILabel()
            label.text = "Set New Password"
            label.font = .boldSystemFont(ofSize: 28)
            label.textColor = UIColor(hex: "#101828")
            return label
        }()
        
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headLabel)
        NSLayoutConstraint.activate([
            headLabel.topAnchor.constraint(equalTo: keyLogoView.bottomAnchor, constant: 20),
            headLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let secondLabel : UILabel = {
            let label = UILabel()
            label.text = "Your new password must be different than previously used passwords!"
            label.font = .systemFont(ofSize: 18)
            label.textColor = UIColor(hex: "#475467")
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(secondLabel)
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 10),
            secondLabel.widthAnchor.constraint(lessThanOrEqualTo: headerView.widthAnchor, constant: -32),
            secondLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
        ])
    }
    

    func setupPasswordFields() {
        setupTextField(textField: passwordTextField, placeholder: "Password", toggleButton: passwordToggleVisibilityButton)
        setupTextField(textField: confirmPasswordTextField, placeholder: "Confirm password", toggleButton: confirmPasswordToggleVisibilityButton)
        
        layoutPasswordField(textField: passwordTextField, toggleButton: passwordToggleVisibilityButton, yPos: 40)
        layoutPasswordField(textField: confirmPasswordTextField, toggleButton: confirmPasswordToggleVisibilityButton, yPos: 100)
    }
    
    private func setupTextField(textField: UITextField, placeholder: String, toggleButton: UIButton) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye"), for: .selected)
        toggleButton.tintColor = UIColor(hex: "#667085")
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        
        view.addSubview(textField)
        textField.rightView = toggleButton
        textField.rightViewMode = .always
        toggleButton.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
    }
    
    private func layoutPasswordField(textField: UITextField, toggleButton: UIButton, yPos: CGFloat) {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: yPos),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        if let textField = sender.superview as? UITextField {
            textField.isSecureTextEntry = !sender.isSelected
        }
    }
    
    func setupUI() {
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            
            resetButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 180),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    
    func setupBackButton() {
        backToLogin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backToLogin)
        NSLayoutConstraint.activate([
            backToLogin.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 50),
            backToLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func didTapBackToLogin() {
        navigationController?.popViewController(animated: true)
    }

}
