//
//  EditProfileVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 15/03/24.
//

import UIKit

class EditProfileVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    let nameTextField = UITextField()
    let designationTextField = UITextField()
    let locationTextField = UITextField()
    let pinCodeTF = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground

        navigationItem.title = "Edit Profile"
        navigationItem.hidesBackButton = true
        
        let backButtonImage = UIImage(systemName: "xmark") // Change "xmark" to any system image you prefer
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        
        
        nameTextField.delegate = self
        designationTextField.delegate = self
        locationTextField.delegate = self
        pinCodeTF.delegate = self
        
        
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
        setupFullName()
        setupDesignation()
        setupLocation()
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
        
        let extraSpaceHeight: CGFloat = 50
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
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
    
    func setupFullName() {
        let fullName = UILabel()
        fullName.text = "Full Name"
        fullName.font = .systemFont(ofSize: 18)
        fullName.textColor = UIColor(hex: "#344054")
        
        fullName.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(fullName)
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
        scrollView.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            nameTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 36),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupDesignation() {
        let designation = UILabel()
        designation.text = "Designation"
        designation.font = .systemFont(ofSize: 18)
        designation.textColor = UIColor(hex: "#344054")
        
        designation.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(designation)
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
        scrollView.addSubview(designationTextField)
        NSLayoutConstraint.activate([
            designationTextField.topAnchor.constraint(equalTo: designation.bottomAnchor, constant: 8),
            designationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            designationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 36),
            designationTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupLocation() {
        let location = UILabel()
        location.text = "Current Location"
        location.font = .systemFont(ofSize: 18)
        location.textColor = UIColor(hex: "#344054")
        
        location.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(location)
        
        locationTextField.borderStyle = .roundedRect
        locationTextField.layer.borderWidth = 1
        locationTextField.layer.cornerRadius = 8
        locationTextField.layer.borderColor = UIColor(hex: "#344054").cgColor
        locationTextField.placeholder = "Pune, Maharashtra"
        locationTextField.textColor = UIColor(hex: "#344054")
        
        locationTextField.translatesAutoresizingMaskIntoConstraints =  false
        scrollView.addSubview(locationTextField)
        
        NSLayoutConstraint.activate([
            location.topAnchor.constraint(equalTo: designationTextField.bottomAnchor, constant: 16),
            location.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            locationTextField.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 8),
            locationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            locationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 36),
            locationTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let pin = UILabel()
        pin.text = "Pin Code"
        pin.font = .systemFont(ofSize: 18)
        pin.textColor = UIColor(hex: "#344054")
        
        pin.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(pin)
        
        pinCodeTF.borderStyle = .roundedRect
        pinCodeTF.layer.borderWidth = 1
        pinCodeTF.layer.cornerRadius = 8
        pinCodeTF.layer.borderColor = UIColor(hex: "#344054").cgColor
        pinCodeTF.placeholder = "Pune, Maharashtra"
        pinCodeTF.textColor = UIColor(hex: "#344054")
        pinCodeTF.keyboardType = .numberPad
        
        pinCodeTF.translatesAutoresizingMaskIntoConstraints =  false
        scrollView.addSubview(pinCodeTF)
        
        NSLayoutConstraint.activate([
            pin.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 16),
            pin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            pinCodeTF.topAnchor.constraint(equalTo: pin.bottomAnchor, constant: 8),
            pinCodeTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            pinCodeTF.widthAnchor.constraint(equalToConstant: view.frame.width - 36),
            pinCodeTF.heightAnchor.constraint(equalToConstant: 50)
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
        guard let name = nameTextField.text, !name.isEmpty,
              let designation = designationTextField.text, !designation.isEmpty,
              let address = locationTextField.text, !address.isEmpty,
              let pinCode = pinCodeTF.text, !pinCode.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields before saving.")
            return
        }
        
        let currentAddress = Address(address: address, pincode: pinCode, state: "", city: "")
        let json: [String: Any] = [
            "name": name,
            "designation": designation,
//            "currentAddress": [
//                "address": currentAddress.address,
//                "pinCode": currentAddress.pinCode
//            ]
        ]
        
        uploadProfilePicture()
        sendUpdateRequest(with: json)
        
        // Setup and start the spinner
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = view.center
        spinner.startAnimating()
        scrollView.alpha = 0.4
        view.addSubview(spinner)
        
        uploadProfilePicture()
        sendUpdateRequest(with: json)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Stop and remove the spinner
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.scrollView.alpha = 1
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func uploadProfilePicture() {
        guard let image = profileImageView.image,
              let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 800, height: 600)),
              let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        else {
            showAlert(withTitle: "Missing Information", message: "Please select a valid image before saving.")
            return
        }

        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-profile-pic") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")

        request.httpBody = createBody(boundary: boundary, data: imageData, mimeType: "image/jpeg", filename: "profile.jpg")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error in URLSession data task: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Successfully uploaded profile picture")
            } else {
                print("Failed to upload profile picture with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
        }.resume()
    }
    
    private func createBody(boundary: String, data: Data, mimeType: String, filename: String) -> Data {
        var body = Data()

        // Add the image data to the request body as binary data
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"profilePic\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)

        // End part
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
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


extension EditProfileVC {
    
    func fetchUserProfile() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/profile") else {
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
                    self.nameTextField.text = user.name
                    self.designationTextField.text = user.designation
                    self.locationTextField.text = user.currentAddress?.address
                    self.pinCodeTF.text = user.currentAddress?.pincode
                    
                    self.fetchProfilePicture(size: "m", userID: user._id)
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }

        task.resume()
    }
    
    func fetchProfilePicture(size: String, userID: String) {
        let urlString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/profile/\(size)/\(userID)"
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

    
    func sendUpdateRequest(with json: [String: Any]) {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            print("Failed to encode data to JSON: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error in URLSession data task: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Successfully updated profile")
            } else {
                print("Failed to update profile with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response JSON: \(json)")
                }
            } catch {
                print("Failed to parse response data: \(error)")
            }
        }.resume()
    }

}
