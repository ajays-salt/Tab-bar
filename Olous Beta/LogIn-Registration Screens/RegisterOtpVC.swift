//
//  RegisterOtpVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 14/05/24.
//

import UIKit

class RegisterOtpVC: UIViewController, BackspaceDetectingTextFieldDelegate {

    var headerView : UIView!
    
    var otpTextFields: [BackspaceDetectingTextField] = []
    
    var email : String = ""
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Verify OTP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = UIColor(hex: "#0079C4")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
        let backToLoginString = NSAttributedString(string: "Back to Registration")
        attributedString.append(backToLoginString)
        
        // Set attributed title for button
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textColor = UIColor(hex: "#475467")
        
        button.addTarget(self, action: #selector(didTapBackToLogin), for: .touchUpInside)
        return button
    }()
    
    let resendOtpLabel: UILabel = {
        let label = UILabel()
        label.text = "Resend OTP in"
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor(hex: "#475467")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "2:00"
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor(hex: "#0056E2")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let resendOtp: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Click here to Resend", for: .normal)
        button.setTitleColor(UIColor(hex: "#0056E2"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapResendOtp), for: .touchUpInside)
        return button
    }()
    
    private var timer: Timer?
    private var remainingTime = 120

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        startTimer()
        setupViews()
    }
    
    func setupViews() {
        setupHeaderView()
        setupOTPFields()
        setupLoginButton()
        setupResendOtp()
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
            headerView.heightAnchor.constraint(equalToConstant: 160)
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
        
        let headLabel : UILabel = {
            let label = UILabel()
            label.text = "Log in to your account"
            label.font = .boldSystemFont(ofSize: 28)
            label.textColor = UIColor(hex: "#101828")
            return label
        }()
        
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headLabel)
        NSLayoutConstraint.activate([
            headLabel.topAnchor.constraint(equalTo: olousLogo.bottomAnchor, constant: 20),
            headLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let secondLabel : UILabel = {
            let label = UILabel()
            label.text = "Please enter OTP sent tooooo \(email)"
            label.font = .systemFont(ofSize: 18)
            label.numberOfLines = 2
            label.textColor = UIColor(hex: "#475467")
            label.textAlignment = .center
            return label
        }()
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(secondLabel)
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 10),
            secondLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            secondLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 16),
            secondLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -16),
            secondLabel.widthAnchor.constraint(lessThanOrEqualTo: headerView.widthAnchor, constant: -32) // Ensures the label does not exceed the width of headerView
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
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
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
    
    

    func setupLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 115),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func loginButtonTapped() {
        
        let otp = otpTextFields.compactMap { $0.text }.joined()
        
        guard otp.count == 4 else {
            showAlert(withTitle: "Error", message: "Please enter a complete 4-digit OTP.")
            return
        }
        
        verifyOtp(otp: otp, email: email ?? "nil")
    }
    
    func verifyOtp(otp: String, email: String) {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/auth/verify-otp") else {
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
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error in URLSession data task: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response from server: \(responseString)")
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("OTP verified successfully")
                
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print(json)
                    if let user = json["user"] as? [String: Any], let email = user["email"] as? String, let accessToken = json["accessToken"] as? String {
                        
                        UserDefaults.standard.set(accessToken, forKey: "accessToken")
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    spinner.stopAnimating()
                    spinner.removeFromSuperview()
                    
                    let vc = BasicDetails1()
                    let navVC = UINavigationController(rootViewController: vc)
                    navVC.modalPresentationStyle = .fullScreen
                    navVC.navigationBar.isHidden = true
                    self.present(navVC, animated: true)
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
    
    
    func setupResendOtp() {
        view.addSubview(resendOtpLabel)
        view.addSubview(timeLabel)
        view.addSubview(resendOtp)
        
        NSLayoutConstraint.activate([
            resendOtpLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40),
            resendOtpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            
            timeLabel.centerYAnchor.constraint(equalTo: resendOtpLabel.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: resendOtpLabel.trailingAnchor, constant: 6),
            
            resendOtp.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 22),
            resendOtp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func didTapResendOtp() {
        resendOtpApiCall()
        remainingTime = 120  // Reset the timer
        startTimer()
        resendOtp.isHidden = true
        resendOtpLabel.isHidden = false
        timeLabel.isHidden = false
    }
    
    func resendOtpApiCall(){
        let loginData: [String: String] = ["email": email]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: loginData) else {
            print("Failed to serialize login data")
            return
        }
        
        let loginURL = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/auth/resend-otp")!
        
        // Create the request
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Login request error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print(jsonResponse)
                if let msg = jsonResponse["msg"] as? String, msg == "otp sent" {
                    print("Otp Resend Successful")
                }
            } else {
                print("Failed to parse JSON response")
            }
        }
        task.resume()
    
    }
    
    func startTimer() {
        timer?.invalidate()  // Invalidate the previous timer if it exists
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            let timeString = String(format: "%d:%02d", minutes, seconds)
            timeLabel.text = timeString
        } else {
            timer?.invalidate()
            resendOtpLabel.isHidden = true
            timeLabel.isHidden = true
            resendOtp.isHidden = false
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    
    func setupBackButton() {
        backToLogin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backToLogin)
        NSLayoutConstraint.activate([
            backToLogin.topAnchor.constraint(equalTo: resendOtp.bottomAnchor, constant: 30),
            backToLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func didTapBackToLogin() {
        navigationController?.popViewController(animated: true)
    }

}
