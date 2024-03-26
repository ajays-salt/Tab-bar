//
//  ForgotPassword2.swift
//  olousTabBar
//
//  Created by Salt Technologies on 26/03/24.
//

import UIKit

class ForgotPassword2: UIViewController {
    
    var headerView : UIView!
    
    var keyLogoView : UIView!
    
    var emailLabel : UILabel!
    
    let openEmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open mail app", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = UIColor(hex: "#0079C4")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(openEmailButtonTapped), for: .touchUpInside)
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
        setupUI()
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
            olousLogo.widthAnchor.constraint(equalToConstant: 116),
            olousLogo.heightAnchor.constraint(equalToConstant: 24)
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
            label.text = "We sent a password reset link to"
            label.font = .systemFont(ofSize: 18)
            label.textColor = UIColor(hex: "#475467")
            return label
        }()
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(secondLabel)
        
        
        emailLabel = UILabel()
        emailLabel.text = "ajays@salttechno.com"
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
    

    func setupUI() {
        view.addSubview(openEmailButton)
        
        NSLayoutConstraint.activate([
            openEmailButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 50),
            openEmailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openEmailButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            openEmailButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func openEmailButtonTapped() {
        guard let emailURL = URL(string: "message:") else {
            print("Invalid email URL")
            return
        }
        
        guard UIApplication.shared.canOpenURL(emailURL) else {
            print("Device cannot send emails")
            return
        }
        
        // Open the email app
        UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
    }
    
    func setupBackButton() {
        backToLogin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backToLogin)
        NSLayoutConstraint.activate([
            backToLogin.topAnchor.constraint(equalTo: openEmailButton.bottomAnchor, constant: 50),
            backToLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func didTapBackToLogin() {
//        navigationController?.popViewController(animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
}

