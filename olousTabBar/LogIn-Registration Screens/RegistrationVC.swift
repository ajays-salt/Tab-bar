//
//  RegistrationVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 26/03/24.
//

import UIKit

class RegistrationVC: UIViewController, UITextFieldDelegate {
    
    var headerView : UIView!
    
    let nameLabel: UILabel = {
        let label = UILabel()
        let attributedText1 = NSMutableAttributedString(string: "Name")
        let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText1.append(asterisk1)
        label.attributedText = attributedText1
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        let attributedText1 = NSMutableAttributedString(string: "Email")
        let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText1.append(asterisk1)
        label.attributedText = attributedText1
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
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
    
    
    
    let passwordLabel : UILabel = {
        let label = UILabel()
        let attributedText1 = NSMutableAttributedString(string: "Password")
        let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText1.append(asterisk1)
        label.attributedText = attributedText1
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Create a password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
//        textField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let toggleButton = UIButton(type: .custom)
    
    let numberLabel: UILabel = {
        let label = UILabel()
        let attributedText1 = NSMutableAttributedString(string: "Mobile Number")
        let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText1.append(asterisk1)
        label.attributedText = attributedText1
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Mobile Number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordValidationLabel1: UILabel = {
        let label = UILabel()
        label.text = "Must be at least 8 characters"
        label.textColor = UIColor(hex: "#475467")
        label.textAlignment = .left
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordValidationLabel2: UILabel = {
        let label = UILabel()
        label.text = "Must contain one special character"
        label.textColor = UIColor(hex: "#475467")
        label.textAlignment = .left
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkmark1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#D0D5DD")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let tickImageView = UIImageView(image: UIImage(systemName: "checkmark"))
        tickImageView.contentMode = .scaleAspectFit
        tickImageView.tintColor = .white
        tickImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tickImageView)
        
        NSLayoutConstraint.activate([
            tickImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tickImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tickImageView.widthAnchor.constraint(equalToConstant: 14), // Adjust size as needed
            tickImageView.heightAnchor.constraint(equalToConstant: 14) // Adjust size as needed
        ])
        
        return view
    }()
    
    let checkmark2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#D0D5DD")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let tickImageView = UIImageView(image: UIImage(systemName: "checkmark"))
        tickImageView.contentMode = .scaleAspectFit
        tickImageView.tintColor = .white
        tickImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tickImageView)
        
        NSLayoutConstraint.activate([
            tickImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tickImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tickImageView.widthAnchor.constraint(equalToConstant: 14), // Adjust size as needed
            tickImageView.heightAnchor.constraint(equalToConstant: 14) // Adjust size as needed
        ])
        
        return view
    }()
    
    let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor(hex: "#0079C4")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let logInLabel : UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Already have an account? ")
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#475467"), range: NSRange(location: 0, length: attributedString.length))
        
        let loginString = NSMutableAttributedString(string: "Log in")
        loginString.addAttribute(.foregroundColor, value: UIColor(hex: "#0079C4"), range: NSRange(location: 0, length: loginString.length))
        
        label.isUserInteractionEnabled = true
        
        attributedString.append(loginString)
        label.attributedText = attributedString
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        numberTextField.delegate = self
        
        overrideUserInterfaceStyle = .light
        
        setupViews()
        
        let loginTapGesture = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        logInLabel.addGestureRecognizer(loginTapGesture)
    }
    
    func setupViews() {
        setupHeaderView()
        setupUI()
        setupToggleButton()
        setupLogin()
    }
    
    func setupHeaderView() {
        
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        let olousLogo : UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "OlousLogo")
//            imageView.contentMode = .scaleAspectFit
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
            label.text = "Create an account"
            label.font = .boldSystemFont(ofSize: 32)
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
            label.text = "Start your 30-day free trial."
            label.font = .systemFont(ofSize: 20)
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
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
//        view.addSubview(passwordValidationLabel1)
//        view.addSubview(passwordValidationLabel2)
//        view.addSubview(checkmark1)
//        view.addSubview(checkmark2)
        
        view.addSubview(numberLabel)
        view.addSubview(numberTextField)
        view.addSubview(getStartedButton)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            numberLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            numberTextField.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 8),
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numberTextField.heightAnchor.constraint(equalToConstant: 40),
            
//            passwordValidationLabel1.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
//            passwordValidationLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//            passwordValidationLabel1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            passwordValidationLabel1.heightAnchor.constraint(equalToConstant: 30),
//            
//            passwordValidationLabel2.topAnchor.constraint(equalTo: passwordValidationLabel1.bottomAnchor, constant: -4),
//            passwordValidationLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//            passwordValidationLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            passwordValidationLabel2.heightAnchor.constraint(equalToConstant: 30),
//            
//            checkmark1.centerYAnchor.constraint(equalTo: passwordValidationLabel1.centerYAnchor),
////            checkmark1.topAnchor.constraint(equalTo: passwordValidationLabel1.topAnchor),
//            checkmark1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            checkmark1.widthAnchor.constraint(equalToConstant: 20),
//            checkmark1.heightAnchor.constraint(equalToConstant: 20),
//            
//            checkmark2.centerYAnchor.constraint(equalTo: passwordValidationLabel2.centerYAnchor),
////            checkmark2.topAnchor.constraint(equalTo: passwordValidationLabel2.topAnchor),
//            checkmark2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            checkmark2.widthAnchor.constraint(equalToConstant: 20),
//            checkmark2.heightAnchor.constraint(equalToConstant: 20),
            
            getStartedButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 30),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setupToggleButton() {
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye"), for: .selected)
        toggleButton.tintColor = UIColor(hex: "#667085")
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        
        passwordTextField.rightView = toggleButton
        passwordTextField.rightViewMode = .always
        toggleButton.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
    }
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        if let textField = sender.superview as? UITextField {
            textField.isSecureTextEntry = !sender.isSelected
        }
    }
    
    @objc private func passwordChanged() {
        if let password = passwordTextField.text {
            let hasMinimumLength = password.count >= 8
            let containsSpecialCharacter = password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()-_=+`~[]{}|;:'\",.<>/?")) != nil
            
            
            updateCheckmark(checkmark1, isValid: hasMinimumLength)
            updateCheckmark(checkmark2, isValid: containsSpecialCharacter)
        }
    }

    private func updateCheckmark(_ checkmark: UIView, isValid: Bool) {
        checkmark.backgroundColor = isValid ? UIColor(hex: "#0079C4") : UIColor(hex: "#D0D5DD")
    }
    
    @objc private func getStartedButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty, email.isValidEmail(),
              let password = passwordTextField.text, !password.isEmpty,
              let mobile = numberTextField.text, !mobile.isEmpty, mobile.isValidMobileNumber() else {
            
            showAlert(title: "Alert!", message: "Fill all the details")
            return
        }

        let registrationData: [String: String] = [
            "email": email,
            "mobile": mobile,
            "password": password,
            "name": name
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: registrationData) else {
            print("Failed to serialize registration data")
            return
        }
        
        let registrationURL = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/auth/register")!
        
        // Create the request
        var request = URLRequest(url: registrationURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            defer {
                DispatchQueue.main.async {
                    spinner.stopAnimating()
                    spinner.removeFromSuperview()
                }
            }
            
            if let error = error {
                print("Registration request error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response from server: \(rawResponse)")
            }
            
            if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print(jsonResponse)
                DispatchQueue.main.async {
                    self.handleRegistrationResponse(jsonResponse, email: email)
                }
            } else {
                print("Failed to parse JSON response")
            }
        }
        task.resume()
    }

    private func handleRegistrationResponse(_ json: [String: Any], email: String) {
        if let user = json["user"] as? [String: Any], let email = user["email"] as? String, let accessToken = user["accessToken"] as? String {
            UserDefaults.standard.set(accessToken, forKey: "accessToken")
            print("First if statement where accessToken is saved")
//            navigateToBasicDetails()
        } else if let msg = json["msg"] as? String, msg == "user already exists try login" {
            showAlert(title: "Alert!", message: "User already exists")
        } else if let msg = json["msg"] as? String, msg == "otp sent" {
//            print("Otp sent")
//            navigateToRegisterOtpVC(email: email)
        } else {
            print("Unexpected response from server")
            print("Otp sent")
            navigateToRegisterOtpVC(email: email)
        }
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    private func navigateToBasicDetails() {
        let vc = BasicDetails1()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.isHidden = true
        present(navVC, animated: true)
    }

    private func navigateToRegisterOtpVC(email: String) {
        let vc = RegisterOtpVC()
        vc.email = email
        navigationController?.pushViewController(vc, animated: true)
    }

    
//    func showAlert(withTitle title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
    
    func setupLogin() {
        logInLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logInLabel)
        
        NSLayoutConstraint.activate([
            logInLabel.topAnchor.constraint(equalTo: getStartedButton.bottomAnchor, constant: 60),
            logInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func loginTapped() {
        let vc = LoginVC()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.isHidden = true
        present(navVC, animated: true)
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

extension String {
    func isValidEmail() -> Bool {
        // Implement email validation logic here
        // Example validation:
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidMobileNumber() -> Bool {
        // Implement mobile number validation logic here
        // Example validation: Check if the string contains only digits and has a specific length
        let mobileRegex = "^[0-9]{10}$"
        let mobilePredicate = NSPredicate(format: "SELF MATCHES %@", mobileRegex)
        return mobilePredicate.evaluate(with: self)
    }
}

