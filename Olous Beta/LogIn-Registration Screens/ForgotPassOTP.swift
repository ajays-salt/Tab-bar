//
//  ForgotPassword2.swift
//  olousTabBar
//
//  Created by Salt Technologies on 26/03/24.
//

import UIKit

class ForgotPassOTP: UIViewController, BackspaceDetectingTextFieldDelegate {
    
    var headerView : UIView!
    
    var keyLogoView : UIView!
    
    var emailLabel = UILabel()
    
    var otpTextFields: [BackspaceDetectingTextField] = []
    let verifyOtpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Verify OTP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = UIColor(hex: "#0079C4")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(verifyOtpButtonTapped), for: .touchUpInside)
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
        let backToLoginString = NSAttributedString(string: "Go Back")
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
        setupOTPFields()
        setupVerifyOtp()
        setupBackButton()
    }
    
    func setupHeaderView() {
        
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
            olousLogo.widthAnchor.constraint(equalToConstant: 160),
            olousLogo.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        keyLogoView = UIView()
        keyLogoView.layer.borderWidth = 1
        keyLogoView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        keyLogoView.layer.cornerRadius = 12
        
        let imgView = UIImageView(image: UIImage(named: "mail-01"))
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
            label.text = "Check your mail"
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
            label.text = "We've sent a verification OTP to"
            label.font = .systemFont(ofSize: 18)
            label.textColor = UIColor(hex: "#475467")
            return label
        }()
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(secondLabel)
        
        
//        emailLabel.text = "ajay.com"
        emailLabel.font = .systemFont(ofSize: 18)
        emailLabel.textColor = UIColor(hex: "#475467")
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 10),
            secondLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            secondLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 16),
            secondLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 6),
            emailLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
        ])
    }
    
    
    func setupOTPFields() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 45),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        for i in 0..<4 {
            let textField = BackspaceDetectingTextField()
            textField.delegate = self
            textField.backspaceDelegate = self
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 24)
            textField.keyboardType = .numberPad
            textField.layer.borderColor = UIColor(hex: "#667085").cgColor
            textField.layer.borderWidth = 2
            textField.layer.cornerRadius = 8
            textField.borderStyle = .roundedRect
            textField.tag = i
            textField.addDoneButtonOnKeyboard()
            otpTextFields.append(textField)
            stackView.addArrangedSubview(textField)
        }
    }
    
    func textFieldDidDeleteBackward(_ textField: BackspaceDetectingTextField) {
        // Handle backspace on empty text field
        if textField.text?.isEmpty ?? true, textField.tag > 0 {
            otpTextFields[textField.tag - 1].becomeFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Handle backspace on Non Empty text field
        if string.isEmpty { // string.isEmpty means the input is backspace
            if textField.tag > 0 {
                textField.text = ""
                otpTextFields[textField.tag - 1].becomeFirstResponder()
                return false
            }
        }
        
        // Handle digit input
        if !string.isEmpty {
            textField.text = string
            // Move to the next text field if available
            if textField.tag < otpTextFields.count - 1 {
                otpTextFields[textField.tag + 1].becomeFirstResponder()
            } else {
                textField.resignFirstResponder() // Last field, resign first responder
            }
            return false
        }
        
        return true
    }
    
    
    
    func setupVerifyOtp() {
        view.addSubview(verifyOtpButton)
        
        NSLayoutConstraint.activate([
            verifyOtpButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 130),
            verifyOtpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verifyOtpButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            verifyOtpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func verifyOtpButtonTapped() {
        
        let otp = otpTextFields.compactMap { $0.text }.joined()
        
        guard otp.count == 4 else {
            showAlert(withTitle: "Error", message: "Please enter a complete 4-digit OTP.")
            return
        }
        
        verifyOtp(otp: otp, email: emailLabel.text ?? "nil")
    }
    
    func verifyOtp(otp: String, email: String) {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/auth/verify-reset-otp") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["otp": otp, "email": email]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            print("Failed to encode JSON")
            return
        }
        
        request.httpBody = jsonData
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
        DispatchQueue.main.async {
            self.verifyOtpButton.alpha = 0.3
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            defer {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    spinner.stopAnimating()
                    spinner.removeFromSuperview()
                    self.verifyOtpButton.alpha = 1
                }
            }
            guard let data = data, error == nil else {
                print("Error in URLSession data task: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("OTP verified successfully")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = ForgotPassReset()
                    vc.otp = otp
                    vc.email = email
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(withTitle: "Verification Failed", message: "Failed to verify OTP. Please try again.")
                }
            }
        }.resume()
    }
    
    private func showAlert(withTitle title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }


    
    
    func setupBackButton() {
        backToLogin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backToLogin)
        NSLayoutConstraint.activate([
            backToLogin.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 200),
            backToLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func didTapBackToLogin() {
        navigationController?.popViewController(animated: true)
//        navigationController?.popToRootViewController(animated: true)
    }
}

