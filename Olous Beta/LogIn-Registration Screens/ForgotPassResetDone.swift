//
//  ForgotPassword4.swift
//  olousTabBar
//
//  Created by Salt Technologies on 07/05/24.
//

import UIKit

class ForgotPassResetDone: UIViewController {

    var headerView : UIView!
    var keyLogoView : UIView!
    
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
        
        setupHeaderView()
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
            olousLogo.widthAnchor.constraint(equalToConstant: 160),
            olousLogo.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        keyLogoView = UIView()
        keyLogoView.layer.borderWidth = 1
        keyLogoView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        keyLogoView.layer.cornerRadius = 12
        
        let imgView = UIImageView(image: UIImage(systemName: "checkmark.circle"))
        imgView.tintColor = UIColor(hex: "#344054")
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
            label.text = "Password reset"
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
            label.text = "Your password was successfully reset.       Go back to login"
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

    
    func setupBackButton() {
        backToLogin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backToLogin)
        NSLayoutConstraint.activate([
            backToLogin.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 50),
            backToLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func didTapBackToLogin() {
        navigationController?.popToRootViewController(animated: true)
    }
}
