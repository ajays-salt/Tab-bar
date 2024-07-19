//
//  EditProfileVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 19/06/24.
//

import UIKit

class EditProfileVC: UIViewController {
    
    var scrollView : UIScrollView!
    
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
    
    
    var fullNameTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter Full Name"
        return tf
    }()
    var designationTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter Designation"
        return tf
    }()
    
    var mobileTF : UITextField = {
        let mobileTF = UITextField()
        mobileTF.translatesAutoresizingMaskIntoConstraints = false
        mobileTF.borderStyle = .roundedRect
        mobileTF.placeholder = "Eg. Indian"
        mobileTF.keyboardType = .numberPad
        mobileTF.addDoneButtonOnKeyboard()
        
        mobileTF.addTarget(self, action: #selector(limitTextFieldCharacters(_:)), for: .editingChanged)
        return mobileTF
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground

        navigationItem.title = "Edit Profile"
        navigationItem.hidesBackButton = true
        
        let backButtonImage = UIImage(systemName: "xmark") // Change "xmark" to any system image you prefer
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
    
        setupViews()
        
        fetchUserProfile()
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
        setupScrollView()
        setupProfileCircleView()
        setupEditImageButton()
        
        setupUI()
        
        setupSaveButton()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
        
        let extraSpaceHeight: CGFloat = 100
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height - 300
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    
    func setupProfileCircleView() {
        profileCircle.backgroundColor = UIColor(hex: "#D7F0FF")
        profileCircle.layer.cornerRadius = 60
        
        profileCircle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(profileCircle)
        
        // Calculate initials
        let vc = ProfileController()
        let userNameLabel = vc.userNameLabel
        let arr = userNameLabel.text!.components(separatedBy: " ")
        let initials = "\(arr[0].first ?? "A")\(arr[1].first ?? "B")".uppercased()
        
        profileCircleLabel.isHidden = true
        profileCircleLabel.text = initials
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileCircleLabel)
        
        NSLayoutConstraint.activate([
            profileCircle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            profileCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.width / 2 ) - 60),
            profileCircle.widthAnchor.constraint(equalToConstant: 120),
            profileCircle.heightAnchor.constraint(equalToConstant: 120),
            
            profileCircleLabel.centerXAnchor.constraint(equalTo: profileCircle.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: profileCircle.centerYAnchor)
        ])
        
        profileImageView = UIImageView()
//        profileImageView.isHidden = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 60
        
        // Add the selected image view to the profile circle
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: profileCircle.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: profileCircle.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: profileCircle.trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: profileCircle.bottomAnchor)
        ])
    }
    
    func setupEditImageButton() {
        editImageButton.addTarget(self, action: #selector(didTapEditImageButton), for: .touchUpInside)
        editImageButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(editImageButton)
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
    
    
    //******************************* newly added changes ***********************
    
    func setupUI() {
        let fullNameLabel = UILabel()
        fullNameLabel.attributedText = createAttributedText(for: "Full Name")
        fullNameLabel.font = .boldSystemFont(ofSize: 16)
        fullNameLabel.textColor = UIColor(hex: "#344054")
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(fullNameLabel)
        
        fullNameTF.delegate = self
        scrollView.addSubview(fullNameTF)
        
        
        let designationLabel = UILabel()
        designationLabel.attributedText = createAttributedText(for: "Designation")
        designationLabel.font = .boldSystemFont(ofSize: 16)
        designationLabel.textColor = UIColor(hex: "#344054")
        designationLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(designationLabel)
        
        designationTF.delegate = self
        scrollView.addSubview(designationTF)
        
        
        
        
        let mobileLabel = UILabel()
        mobileLabel.attributedText = createAttributedText(for: "Mobile Number")
        mobileLabel.font = .boldSystemFont(ofSize: 16)
        mobileLabel.textColor = UIColor(hex: "#344054")
        mobileLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mobileLabel)
        
        
        mobileTF.delegate = self
        scrollView.addSubview(mobileTF)
        
        // Constraints
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: profileCircle.bottomAnchor, constant: 20),
            fullNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            fullNameTF.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            fullNameTF.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            fullNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            designationLabel.topAnchor.constraint(equalTo: fullNameTF.bottomAnchor, constant: 16),
            designationLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            
            designationTF.topAnchor.constraint(equalTo: designationLabel.bottomAnchor, constant: 8),
            designationTF.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            designationTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            mobileLabel.topAnchor.constraint(equalTo: designationTF.bottomAnchor, constant: 16),
            mobileLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),

            mobileTF.topAnchor.constraint(equalTo: mobileLabel.bottomAnchor, constant: 8),
            mobileTF.leadingAnchor.constraint(equalTo: mobileLabel.leadingAnchor),
            mobileTF.trailingAnchor.constraint(equalTo: fullNameTF.trailingAnchor)
        ])
    }
    
    func createAttributedText(for string: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: string)
        let asterisk = NSAttributedString(string: " *", attributes: [NSAttributedString.Key.baselineOffset: -1])
        attributedText.append(asterisk)
        return attributedText
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
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: view.frame.width - 36),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func didTapSaveButton() {
        submitPersonalInfo()
    }

    func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size

        let widthRatio  = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let ratio = min(widthRatio, heightRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)

        let rect = CGRect(origin: .zero, size: newSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
    
    
    
    @objc func limitTextFieldCharacters(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        let text2 = text.prefix(10)
        
        return textField.text = String(text2)
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

extension EditProfileVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    
}

extension EditProfileVC {
    func fetchUserProfile() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/profile") else {
            print("Invalid URL")
            return
        }

        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Retrieve the accessToken and set the Authorization header
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Access Token not found")
            return
        }

        // Execute the network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                print(user)
                
                DispatchQueue.main.async {
                    self.fetchProfilePicture(size: "m", userID: user._id)
                    
                    self.fullNameTF.text = user.name
                    self.designationTF.text = user.designation
                    self.mobileTF.text = user.mobile
                    
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }

        task.resume()
    }
    
    func fetchProfilePicture(size: String, userID: String) {
        let urlString = "\(Config.serverURL)/api/v1/user/profile/\(size)/\(userID)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.profileImageView.image = image
                } else {
                    print("Failed to decode image")
                }
            }
        }

        task.resume()
    }
}


extension EditProfileVC {
    
    func submitPersonalInfo() {
        // Validate the input fields
        guard let image = profileImageView.image,
              let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 800, height: 600)),
              let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        else {
            showAlert(withTitle: "Missing Information", message: "Please select a valid image before saving.")
            return
        }
        
        guard let fullName = fullNameTF.text, !fullName.isEmpty,
              let designation = designationTF.text, !designation.isEmpty
        else {
            showAlert(withTitle: "Alert!", message: "Please fill all the details")
            return
        }
        
        guard let mobile = mobileTF.text, !mobile.isEmpty, mobile.isValidMobileNumber() 
        else {
            showAlert(withTitle: "Alert!", message: "Invalid Mobile Number")
            return
        }
        
        
        let personalInfo = ProfileEditStruct(
            name: fullName,
            mobile: mobile,
            profilePicData: imageData
        )
        
        updateDesignation(designation: designation)
        uploadPersonalInfo(userInfo: personalInfo)
    }
    
    func updateDesignation(designation : String) {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access token not found in UserDefaults")
            return
        }
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let requestBody: [String: String] = ["designation": designation]
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode designation: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  !(400...599).contains(httpResponse.statusCode) else {
                print("Server Error")
                return
            }
            
            if let data = data {
                print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            }
            
            print("Designation updated successfully")
        }
        task.resume()
    }
    
    func uploadPersonalInfo(userInfo: ProfileEditStruct) {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/update-profile-pic") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Retrieve access token from UserDefaults
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access token not found in UserDefaults")
            return
        }
        
        // Correctly add the access token in the Authorization header
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Create multipart form data
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()
        
        // Helper function to append form data
        func appendFormField(_ name: String, value: String, to data: inout Data) {
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
            data.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Append fields
        appendFormField("name", value: userInfo.name, to: &body)
        appendFormField("mobile", value: userInfo.mobile, to: &body)
        
        // Append profile picture data if available
        if let profilePicData = userInfo.profilePicData {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"profilePic\"; filename=\"profilePic.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
            body.append(profilePicData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        
        let loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        loader.startAnimating()
        view.addSubview(loader)
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  !(400...599).contains(httpResponse.statusCode) else {
                print("Server Error")
                return
            }
            print(httpResponse)
            
            if let data = data {
                print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            }
            
            print("File uploaded successfully")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                loader.stopAnimating()
                loader.removeFromSuperview()
                self.navigationController?.popViewController(animated: true)
            }
        }
        task.resume()
    }
    
}
