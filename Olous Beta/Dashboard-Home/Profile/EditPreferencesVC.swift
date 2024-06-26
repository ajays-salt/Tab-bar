//
//  EditPreferencesVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 21/06/24.
//

import UIKit

class EditPreferencesVC: UIViewController, UITextFieldDelegate {
    
    var portfolioString : String!
    var currCtcString : String!
    var expCtcString : String!
    var noticeString : String!
    var relocateString : String!
    var employedString : String!
    var workTypeString : String!
    
    
    let portfolioTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Portfolio link(Github, Drive etc)"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let currentCtcTextField : UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "E.g. 4"
        textField.keyboardType = .decimalPad // Numeric keypad
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addDoneButtonOnKeyboard()
        
        return textField
    }()
    let expectedCtcTextField : UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "E.g. 7.5"
        textField.keyboardType = .decimalPad // Numeric keypad
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addDoneButtonOnKeyboard()
        
        return textField
    }()
    
    // changes to fit this VC in User Profile VC
    var noticeOptionsScrollView = UIScrollView()
    var noticePeriodOptions = ["Immediate", "15 days", "1 Month", "2 Months", "3 Months" ]
    var relocateStackView = UIStackView()
    var employedStackView = UIStackView()
    var workTypeScrollView = UIScrollView()
    
    var selectedNoticeOptionsButton : UIButton?
    var selectedRelocateButton : UIButton?
    var selectedEmployedButton : UIButton?
    var selectedWorkTypeButton : UIButton?
    
    var workTypeScrollViewBottomAnchor: NSLayoutYAxisAnchor?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground

        navigationItem.title = "Edit Personal Info"
        navigationItem.hidesBackButton = true
        
        let backButtonImage = UIImage(systemName: "xmark") // Change "xmark" to any system image you prefer
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        setupUI1()
        setupUI2()
        
        setupSaveButton()
        
        portfolioTextField.delegate = self
        currentCtcTextField.delegate = self
        expectedCtcTextField.delegate = self
    }
    
    func setupUI1() {
        let portfolioLabel : UILabel = {
            let label = UILabel()
            label.text = "Portfolio Link(Architects, Interior designers)"
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let currentCtcLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Current CTC(LPA)")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let expectedCtcLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Expected CTC(LPA)")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        
        [portfolioLabel,portfolioTextField, currentCtcLabel, currentCtcTextField, expectedCtcLabel, expectedCtcTextField].forEach { v in
            view.addSubview(v)
        }
        
        portfolioTextField.text = portfolioString
        currentCtcTextField.text = currCtcString
        expectedCtcTextField.text = expCtcString
        
        NSLayoutConstraint.activate([
            portfolioLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            portfolioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            portfolioTextField.topAnchor.constraint(equalTo: portfolioLabel.bottomAnchor, constant: 10),
            portfolioTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            portfolioTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            portfolioTextField.heightAnchor.constraint(equalToConstant: 40),
            
            currentCtcLabel.topAnchor.constraint(equalTo: portfolioTextField.bottomAnchor, constant: 20),
            currentCtcLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            currentCtcTextField.topAnchor.constraint(equalTo: currentCtcLabel.bottomAnchor, constant: 10),
            currentCtcTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currentCtcTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            currentCtcTextField.heightAnchor.constraint(equalToConstant: 40),
            
            expectedCtcLabel.topAnchor.constraint(equalTo: currentCtcTextField.bottomAnchor, constant: 20),
            expectedCtcLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            expectedCtcTextField.topAnchor.constraint(equalTo: expectedCtcLabel.bottomAnchor, constant: 10),
            expectedCtcTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            expectedCtcTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            expectedCtcTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupUI2() {
        
        let noticePLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Notice Period")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        noticeOptionsScrollView.showsHorizontalScrollIndicator = false
        noticeOptionsScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the stack view for options
        let noticeOptionsStackView = UIStackView()
        noticeOptionsStackView.axis = .horizontal
        noticeOptionsStackView.spacing = 12
        noticeOptionsStackView.translatesAutoresizingMaskIntoConstraints = false
        noticeOptionsScrollView.addSubview(noticeOptionsStackView)
        
        // Add options buttons to the stack view
        var i = 1
        for option in noticePeriodOptions {
            let optionButton = UIButton(type: .system)
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            optionButton.layer.cornerRadius = 8
            optionButton.setTitle("  \(option)  ", for: .normal)
            optionButton.titleLabel?.font = .systemFont(ofSize: 18)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.addTarget(self, action: #selector(noticeOptionButtonTapped(_:)), for: .touchUpInside)
            if noticePeriodOptions[i-1] == noticeString {
                selectedNoticeOptionsButton = optionButton
                selectedNoticeOptionsButton?.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
                selectedNoticeOptionsButton?.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            }
            i = i + 1
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            noticeOptionsStackView.addArrangedSubview(optionButton)
        }
        
        view.addSubview(noticePLabel)
        view.addSubview(noticeOptionsScrollView)
        
        let relocateLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Willing To Relocate")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        
        relocateStackView.axis = .horizontal
        relocateStackView.spacing = 12
        relocateStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let relocateOptions = ["Yes", "No"]
        i = 1
        for (index, option) in relocateOptions.enumerated() {
            let button = UIButton(type: .system)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            button.layer.cornerRadius = 8
            button.setTitle("  \(option)  ", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.setTitleColor(.black, for: .normal)
            
            if relocateOptions[i-1] == relocateString {
                selectedRelocateButton = button
                selectedRelocateButton?.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
                selectedRelocateButton?.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            }
            i = i + 1
            
            button.addTarget(self, action: #selector(relocateOptionSelected(_:)), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            relocateStackView.addArrangedSubview(button)
        }
        
        view.addSubview(relocateLabel)
        view.addSubview(relocateStackView)
        
        
        let employedLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Are you currently Employed")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        
        employedStackView.axis = .horizontal
        employedStackView.spacing = 12
        employedStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let employedOptions = ["Yes", "No"]
        i = 1
        for (index, option) in employedOptions.enumerated() {
            let button = UIButton(type: .system)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            button.layer.cornerRadius = 8
            button.setTitle("  \(option)  ", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.setTitleColor(.black, for: .normal)
            
            if employedOptions[i-1] == employedString {
                selectedEmployedButton = button
                selectedEmployedButton?.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
                selectedEmployedButton?.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            }
            i = i + 1
            
            button.addTarget(self, action: #selector(employedOptionSelected(_:)), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            employedStackView.addArrangedSubview(button)
        }
        
        view.addSubview(employedLabel)
        view.addSubview(employedStackView)
        
        let workTypeLabel : UILabel = {
            let label = UILabel()
            
            let attributedText1 = NSMutableAttributedString(string: "Preferred Work Type")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let workTypeOptions = ["Office", "Home", "Office + Site", "On-Site"]
        
        
        workTypeScrollView.showsHorizontalScrollIndicator = false
        workTypeScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the stack view for options
        let workTypeStackView = UIStackView()
        workTypeStackView.axis = .horizontal
        workTypeStackView.spacing = 12
        workTypeStackView.translatesAutoresizingMaskIntoConstraints = false
        workTypeScrollView.addSubview(workTypeStackView)
        
        // Add options buttons to the stack view
        i = 1
        for option in workTypeOptions {
            let optionButton = UIButton(type: .system)
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            optionButton.layer.cornerRadius = 8
            optionButton.setTitle("  \(option)  ", for: .normal)
            optionButton.titleLabel?.font = .systemFont(ofSize: 18)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.addTarget(self, action: #selector(workTypeOptionSelected(_:)), for: .touchUpInside)
            if workTypeOptions[i-1] == workTypeString {
                selectedWorkTypeButton = optionButton
                selectedWorkTypeButton?.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
                selectedWorkTypeButton?.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            }
            i = i + 1
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            workTypeStackView.addArrangedSubview(optionButton)
        }
        
        view.addSubview(workTypeLabel)
        view.addSubview(workTypeScrollView)
        
        
        NSLayoutConstraint.activate([
            noticePLabel.topAnchor.constraint(equalTo: expectedCtcTextField.bottomAnchor, constant: 20),
            noticePLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            noticeOptionsScrollView.topAnchor.constraint(equalTo: noticePLabel.bottomAnchor, constant: 10),
            noticeOptionsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noticeOptionsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noticeOptionsScrollView.heightAnchor.constraint(equalToConstant: 40),
            
            noticeOptionsStackView.topAnchor.constraint(equalTo: noticeOptionsScrollView.topAnchor),
            noticeOptionsStackView.leadingAnchor.constraint(equalTo: noticeOptionsScrollView.leadingAnchor),
            noticeOptionsStackView.trailingAnchor.constraint(equalTo: noticeOptionsScrollView.trailingAnchor),
            noticeOptionsStackView.heightAnchor.constraint(equalToConstant: 40),
            
            relocateLabel.topAnchor.constraint(equalTo: noticeOptionsScrollView.bottomAnchor, constant: 20),
            relocateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            relocateStackView.topAnchor.constraint(equalTo: relocateLabel.bottomAnchor, constant: 10),
            relocateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            employedLabel.topAnchor.constraint(equalTo: relocateStackView.bottomAnchor, constant: 20),
            employedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            employedStackView.topAnchor.constraint(equalTo: employedLabel.bottomAnchor, constant: 10),
            employedStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            workTypeLabel.topAnchor.constraint(equalTo: employedStackView.bottomAnchor, constant: 20),
            workTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            workTypeScrollView.topAnchor.constraint(equalTo: workTypeLabel.bottomAnchor, constant: 10),
            workTypeScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            workTypeScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            workTypeScrollView.heightAnchor.constraint(equalToConstant: 40),
            
            workTypeStackView.topAnchor.constraint(equalTo: workTypeScrollView.topAnchor),
            workTypeStackView.leadingAnchor.constraint(equalTo: workTypeScrollView.leadingAnchor),
            workTypeStackView.trailingAnchor.constraint(equalTo: workTypeScrollView.trailingAnchor),
            workTypeStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        workTypeScrollViewBottomAnchor = workTypeScrollView.bottomAnchor
    }
    
    
    @objc func noticeOptionButtonTapped(_ sender: UIButton) {
        selectedNoticeOptionsButton?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedNoticeOptionsButton?.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        selectedNoticeOptionsButton = sender
    }
    
    @objc func relocateOptionSelected(_ sender: UIButton) {
        selectedRelocateButton?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedRelocateButton?.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        selectedRelocateButton = sender
    }
    
    @objc func employedOptionSelected(_ sender: UIButton) {
        selectedEmployedButton?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedEmployedButton?.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        selectedEmployedButton = sender
    }
    
    @objc func workTypeOptionSelected(_ sender: UIButton) {
        selectedWorkTypeButton?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedWorkTypeButton?.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        selectedWorkTypeButton = sender
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
        uploadUserProfile()
    }
    
    
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
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


extension EditPreferencesVC {
    
    func uploadUserProfile() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        guard let portfolio = portfolioTextField.text,
              let currentCtcText = currentCtcTextField.text, !currentCtcText.isEmpty, let currentCtc = Double(currentCtcText),
              let expectedCtcText = expectedCtcTextField.text, !expectedCtcText.isEmpty, let expectedCtc = Double(expectedCtcText),
              let noticePeriod = selectedNoticeOptionsButton?.titleLabel?.text,
              let willingToRelocate = selectedRelocateButton?.titleLabel?.text,
              let currentlyEmployed = selectedEmployedButton?.titleLabel?.text,
              let preferredWorkType = selectedWorkTypeButton?.titleLabel?.text
        else {
            showAlert(withTitle: "Missing Information", message: "Please fill in all the details.")
            return
        }
        
        let userPreferencesUpdate = UserPreferencesUpdate(
            hobbies: "",
            preferredWorkType: preferredWorkType.trimmingCharacters(in: .whitespacesAndNewlines),
            willingToRelocate: willingToRelocate,
            noticePeriod: noticePeriod,
            currentlyEmployed: currentlyEmployed,
            currentCtc: currentCtc,
            expectedCtc: expectedCtc,
            portfolio: portfolio
        )
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        
        
        do {
            let jsonData = try JSONEncoder().encode(userPreferencesUpdate)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode user profile to JSON: \(error)")
            return
        }
        
        let loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        loader.startAnimating()
        view.addSubview(loader)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to upload user profile, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return
            }
            print(response)
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Server response: \(responseString)")
            }
            if let error = error {
                print("Error uploading user profile: \(error.localizedDescription)")
            } else {
                print("User Preferences successfully uploaded.")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                loader.stopAnimating()
                loader.removeFromSuperview()
                self.navigationController?.popViewController(animated: true)
            }
        }.resume()
    }
    
}
