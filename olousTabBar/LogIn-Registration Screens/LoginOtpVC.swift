//
//  LoginOtpVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 13/05/24.
//

import UIKit

class LoginOtpVC: UIViewController, UITextFieldDelegate {
    
    var headerView : UIView!
    
    var otpTextFields: [UITextField] = []
    
    var email : String = ""
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
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
        setupOTPFields()
        setupLoginButton()
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
            olousLogo.widthAnchor.constraint(equalToConstant: 116),
            olousLogo.heightAnchor.constraint(equalToConstant: 24)
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
            label.text = "Please enter OTP."
            label.font = .systemFont(ofSize: 18)
            label.textColor = UIColor(hex: "#475467")
            return label
        }()
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(secondLabel)
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 10),
            secondLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            secondLabel.heightAnchor.constraint(equalToConstant: 24)
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
        
        for _ in 1...4 {
            let textField = UITextField()
            textField.delegate = self
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 24)
            textField.keyboardType = .numberPad
            textField.borderStyle = .roundedRect
            otpTextFields.append(textField)
            stackView.addArrangedSubview(textField)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        if range.length + range.location > currentText.count {
            return false
        }
        
        let newLength = currentText.count + string.count - range.length
        if newLength == 1 {
            textField.text = string
            if let nextTextField = otpTextFields.first(where: { $0.text?.isEmpty ?? true }) {
                nextTextField.becomeFirstResponder()
            }
            return false
        } else if newLength == 0 {
            textField.text = ""
            if let previousTextField = otpTextFields.reversed().first(where: { $0 != textField && !($0.text?.isEmpty ?? true) }) {
                previousTextField.becomeFirstResponder()
            }
            return false
        }
        return true
    }

    func setupLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 135),
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
                    
                    let viewController = ViewController()
                    viewController.modalPresentationStyle = .overFullScreen
                    viewController.overrideUserInterfaceStyle = .light
                    self.present(viewController, animated: true)
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
            backToLogin.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            backToLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func didTapBackToLogin() {
        navigationController?.popViewController(animated: true)
    }
}
