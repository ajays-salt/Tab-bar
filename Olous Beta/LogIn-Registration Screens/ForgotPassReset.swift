//
//  ForgotPassword3.swift
//  olousTabBar
//
//  Created by Salt Technologies on 06/05/24.
//

import UIKit

class ForgotPassReset: UIViewController, UITextFieldDelegate {
    
    var headerView : UIView!
    
    var keyLogoView : UIView!
    
    
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    
    let passwordToggleVisibilityButton = UIButton(type: .custom)
    let confirmPasswordToggleVisibilityButton = UIButton(type: .custom)
    
    
    var otp : String = ""
    var email : String = ""
    
    var activityIndicator: UIActivityIndicatorView?

    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.center = self.view.center
        activityIndicator?.hidesWhenStopped = true
        view.addSubview(activityIndicator!)
    }
    
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset Password", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = UIColor(hex: "#0079C4")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
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
        setupPasswordFields()
        setupResetButton()
        setupActivityIndicator()
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
            olousLogo.widthAnchor.constraint(equalToConstant: 140),
            olousLogo.heightAnchor.constraint(equalToConstant: 26)
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
        
        textField.delegate = self
        
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
    
    func setupResetButton() {
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            
            resetButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 180),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func resetButtonTapped() {
        guard let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(withTitle: "Error", message: "Both fields must be filled.")
            return
        }
        
        if password != confirmPassword {
            showAlert(withTitle: "Error", message: "Passwords do not match.")
            return
        }
        
        performPasswordReset()
    }
    
    func performPasswordReset() {
        guard let newPassword = passwordTextField.text,
              !newPassword.isEmpty, !otp.isEmpty, !email.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "All fields must be filled.")
            return
        }
        
        let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/auth/reset-password")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = [
            "otp": otp,
            "password": newPassword,
            "confirmPassword" : newPassword,
            "email": email
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            print("Failed to encode JSON")
            return
        }
        
        request.httpBody = jsonData
        
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
            self.resetButton.alpha = 0.3
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.activityIndicator?.stopAnimating()
                self.resetButton.alpha = 1
            }
            
            guard let data = data, error == nil else {
                print("Error in URLSession data task: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Password reset successfully")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Delay for 1 second
                    let vc = ForgotPassResetDone()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(withTitle: "Reset Failed", message: "Failed to reset password. Please try again.")
                }
            }
        }.resume()
    }

    private func navigateToLoginScreen() {
        // Implementation to navigate to the login screen
        navigationController?.popToRootViewController(animated: true)
    }

    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
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
