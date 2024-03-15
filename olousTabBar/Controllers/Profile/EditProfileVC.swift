//
//  EditProfileVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 15/03/24.
//

import UIKit

class EditProfileVC: UIViewController, UITextFieldDelegate {
    
    let profileCircle = UIView()
    let profileCircleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#0079C4")
        label.font = .boldSystemFont(ofSize: 48)
        return label
    }()
    
    let nameTextField = UITextField()
    let designationTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Edit Profile"
        navigationItem.hidesBackButton = true
        
        let backButtonImage = UIImage(systemName: "xmark") // Change "xmark" to any system image you prefer
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        
        
        nameTextField.delegate = self
        designationTextField.delegate = self
        setupViews()
        
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
        setupProfileCircleView()
        setupFullName()
        setupDesignation()
    }
    
    func setupProfileCircleView() {
        profileCircle.backgroundColor = UIColor(hex: "#D7F0FF")
        profileCircle.layer.cornerRadius = 60
        
        profileCircle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileCircle)
        NSLayoutConstraint.activate([
            profileCircle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            profileCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.width / 2 ) - 60),
            profileCircle.widthAnchor.constraint(equalToConstant: 120),
            profileCircle.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        // Calculate initials
        let vc = ProfileController()
        let userNameLabel = vc.userNameLabel
        let arr = userNameLabel.text!.components(separatedBy: " ")
        let initials = "\(arr[0].first ?? "A")\(arr[1].first ?? "B")".uppercased()
        
        
        profileCircleLabel.text = initials
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: profileCircle.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: profileCircle.centerYAnchor)
        ])
    }
    
    func setupFullName() {
        let fullName = UILabel()
        fullName.text = "Full name"
        fullName.font = .systemFont(ofSize: 18)
        fullName.textColor = UIColor(hex: "#344054")
        
        fullName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fullName)
        NSLayoutConstraint.activate([
            fullName.topAnchor.constraint(equalTo: profileCircle.bottomAnchor, constant: 40),
            fullName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 8
        nameTextField.layer.borderColor = UIColor(hex: "#344054").cgColor
        nameTextField.placeholder = "Ajay Sarkate"
        nameTextField.textColor = UIColor(hex: "#344054")
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            nameTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 36),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupDesignation() {
        let designation = UILabel()
        designation.text = "Your designation"
        designation.font = .systemFont(ofSize: 18)
        designation.textColor = UIColor(hex: "#344054")
        
        designation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(designation)
        NSLayoutConstraint.activate([
            designation.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            designation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        designationTextField.borderStyle = .roundedRect
        designationTextField.layer.borderWidth = 1
        designationTextField.layer.cornerRadius = 8
        designationTextField.layer.borderColor = UIColor(hex: "#344054").cgColor
        designationTextField.placeholder = "iOS Developer"
        designationTextField.textColor = UIColor(hex: "#344054")
        
        designationTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(designationTextField)
        NSLayoutConstraint.activate([
            designationTextField.topAnchor.constraint(equalTo: designation.bottomAnchor, constant: 10),
            designationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            designationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 36),
            designationTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
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
