//
//  EditProfileVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 15/03/24.
//

import UIKit

class EditProfileVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let locationsArray = ["Paris", "New York", "Pimpri", "Lonar", "Berlin", "Partur", "Pune"]
    var filteredLocations = [String]()
    let suggestionTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()
    
    let profileCircle = UIView()
    let profileCircleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#0079C4")
        label.font = .boldSystemFont(ofSize: 48)
        return label
    }()
    var profileImageView : UIImageView!
    
    let editImageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.tintColor = UIColor(hex: "#667085")
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    let nameTextField = UITextField()
    let designationTextField = UITextField()
    let locationTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Edit Profile"
        navigationItem.hidesBackButton = true
        
        let backButtonImage = UIImage(systemName: "xmark") // Change "xmark" to any system image you prefer
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        
        
        nameTextField.delegate = self
        designationTextField.delegate = self
        locationTextField.delegate = self
        
        suggestionTableView.delegate = self
        suggestionTableView.dataSource = self
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
        setupEditImageButton()
        setupFullName()
        setupDesignation()
        setupLocation()
        setupSuggestions()
        setupSaveButton()
    }
    
    func setupProfileCircleView() {
        profileCircle.backgroundColor = UIColor(hex: "#D7F0FF")
        profileCircle.layer.cornerRadius = 60
        
        profileCircle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileCircle)
        NSLayoutConstraint.activate([
            profileCircle.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
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
    
    func setupEditImageButton() {
        editImageButton.addTarget(self, action: #selector(didTapEditImageButton), for: .touchUpInside)
        editImageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editImageButton)
        NSLayoutConstraint.activate([
            editImageButton.topAnchor.constraint(equalTo: profileCircle.topAnchor, constant: 80),
            editImageButton.leadingAnchor.constraint(equalTo: profileCircle.leadingAnchor, constant: 80),
            editImageButton.widthAnchor.constraint(equalToConstant: 40),
            editImageButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func didTapEditImageButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileCircleLabel.isHidden = true // Hide the profile circle label
            profileCircle.backgroundColor = UIColor.clear // Clear the background color
            
            profileImageView = UIImageView(image: selectedImage)
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.clipsToBounds = true
            profileImageView.layer.cornerRadius = profileCircle.frame.width / 2
            
            // Add the selected image view to the profile circle
            profileCircle.addSubview(profileImageView)
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                profileImageView.topAnchor.constraint(equalTo: profileCircle.topAnchor),
                profileImageView.leadingAnchor.constraint(equalTo: profileCircle.leadingAnchor),
                profileImageView.trailingAnchor.constraint(equalTo: profileCircle.trailingAnchor),
                profileImageView.bottomAnchor.constraint(equalTo: profileCircle.bottomAnchor)
            ])
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func setupFullName() {
        let fullName = UILabel()
        fullName.text = "Full name"
        fullName.font = .systemFont(ofSize: 18)
        fullName.textColor = UIColor(hex: "#344054")
        
        fullName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fullName)
        NSLayoutConstraint.activate([
            fullName.topAnchor.constraint(equalTo: profileCircle.bottomAnchor, constant: 16),
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
            nameTextField.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 8),
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
            designation.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
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
            designationTextField.topAnchor.constraint(equalTo: designation.bottomAnchor, constant: 8),
            designationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            designationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 36),
            designationTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupLocation() {
        let location = UILabel()
        location.text = "Your Location"
        location.font = .systemFont(ofSize: 18)
        location.textColor = UIColor(hex: "#344054")
        
        location.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(location)
        NSLayoutConstraint.activate([
            location.topAnchor.constraint(equalTo: designationTextField.bottomAnchor, constant: 16),
            location.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        locationTextField.borderStyle = .roundedRect
        locationTextField.layer.borderWidth = 1
        locationTextField.layer.cornerRadius = 8
        locationTextField.layer.borderColor = UIColor(hex: "#344054").cgColor
        locationTextField.placeholder = "Pune, Maharashtra"
        locationTextField.textColor = UIColor(hex: "#344054")
        
        locationTextField.translatesAutoresizingMaskIntoConstraints =  false
        view.addSubview(locationTextField)
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 8),
            locationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            locationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 36),
            locationTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupSuggestions() {
        suggestionTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(suggestionTableView)
        NSLayoutConstraint.activate([
            suggestionTableView.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 10),
            suggestionTableView.leadingAnchor.constraint(equalTo: locationTextField.leadingAnchor),
            suggestionTableView.trailingAnchor.constraint(equalTo: locationTextField.trailingAnchor),
            suggestionTableView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupSaveButton() {
        let saveButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 24)
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        saveButton.layer.cornerRadius = 10
        saveButton.tintColor = .white
        saveButton.backgroundColor = UIColor(hex: "#0079C4")
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: view.frame.width - 36),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func didTapSaveButton() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == locationTextField else { return true }
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        filterLocations(with: searchText)
        return true
    }
    
    // Step 5: Filter locations based on search text
    func filterLocations(with searchText: String) {
        filteredLocations = locationsArray.filter { $0.lowercased().hasPrefix(searchText.lowercased()) }
        suggestionTableView.isHidden = filteredLocations.isEmpty
        if(filteredLocations.count == locationsArray.count) {
            filteredLocations.removeAll()
            suggestionTableView.isHidden = true
        }
        suggestionTableView.reloadData()
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


extension EditProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = filteredLocations[indexPath.row]
        cell.backgroundColor = .systemGray6
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = filteredLocations[indexPath.row]
        locationTextField.text = selectedLocation
        
        // Dismiss the suggestion table view
        suggestionTableView.isHidden = true
    }
}
