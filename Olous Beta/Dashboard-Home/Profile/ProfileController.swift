//
//  ProfileController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class ProfileController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    var user : User!
    
    
    var settingButton = UIImageView()
    
    let settingsView = UIView()
    var viewHeightOfSettingsView: CGFloat {
        return view.frame.height / 2
    }
    var isSettingsViewVisible = false
    
    var settingsContentView = UIView()
    
    
    let containerView = UIView()
    let scrollView = UIScrollView()
    
    
    var headerView = UIView()
    
    let profileCircle = UIView()
    var profileImageView : UIImageView!
    
    let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Ajay Sarkate"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()
    let jobTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.textColor = UIColor(hex: "#475467")
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    let locationLabel : UILabel = {
        let label = UILabel()
        label.text = "Pune, Maharashtra"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    
    var contactInfoView = UIView()
    var emailLabel : UILabel!
    var mobileLabel : UILabel!
    
    
    var headlineView = UIView()
    let headlineLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "#475467")
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let summaryLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 7
        label.textColor = UIColor(hex: "#475467")
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var empView = UIView()
    
    
    var projectView = UIView()
    
    
    var educationView = UIView()
    
    
    var softwareView = UIView()
    
    
    var skillsView = UIView()
    
    
    var personalInfoView = UIView()
    
    
    var preferenceView = UIView()
    
    
    
//   ******************************  New changes in this controller **************************************************************
    
    var employmentCV : UICollectionView!
    var empDataArray : [Employment] = []
    var employmentCVHeightConstraint: NSLayoutConstraint!
    
    var empEditView : UIView!
    var editExpTitleTF : UITextField!
    var editExpCompanyTF : UITextField!
    var editYearsOfExpTF : UITextField!
    var editExpPeriodTF : UITextField!
    var empSaveButton: UIButton!
    var empCancelButton: UIButton!
    
    
    var educationCV : UICollectionView!
    var eduDataArray : [Education] = []
    var educationCVHeightConstraint: NSLayoutConstraint!
    
    var eduEditView : UIView!
    var editEducationTF : UITextField!
    var editCollegeTF : UITextField!
    var editPassYearTF : UITextField!
    var editMarksTF : UITextField!
    var eduSaveButton: UIButton!
    var eduCancelButton: UIButton!
    
    
    var projectCV : UICollectionView!
    var projectDataArray : [Project] = []
    var projectCVHeightConstraint: NSLayoutConstraint!
    
    var projectEditView: UIScrollView!
    var editProjectNameTF: UITextField!
    var editProjectRoleTF: UITextField!
    var editProjectDescTextview: UITextView!
    var editProjectRespTextview: UITextView!
    var projectSaveButton: UIButton!
    var projectCancelButton: UIButton!
    
    var projectDescLoader: LoadingView!
    var projectRespLoader: LoadingView!
    
    var generateButton2 : UIButton!
    var generateButton3 : UIButton!
    
    
    var softwaresArray : [String] = []
    var skillsArray : [String] = []
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        
//        fetchUserProfile()
//        DispatchQueue.main.async {
//            self.setupViews()
//        }
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserProfile()
    }
    
    
    deinit {
        // Unregister from keyboard notifications
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let activeTextField = UIResponder.currentFirstResponder as? UITextView else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let textFieldFrame = activeTextField.convert(activeTextField.bounds, to: self.view)
        let textFieldBottomY = textFieldFrame.maxY
        
        let visibleHeight = self.view.frame.height - keyboardHeight
        if textFieldBottomY > visibleHeight {
            let offset = textFieldBottomY - visibleHeight + 20
            self.view.frame.origin.y = -offset
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    
    
    func setupViews() {
        setupTitleAndSettingButton()
        
        setupScrollView()
        
        setupSettingsView()
        
        setupHeaderView()
        
        setupContactInfo()
        
        setupHeadline()
        
        setupEmploymentView()
        setupEmpEditView()
        
        setupProjectView()
        setupProjectEditView()
        setupLoaderForProjectEdit()
        
        setupEducationView()
        setupEducationEditView()
        
        setupSoftwares()
        
        setupSkills()
        
        setupPersonalInfoView()
        
        setupPreferencesView()
        
        DispatchQueue.main.async {
            self.updateScrollViewContentSize()
        }
    }
    
    
    private func setupTitleAndSettingButton() {
        
        let companiesLabel = UILabel()
        companiesLabel.text = "My  Profile"
        companiesLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        companiesLabel.textAlignment = .center
        companiesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(companiesLabel)
        
        NSLayoutConstraint.activate([
            companiesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            companiesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
        
        
        // Settings Button Setup
        
        settingButton.image = UIImage(systemName: "line.3.horizontal")?.withTintColor(UIColor(hex: "#667085"))
        settingButton.tintColor = UIColor(hex: "#667085")
        settingButton.isUserInteractionEnabled = true
        
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingButton)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSettingsButton))
        settingButton.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            settingButton.widthAnchor.constraint(equalToConstant: 25),
            settingButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func didTapSettingsButton() {
        toggleSettingsView()
    }
    
    
    func setupScrollView() {
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: settingButton.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
            
        // Constraints for scrollView
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    
    
    private func setupSettingsView() {
        // Settings View Setup
        settingsView.backgroundColor = UIColor(hex: "#EFEFF1")
        view.addSubview(settingsView)
        
        // Initially position the settings view below the visible area
        settingsView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: viewHeightOfSettingsView)
        settingsView.layer.cornerRadius = 20
        
        // Add swipe gesture to dismiss the settings view
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
        swipeDownGesture.direction = .down
        settingsView.addGestureRecognizer(swipeDownGesture)
        
        setupSettingsContentView()
    }
    
    @objc private func handleSwipeDown(_ gesture: UISwipeGestureRecognizer) {
        if isSettingsViewVisible {
            toggleSettingsView()
        }
    }
    
    private func toggleSettingsView() {
        isSettingsViewVisible.toggle()
        UIView.animate(withDuration: 0.36) {
            // show settingsView
            if self.isSettingsViewVisible {
                self.settingsView.frame.origin.y = self.view.frame.height - self.viewHeightOfSettingsView
                self.scrollView.isUserInteractionEnabled = false
                self.containerView.alpha = 0.2
                self.containerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
                if let tabBar = self.tabBarController?.tabBar {
                    tabBar.frame = CGRect(
                        x: tabBar.frame.origin.x,
                        y: self.view.frame.size.height,
                        width: tabBar.frame.size.width,
                        height: tabBar.frame.size.height
                    )
                }
            }
            // hide settingsView
            else {
                self.settingsView.frame.origin.y = self.view.frame.height
                self.scrollView.isUserInteractionEnabled = true
                self.containerView.alpha = 1
                self.containerView.backgroundColor = .systemBackground
                if let tabBar = self.tabBarController?.tabBar {
                    tabBar.frame = CGRect(
                        x: tabBar.frame.origin.x,
                        y: self.view.frame.size.height - tabBar.frame.size.height,
                        width: tabBar.frame.size.width,
                        height: tabBar.frame.size.height
                    )
                }
            }
        }
    }
    
    
    func setupSettingsContentView() {
        settingsContentView.backgroundColor = .white
        settingsContentView.layer.cornerRadius = 16
        settingsContentView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addSubview(settingsContentView)
        
        NSLayoutConstraint.activate([
            settingsContentView.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 20),
            settingsContentView.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 16),
            settingsContentView.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -16),
            settingsContentView.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor)
        ])
        
        setupChangePassword()
        setupPrivacyPolicy()
        setupTermsOfService()
        setupLogout()
    }
    
    
    func setupChangePassword() {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock.circle")?.withTintColor(UIColor(hex: "#667085"))
        imageView.tintColor = UIColor(hex: "#667085")
        imageView.isUserInteractionEnabled = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        settingsContentView.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapChangePassword))
        imageView.addGestureRecognizer(tap)
        
        let label = UILabel()
        label.text = "Change Password"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#667085")
        label.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(didTapChangePassword))
        label.addGestureRecognizer(tap2)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        settingsContentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: settingsContentView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 26),
            imageView.heightAnchor.constraint(equalToConstant: 26),
            
            label.topAnchor.constraint(equalTo: settingsContentView.topAnchor, constant: 24),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
        ])
    }
    
    @objc func didTapChangePassword() {
        let alertController = UIAlertController(title: "Change Password", message: "Are you sure you want to change password?", preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            // Perform the logout operation
            UserDefaults.standard.removeObject(forKey: "accessToken")
            UserDefaults.standard.synchronize() // To ensure the accessToken is removed
            
            self.goToResetPasswordScreens()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel)

        alertController.addAction(yesAction)
        alertController.addAction(noAction)

        present(alertController, animated: true)
    }
    
    func goToResetPasswordScreens(){
        guard let email = user.email, !email.isEmpty else {
            showAlert(withTitle: "Input Error", message: "Email cannot be empty.")
            return
        }

        let url = URL(string: "\(Config.serverURL)/api/v1/auth/send-reset-password-otp")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["email": email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to send OTP: \(error?.localizedDescription ?? "No error description")")
                return
            }
            
            defer {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    spinner.stopAnimating()
                    spinner.removeFromSuperview()
                }
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("OTP sent successfully")
                
                DispatchQueue.main.async {
                    let vc = ForgotPassOTP()
                    vc.emailLabel.text = email
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                print("Failed to send OTP with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
        }.resume()
    }
    
    
    func setupPrivacyPolicy() {
        let line = UIView()
        line.backgroundColor = UIColor(hex: "#667085")
        line.translatesAutoresizingMaskIntoConstraints = false
        settingsContentView.addSubview(line)
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.shield")?.withTintColor(UIColor(hex: "#667085"))
        imageView.tintColor = UIColor(hex: "#667085")
        imageView.isUserInteractionEnabled = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        settingsContentView.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapPrivacyPolicy))
        imageView.addGestureRecognizer(tap)
        
        let label = UILabel()
        label.text = "Privacy policy"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#667085")
        label.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(didTapPrivacyPolicy))
        label.addGestureRecognizer(tap2)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        settingsContentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: settingsContentView.topAnchor, constant: 60),
            line.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: -16),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            imageView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 14),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 27),
            
            label.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 14),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
        ])
    }
    
    @objc func didTapPrivacyPolicy() {
        guard let url = URL(string: "https://olous.app/privacy") else {
            print("Invalid URL")
            return
        }
        UIApplication.shared.open(url)
    }
    
    
    func setupTermsOfService() {
        let line = UIView()
        line.backgroundColor = UIColor(hex: "#667085")
        line.translatesAutoresizingMaskIntoConstraints = false
        settingsContentView.addSubview(line)
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "list.star")?.withTintColor(UIColor(hex: "#667085"))
        imageView.tintColor = UIColor(hex: "#667085")
        imageView.isUserInteractionEnabled = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        settingsContentView.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapTermsOfService))
        imageView.addGestureRecognizer(tap)
        
        let label = UILabel()
        label.text = "Terms of Service"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#667085")
        label.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(didTapTermsOfService))
        label.addGestureRecognizer(tap2)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        settingsContentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: settingsContentView.topAnchor, constant: 110),
            line.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: -16),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            imageView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 26),
            
            label.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 14),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
        ])
    }
    
    @objc func didTapTermsOfService() {
        guard let url = URL(string: "https://olous.app/terms-of-services") else {
            print("Invalid URL")
            return
        }
        UIApplication.shared.open(url)
    }
    
    
    func setupLogout() {
        let line = UIView()
        line.backgroundColor = UIColor(hex: "#667085")
        line.translatesAutoresizingMaskIntoConstraints = false
        settingsContentView.addSubview(line)
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")?.withTintColor(UIColor(hex: "#667085"))
        imageView.tintColor = UIColor(hex: "#667085")
        imageView.isUserInteractionEnabled = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        settingsContentView.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLogOut))
        imageView.addGestureRecognizer(tap)
        
        let label = UILabel()
        label.text = "Log out"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#667085")
        label.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(didTapLogOut))
        label.addGestureRecognizer(tap2)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        settingsContentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: settingsContentView.topAnchor, constant: 160),
            line.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: -16),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            imageView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 18),
            imageView.widthAnchor.constraint(equalToConstant: 27),
            imageView.heightAnchor.constraint(equalToConstant: 25),
            
            label.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 14),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
        ])
    }
    
    @objc func didTapLogOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            // Perform the logout operation
            UserDefaults.standard.removeObject(forKey: "accessToken")
            UserDefaults.standard.synchronize() // To ensure the accessToken is removed
            
            let vc = LoginVC()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.isHidden = true
            self.present(navVC, animated: true)
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel)

        alertController.addAction(yesAction)
        alertController.addAction(noAction)

        present(alertController, animated: true)
    }
    
    
    
    
    
//   **************************************************************************************************************************************
    
    func setupHeaderView() {
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        headerView.layer.cornerRadius = 12
        headerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        profileCircle.backgroundColor = UIColor(hex: "#D7F0FF")
        profileCircle.layer.cornerRadius = 50
        
        profileCircle.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(profileCircle)
        NSLayoutConstraint.activate([
            profileCircle.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            profileCircle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            profileCircle.widthAnchor.constraint(equalToConstant: 100),
            profileCircle.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        
        profileImageView = UIImageView()
//        profileImageView.isHidden = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50
        
        // Add the selected image view to the profile circle
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: profileCircle.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: profileCircle.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: profileCircle.trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: profileCircle.bottomAnchor)
        ])
        
        let editProfileButton : UIButton = {
            let button = UIButton()
            button.setTitle("Edit Profile", for: .normal)
            button.tintColor = .white
            button.backgroundColor = UIColor(hex: "#2563EB")
            button.layer.cornerRadius = 12
            return button
        }()
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        
        [userNameLabel, jobTitleLabel, locationLabel, editProfileButton].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: profileCircle.topAnchor, constant: 0),
            userNameLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
//            userNameLabel.heightAnchor.constraint(equalToConstant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            jobTitleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 12),
            jobTitleLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
            jobTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            locationLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            editProfileButton.topAnchor.constraint(equalTo: profileCircle.bottomAnchor, constant: 20),
            editProfileButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            editProfileButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            editProfileButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func didTapEditProfileButton() {
        let vc = EditProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setupContactInfo() {
        contactInfoView.layer.borderWidth = 1
        contactInfoView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        contactInfoView.layer.cornerRadius = 12
        
        contactInfoView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contactInfoView)
        
        let profileEditButton : UIButton = {
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
        profileEditButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        profileEditButton.translatesAutoresizingMaskIntoConstraints = false
        contactInfoView.addSubview(profileEditButton)
        
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Contact Info"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        contactInfoView.addSubview(label)
        
        let mailIcon : UIImageView = UIImageView()
        mailIcon.image = UIImage(systemName: "envelope")
        mailIcon.tintColor = UIColor(hex: "#98A2B3")
        mailIcon.translatesAutoresizingMaskIntoConstraints = false
        contactInfoView.addSubview(mailIcon)
        
        let email = createStaticLabel()
        email.text = "Email"
        contactInfoView.addSubview(email)
        emailLabel = createDynamicLabel()
        emailLabel.numberOfLines = 2
        contactInfoView.addSubview(emailLabel)
        
        let phoneIcon : UIImageView = UIImageView()
        phoneIcon.image = UIImage(systemName: "phone")
        phoneIcon.tintColor = UIColor(hex: "#98A2B3")
        phoneIcon.translatesAutoresizingMaskIntoConstraints = false
        contactInfoView.addSubview(phoneIcon)
        
        let mobile = createStaticLabel()
        mobile.text = "Phone"
        contactInfoView.addSubview(mobile)
        mobileLabel = createDynamicLabel()
        contactInfoView.addSubview(mobileLabel)
        
        NSLayoutConstraint.activate([
            contactInfoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            contactInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contactInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contactInfoView.heightAnchor.constraint(equalToConstant: 200),
            
            profileEditButton.topAnchor.constraint(equalTo: contactInfoView.topAnchor, constant: 10),
            profileEditButton.trailingAnchor.constraint(equalTo: contactInfoView.trailingAnchor, constant: -16),
            profileEditButton.widthAnchor.constraint(equalToConstant: 36),
            profileEditButton.heightAnchor.constraint(equalToConstant: 36),
            
            label.topAnchor.constraint(equalTo: contactInfoView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: contactInfoView.leadingAnchor, constant: 20),
            
            mailIcon.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            mailIcon.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            
            email.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            email.leadingAnchor.constraint(equalTo: mailIcon.trailingAnchor, constant: 10),
            
            emailLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: contactInfoView.trailingAnchor, constant: -10),
            
            phoneIcon.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            phoneIcon.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            
            mobile.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            mobile.leadingAnchor.constraint(equalTo: phoneIcon.trailingAnchor, constant: 10),
            
            mobileLabel.topAnchor.constraint(equalTo: mobile.bottomAnchor, constant: 10),
            mobileLabel.leadingAnchor.constraint(equalTo: mobile.leadingAnchor),
            mobileLabel.trailingAnchor.constraint(equalTo: contactInfoView.trailingAnchor, constant: -10),
        ])
    }
    
    
    func setupHeadline() {
        headlineView.layer.borderWidth = 1
        headlineView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        headlineView.layer.cornerRadius = 12
        
        headlineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(headlineView)
        
        let profileEditButton : UIButton = {
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
        profileEditButton.addTarget(self, action: #selector(didTapEditHeadlineButton), for: .touchUpInside)
        profileEditButton.translatesAutoresizingMaskIntoConstraints = false
        headlineView.addSubview(profileEditButton)
        
        
        let headline : UILabel = {
            let label = UILabel()
            label.text = "Headline"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        headlineView.addSubview(headline)
        
        headlineView.addSubview(headlineLabel)
        
        let summary : UILabel = {
            let label = UILabel()
            label.text = "Summary"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        headlineView.addSubview(summary)
        
        headlineView.addSubview(summaryLabel)
        
        let viewMore = UIButton()
        viewMore.setTitle("View more", for: .normal)
        viewMore.setTitleColor(UIColor(hex: "#2563EB"), for: .normal)
        viewMore.addTarget(self, action: #selector(didTapEditHeadlineButton), for: .touchUpInside)
        
        viewMore.translatesAutoresizingMaskIntoConstraints = false
        headlineView.addSubview(viewMore)
        
        NSLayoutConstraint.activate([
            headlineView.topAnchor.constraint(equalTo: contactInfoView.bottomAnchor, constant: 20),
            headlineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headlineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            profileEditButton.topAnchor.constraint(equalTo: headlineView.topAnchor, constant: 10),
            profileEditButton.trailingAnchor.constraint(equalTo: headlineView.trailingAnchor, constant: -16),
            profileEditButton.widthAnchor.constraint(equalToConstant: 36),
            profileEditButton.heightAnchor.constraint(equalToConstant: 36),
            
            headline.topAnchor.constraint(equalTo: headlineView.topAnchor, constant: 20),
            headline.leadingAnchor.constraint(equalTo: headlineView.leadingAnchor, constant: 20),
            
            headlineLabel.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 10),
            headlineLabel.leadingAnchor.constraint(equalTo: headline.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: headlineView.trailingAnchor, constant: -10),
            
            summary.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 20),
            summary.leadingAnchor.constraint(equalTo: headlineView.leadingAnchor, constant: 20),
            
            summaryLabel.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: 10),
            summaryLabel.leadingAnchor.constraint(equalTo: summary.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: headlineView.trailingAnchor, constant: -10),
            
            viewMore.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 2),
            viewMore.trailingAnchor.constraint(equalTo: summaryLabel.trailingAnchor),
            viewMore.widthAnchor.constraint(equalToConstant: 100),
            
            headlineView.bottomAnchor.constraint(equalTo: viewMore.bottomAnchor, constant: 10)
        ])
        
        
    }
    
    @objc func didTapEditHeadlineButton() {
        let vc = HeadlineEditVC()
        vc.resume = headlineLabel.text
        vc.summary = summaryLabel.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setupEmploymentView() {
        empView.layer.borderWidth = 1
        empView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        empView.layer.cornerRadius = 12
        
        empView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(empView)
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Employment"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        empView.addSubview(label)
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Add", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            return btn
        }()
        addButton.addTarget(self, action: #selector(didTapAddEmployment), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        empView.addSubview(addButton)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        employmentCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        employmentCV.register(EmploymentCell.self, forCellWithReuseIdentifier: "exp")
        employmentCV.delegate = self
        employmentCV.dataSource = self
        
        employmentCV.translatesAutoresizingMaskIntoConstraints = false
        empView.addSubview(employmentCV)
        
        employmentCVHeightConstraint = employmentCV.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        employmentCVHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            empView.topAnchor.constraint(equalTo: headlineView.bottomAnchor, constant: 20),
            empView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            empView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: empView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: empView.leadingAnchor, constant: 20),
            
            addButton.topAnchor.constraint(equalTo: empView.topAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            
            employmentCV.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            employmentCV.leadingAnchor.constraint(equalTo: empView.leadingAnchor, constant: 20),
            employmentCV.trailingAnchor.constraint(equalTo: empView.trailingAnchor, constant: -20),
            
            empView.bottomAnchor.constraint(equalTo: employmentCV.bottomAnchor, constant: 20)
        ])
    }
    
    func reloadEmploymentsCollectionView() {
        employmentCV.reloadData()
       
        let contentSize = employmentCV.collectionViewLayout.collectionViewContentSize
        employmentCVHeightConstraint.constant = contentSize.height
        
        employmentCV.layoutIfNeeded()
        updateScrollViewContentSize()
        
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
    }
    @objc func deleteEmpCell(_ sender : UIButton) {
        guard let cell = sender.superview as? EmploymentCell, // Adjust the number of superviews according to your cell's hierarchy
            let indexPath = employmentCV.indexPath(for: cell)
        else {
            return
        }
        
        // Call the confirmation alert
        askUserConfirmation(title: "Delete Employment", message: "Are you sure you want to delete this item?") {
            // This closure is executed if the user confirms
            self.empDataArray.remove(at: indexPath.row)
            
            // Perform batch updates for animation
            self.employmentCV.performBatchUpdates({
                self.employmentCV.deleteItems(at: [indexPath])
            }, completion: { _ in
                self.reloadEmploymentsCollectionView()
            })
            
            // Assume uploadEmploymentArray() syncs data with a server or updates the local storage
            self.uploadEmploymentArray()
        }
    }
    
    func setupEmpEditView() {
        // Initialize and configure editView
        empEditView = UIView()
        empEditView.backgroundColor = .white
        empEditView.layer.cornerRadius = 12
        empEditView.layer.shadowOpacity = 0.25
        empEditView.layer.shadowRadius = 5
        empEditView.layer.shadowOffset = CGSize(width: 0, height: 2)
        empEditView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(empEditView)
        
        // Set initial off-screen position
        NSLayoutConstraint.activate([
            empEditView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            empEditView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            empEditView.heightAnchor.constraint(equalToConstant: view.frame.height),
            empEditView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)  // Top of editView to the bottom of the main view
        ])

        // Setup text fields and labels
        let labelsTitles = ["Designation", "Company", "Years of Experience", "Employment Period"]
        let textFields = [UITextField(), UITextField(), UITextField(), UITextField()]
        var lastBottomAnchor = empEditView.topAnchor
        
        for (index, title) in labelsTitles.enumerated() {
            let label = UILabel()
            label.text = title
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            empEditView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: lastBottomAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: empEditView.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: empEditView.trailingAnchor, constant: -20)
            ])
            
            let textField = textFields[index]
            textField.borderStyle = .roundedRect
            textField.placeholder = "Enter \(title)"
            textField.translatesAutoresizingMaskIntoConstraints = false
            empEditView.addSubview(textField)
            
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                textField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: label.trailingAnchor)
            ])
            
            lastBottomAnchor = textField.bottomAnchor
        }
        
        editExpTitleTF = textFields[0]
        editExpTitleTF.delegate = self
        editExpCompanyTF = textFields[1]
        editExpCompanyTF.delegate = self
        editYearsOfExpTF = textFields[2]
        editYearsOfExpTF.delegate = self
        editExpPeriodTF = textFields[3]
        editExpPeriodTF.delegate = self
        
        // Setup buttons
        empSaveButton = UIButton(type: .system)
        empSaveButton.setTitle("Save", for: .normal)
        empSaveButton.titleLabel?.font = .systemFont(ofSize: 20)
        empSaveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        empSaveButton.backgroundColor = UIColor(hex: "#0079C4")
        empSaveButton.layer.cornerRadius = 8
        empSaveButton.addTarget(self, action: #selector(saveEmpChanges), for: .touchUpInside)
        
        
        
        empCancelButton = UIButton(type: .system)
        empCancelButton.setTitle("Cancel", for: .normal)
        empCancelButton.titleLabel?.font = .systemFont(ofSize: 20)
        empCancelButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        empCancelButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        empCancelButton.layer.borderWidth = 1
        empCancelButton.layer.cornerRadius = 8
        empCancelButton.addTarget(self, action: #selector(cancelEmpEdit), for: .touchUpInside)
        
        
        empSaveButton.translatesAutoresizingMaskIntoConstraints = false
        empCancelButton.translatesAutoresizingMaskIntoConstraints = false
        empEditView.addSubview(empSaveButton)
        empEditView.addSubview(empCancelButton)
        
        NSLayoutConstraint.activate([
//            saveButton.bottomAnchor.constraint(equalTo: editView.bottomAnchor, constant: -60),
            empSaveButton.topAnchor.constraint(equalTo: editExpPeriodTF.bottomAnchor, constant: 20),
            empSaveButton.trailingAnchor.constraint(equalTo: empEditView.trailingAnchor, constant: -20),
            empSaveButton.widthAnchor.constraint(equalToConstant: 80),
            empSaveButton.heightAnchor.constraint(equalToConstant: 40),
            
            empCancelButton.bottomAnchor.constraint(equalTo: empSaveButton.bottomAnchor),
            empCancelButton.leadingAnchor.constraint(equalTo: empEditView.leadingAnchor, constant: 20),
            empCancelButton.widthAnchor.constraint(equalToConstant: 80),
            empCancelButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    @objc func saveEmpChanges() {
        // Attempt to get the selected index path, if any
        let selectedIndexPath = employmentCV.indexPathsForSelectedItems?.first
        
        // Ensure all fields are non-empty
        guard let companyName = editExpCompanyTF.text, !companyName.isEmpty,
              let yearsOfExperience = editYearsOfExpTF.text, !yearsOfExperience.isEmpty,
              let employmentDesignation = editExpTitleTF.text, !employmentDesignation.isEmpty,
              let employmentPeriod = editExpPeriodTF.text, !employmentPeriod.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields")
            return
        }
        
        // Create the employment object
        let newEmployment = Employment(companyName: companyName, yearsOfExperience: yearsOfExperience,
                                       employmentDesignation: employmentDesignation, employmentPeriod: employmentPeriod,
                                       employmentType: "") // Assuming employmentType is optional or handled elsewhere

        if let indexPath = selectedIndexPath {
            // Update the existing item in the data array
            empDataArray[indexPath.row] = newEmployment
            employmentCV.reloadItems(at: [indexPath])
        } else {
            // Add new item to the data array
            empDataArray.append(newEmployment)
            employmentCV.insertItems(at: [IndexPath(row: empDataArray.count - 1, section: 0)])
            reloadEmploymentsCollectionView()
        }
        
        uploadEmploymentArray()
        cancelEmpEdit()
    }
    
    var totalExperience : Double!
    
    func uploadEmploymentArray() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/update-by-resume") else {
            print("Invalid URL for updating resume")
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not found")
            return
        }
        
        guard let experienceArray = empDataArray as? [Employment], !experienceArray.isEmpty else {
            print("Employment data array is empty or not properly cast.")
            return
        }

        guard let jsonData = encodeEmploymentArray(experienceArray: experienceArray, totalExperience: totalExperience ?? 0) else {
            print("Failed to encode employment data")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response from server: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if httpResponse.statusCode == 200 {
                print("Data successfully uploaded")
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Server response: \(responseString)")
                }
            } else {
                print("Failed to upload data, status code: \(httpResponse.statusCode)")
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response details: \(responseString)")
                }
            }
        }.resume()
    }
    
    func encodeEmploymentArray(experienceArray: [Employment], totalExperience: Double) -> Data? {
        guard let firstDesignation = experienceArray.first?.employmentDesignation else {
            print("No employment designation available in the first item of the array.")
            return nil
        }

        let employmentData = EmploymentData(
            experience: experienceArray,
            designation: firstDesignation,
            totalExperience: "\(totalExperience)"
        )

        do {
            let jsonData = try JSONEncoder().encode(employmentData)
            return jsonData
        } catch {
            print("Error encoding employment data to JSON: \(error)")
            return nil
        }
    }

    @objc func cancelEmpEdit() {
        editExpTitleTF.text = ""
        editExpCompanyTF.text = ""
        editYearsOfExpTF.text = ""
        editExpPeriodTF.text = ""
        UIView.animate(withDuration: 0.3) {
            self.empEditView.transform = .identity
            if let tabBar = self.tabBarController?.tabBar {
                tabBar.frame = CGRect(
                    x: tabBar.frame.origin.x,
                    y: self.view.frame.size.height - tabBar.frame.size.height,
                    width: tabBar.frame.size.width,
                    height: tabBar.frame.size.height
                )
            }
        }
    }
    
    @objc func didTapAddEmployment() {
        UIView.animate(withDuration: 0.3) {
            self.empEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)
            if let tabBar = self.tabBarController?.tabBar {
                tabBar.frame = CGRect(
                    x: tabBar.frame.origin.x,
                    y: self.view.frame.size.height,
                    width: tabBar.frame.size.width,
                    height: tabBar.frame.size.height
                )
            }
        }
    }
    
    
    
    
    
    func setupProjectView() {
        projectView.layer.borderWidth = 1
        projectView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        projectView.layer.cornerRadius = 12
        
        projectView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(projectView)
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Project"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        projectView.addSubview(label)
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Add", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            return btn
        }()
        addButton.addTarget(self, action: #selector(didTapAddProject), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        projectView.addSubview(addButton)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        projectCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        projectCV.register(ProjectCell.self, forCellWithReuseIdentifier: "project")
        projectCV.delegate = self
        projectCV.dataSource = self
        
        projectCV.translatesAutoresizingMaskIntoConstraints = false
        projectView.addSubview(projectCV)
        
        NSLayoutConstraint.activate([
            projectView.topAnchor.constraint(equalTo: empView.bottomAnchor, constant: 20),
            projectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            projectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: projectView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: projectView.leadingAnchor, constant: 20),
            
            addButton.topAnchor.constraint(equalTo: projectView.topAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            
            projectCV.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            projectCV.leadingAnchor.constraint(equalTo: projectView.leadingAnchor, constant: 20),
            projectCV.trailingAnchor.constraint(equalTo: projectView.trailingAnchor, constant: -20),
            
            projectView.bottomAnchor.constraint(equalTo: projectCV.bottomAnchor, constant: 20)
        ])
        
        projectCVHeightConstraint = projectCV.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        projectCVHeightConstraint.isActive = true
    }
    
    func reloadProjectCollectionView() {
        projectCV.reloadData()
        
        let contentSize = projectCV.collectionViewLayout.collectionViewContentSize
        projectCVHeightConstraint.constant = contentSize.height
        
        projectCV.layoutIfNeeded()
        updateScrollViewContentSize()
        
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
    }
    
    @objc func deleteProjectCell(_ sender : UIButton) {
        guard let cell = sender.superview as? ProjectCell, // Adjust the number of superviews according to your cell's hierarchy
            let indexPath = projectCV.indexPath(for: cell)
        else {
            return
        }
        
        askUserConfirmation(title: "Delete Item", message: "Are you sure you want to delete this item?") {
            // This closure is executed if the user confirms
            self.projectDataArray.remove(at: indexPath.row)
            self.projectCV.performBatchUpdates({
                self.projectCV.deleteItems(at: [indexPath])
            }, completion: { _ in
                self.reloadProjectCollectionView()
            })
            self.uploadProjectDataArray()
        }
    }
    
    @objc func didTapAddProject() {
        UIView.animate(withDuration: 0.3) {
            self.projectEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)  
            if let tabBar = self.tabBarController?.tabBar {
                tabBar.frame = CGRect(
                    x: tabBar.frame.origin.x,
                    y: self.view.frame.size.height,
                    width: tabBar.frame.size.width,
                    height: tabBar.frame.size.height
                )
            }
        }
    }
    
    func setupProjectEditView() {
        // Initialize and configure editView
        projectEditView = UIScrollView()
        projectEditView.contentSize = CGSize(width: view.bounds.width, height: view.frame.height + 100)
        projectEditView.backgroundColor = .white
        projectEditView.layer.cornerRadius = 12
        projectEditView.layer.shadowOpacity = 0.25
        projectEditView.layer.shadowRadius = 5
        projectEditView.layer.shadowOffset = CGSize(width: 0, height: 2)
        projectEditView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(projectEditView)

        // Set initial off-screen position
        NSLayoutConstraint.activate([
            projectEditView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            projectEditView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            projectEditView.heightAnchor.constraint(equalToConstant: view.frame.height),
            projectEditView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)  // Top of editView to the bottom of the main view
        ])

        // Setup text fields and text views along with labels
        let labelsTitles = ["Project Name", "Role", "Description", "Responsibility"]
        let controls = [UITextField(), UITextField(), UITextView(), UITextView()]
        var lastBottomAnchor = projectEditView.topAnchor
        
        for (index, title) in labelsTitles.enumerated() {
            let label = UILabel()
            label.text = title
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            projectEditView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: lastBottomAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: projectEditView.leadingAnchor, constant: 16)
            ])
            
            let control = controls[index]
            control.translatesAutoresizingMaskIntoConstraints = false
            projectEditView.addSubview(control)
            
            if let textField = control as? UITextField {
                textField.borderStyle = .roundedRect
                textField.placeholder = "Enter \(title)"
                NSLayoutConstraint.activate([
                    textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                    textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
                ])
                lastBottomAnchor = textField.bottomAnchor
            } else if let textView = control as? UITextView {
                textView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
                textView.layer.borderWidth = 1.0
                textView.layer.cornerRadius = 5
                textView.font = .systemFont(ofSize: 14)
                textView.isScrollEnabled = true  // Enable scrolling for larger content
                NSLayoutConstraint.activate([
                    textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
                    textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//                    textView.heightAnchor.constraint(equalToConstant: 120)  // Fixed height for UITextView
                ])
                if index == 2 {
                    textView.heightAnchor.constraint(equalToConstant: 120).isActive = true
                }
                if index == 3 {
                    textView.heightAnchor.constraint(equalToConstant: 180).isActive = true
                }
                lastBottomAnchor = textView.bottomAnchor
                
                let generateButton = createGenerateButton()
                
                projectEditView.addSubview(generateButton)
                NSLayoutConstraint.activate([
                    generateButton.topAnchor.constraint(equalTo: label.topAnchor, constant: -3),
                    generateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    generateButton.heightAnchor.constraint(equalToConstant: 36),
                    generateButton.widthAnchor.constraint(equalToConstant: 180),
                ])
                
                if index == 2 {
                    generateButton2 = generateButton
                    generateButton2.addTarget(self, action: #selector(generateDescription), for: .touchUpInside)
                } else if index == 3 {
                    generateButton3 = generateButton
                    generateButton3.addTarget(self, action: #selector(generateResponsibility), for: .touchUpInside)
                }
            }
            
            if index == 0 {
                editProjectNameTF = control as? UITextField
                editProjectNameTF.delegate = self
            } else if index == 1 {
                editProjectRoleTF = control as? UITextField
                editProjectRoleTF.delegate = self
            } else if index == 2 {
                editProjectDescTextview = control as? UITextView
                editProjectDescTextview.addDoneButtonOnKeyboard()
            } else if index == 3 {
                editProjectRespTextview = control as? UITextView
                editProjectRespTextview.addDoneButtonOnKeyboard()
            }
        }

        setupSaveAndCancelButtons()  // A separate method for setting up buttons
    }
    
    func setupSaveAndCancelButtons() {
        projectSaveButton = UIButton(type: .system)
        projectSaveButton.setTitle("Save", for: .normal)
        projectSaveButton.titleLabel?.font = .systemFont(ofSize: 20)
        projectSaveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        projectSaveButton.backgroundColor = UIColor(hex: "#0079C4")
        projectSaveButton.layer.cornerRadius = 8
        projectSaveButton.addTarget(self, action: #selector(saveProjectChanges), for: .touchUpInside)
        
        
        
        projectCancelButton = UIButton(type: .system)
        projectCancelButton.setTitle("Cancel", for: .normal)
        projectCancelButton.titleLabel?.font = .systemFont(ofSize: 20)
        projectCancelButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        projectCancelButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        projectCancelButton.layer.borderWidth = 1
        projectCancelButton.layer.cornerRadius = 8
        projectCancelButton.addTarget(self, action: #selector(cancelProjectEdit), for: .touchUpInside)
        
        // Layout
        projectSaveButton.translatesAutoresizingMaskIntoConstraints = false
        projectCancelButton.translatesAutoresizingMaskIntoConstraints = false
        projectEditView.addSubview(projectSaveButton)
        projectEditView.addSubview(projectCancelButton)
        
        NSLayoutConstraint.activate([
            projectSaveButton.bottomAnchor.constraint(equalTo: editProjectRespTextview.bottomAnchor, constant: 60),
            projectSaveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            projectSaveButton.widthAnchor.constraint(equalToConstant: 80),
            projectSaveButton.heightAnchor.constraint(equalToConstant: 40),
            
            projectCancelButton.bottomAnchor.constraint(equalTo: projectSaveButton.bottomAnchor),
            projectCancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            projectCancelButton.widthAnchor.constraint(equalToConstant: 80),
            projectCancelButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    func createGenerateButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(" Generate content", for: .normal)
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.tintColor = UIColor(hex: "#0079C4")
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    private func setupLoaderForProjectEdit() {
        projectDescLoader = LoadingView()
        projectDescLoader.isHidden = true
        projectDescLoader.layer.cornerRadius = 20
        
        projectDescLoader.translatesAutoresizingMaskIntoConstraints = false
        projectEditView.addSubview(projectDescLoader)
        
        let imgView = UIImageView()
        imgView.image = UIImage(named: "AISymbol")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        projectDescLoader.addSubview(imgView)
        
        let label = UILabel()
        label.text = "Project description is being generated..."
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        projectDescLoader.addSubview(label)
        
        NSLayoutConstraint.activate([
            projectDescLoader.centerXAnchor.constraint(equalTo: editProjectDescTextview.centerXAnchor),
            projectDescLoader.centerYAnchor.constraint(equalTo: editProjectDescTextview.centerYAnchor),
            projectDescLoader.widthAnchor.constraint(equalToConstant: 300),
            projectDescLoader.heightAnchor.constraint(equalToConstant: 80),
            
            imgView.centerYAnchor.constraint(equalTo: projectDescLoader.centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: projectDescLoader.leadingAnchor, constant: 16),
            imgView.heightAnchor.constraint(equalToConstant: 40),
            imgView.widthAnchor.constraint(equalToConstant: 40),
            
            label.centerYAnchor.constraint(equalTo: projectDescLoader.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: projectDescLoader.trailingAnchor, constant: -16)
        ])
        
        projectDescLoader.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = projectDescLoader.bounds

        let color1 = UIColor(hex: "#5825EB").withAlphaComponent(0.11).cgColor
        let color2 = UIColor(hex: "#DB7F14").withAlphaComponent(0.11).cgColor
        
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: gradientLayer.bounds, cornerRadius: 20)
        maskLayer.path = path.cgPath
        
        // Apply the mask to the gradient layer
        gradientLayer.mask = maskLayer
        
        projectDescLoader.layer.insertSublayer(gradientLayer, at: 0)
        
        
        
        projectRespLoader = LoadingView()
        projectRespLoader.isHidden = true
        projectRespLoader.layer.cornerRadius = 20
        
        projectRespLoader.translatesAutoresizingMaskIntoConstraints = false
        projectEditView.addSubview(projectRespLoader)
        
        let imgView2 = UIImageView()
        imgView2.image = UIImage(named: "AISymbol")
        imgView2.translatesAutoresizingMaskIntoConstraints = false
        projectRespLoader.addSubview(imgView2)
        
        let label2 = UILabel()
        label2.text = "Projects responsibility is being generated..."
        label2.font = .boldSystemFont(ofSize: 20)
        label2.numberOfLines = 2
        label2.textAlignment = .center
        label2.translatesAutoresizingMaskIntoConstraints = false
        projectRespLoader.addSubview(label2)
        
        NSLayoutConstraint.activate([
            projectRespLoader.centerXAnchor.constraint(equalTo: editProjectRespTextview.centerXAnchor),
            projectRespLoader.centerYAnchor.constraint(equalTo: editProjectRespTextview.centerYAnchor),
            projectRespLoader.widthAnchor.constraint(equalToConstant: 300),
            projectRespLoader.heightAnchor.constraint(equalToConstant: 80),
            
            imgView2.centerYAnchor.constraint(equalTo: projectRespLoader.centerYAnchor),
            imgView2.leadingAnchor.constraint(equalTo: projectRespLoader.leadingAnchor, constant: 16),
            imgView2.heightAnchor.constraint(equalToConstant: 40),
            imgView2.widthAnchor.constraint(equalToConstant: 40),
            
            label2.centerYAnchor.constraint(equalTo: projectRespLoader.centerYAnchor),
            label2.leadingAnchor.constraint(equalTo: imgView2.trailingAnchor, constant: 10),
            label2.trailingAnchor.constraint(equalTo: projectRespLoader.trailingAnchor, constant: -16)
        ])
        
        projectRespLoader.layoutIfNeeded()
        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame = projectRespLoader.bounds

        let color12 = UIColor(hex: "#5825EB").withAlphaComponent(0.11).cgColor
        let color22 = UIColor(hex: "#DB7F14").withAlphaComponent(0.11).cgColor
        
        gradientLayer2.colors = [color12, color22]
        gradientLayer2.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer2.endPoint = CGPoint(x: 1, y: 0)
        
        let maskLayer2 = CAShapeLayer()
        let path2 = UIBezierPath(roundedRect: gradientLayer2.bounds, cornerRadius: 20)
        maskLayer2.path = path2.cgPath
        
        // Apply the mask to the gradient layer
        gradientLayer2.mask = maskLayer2
        
        projectRespLoader.layer.insertSublayer(gradientLayer2, at: 0)
    }

    @objc func generateDescription() {
        if let text = editProjectNameTF.text, let text2 = editProjectRoleTF.text, text != "", text2 != "" {
            fetchContentAndUpdateTextView(forURL: "\(Config.serverURL)/api/v1/user/candidate/project-description",
                                          withText: text, updateTextView: editProjectDescTextview)
        }
        else {
            showAlert(withTitle: "Missing Information", message: "Please add project name and role first")
        }
    }

    @objc func generateResponsibility() {
        if let text = editProjectNameTF.text, let text2 = editProjectRoleTF.text, text != "", text2 != "" {
            fetchContentAndUpdateTextView(forURL: "\(Config.serverURL)/api/v1/user/candidate/project-responsibility",
                                          withText: text, updateTextView: editProjectRespTextview)
        }
        else {
            showAlert(withTitle: "Missing Information", message: "Please add project name and role first")
        }
    }
    
    func fetchContentAndUpdateTextView(forURL urlString: String, withText text: String, updateTextView textView: UITextView) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        if textView == editProjectDescTextview {
            DispatchQueue.main.async {
                self.editProjectDescTextview.text = ""
                self.generateButton2.isUserInteractionEnabled = false
                self.projectDescLoader.isHidden = false
                self.projectDescLoader.startAnimating()  // Start the loader before the request
            }
        }
        if textView == editProjectRespTextview {
            DispatchQueue.main.async {
                self.editProjectRespTextview.text = ""
                self.generateButton3.isUserInteractionEnabled = false
                self.projectRespLoader.isHidden = false
                self.projectRespLoader.startAnimating()  // Start the loader before the request
            }
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["inputText": text]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        // Include accessToken for Authorization if needed
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if textView == self.editProjectDescTextview {
                DispatchQueue.main.async {
                    self.generateButton2.isUserInteractionEnabled = true
                    self.projectDescLoader.isHidden = true
                    self.projectDescLoader.stopAnimating()
                }
            }
            if textView == self.editProjectRespTextview {
                DispatchQueue.main.async {
                    self.generateButton3.isUserInteractionEnabled = true
                    self.projectRespLoader.isHidden = true
                    self.projectRespLoader.stopAnimating()
                }
            }
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let responseString = String(data: data, encoding: .utf8) {
                if textView == self.editProjectDescTextview {
                    DispatchQueue.main.async {
                        var s = responseString
                        if s.hasPrefix("\"") {
                            s = String(s.dropFirst().dropLast())
                        }
                        textView.text = s  // Update the UITextView on the main thread
                    }
                }
                if textView == self.editProjectRespTextview {
                    DispatchQueue.main.async {
                        let components = responseString.components(separatedBy: "\n-").map { line -> String in
                            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                            return trimmedLine.hasPrefix("---") ? String(trimmedLine.dropFirst(2)) : trimmedLine
                        }

                        let cleanedArray = components.map { string -> String in
                            if let index = string.firstIndex(of: " ") {
                                return String(string[index...].dropFirst())
                            } else {
                                return string
                            }
                        }

                        var finalString = cleanedArray.joined(separator: "")
                        
                        finalString = finalString.replacingOccurrences(of: "\\n-", with: "\n\n ") //•
                        finalString = finalString.replacingOccurrences(of: "\\n", with: "\n  ")
                        finalString = String(finalString.dropLast())
                        
                        
                        textView.text = finalString
                    }
                }
            }
        }.resume()
    }

    @objc func saveProjectChanges() {
        // Attempt to get the selected index path, if any
        let selectedIndexPath = projectCV.indexPathsForSelectedItems?.first
        
        // Ensure all fields are non-empty
        guard let name = editProjectNameTF.text, !name.isEmpty,
              let role = editProjectRoleTF.text, !role.isEmpty,
              let desc = editProjectDescTextview.text, !desc.isEmpty,
              let resp = editProjectRespTextview.text, !resp.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields")
            return
        }
        
        // Create the project object
        let newProject = Project(projectName: name, role: role, responsibility: resp, description: desc)
        
        if let indexPath = selectedIndexPath {
            // Update the existing item in the data array
            projectDataArray[indexPath.row] = newProject
            projectCV.reloadItems(at: [indexPath])
        } else {
            // Add new item to the data array
            projectDataArray.append(newProject)
            projectCV.insertItems(at: [IndexPath(row: projectDataArray.count - 1, section: 0)])
            reloadProjectCollectionView()
        }
        
        uploadProjectDataArray()
        cancelProjectEdit()
    }
    
    func uploadProjectDataArray() {
        // upload to server
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let projectsData = ["projects": projectDataArray]
            let jsonData = try JSONEncoder().encode(projectsData)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode projects to JSON: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Failed to upload projects, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Projects successfully uploaded.")
            } else {
                print("Failed to upload projects, status code: \(httpResponse.statusCode)")
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Server response: \(responseString)")
            }
            if let error = error {
                print("Error uploading projects: \(error.localizedDescription)")
            }
            
        }.resume()
    }

    @objc func cancelProjectEdit() {
        editProjectNameTF.text = ""
        editProjectRoleTF.text = ""
        editProjectDescTextview.text = ""
        editProjectRespTextview.text = ""
        UIView.animate(withDuration: 0.3) {
            self.projectEditView.transform = .identity
            if let tabBar = self.tabBarController?.tabBar {
                tabBar.frame = CGRect(
                    x: tabBar.frame.origin.x,
                    y: self.view.frame.size.height - tabBar.frame.size.height,
                    width: tabBar.frame.size.width,
                    height: tabBar.frame.size.height
                )
            }
        }
    }
    
    
    
    
    
    func setupEducationView() {
        educationView.layer.borderWidth = 1
        educationView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        educationView.layer.cornerRadius = 12
        
        educationView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(educationView)
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Education"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        educationView.addSubview(label)
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Add", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            return btn
        }()
        addButton.addTarget(self, action: #selector(didTapAddEducation), for: .touchUpInside)
        educationView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        educationCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        educationCV.register(EducationCell.self, forCellWithReuseIdentifier: "edu")
        educationCV.delegate = self
        educationCV.dataSource = self
        
        educationCV.translatesAutoresizingMaskIntoConstraints = false
        educationView.addSubview(educationCV)
        
        NSLayoutConstraint.activate([
            educationView.topAnchor.constraint(equalTo: projectView.bottomAnchor, constant: 20),
            educationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            educationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: educationView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: educationView.leadingAnchor, constant: 20),
            
            addButton.topAnchor.constraint(equalTo: educationView.topAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            
            educationCV.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            educationCV.leadingAnchor.constraint(equalTo: educationView.leadingAnchor, constant: 20),
            educationCV.trailingAnchor.constraint(equalTo: educationView.trailingAnchor, constant: -20),
            
            educationView.bottomAnchor.constraint(equalTo: educationCV.bottomAnchor, constant: 20)
        ])
        
        educationCVHeightConstraint = educationCV.heightAnchor.constraint(equalToConstant: 0) // Initial height
        educationCVHeightConstraint.isActive = true
    }
    
    func reloadEducationCollectionView() {
        educationCV.reloadData()
        
        let contentSize = educationCV.collectionViewLayout.collectionViewContentSize
        educationCVHeightConstraint.constant = contentSize.height
        
        educationCV.layoutIfNeeded()
        updateScrollViewContentSize()
        
//        UIView.animate(withDuration: 0.3) {
//            self.scrollView.layoutIfNeeded()
//            self.view.layoutIfNeeded()
//        }
    }
    
    func setupEducationEditView() {
        // Initialize and configure editView
        eduEditView = UIView()
        eduEditView.backgroundColor = .white
        eduEditView.layer.cornerRadius = 12
        eduEditView.layer.shadowOpacity = 0.25
        eduEditView.layer.shadowRadius = 5
        eduEditView.layer.shadowOffset = CGSize(width: 0, height: 2)
        eduEditView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(eduEditView)
        
        // Set initial off-screen position
        NSLayoutConstraint.activate([
            eduEditView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eduEditView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eduEditView.heightAnchor.constraint(equalToConstant: view.frame.height),
            eduEditView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)  // Top of editView to the bottom of the main view
        ])

        // Setup text fields and labels
        let labelsTitles = ["Education", "College", "Passing Year", "Marks Obtained"]
        let textFields = [UITextField(), UITextField(), UITextField(), UITextField()]
        var lastBottomAnchor = eduEditView.topAnchor
        
        for (index, title) in labelsTitles.enumerated() {
            let label = UILabel()
            label.text = title
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            eduEditView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: lastBottomAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: eduEditView.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: eduEditView.trailingAnchor, constant: -20)
            ])
            
            let textField = textFields[index]
            textField.borderStyle = .roundedRect
            textField.placeholder = "Enter \(title)"
            textField.translatesAutoresizingMaskIntoConstraints = false
            eduEditView.addSubview(textField)
            
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                textField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: label.trailingAnchor)
            ])
            
            lastBottomAnchor = textField.bottomAnchor
        }
        
        editEducationTF = textFields[0]
        editEducationTF.delegate = self
        editCollegeTF = textFields[1]
        editCollegeTF.delegate = self
        editPassYearTF = textFields[2]
        editPassYearTF.keyboardType = .numberPad
        editPassYearTF.addDoneButtonOnKeyboard()
        editMarksTF = textFields[3]
        editMarksTF.keyboardType = .decimalPad
        editMarksTF.addDoneButtonOnKeyboard()
        
        // Setup buttons
        eduSaveButton = UIButton(type: .system)
        eduSaveButton.setTitle("Save", for: .normal)
        eduSaveButton.titleLabel?.font = .systemFont(ofSize: 20)
        eduSaveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        eduSaveButton.backgroundColor = UIColor(hex: "#0079C4")
        eduSaveButton.layer.cornerRadius = 8
        eduSaveButton.addTarget(self, action: #selector(saveEduChanges), for: .touchUpInside)
        
        
        
        eduCancelButton = UIButton(type: .system)
        eduCancelButton.setTitle("Cancel", for: .normal)
        eduCancelButton.titleLabel?.font = .systemFont(ofSize: 20)
        eduCancelButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        eduCancelButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        eduCancelButton.layer.borderWidth = 1
        eduCancelButton.layer.cornerRadius = 8
        eduCancelButton.addTarget(self, action: #selector(cancelEduEdit), for: .touchUpInside)
        
        
        eduSaveButton.translatesAutoresizingMaskIntoConstraints = false
        eduCancelButton.translatesAutoresizingMaskIntoConstraints = false
        eduEditView.addSubview(eduSaveButton)
        eduEditView.addSubview(eduCancelButton)
        
        NSLayoutConstraint.activate([
            eduSaveButton.bottomAnchor.constraint(equalTo: editMarksTF.bottomAnchor, constant: 60),
            eduSaveButton.trailingAnchor.constraint(equalTo: eduEditView.trailingAnchor, constant: -20),
            eduSaveButton.widthAnchor.constraint(equalToConstant: 80),
            eduSaveButton.heightAnchor.constraint(equalToConstant: 40),
            
            eduCancelButton.bottomAnchor.constraint(equalTo: eduSaveButton.bottomAnchor),
            eduCancelButton.leadingAnchor.constraint(equalTo: eduEditView.leadingAnchor, constant: 20),
            eduCancelButton.widthAnchor.constraint(equalToConstant: 80),
            eduCancelButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    @objc func saveEduChanges() {
        // Attempt to get the selected index path, if any
        let selectedIndexPath = educationCV.indexPathsForSelectedItems?.first
        
        // Ensure all fields are non-empty
        guard let educationName = editEducationTF.text, !educationName.isEmpty,
              let yearOfPassing = editPassYearTF.text, !yearOfPassing.isEmpty,
              let boardOrUniversity = editCollegeTF.text, !boardOrUniversity.isEmpty,
              let marks = editMarksTF.text, !marks.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields before saving.")
            return
        }
        
        // Create the education object
        let newEducation = Education(educationName: educationName,
                                     yearOfPassing: yearOfPassing,
                                     boardOrUniversity: boardOrUniversity,
                                     marksObtained: marks)  // Modify according to your data model if necessary
        
        if let indexPath = selectedIndexPath {
            // Update the existing item in the data array
            eduDataArray[indexPath.row] = newEducation
            educationCV.reloadItems(at: [indexPath])
        } else {
            // Add new item to the data array
            eduDataArray.append(newEducation)
            educationCV.insertItems(at: [IndexPath(row: eduDataArray.count - 1, section: 0)])
            reloadEducationCollectionView()
        }
        
        uploadEducationArray()
        cancelEduEdit()
    }
    
    func uploadEducationArray() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not found")
            return
        }
        
        
        
        let educationDictionary = ["education": eduDataArray]
        var jsonData: Data? = nil
        do {
            jsonData = try JSONEncoder().encode(educationDictionary)
        } catch {
            print("Error encoding dataArray to JSON: \(error)")
        }
        
//        guard let jsonData = encodeEducationArray() else {
//            print("Failed to encode education data")
//            return
//        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization") // Replace `accessToken` with your actual token
        request.httpBody = jsonData
        

        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response from server: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if httpResponse.statusCode == 200 {
//                print("Data successfully uploaded")
//                if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                    print("Server response: \(responseString)")
//                }
            } else {
                print("Failed to upload data, status code: \(httpResponse.statusCode)")
                print(data , error)
            }
            
        }.resume()
    }

    @objc func cancelEduEdit() {
        editEducationTF.text = ""
        editCollegeTF.text = ""
        editPassYearTF.text = ""
        editMarksTF.text = ""
        UIView.animate(withDuration: 0.3) {
            self.eduEditView.transform = .identity
            if let tabBar = self.tabBarController?.tabBar {
                tabBar.frame = CGRect(
                    x: tabBar.frame.origin.x,
                    y: self.view.frame.size.height - tabBar.frame.size.height,
                    width: tabBar.frame.size.width,
                    height: tabBar.frame.size.height
                )
            }
        }
    }
    
    @objc func deleteEduCell(_ sender : UIButton) {
        guard let cell = sender.superview as? EducationCell, // Adjust the number of superviews according to your cell's hierarchy
            let indexPath = educationCV.indexPath(for: cell)
        else {
            return
        }
        
        // Call the confirmation alert
        askUserConfirmation(title: "Delete Education", message: "Are you sure you want to delete this item?") {
            // This closure is executed if the user confirms
            self.eduDataArray.remove(at: indexPath.row)
            
            // Perform batch updates for animation
            self.educationCV.performBatchUpdates({
                self.educationCV.deleteItems(at: [indexPath])
            }, completion: { _ in
                self.reloadEducationCollectionView()
            })
            
            // Assume uploadEducationArray() syncs data with a server or updates the local storage
            self.uploadEducationArray()
        }
    }
    
    @objc func didTapAddEducation() {
        UIView.animate(withDuration: 0.3) {
            self.eduEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)
            if let tabBar = self.tabBarController?.tabBar {
                tabBar.frame = CGRect(
                    x: tabBar.frame.origin.x,
                    y: self.view.frame.size.height,
                    width: tabBar.frame.size.width,
                    height: tabBar.frame.size.height
                )
            }
        }
    }
    
    
    
    
    
    func setupSoftwares() {
        softwareView.layer.borderWidth = 1
        softwareView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        softwareView.layer.cornerRadius = 12
        
        softwareView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(softwareView)
        
        NSLayoutConstraint.activate([
            softwareView.topAnchor.constraint(equalTo: educationView.bottomAnchor, constant: 20),
            softwareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            softwareView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func addLabelsInSoftwares() {
        if let existingHeightConstraint = softwareView.constraints.first(where: { $0.firstAttribute == .height }) {
            existingHeightConstraint.isActive = false
        }
        for subview in softwareView.subviews {
            subview.removeFromSuperview()
        }
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Softwares"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        softwareView.addSubview(label)
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Add", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        addButton.addTarget(self, action: #selector(didTapEditSoftwares), for: .touchUpInside)
        softwareView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: softwareView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: softwareView.leadingAnchor, constant: 20),
            
            addButton.topAnchor.constraint(equalTo: softwareView.topAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        
        var currentX: CGFloat = 20
        var currentY: CGFloat = 60
        let spacing: CGFloat = 10
        let maxWidth: CGFloat = view.bounds.width - 72  // Adjust for left and right padding
        
        for string in softwaresArray {
            let label = PaddedLabel()
            label.text = string
            label.font = .systemFont(ofSize: 16)
            label.backgroundColor = .white
            label.textColor = UIColor(hex: "#475467")
            label.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            
            // Ensure the label fits the text with padding
            let labelSize = label.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
            
            // Check if the label fits in the current line
            if currentX + labelSize.width > maxWidth {
                // Move to the next line
                currentX = 20
                currentY += labelSize.height + spacing
            }
            
            label.frame = CGRect(origin: CGPoint(x: currentX, y: currentY), size: labelSize)
            softwareView.addSubview(label)
            
            // Update currentX to the next position
            currentX += labelSize.width + spacing
        }
        // Calculate new height
        let newHeight = currentY + 28
        
        // Create and activate the new height constraint
        let newHeightConstraint = softwareView.heightAnchor.constraint(equalToConstant: newHeight + 20)
        newHeightConstraint.isActive = true
        
        softwareView.setNeedsLayout()
        softwareView.layoutIfNeeded()
        
//        if newHeight > 250 {
//            let contentHeight = containerView.contentSize.height + 200
//            containerView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
//        }
//        if newHeight > 500 {
//            let contentHeight = containerView.contentSize.height + 500
//            containerView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
//        }
    }
    
    @objc func didTapEditSoftwares() {
        let vc = EditSoftwareVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func setupSkills() {
        skillsView.layer.borderWidth = 1
        skillsView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        skillsView.layer.cornerRadius = 12
        
        skillsView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(skillsView)
        
        NSLayoutConstraint.activate([
            skillsView.topAnchor.constraint(equalTo: softwareView.bottomAnchor, constant: 20),
            skillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func addLabelsInSkills() {
        
        if let existingHeightConstraint = skillsView.constraints.first(where: { $0.firstAttribute == .height }) {
            existingHeightConstraint.isActive = false
        }
        for subview in skillsView.subviews {
            subview.removeFromSuperview()
        }
        
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Skills"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        skillsView.addSubview(label)
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Add", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        addButton.addTarget(self, action: #selector(didTapEditSkills), for: .touchUpInside)
        skillsView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: skillsView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: skillsView.leadingAnchor, constant: 20),
            
            addButton.topAnchor.constraint(equalTo: skillsView.topAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        
        var currentX: CGFloat = 20
        var currentY: CGFloat = 60
        let spacing: CGFloat = 10
        let maxWidth: CGFloat = view.bounds.width - 32  // Adjust for left and right padding
        
        for string in skillsArray {
            let label = PaddedLabel()
            label.text = string
            label.font = .systemFont(ofSize: 16)
            label.backgroundColor = .white
            label.textColor = UIColor(hex: "#475467")
            label.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            
            // Ensure the label fits the text with padding
            let labelSize = label.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
            
            // Check if the label fits in the current line
            if currentX + labelSize.width > maxWidth {
                // Move to the next line
                currentX = 20
                currentY += labelSize.height + spacing
            }
            
            label.frame = CGRect(origin: CGPoint(x: currentX, y: currentY), size: labelSize)
            skillsView.addSubview(label)
            
            // Update currentX to the next position
            currentX += labelSize.width + spacing
        }
        
        // Calculate new height
        let newHeight = currentY + 28
        
        // Create and activate the new height constraint
        let newHeightConstraint = skillsView.heightAnchor.constraint(equalToConstant: newHeight + 20)
        newHeightConstraint.isActive = true
        
        skillsView.setNeedsLayout()
        skillsView.layoutIfNeeded()
        
//        print("New Height : " , newHeight)
//        if newHeight > 250 {
//            let contentHeight = containerView.contentSize.height + 200
//            containerView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
//        }
//        if newHeight > 500 {
//            let contentHeight = containerView.contentSize.height + 500
//            containerView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
//        }
    }
    
    @objc func didTapEditSkills() {
        let vc = EditSkillVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
    var dobLabel : UILabel!
    var nationalityLabel : UILabel!
    var genderLabel : UILabel!
    var permanentAddressLabel : UILabel!
    var currentAddressLabel : UILabel!
    var stateLabel : UILabel!
    var cityLabel : UILabel!
    var pincodeLabel : UILabel!
    var uidLabel : UILabel!
    var passportLabel : UILabel!
    var pancardLabel : UILabel!
    var languageLabel : UILabel!
    
    func setupPersonalInfoView() {
        personalInfoView.layer.borderWidth = 1
        personalInfoView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        personalInfoView.layer.cornerRadius = 12
        
        personalInfoView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(personalInfoView)
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Personal Info"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        personalInfoView.addSubview(label)
        
        let editButton : UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "pencil"), for: .normal)
            button.adjustsImageSizeForAccessibilityContentSizeCategory = true
            button.tintColor = UIColor(hex: "#667085")
            button.backgroundColor = .systemBackground
            button.layer.cornerRadius = 20
            button.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
            button.layer.borderWidth = 1
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        editButton.addTarget(self, action: #selector(didTapPersonalInfoEditButton), for: .touchUpInside)
        
        personalInfoView.addSubview(editButton)
        
        NSLayoutConstraint.activate([
            personalInfoView.topAnchor.constraint(equalTo: skillsView.bottomAnchor, constant: 20),
            personalInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            personalInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: personalInfoView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: personalInfoView.leadingAnchor, constant: 20),
            
            editButton.topAnchor.constraint(equalTo: personalInfoView.topAnchor, constant: 10),
            editButton.trailingAnchor.constraint(equalTo: personalInfoView.trailingAnchor, constant: -20),
            editButton.widthAnchor.constraint(equalToConstant: 36),
            editButton.heightAnchor.constraint(equalToConstant: 36),
        ])
        
        var dob = createStaticLabel()
        dob.text = "Date of Birth"
        personalInfoView.addSubview(dob)
        dobLabel = createDynamicLabel()
        personalInfoView.addSubview(dobLabel)
        
        var nationality = createStaticLabel()
        nationality.text = "Nationality"
        personalInfoView.addSubview(nationality)
        nationalityLabel = createDynamicLabel()
        personalInfoView.addSubview(nationalityLabel)
        
        var gender = createStaticLabel()
        gender.text = "Gender"
        personalInfoView.addSubview(gender)
        genderLabel = createDynamicLabel()
        personalInfoView.addSubview(genderLabel)
        
        var permanent = createStaticLabel()
        permanent.text = "Permanent Address"
        personalInfoView.addSubview(permanent)
        permanentAddressLabel = createDynamicLabel()
        permanentAddressLabel.numberOfLines = 0
        personalInfoView.addSubview(permanentAddressLabel)
        
        var current = createStaticLabel()
        current.text = "Current Address"
        personalInfoView.addSubview(current)
        currentAddressLabel = createDynamicLabel()
        currentAddressLabel.numberOfLines = 0
        personalInfoView.addSubview(currentAddressLabel)
        
        var state = createStaticLabel()
        state.text = "State"
        personalInfoView.addSubview(state)
        stateLabel = createDynamicLabel()
        stateLabel.numberOfLines = 0
        personalInfoView.addSubview(stateLabel)
        
        var city = createStaticLabel()
        city.text = "City"
        personalInfoView.addSubview(city)
        cityLabel = createDynamicLabel()
        personalInfoView.addSubview(cityLabel)
        
        var pin = createStaticLabel()
        pin.text = "Pin Code"
        personalInfoView.addSubview(pin)
        pincodeLabel = createDynamicLabel()
        personalInfoView.addSubview(pincodeLabel)
        
        var uid = createStaticLabel()
        uid.text = "UID Number"
        personalInfoView.addSubview(uid)
        uidLabel = createDynamicLabel()
        personalInfoView.addSubview(uidLabel)
        
        var passport = createStaticLabel()
        passport.text = "Passport Number"
        personalInfoView.addSubview(passport)
        passportLabel = createDynamicLabel()
        personalInfoView.addSubview(passportLabel)
        
        var pan = createStaticLabel()
        pan.text = "PanCard Number"
        personalInfoView.addSubview(pan)
        pancardLabel = createDynamicLabel()
        personalInfoView.addSubview(pancardLabel)
        
        var lang = createStaticLabel()
        lang.text = "Languages"
        personalInfoView.addSubview(lang)
        languageLabel = createDynamicLabel()
        languageLabel.numberOfLines = 0
        personalInfoView.addSubview(languageLabel)
        
        
        NSLayoutConstraint.activate([
            dob.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            dob.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            dob.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dobLabel.topAnchor.constraint(equalTo: dob.bottomAnchor, constant: 10),
            dobLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            nationality.topAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 20),
            nationality.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            nationalityLabel.topAnchor.constraint(equalTo: nationality.bottomAnchor, constant: 10),
            nationalityLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            gender.topAnchor.constraint(equalTo: nationalityLabel.bottomAnchor, constant: 20),
            gender.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            genderLabel.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 10),
            genderLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            permanent.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20),
            permanent.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            permanentAddressLabel.topAnchor.constraint(equalTo: permanent.bottomAnchor, constant: 10),
            permanentAddressLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            permanentAddressLabel.trailingAnchor.constraint(equalTo: dob.trailingAnchor),
            
            current.topAnchor.constraint(equalTo: permanentAddressLabel.bottomAnchor, constant: 20),
            current.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            currentAddressLabel.topAnchor.constraint(equalTo: current.bottomAnchor, constant: 10),
            currentAddressLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            currentAddressLabel.trailingAnchor.constraint(equalTo: dob.trailingAnchor),
            
            state.topAnchor.constraint(equalTo: currentAddressLabel.bottomAnchor, constant: 20),
            state.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            stateLabel.topAnchor.constraint(equalTo: state.bottomAnchor, constant: 10),
            stateLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            city.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 20),
            city.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            cityLabel.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 10),
            cityLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            pin.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            pin.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            pincodeLabel.topAnchor.constraint(equalTo: pin.bottomAnchor, constant: 10),
            pincodeLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            uid.topAnchor.constraint(equalTo: pincodeLabel.bottomAnchor, constant: 20),
            uid.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            uidLabel.topAnchor.constraint(equalTo: uid.bottomAnchor, constant: 10),
            uidLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            passport.topAnchor.constraint(equalTo: uidLabel.bottomAnchor, constant: 20),
            passport.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            passportLabel.topAnchor.constraint(equalTo: passport.bottomAnchor, constant: 10),
            passportLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            pan.topAnchor.constraint(equalTo: passportLabel.bottomAnchor, constant: 20),
            pan.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            pancardLabel.topAnchor.constraint(equalTo: pan.bottomAnchor, constant: 10),
            pancardLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            lang.topAnchor.constraint(equalTo: pancardLabel.bottomAnchor, constant: 20),
            lang.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            languageLabel.topAnchor.constraint(equalTo: lang.bottomAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            languageLabel.trailingAnchor.constraint(equalTo: dob.trailingAnchor),
            
            personalInfoView.bottomAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func didTapPersonalInfoEditButton(gesture: UITapGestureRecognizer) {
        let vc = EditPersonalInfoVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

    
    
    
    var portfolioLabel : UILabel!
    var currCtcLabel : UILabel!
    var expectedCtcLabel : UILabel!
    var noticePeriodLabel : UILabel!
    var willingToRelocate : UILabel!
    var currentlyEmployed : UILabel!
    var worktypeLabel : UILabel!
    
    func setupPreferencesView() {
        preferenceView.layer.borderWidth = 1
        preferenceView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        preferenceView.layer.cornerRadius = 12
        
        preferenceView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(preferenceView)
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "Preferences"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        preferenceView.addSubview(label)
        
        let editButton : UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "pencil"), for: .normal)
            button.adjustsImageSizeForAccessibilityContentSizeCategory = true
            button.tintColor = UIColor(hex: "#667085")
            button.backgroundColor = .systemBackground
            button.layer.cornerRadius = 20
            button.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
            button.layer.borderWidth = 1
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        editButton.addTarget(self, action: #selector(didTapEditPreferencesButton), for: .touchUpInside)
        preferenceView.addSubview(editButton)
        
        NSLayoutConstraint.activate([
            preferenceView.topAnchor.constraint(equalTo: personalInfoView.bottomAnchor, constant: 20),
            preferenceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            preferenceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: preferenceView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: preferenceView.leadingAnchor, constant: 20),
            
            editButton.topAnchor.constraint(equalTo: preferenceView.topAnchor, constant: 10),
            editButton.trailingAnchor.constraint(equalTo: preferenceView.trailingAnchor, constant: -20),
            editButton.widthAnchor.constraint(equalToConstant: 36),
            editButton.heightAnchor.constraint(equalToConstant: 36),
        ])
        
        
        var pfLabel = createStaticLabel()
        pfLabel.text = "Portfolio Link"
        preferenceView.addSubview(pfLabel)
        
        portfolioLabel = createDynamicLabel()
        portfolioLabel.numberOfLines = 0
        preferenceView.addSubview(portfolioLabel)
        
        var ccLabel = createStaticLabel()
        ccLabel.text = "Current CTC"
        preferenceView.addSubview(ccLabel)
        
        currCtcLabel = createDynamicLabel()
        containerView.addSubview(currCtcLabel)
        
        var ecLabel = createStaticLabel()
        ecLabel.text = "Expected CTC"
        preferenceView.addSubview(ecLabel)
        
        expectedCtcLabel = createDynamicLabel()
        preferenceView.addSubview(expectedCtcLabel)
        
        var npLabel = createStaticLabel()
        npLabel.text = "Notice Period"
        preferenceView.addSubview(npLabel)
        noticePeriodLabel = createDynamicLabel()
        preferenceView.addSubview(noticePeriodLabel)
        
        
        var wtrLabel = createStaticLabel()
        wtrLabel.text = "Willing to Relocate"
        preferenceView.addSubview(wtrLabel)
        willingToRelocate = createDynamicLabel()
        preferenceView.addSubview(willingToRelocate)
        
        var ceLabel = createStaticLabel()
        ceLabel.text = "Currently Employed"
        preferenceView.addSubview(ceLabel)
        currentlyEmployed = createDynamicLabel()
        preferenceView.addSubview(currentlyEmployed)
        
        var pwtLabel = createStaticLabel()
        pwtLabel.text = "Preferred Work Type"
        preferenceView.addSubview(pwtLabel)
        worktypeLabel = createDynamicLabel()
        preferenceView.addSubview(worktypeLabel)
        
        NSLayoutConstraint.activate([
            pfLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            pfLabel.leadingAnchor.constraint(equalTo: preferenceView.leadingAnchor, constant: 20),
            portfolioLabel.topAnchor.constraint(equalTo: pfLabel.bottomAnchor, constant: 10),
            portfolioLabel.leadingAnchor.constraint(equalTo: pfLabel.leadingAnchor),
            portfolioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            ccLabel.topAnchor.constraint(equalTo: portfolioLabel.bottomAnchor, constant: 20),
            ccLabel.leadingAnchor.constraint(equalTo: pfLabel.leadingAnchor),
            currCtcLabel.topAnchor.constraint(equalTo: ccLabel.bottomAnchor, constant: 10),
            currCtcLabel.leadingAnchor.constraint(equalTo: ccLabel.leadingAnchor),
            
            ecLabel.topAnchor.constraint(equalTo: currCtcLabel.bottomAnchor, constant: 20),
            ecLabel.leadingAnchor.constraint(equalTo: ccLabel.leadingAnchor),
            expectedCtcLabel.topAnchor.constraint(equalTo: ecLabel.bottomAnchor, constant: 10),
            expectedCtcLabel.leadingAnchor.constraint(equalTo: ecLabel.leadingAnchor),
            
            npLabel.topAnchor.constraint(equalTo: expectedCtcLabel.bottomAnchor, constant: 20),
            npLabel.leadingAnchor.constraint(equalTo: ecLabel.leadingAnchor),
            noticePeriodLabel.topAnchor.constraint(equalTo: npLabel.bottomAnchor, constant: 10),
            noticePeriodLabel.leadingAnchor.constraint(equalTo: npLabel.leadingAnchor),
            
            wtrLabel.topAnchor.constraint(equalTo: noticePeriodLabel.bottomAnchor, constant: 20),
            wtrLabel.leadingAnchor.constraint(equalTo:noticePeriodLabel.leadingAnchor),
            willingToRelocate.topAnchor.constraint(equalTo: wtrLabel.bottomAnchor, constant: 10),
            willingToRelocate.leadingAnchor.constraint(equalTo: wtrLabel.leadingAnchor),
            
            ceLabel.topAnchor.constraint(equalTo: willingToRelocate.bottomAnchor, constant: 20),
            ceLabel.leadingAnchor.constraint(equalTo: wtrLabel.leadingAnchor),
            currentlyEmployed.topAnchor.constraint(equalTo: ceLabel.bottomAnchor, constant: 10),
            currentlyEmployed.leadingAnchor.constraint(equalTo: ceLabel.leadingAnchor),
            
            pwtLabel.topAnchor.constraint(equalTo: currentlyEmployed.bottomAnchor, constant: 20),
            pwtLabel.leadingAnchor.constraint(equalTo: ceLabel.leadingAnchor),
            worktypeLabel.topAnchor.constraint(equalTo: pwtLabel.bottomAnchor, constant: 10),
            worktypeLabel.leadingAnchor.constraint(equalTo: pwtLabel.leadingAnchor),
            
            preferenceView.bottomAnchor.constraint(equalTo: worktypeLabel.bottomAnchor, constant: 20)
        ])
        
        preferenceView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
    }
    
    @objc func didTapEditPreferencesButton() {
        let vc = EditPreferencesVC()
        
        vc.portfolioString = portfolioLabel.text
        vc.currCtcString = currCtcLabel.text
        vc.expCtcString = expectedCtcLabel.text
        vc.noticeString = noticePeriodLabel.text
        vc.relocateString = willingToRelocate.text
        vc.employedString = currentlyEmployed.text
        vc.workTypeString = worktypeLabel.text
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    // ******************* Common Methods ***********************************
    
    func createStaticLabel() -> UILabel {
        var label = UILabel()
        label.font =  .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#667085")
        return label
    }
    
    func createDynamicLabel() -> UILabel {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#344054")
        return label
    }

    
    func updateScrollViewContentSize() {
        containerView.layoutIfNeeded()
        view.layoutIfNeeded()
    }
    
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func askUserConfirmation(title: String, message: String, confirmedAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // 'Yes' action
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            confirmedAction()  // Perform the action passed in the closure
        }
        
        // 'No' action
        let noAction = UIAlertAction(title: "No", style: .cancel)

        alertController.addAction(yesAction)
        alertController.addAction(noAction)

        present(alertController, animated: true)
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

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}




extension ProfileController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case employmentCV:
                return empDataArray.count
            case educationCV:
                return eduDataArray.count
            case projectCV:
                return projectDataArray.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == employmentCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exp", for: indexPath) as! EmploymentCell
            let exp = empDataArray[indexPath.row]
            
            cell.titleLabel.text = exp.employmentDesignation
            cell.companyNameLabel.text = exp.companyName
            cell.noOfYearsLabel.text = "\(exp.yearsOfExperience),"
            cell.jobTypeLabel.text = exp.employmentPeriod
            
            cell.editButton.isUserInteractionEnabled = false
            cell.deleteButton.addTarget(self, action: #selector(deleteEmpCell(_:)), for: .touchUpInside)
            
//            cell.layer.borderWidth = 1
//            cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
//            cell.layer.cornerRadius = 12
            
            return cell
        }
        if collectionView == educationCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "edu", for: indexPath) as! EducationCell
            
            let edu = eduDataArray[indexPath.row]
            
            cell.educationLabel.text = edu.educationName
            cell.collegeLabel.text = edu.boardOrUniversity ?? "nil"
            cell.passYearLabel.text = "\(edu.yearOfPassing ?? "nil"),"
            let m = edu.marksObtained ?? ""
            if m.hasSuffix("%") {
                cell.courseTypeLabel.text = m
            }
            else {
                cell.courseTypeLabel.text = "\(m)%"
            }
            
            cell.editButton.isUserInteractionEnabled = false
            cell.deleteButton.addTarget(self, action: #selector(deleteEduCell(_:)), for: .touchUpInside)
            
//            cell.layer.borderWidth = 1
//            cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
//            cell.layer.cornerRadius = 12
        
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "project", for: indexPath) as! ProjectCell
            let project = projectDataArray[indexPath.row]
            
            cell.projectName.text = project.projectName
            cell.projectRole.text = project.role
            cell.projectDescription.text = project.description
            cell.projectResponsibility.text = project.responsibility
            
            cell.deleteButton.addTarget(self, action: #selector(deleteProjectCell(_:)), for: .touchUpInside)
            cell.editButton.isUserInteractionEnabled = false
            
//            cell.layer.borderWidth = 1
//            cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
//            cell.layer.cornerRadius = 12
        
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == projectCV {
            let project = projectDataArray[indexPath.row]

            let padding: CGFloat = 6 // Adjust padding as necessary
            let labelWidth = collectionView.bounds.width - (padding * 2)

            let descriptionFont = UIFont.systemFont(ofSize: 14)
            let responsibilityFont = UIFont.systemFont(ofSize: 14)
            let fixedHeightFont = UIFont.systemFont(ofSize: 18) // Assuming the single-line labels use this

            // Calculate maximum heights for the labels with limited lines
            let maxLines: CGFloat = 3
            let descriptionHeight = min(descriptionFont.lineHeight * maxLines, project.description.heightWithConstrainedWidth(width: labelWidth, font: descriptionFont))
            let responsibilityHeight = min(responsibilityFont.lineHeight * maxLines, project.responsibility.heightWithConstrainedWidth(width: labelWidth, font: responsibilityFont))

            // Add heights for the fixed single-line labels
            let fixedHeight = fixedHeightFont.lineHeight // Since they are single line, we can use line height directly

            // Calculate total height
            let totalHeight = descriptionHeight + responsibilityHeight + (fixedHeight * 2) + (padding * 3) // Adjust number of paddings as needed

            return CGSize(width: view.frame.width - 72, height: totalHeight + 90)
        }
        else if collectionView == employmentCV {
            return CGSize(width: view.frame.width - 72, height: 100)
        }
        else {
            return CGSize(width: view.frame.width - 72, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == employmentCV {
            let exp = empDataArray[indexPath.row]
            editExpTitleTF.text = exp.employmentDesignation
            editExpCompanyTF.text = exp.companyName
            editYearsOfExpTF.text = exp.yearsOfExperience
            editExpPeriodTF.text = exp.employmentPeriod
            
            UIView.animate(withDuration: 0.3) {
                self.empEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)
                if let tabBar = self.tabBarController?.tabBar {
                    tabBar.frame = CGRect(
                        x: tabBar.frame.origin.x,
                        y: self.view.frame.size.height,
                        width: tabBar.frame.size.width,
                        height: tabBar.frame.size.height
                    )
                }
            }
        }
        if collectionView == educationCV {
            let edu = eduDataArray[indexPath.row]
            editEducationTF.text = edu.educationName
            editCollegeTF.text = edu.boardOrUniversity
            editPassYearTF.text = edu.yearOfPassing
            editMarksTF.text = edu.marksObtained
            
            UIView.animate(withDuration: 0.3) {
                self.eduEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)
                if let tabBar = self.tabBarController?.tabBar {
                    tabBar.frame = CGRect(
                        x: tabBar.frame.origin.x,
                        y: self.view.frame.size.height,
                        width: tabBar.frame.size.width,
                        height: tabBar.frame.size.height
                    )
                }
            }
        }
        if collectionView == projectCV {  // projectCV
            let project = projectDataArray[indexPath.row]
            editProjectNameTF.text = project.projectName
            editProjectRoleTF.text = project.role
            editProjectDescTextview.text = project.description
            editProjectRespTextview.text = project.responsibility
            
            UIView.animate(withDuration: 0.3) {
                self.projectEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)
                if let tabBar = self.tabBarController?.tabBar {
                    tabBar.frame = CGRect(
                        x: tabBar.frame.origin.x,
                        y: self.view.frame.size.height,
                        width: tabBar.frame.size.width,
                        height: tabBar.frame.size.height
                    )
                }
            }
        }
    }
    
}


extension ProfileController { // Extension for APIs
    
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
                self.user = try JSONDecoder().decode(User.self, from: data)
//                print("User fetched: \(user)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                    self.assignValues(user: self.user)
                }
                
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }

        task.resume()
    }
    
    func assignValues(user : User) {
        let initialsOfName = self.extractInitials(from: self.user.name)
        let userName = self.user.name ?? ""
        
        DispatchQueue.main.async {
            self.userNameLabel.text = "\(userName)"
            self.jobTitleLabel.text = self.user.designation
            self.locationLabel.text = "\(self.user.currentAddress?.city ?? ""), \(self.user.currentAddress?.state ?? "")"
            
            self.fetchProfilePicture(size: "m", userID: self.user._id)
            
            self.emailLabel.text = self.user.email
            self.mobileLabel.text = self.user.mobile
            
            self.headlineLabel.text = self.user.headline
            self.summaryLabel.text = self.user.summary
            
            self.dobLabel.text = self.user.dateOfBirth
            self.nationalityLabel.text = self.user.nationality
            self.genderLabel.text = self.user.gender?.trimmingCharacters(in: .whitespaces)
            self.permanentAddressLabel.text = self.user.permanentAddress
            self.currentAddressLabel.text = self.user.currentAddress?.address
            self.stateLabel.text = self.user.currentAddress?.state
            self.cityLabel.text = self.user.currentAddress?.city
            self.pincodeLabel.text = self.user.currentAddress?.pincode
            self.uidLabel.text = self.user.uidNumber ?? "UID nil"
            self.passportLabel.text = self.user.passportNo ?? "Passport nil"
            self.pancardLabel.text = self.user.panNo ?? "PAN nil"
            
            var a : [String] = []
            for s in self.user.language! {
                a.append(s.language)
            }
            self.languageLabel.text = a.joined(separator: ", ")
            
            
            self.empDataArray = self.user.experience!
            self.reloadEmploymentsCollectionView()
            
            self.eduDataArray = self.user.education!
            self.reloadEducationCollectionView()
            
            self.projectDataArray = self.user.projects!
            self.reloadProjectCollectionView()
            
            self.totalExperience = self.user.totalExperience
            
            
            self.portfolioLabel.text = self.user.portfolio
            self.currCtcLabel.text = self.user.currentCtc
            self.expectedCtcLabel.text = self.user.expectedCtc
            DispatchQueue.main.async {
                self.noticePeriodLabel.text = self.user.noticePeriod?.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            self.willingToRelocate.text = self.user.willingToRelocate?.trimmingCharacters(in: .whitespacesAndNewlines)
            self.currentlyEmployed.text = self.user.currentlyEmployed?.trimmingCharacters(in: .whitespacesAndNewlines)
            self.worktypeLabel.text = self.user.preferredWorkType?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            self.preferenceView.layoutIfNeeded()
//                    for s in user.softwares! {
//                        self.softwaresArray.append(s)
//                    }
            
            for subview in self.softwareView.subviews {
                subview.removeFromSuperview()
            }
            self.softwaresArray = self.user.softwares!
            self.addLabelsInSoftwares()
            
            for subview in self.skillsView.subviews {
                subview.removeFromSuperview()
            }
            self.skillsArray = self.user.skills!
            self.addLabelsInSkills()
            
            self.scrollView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
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
                    // Use the image in your app, e.g., assign it to an UIImageView
                    self.profileImageView.image = image
//                    print("Image Fetched Successfully")
                } else {
                    print("Failed to decode image")
                }
            }
        }

        task.resume()
    }
    
    private func extractInitials(from name: String?) -> String {
        guard let name = name, !name.isEmpty else { return "" }
        let parts = name.split(separator: " ").map(String.init)
        let initials = parts.compactMap { $0.first }.prefix(2)
        return initials.map(String.init).joined().uppercased()
    }
}


class PaddedLabel: UILabel {
    var edgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInsets.left + edgeInsets.right,
                      height: size.height + edgeInsets.top + edgeInsets.bottom)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let sizeThatFits = super.sizeThatFits(size)
        return CGSize(width: sizeThatFits.width + edgeInsets.left + edgeInsets.right,
                      height: sizeThatFits.height + edgeInsets.top + edgeInsets.bottom)
    }
}

