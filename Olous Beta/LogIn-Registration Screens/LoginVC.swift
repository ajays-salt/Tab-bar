//
//  LoginVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 26/03/24.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    var headerView : UIView!
    
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
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password :"
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
    
    let forgotPasswordLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password", for: .normal)
        button.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get OTP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = UIColor(hex: "#0079C4")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let googleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "googleLogo"), for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let signUpLabel : UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Don't have an account? ")
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#475467"), range: NSRange(location: 0, length: attributedString.length))
        
        let loginString = NSMutableAttributedString(string: "Sign Up")
        loginString.addAttribute(.foregroundColor, value: UIColor(hex: "#0079C4"), range: NSRange(location: 0, length: loginString.length))
        
        label.isUserInteractionEnabled = true
        
        attributedString.append(loginString)
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let toggleButton = UIButton(type: .custom)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        emailTextField.delegate = self
        passwordTextField.delegate = self

        setupViews()
        
        let signUpTapGesture = UITapGestureRecognizer(target: self, action: #selector(signUpTapped))
        signUpLabel.addGestureRecognizer(signUpTapGesture)
    }
    
    func setupViews() {
        setupHeaderView()
        setupUI()
        setupToggleButton()
        setupGoogleSignIn()
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
            olousLogo.widthAnchor.constraint(equalToConstant: 140),
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
            label.text = "Welcome back! Please enter your details."
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
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordLabel)
        view.addSubview(loginButton)
        
        view.addSubview(googleButton)
        
        view.addSubview(signUpLabel)
        
        NSLayoutConstraint.activate([
            
            emailLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
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
            
            forgotPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forgotPasswordLabel.heightAnchor.constraint(equalToConstant: 30),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            googleButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleButton.heightAnchor.constraint(equalToConstant: 80),
            googleButton.widthAnchor.constraint(equalToConstant: 80),
            
            signUpLabel.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 20),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
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
    
    
    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty, email.isValidEmail(),
              let password = passwordTextField.text, !password.isEmpty else {
            
            // Handle validation failure
            showAlert(title: "Alert!", message: "Fill all the details")
            return
        }
        
        let loginData: [String: String] = ["email": email, "password": password]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: loginData) else {
            print("Failed to serialize login data")
            return
        }
        
        let loginURL = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/auth/login")!
        
        // Create the request
        var request = URLRequest(url: loginURL)
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
                print("Login request error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print(jsonResponse)
                DispatchQueue.main.async {
                    self.handleLoginResponse(jsonResponse, email: email)
                }
            } else {
                print("Failed to parse JSON response")
            }
        }
        task.resume()
    }

    private func handleLoginResponse(_ json: [String: Any], email: String) {
        if let user = json["user"] as? [String: Any], let email = user["email"] as? String, let accessToken = json["accessToken"] as? String {
            UserDefaults.standard.set(accessToken, forKey: "accessToken")
//            navigateToBasicDetails()
        } else if let msg = json["msg"] as? String, msg == "user does not exist" {
            showAlert(title: "Alert!", message: "User does not Exist")
        } else if let msg = json["msg"] as? String, msg == "Invalid credentials" {
            showAlert(title: "Alert!", message: "Invalid Login Credentials")
        } else if let msg = json["msg"] as? String, msg == "otp sent" {
            navigateToLoginOtpVC(email: email)
        } else {
            print("Unexpected response from server")
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

    private func navigateToLoginOtpVC(email: String) {
        let vc = LoginOtpVC()
        vc.email = email
        vc.pass = passwordTextField.text!
        navigationController?.pushViewController(vc, animated: true)
    }

    
    func setupGoogleSignIn() {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(hex: "fafafa") // or any appropriate background color
        containerView.layer.cornerRadius = 31 // Half of height and width to make it circular
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 23.5),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 62),
            containerView.widthAnchor.constraint(equalToConstant: 62),
        ])
        
        // ImageView for the Google logo
        let imageView = UIImageView(image: UIImage(named: "googleLogo"))
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill  // Maintain the aspect ratio
        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 100),  // Adjust size as needed
            imageView.heightAnchor.constraint(equalToConstant: 100), // Adjust size as needed
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 4),
        ])
        
        containerView.isHidden = true
        imageView.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleGoogleSignInTap))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleGoogleSignInTap() {
        print("Google Sign-In tapped")
    }
    
    
    
    @objc func signUpTapped() {
        let vc = RegistrationVC()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.isHidden = true
        present(navVC, animated: true)
    }
    
    @objc func forgotPasswordTapped() {
        let vc = ForgotPassword1()
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
