//
//  HeadlineEditVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 20/06/24.
//

import UIKit

class HeadlineEditVC: UIViewController, UITextViewDelegate {
    
    var resume: String!
    var summary: String!
    
    var resumeTextView : UITextView!
    let generateResume: UIButton = {
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
    }()
    var summaryTextView : UITextView!
    let generateSummary: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Generate content", for: .normal)
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.tintColor = UIColor(hex: "#0079C4")
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    var loader: LoadingView!
    var loader2: LoadingView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground

        navigationItem.title = "Edit Headline & Summary"
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        let backButtonImage = UIImage(systemName: "xmark") // Change "xmark" to any system image you prefer
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        setupUI()
        setupSaveButton()
        setupLoader()
        setupLoader2()
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
    
    
    private func setupLoader() {
        loader = LoadingView()
        loader.isHidden = true
        loader.backgroundColor = UIColor(hex: "#DB7F14").withAlphaComponent(0.05)
        loader.layer.cornerRadius = 20
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        
        let imgView = UIImageView()
        imgView.image = UIImage(named: "AISymbol")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        loader.addSubview(imgView)
        
        let label = UILabel()
        label.text = "Generating resume headline"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        loader.addSubview(label)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: resumeTextView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: resumeTextView.centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: 300),
            loader.heightAnchor.constraint(equalToConstant: 80),
            
            imgView.centerYAnchor.constraint(equalTo: loader.centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: loader.leadingAnchor, constant: 16),
            imgView.heightAnchor.constraint(equalToConstant: 40),
            imgView.widthAnchor.constraint(equalToConstant: 40),
            
            label.centerYAnchor.constraint(equalTo: loader.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: loader.trailingAnchor, constant: -16)
        ])
        
        loader.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = loader.bounds

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
        
        loader.layer.insertSublayer(gradientLayer, at: 0)
    }
    private func setupLoader2() {
        loader2 = LoadingView()
        loader2.isHidden = true
        loader2.backgroundColor = UIColor(hex: "#DB7F14").withAlphaComponent(0.05)
        loader2.layer.cornerRadius = 20
        
        loader2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader2)
        
        let imgView = UIImageView()
        imgView.image = UIImage(named: "AISymbol")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        loader2.addSubview(imgView)
        
        let label = UILabel()
        label.text = "Generating profile summary"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        loader2.addSubview(label)
        
        NSLayoutConstraint.activate([
            loader2.centerXAnchor.constraint(equalTo: summaryTextView.centerXAnchor),
            loader2.centerYAnchor.constraint(equalTo: summaryTextView.centerYAnchor),
            loader2.widthAnchor.constraint(equalToConstant: 300),
            loader2.heightAnchor.constraint(equalToConstant: 80),
            
            imgView.centerYAnchor.constraint(equalTo: loader2.centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: loader2.leadingAnchor, constant: 16),
            imgView.heightAnchor.constraint(equalToConstant: 40),
            imgView.widthAnchor.constraint(equalToConstant: 40),
            
            label.centerYAnchor.constraint(equalTo: loader2.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: loader2.trailingAnchor, constant: -16)
        ])
        
        loader2.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = loader2.bounds

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
        
        loader2.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
    func setupUI() {
        let headlineLabel = UILabel()
        headlineLabel.font = .boldSystemFont(ofSize: 18)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Resume Headline")
        let asterisk = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText.append(asterisk)
        headlineLabel.attributedText = attributedText
        headlineLabel.textColor = UIColor(hex: "#101828")
        view.addSubview(headlineLabel)
        
        resumeTextView = UITextView()
        
        resumeTextView.delegate = self
        resumeTextView.font = .systemFont(ofSize: 15)
        resumeTextView.textColor = UIColor(hex: "#344054")
        resumeTextView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        resumeTextView.layer.borderWidth = 1.0 // Border width
        resumeTextView.layer.cornerRadius = 12.0
        resumeTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Padding
        
        resumeTextView.addDoneButtonOnKeyboard()
        
        resumeTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resumeTextView)
        
        resumeTextView.text = resume
        resumeTextView.setContentOffset(.zero, animated: false)
        
        generateResume.addTarget(self, action: #selector(didTapGenerateResume), for: .touchUpInside)
        
        generateResume.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(generateResume)
        
        
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            generateResume.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            generateResume.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            generateResume.widthAnchor.constraint(equalToConstant: 180),
            generateResume.heightAnchor.constraint(equalToConstant: 40),
            
            resumeTextView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 20),
            resumeTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resumeTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resumeTextView.heightAnchor.constraint(equalToConstant: 130),
        ])
        
        
        let summaryLabel = UILabel()
        summaryLabel.font = .boldSystemFont(ofSize: 18)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText2 = NSMutableAttributedString(string: "Profile Summary")
        let asterisk2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText2.append(asterisk2)
        summaryLabel.attributedText = attributedText2
        summaryLabel.textColor = UIColor(hex: "#101828")
        view.addSubview(summaryLabel)
        
        summaryTextView = UITextView()
        
        summaryTextView.delegate = self
        summaryTextView.font = .systemFont(ofSize: 15)
        summaryTextView.textColor = UIColor(hex: "#344054")
        summaryTextView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        summaryTextView.layer.borderWidth = 1.0 // Border width
        summaryTextView.layer.cornerRadius = 12.0
        summaryTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Padding
        
        summaryTextView.addDoneButtonOnKeyboard()
        
        summaryTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(summaryTextView)
        
        summaryTextView.text = summary
        summaryTextView.setContentOffset(.zero, animated: false)
        
        generateSummary.addTarget(self, action: #selector(didTapGenerateSummary), for: .touchUpInside)
        generateSummary.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(generateSummary)
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: resumeTextView.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            generateSummary.topAnchor.constraint(equalTo: resumeTextView.bottomAnchor, constant: 10),
            generateSummary.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            generateSummary.widthAnchor.constraint(equalToConstant: 180),
            generateSummary.heightAnchor.constraint(equalToConstant: 40),
            
            summaryTextView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 20),
            summaryTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            summaryTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            summaryTextView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    @objc func didTapGenerateResume() {
        fetchHeadline()
    }
    
    @objc func didTapGenerateSummary() {
        fetchProfileSummary()
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
        postResumeData()
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


extension HeadlineEditVC {
    
    func fetchHeadline() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/generate-headline") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
            self.resumeTextView.text = ""
            self.loader.isHidden = false
            self.loader.startAnimating()
            self.generateResume.isUserInteractionEnabled = false
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.loader.isHidden = true
                self.generateResume.isUserInteractionEnabled = true
            }
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let headlineResponse = try JSONDecoder().decode(HeadlineResponse.self, from: data)
                    DispatchQueue.main.async {
                        var s = headlineResponse.headline
                        if s.hasPrefix("\"") {
                            s = String(s.dropFirst().dropLast())
                        }
                        self.resumeTextView.text = s
//                        print("Headline set to resumeTextView: \(headlineResponse.headline)")
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Failed to decode JSON: \(error)")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("Failed to fetch headline, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                }
            }
        }.resume()
    }
    
    func fetchProfileSummary() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/profile-summary") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        DispatchQueue.main.async {
            self.summaryTextView.text = ""
            self.loader2.isHidden = false
            self.loader2.startAnimating()
            self.generateSummary.isUserInteractionEnabled = false
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loader2.stopAnimating()
                self.loader2.isHidden = true
                self.generateSummary.isUserInteractionEnabled = true
            }
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let summary = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        
                        let components = summary.components(separatedBy: "\n-").map { line -> String in
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
                        
                        
                        self.summaryTextView.text = finalString
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("Failed to fetch profile summary, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                }
            }
        }.resume()
    }
    
    func postResumeData() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        

        guard let headline = resumeTextView.text, !headline.isEmpty,
              let summary = summaryTextView.text, !summary.isEmpty
        else {
            
            let alert = UIAlertController(title: "Missing Information", message: "Fill all the details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let resumeData = ResumeData(headline: headline, summary: summary)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        do {
            let jsonData = try JSONEncoder().encode(resumeData)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode resume data: \(error)")
            return
        }
        
        let loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        loader.startAnimating()
        view.addSubview(loader)

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
            }
            
            if let error = error {
                print("Error uploading data: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                loader.stopAnimating()
                loader.removeFromSuperview()
                self.navigationController?.popViewController(animated: true)
            }
            
        }.resume()
    }
}
