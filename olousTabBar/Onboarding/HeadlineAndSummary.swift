//
//  BasicDetails2.swift
//  olousTabBar
//
//  Created by Salt Technologies on 27/03/24.
//

import UIKit

class HeadlineAndSummary: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var headerView : UIView!
    var headerHeightConstraint: NSLayoutConstraint?
    var circleContainerView : UIView!
    
    var scrollView : UIScrollView!
    
    var loader: UIActivityIndicatorView!
    var loader2: UIActivityIndicatorView!
    
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
    
    
    var charactersLeftLabel : UILabel = {
        let label = UILabel()
        label.text = "300 characters left"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#475467")
        return label
    }()
    
    
    var bottomView : UIView!
    var bottomHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        
        setupViews()
    }
    
    private func setupLoader() {
        loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: resumeTextView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: resumeTextView.centerYAnchor)
        ])
    }
    private func setupLoader2() {
        loader2 = UIActivityIndicatorView(style: .large)
        loader2.center = view.center
        loader2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader2)
        
        NSLayoutConstraint.activate([
            loader2.centerXAnchor.constraint(equalTo: summaryTextView.centerXAnchor),
            loader2.centerYAnchor.constraint(equalTo: summaryTextView.centerYAnchor)
        ])
    }
    
    func setupViews() {
        setupHeaderView()
        setupScrollView()
        
        setupUI()
        setupLoader()
        setupLoader2()
        
        setupBottomView()
    }
    
    func setupHeaderView() {
        
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 80)
        headerHeightConstraint?.isActive = true
        
        
        circleContainerView = UIView(frame: CGRect(x: 60, y: 60, width: 60, height: 60))
        circleContainerView.layer.cornerRadius = 30
        
        circleContainerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(circleContainerView)
        NSLayoutConstraint.activate([
            circleContainerView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            circleContainerView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            circleContainerView.widthAnchor.constraint(equalToConstant: 60),
            circleContainerView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let profileCircleLabel : UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = UIColor(hex: "#000000")
            label.font = .boldSystemFont(ofSize: 24)
            return label
        }()
        profileCircleLabel.text = "9/9"
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        circleContainerView.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: circleContainerView.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: circleContainerView.centerYAnchor)
        ])
        
        
        // Calculate the center and radius of the circle
        let center = CGPoint(x: circleContainerView.bounds.midX, y: circleContainerView.bounds.midY)
        let radius = min(circleContainerView.bounds.width, circleContainerView.bounds.height) / 2
        
        // Calculate the end angle based on the percentage (0.75 for 75%)
        let percentage: CGFloat = 8.9 / 9
        let greenEndAngle = CGFloat.pi * 2 * percentage + CGFloat.pi / 2
        let normalEndAngle = CGFloat.pi * 2 + CGFloat.pi / 2
        
        // Create a circular path for the green layer
        let greenPath = UIBezierPath(arcCenter: center,
                                     radius: radius,
                                     startAngle: CGFloat.pi / 2,
                                     endAngle: greenEndAngle,
                                     clockwise: true)
        
        let greenBorderLayer : CAShapeLayer = {
            let greenBorderLayer = CAShapeLayer()
            greenBorderLayer.path = greenPath.cgPath
            greenBorderLayer.lineWidth = 6 // Border width
            greenBorderLayer.strokeColor = UIColor(hex: "#0079C4").cgColor // Border color
            greenBorderLayer.fillColor = UIColor.clear.cgColor
            return greenBorderLayer
        }()
        circleContainerView.layer.addSublayer(greenBorderLayer)
        
        
        // regular border without green color
        let normalPath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: greenEndAngle,
                                      endAngle: normalEndAngle,
                                      clockwise: true)
        
        // Create shape layer for the normal circle border
        let normalBorderLayer : CAShapeLayer = {
            let normalBorderLayer = CAShapeLayer()
            normalBorderLayer.path = normalPath.cgPath
            normalBorderLayer.lineWidth = 6 // Border width
            normalBorderLayer.strokeColor = UIColor(hex: "#D9D9D9").cgColor // Border color
            normalBorderLayer.fillColor = UIColor.clear.cgColor
            return normalBorderLayer
        }()
        circleContainerView.layer.addSublayer(normalBorderLayer)
        
        
        let titleLabel = UILabel()
        titleLabel.text = "HEADLINE"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
        ])
        
        let borderView = UIView()
        borderView.backgroundColor = UIColor(hex: "#EAECF0")
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(borderView)
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -1),
            borderView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            borderView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            borderView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -105),
        ])
        
        let extraSpaceHeight: CGFloat = 50
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
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
        scrollView.addSubview(headlineLabel)
        
        resumeTextView = UITextView()
        resumeTextView.delegate = self
        resumeTextView.font = .systemFont(ofSize: 18)
        resumeTextView.textColor = UIColor(hex: "#344054")
        resumeTextView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        resumeTextView.layer.borderWidth = 1.0 // Border width
        resumeTextView.layer.cornerRadius = 12.0
        resumeTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Padding
        resumeTextView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(resumeTextView)
        
        generateResume.addTarget(self, action: #selector(didTapGenerateResume), for: .touchUpInside)
        generateResume.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(generateResume)
        
        
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            headlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            generateResume.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            generateResume.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            generateResume.widthAnchor.constraint(equalToConstant: 180),
            generateResume.heightAnchor.constraint(equalToConstant: 40),
            
            resumeTextView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 20),
            resumeTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resumeTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resumeTextView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        
        let summaryLabel = UILabel()
        summaryLabel.font = .boldSystemFont(ofSize: 18)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText2 = NSMutableAttributedString(string: "Profile Summary")
        let asterisk2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText2.append(asterisk2)
        summaryLabel.attributedText = attributedText2
        summaryLabel.textColor = UIColor(hex: "#101828")
        scrollView.addSubview(summaryLabel)
        
        summaryTextView = UITextView()
        summaryTextView.delegate = self
        summaryTextView.font = .systemFont(ofSize: 18)
        summaryTextView.textColor = UIColor(hex: "#344054")
        summaryTextView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        summaryTextView.layer.borderWidth = 1.0 // Border width
        summaryTextView.layer.cornerRadius = 12.0
        summaryTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Padding
        summaryTextView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(summaryTextView)
        
        generateSummary.addTarget(self, action: #selector(didTapGenerateSummary), for: .touchUpInside)
        generateSummary.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(generateSummary)
        
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
            summaryTextView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    @objc func didTapGenerateResume() {
        fetchHeadline()
    }
    
    @objc func didTapGenerateSummary() {
        fetchProfileSummary()
    }
    
    
    func setupBottomView() {
        bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        
        let nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 20)
        nextButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        nextButton.backgroundColor = UIColor(hex: "#0079C4")
        nextButton.layer.cornerRadius = 8
        
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(nextButton)
        
        let backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 20)
        backButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        backButton.backgroundColor = UIColor(hex: "#FFFFFF")
        backButton.layer.cornerRadius = 8
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        
        backButton.isUserInteractionEnabled = true
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(backButton)
        
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            
            nextButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        bottomHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 100)
        bottomHeightConstraint?.isActive = true
    }
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNextButton() {
        postResumeData()
        
        let viewController = ViewController()
        viewController.modalPresentationStyle = .overFullScreen
        viewController.overrideUserInterfaceStyle = .light
        self.present(viewController, animated: true)
    }
    
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 300 {
            let index = textView.text.index(textView.text.startIndex, offsetBy: 300)
            textView.text = String(textView.text.prefix(upTo: index))
        }
        else {
            let remainingCharacters = 300 - textView.text.count
            charactersLeftLabel.text = "\(remainingCharacters) characters left"
        }
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

extension HeadlineAndSummary {
    
    func fetchHeadline() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/generate-headline") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
            self.loader.startAnimating()  // Start the loader before the request
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loader.stopAnimating()  // Stop the loader when the request completes
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
                        print("Headline set to resumeTextView: \(headlineResponse.headline)")
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
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/profile-summary") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        DispatchQueue.main.async {
            self.loader2.startAnimating()
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loader2.stopAnimating()
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
                        let lines = summary.split(separator: "\n", omittingEmptySubsequences: false)
                        
                        // Mapping each line to remove the leading "- " if it exists
                        let processedLines = lines.map { line -> String in
                            var modifiedLine = String(line)
                            // Check if the line starts with "- " and remove it
                            if modifiedLine.hasPrefix("- ") {
                                modifiedLine = String(modifiedLine.dropFirst(2))
                            }
                            return modifiedLine
                        }
                        
                        let cleanedSummary = processedLines.joined(separator: " ")
                        
                        var s = cleanedSummary
                        s = String(s.dropFirst().dropLast())
                        self.summaryTextView.text = s
                        
                        // Output to check
                        let components = summary.split(separator: ".").map { line -> String in
                            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                            return trimmedLine.hasPrefix("- ") ? String(trimmedLine.dropFirst(2)) : trimmedLine
                        }
                        var cleanedArray: [String] = []
                        
                        for string in components {
                            // Find the index of the first space
                            if let index = string.firstIndex(of: " ") {
                                // Create a substring from the first space to the end of the string
                                let cleanedString = String(string[index...].dropFirst())
                                cleanedArray.append(cleanedString)
                            } else {
                                // If there is no space, append the original string
                                cleanedArray.append(string)
                            }
                        }
                        
                        let modifiedStrings = cleanedArray.map { $0 + "." }
                        
                        // Join all the modified strings into a single string, separating them by a space
                        var finalString = modifiedStrings.joined(separator: " ")
                        finalString = String(finalString.dropLast().dropLast())
                        
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
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
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
        }.resume()
    }

}

struct ResumeData: Codable {
    let headline: String
    let summary: String
}

struct HeadlineResponse: Codable {
    let headline: String
}

