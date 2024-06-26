//
//  JobDetailScreen.swift
//  olousTabBar
//
//  Created by Salt Technologies on 11/03/24.
//

import UIKit

class JobDetailScreen: UIViewController {
    
    var selectedJob : Job!
    
    var scrollView : UIScrollView!
    var headerView : UIView!
    
    let companyLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    let jobTitle: UILabel = {
        let label = UILabel()
        label.text = "Design Coordinator"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let companyName: UILabel = {
        let label = UILabel()
        label.text = "Osumare Marketing Solutions"
        label.textColor = UIColor(hex: "#475467")
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let jobLocationLabel : UILabel = {
        let label = UILabel()
        label.text = "Pune, Maharashtra"
        label.textColor = UIColor(hex: "#475467")
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let jobExperienceLabel : UILabel = {
        let label = UILabel()
        label.tintColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let saveButton = UIButton(type: .system)
    let applyButton = UIButton(type: .system)
    
    let separatorLine1 = UIView()
    
    let responsibilityView = UIView()
//    var jobDescriptionItems = [
//        "Assist in creating marketing materials such as brochures, flyers, and social media posts.",
//        "Conduct market research to identify trends and opportunities for brand expansion.",
//        "Support the marketing team in organizing events and promotional campaigns.",
//        "Collaborate with designers and content creators to develop engaging content for various platforms."
//    ]
    var jobResponsibilityItems : [String] = []
    let descriptionStackView = UIStackView()
    
    let separatorLine2 = UIView()
    
    let requirementsView = UIView()
    var jobRequirementItems : [String] = []
    let requirementsStackView = UIStackView()
    
    let separatorLine3 = UIView()
    
    let moreJobInfo = UIView()
    let sectorLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    let jobTypeLabel : UILabel = {
        let label = UILabel()
        label.text = "Full Time"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    let locationLabel : UILabel = {
        let label = UILabel()
        label.text = "Pune, Maharashtra"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    let vacancyLabel : UILabel = {
        let label = UILabel()
        label.text = "Nil"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    let salaryLabel : UILabel = {
        let label = UILabel()
        label.text = "Salary not disclosed"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    let workmodeLabel : UILabel = {
        let label = UILabel()
        label.text = "Nil"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    
    let separatorLine4 = UIView()
    
    let qualificationsLabel : UILabel = {
        let label = UILabel()
        label.text = "Nil"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    let softwaresLabel : UILabel = {
        let label = UILabel()
        label.text = "Nil"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        setupScrollView()
        checkIfJobIsApplied()
        assignValues()
        setupViews()

        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        shareButton.image = UIImage(systemName: "")
        navigationItem.rightBarButtonItem = shareButton
        
    }
    
    func assignValues() {
        jobTitle.text = selectedJob.title
        companyName.text = selectedJob.companyName ?? "xyz"
        jobLocationLabel.text = "\(selectedJob.location?.city ?? "NA"), \(selectedJob.location?.state ?? "NA")"
        let expText = attributedStringForExperience("\(selectedJob.minExperience ?? "nil") - \(selectedJob.maxExperience ?? "nil")")
        jobExperienceLabel.attributedText = expText
        
        if let responsibilities = selectedJob.keyResponsibilities {
            for responsibility in responsibilities {
                let title = String(responsibility.title.dropFirst(0))
                jobResponsibilityItems.append(title)
            }
        }
        
        for requirement in selectedJob.requirements {
            let title = String(requirement.title.dropFirst(0))
            jobRequirementItems.append(title)
        }
        
        let sectorTitles = selectedJob.sectors.map { $0 }
        let sectorString = sectorTitles.joined(separator: ", ")
        sectorLabel.text = sectorString
        
        jobTypeLabel.text = selectedJob.jobType ?? "Nil"
        
        let location = selectedJob.location
        locationLabel.text = "\(location?.city ?? ""), \(location?.state ?? ""), \(location?.country ?? "")"
        if locationLabel.text == "" {
            locationLabel.text = "Nil"
        }
        
        if selectedJob.noOfPeople != nil {
            vacancyLabel.text = "\(selectedJob.noOfPeople!)"
        }
        
        if selectedJob.salaryRangeFrom != nil && selectedJob.salaryRangeTo != nil {
            var text = "\(selectedJob.salaryRangeFrom!) - \(selectedJob.salaryRangeTo!)"
            if text.hasSuffix("LPA") {
                salaryLabel.text = text
            }
            else {
                salaryLabel.text = "\(text) LPA"
            }
        }
        
        if selectedJob.workPlace != nil {
            workmodeLabel.text = selectedJob.workPlace
        }
        
        print("Preferred Qualifications : ", selectedJob.preferredQualification)
        let qualificationTitle = selectedJob.preferredQualification.map { $0 }
        let qString = qualificationTitle?.joined(separator: ", ") ?? ""
        qualificationsLabel.text = qString
        
        let softwareItems = selectedJob.softwares.map { $0 }
        let softwares = softwareItems.joined(separator: ", ")
        softwaresLabel.text = softwares
        
        DispatchQueue.main.async {
            self.updateScrollViewHeight()
        }
        
        let baseURLString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/company-pic?logo="
        let companyLogoURLString = baseURLString + (selectedJob.companyLogo ?? "")
        if let companyLogoURL = URL(string: companyLogoURLString) {
            URLSession.shared.dataTask(with: companyLogoURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.companyLogo.image = image
                    }
                }
            }.resume()
        }
    }
    
    @objc func shareButtonTapped() {
        print("Share button tapped")
    }
    
    func setupViews() {
        setupHeaderView()
        setupSeparatorLine1()
        setupResponsibilityView()
        setupSeparatorLine2()
        setupRequirementsView()
        setupSeparatorLine3()
        setupMoreJobInfo()
        setupSeparatorLine4()
        additionalJobInfo()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let extraSpaceHeight: CGFloat = 100
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    func updateScrollViewHeight() {
        // Calculate total height of all subviews
        var totalHeight: CGFloat = 0
        for subview in scrollView.subviews {
            for s in subview.subviews {
                totalHeight += s.frame.height
            }
        }

        // Add extra space if needed
        totalHeight += 100

        // Update content size of scrollView
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: totalHeight)
    }

    func setupHeaderView() {
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        companyLogo.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(companyLogo)
        
        jobTitle.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(jobTitle)
        
        companyName.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(companyName)
        
        NSLayoutConstraint.activate([
            companyLogo.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            companyLogo.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            companyLogo.widthAnchor.constraint(equalToConstant: 48),
            companyLogo.heightAnchor.constraint(equalToConstant: 46),
            
            jobTitle.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            jobTitle.leadingAnchor.constraint(equalTo: companyLogo.trailingAnchor, constant: 16),
            jobTitle.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 0),
            jobTitle.heightAnchor.constraint(equalToConstant: 24),
            
            companyName.topAnchor.constraint(equalTo: jobTitle.bottomAnchor, constant: 4),
            companyName.leadingAnchor.constraint(equalTo: companyLogo.trailingAnchor, constant: 16),
            companyName.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 0),
            companyName.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        
        let locationIcon : UIImageView = UIImageView()
        locationIcon.image = UIImage(named: "locationLogo")
        locationIcon.tintColor = UIColor(hex: "#667085")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(locationIcon)
        
        jobLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(jobLocationLabel)
        
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 16),
            locationIcon.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            locationIcon.widthAnchor.constraint(equalToConstant: 16),
            locationIcon.heightAnchor.constraint(equalToConstant: 20),
            
            jobLocationLabel.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 16),
            jobLocationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 6),
            jobLocationLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        if let locationText = jobLocationLabel.text, locationText.count > 25 {
            jobLocationLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        }
        
        jobExperienceLabel.textColor = UIColor(hex: "#667085")
        headerView.addSubview(jobExperienceLabel)
        
        NSLayoutConstraint.activate([
            jobExperienceLabel.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 16),
            jobExperienceLabel.leadingAnchor.constraint(equalTo: jobLocationLabel.trailingAnchor, constant: 6),
            jobExperienceLabel.heightAnchor.constraint(equalToConstant: 20),
            jobExperienceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    
        setupSaveButton()
        setupApplyButton()
    }
    
    func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        saveButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        saveButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 12
        saveButton.clipsToBounds = true
        saveButton.titleLabel?.textAlignment = .center
        
        saveButton.isHidden = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: jobLocationLabel.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            saveButton.widthAnchor.constraint(equalToConstant: 65),
            saveButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupApplyButton() {
        applyButton.setTitle("Apply", for: .normal)
        applyButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        applyButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        applyButton.backgroundColor = UIColor(hex: "#0079C4")
        applyButton.layer.cornerRadius = 12
        applyButton.clipsToBounds = true
        applyButton.titleLabel?.textAlignment = .center
        applyButton.addTarget(self, action: #selector(didTapApplyJobs), for: .touchUpInside)
        
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(applyButton)
        
        NSLayoutConstraint.activate([
            applyButton.topAnchor.constraint(equalTo: jobLocationLabel.bottomAnchor, constant: 20),
            applyButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            applyButton.widthAnchor.constraint(equalToConstant: 75),
            applyButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func checkIfJobIsApplied() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/user-status") else {
            print("Invalid URL")
            return
        }

        let jobId = selectedJob.id // Assuming selectedJob is accessible in this method

        let requestData = ["jobId": jobId]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])
            request.httpBody = jsonData
        } catch {
            print("Failed to serialize request data: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response from server: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response from server: \(responseString)")
            }

            if httpResponse.statusCode == 200 {
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let msg = json["msg"] as? String, msg == "not applied" {
                    print("Job is not applied")
                    // Update UI or perform any other action
                } else {
                    print("Job is already applied")
                    DispatchQueue.main.async {
                        self.applyButton.setTitle("Applied", for: .normal)
                        self.applyButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
                        self.applyButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
                        self.applyButton.backgroundColor = UIColor(hex: "#0079C4")
                        self.applyButton.alpha = 0.7
                        self.applyButton.isUserInteractionEnabled = false
                    }
                }
            } else if httpResponse.statusCode == 404 {
                print("Job is not applied")
                // Update UI or perform any other action
            } else {
                print("Failed to check job status, status code: \(httpResponse.statusCode)")
            }

            if let error = error {
                print("Error checking job status: \(error.localizedDescription)")
            }
        }.resume()

    }

    
    @objc func didTapApplyJobs() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/application") else {
            print("Invalid URL")
            return
        }

        let jobId = selectedJob.id // Assuming selectedJob is accessible in this method

        let requestData = ["jobId": jobId]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])
            request.httpBody = jsonData
        } catch {
            print("Failed to serialize request data: \(error)")
            return
        }
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = view.center
        spinner.startAnimating()
        scrollView.alpha = 0.4
        view.addSubview(spinner)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response from server: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response from server: \(responseString)")
            }
            
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                print("Job application successful")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    
                    self.applyButton.setTitle("Applied", for: .normal)
                    self.applyButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
                    self.applyButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
                    self.applyButton.backgroundColor = UIColor(hex: "#0079C4")
                    self.applyButton.alpha = 0.7
                    self.applyButton.isUserInteractionEnabled = false
                }
            } else {
                print("Failed to apply for job, status code: \(httpResponse.statusCode)")
            }
            
            if let error = error {
                print("Error applying for job: \(error.localizedDescription)")
            }
        }.resume()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.scrollView.alpha = 1
        }
    }

    
    func setupSeparatorLine1() {
        separatorLine1.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine1.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine1)
        
        NSLayoutConstraint.activate([
            separatorLine1.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            separatorLine1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine1.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupResponsibilityView() {
        
        responsibilityView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(responsibilityView)
        
        NSLayoutConstraint.activate([
            responsibilityView.topAnchor.constraint(equalTo: separatorLine1.bottomAnchor),
            responsibilityView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            responsibilityView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            descriptionView.heightAnchor.constraint(equalToConstant: 254)
        ])
        
        let rolesLabel = UILabel()
        rolesLabel.text = "Roles and Responsibilities :"
        rolesLabel.font = .boldSystemFont(ofSize: 16)
        rolesLabel.tintColor = UIColor(hex: "#101828")
        
        rolesLabel.translatesAutoresizingMaskIntoConstraints = false
        responsibilityView.addSubview(rolesLabel)
        
        NSLayoutConstraint.activate([
            rolesLabel.topAnchor.constraint(equalTo: responsibilityView.topAnchor, constant: 16),
            rolesLabel.leadingAnchor.constraint(equalTo: responsibilityView.leadingAnchor, constant: 16),
            rolesLabel.trailingAnchor.constraint(equalTo: responsibilityView.trailingAnchor),
            rolesLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        descriptionStackView.axis = .vertical
        descriptionStackView.spacing = 0 // Adjust spacing between items
        
        for item in jobResponsibilityItems {
            let bulletLabelText = "\u{2022} " // Unicode bullet symbol with a space
            let attributedText = NSMutableAttributedString(string: bulletLabelText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black])
            
            let text = NSAttributedString(string: item, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor(hex: "#344054")])
            
            attributedText.append(text)
            
            let bulletLabel = UILabel()
            bulletLabel.attributedText = attributedText
            bulletLabel.numberOfLines = 0 // Allow multiline text
            descriptionStackView.addArrangedSubview(bulletLabel)
        }
        
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        responsibilityView.addSubview(descriptionStackView)
        
        NSLayoutConstraint.activate([
            descriptionStackView.topAnchor.constraint(equalTo: rolesLabel.bottomAnchor, constant: 10),
            descriptionStackView.leadingAnchor.constraint(equalTo: responsibilityView.leadingAnchor, constant: 16),
            descriptionStackView.trailingAnchor.constraint(equalTo: responsibilityView.trailingAnchor, constant: -16),
            descriptionStackView.bottomAnchor.constraint(equalTo: responsibilityView.bottomAnchor, constant: 0)
        ])
    }
    
    func setupSeparatorLine2() {
        separatorLine2.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine2.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine2)
        
        NSLayoutConstraint.activate([
            separatorLine2.topAnchor.constraint(equalTo: responsibilityView.bottomAnchor, constant: 16),
            separatorLine2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine2.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupRequirementsView() {
        
        requirementsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(requirementsView)
        
        NSLayoutConstraint.activate([
            requirementsView.topAnchor.constraint(equalTo: separatorLine2.bottomAnchor),
            requirementsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            requirementsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        
        let requirementsLabel = UILabel()
        requirementsLabel.text = "Requirements :"
        requirementsLabel.font = .boldSystemFont(ofSize: 16)
        requirementsLabel.tintColor = UIColor(hex: "#101828")
        
        requirementsLabel.translatesAutoresizingMaskIntoConstraints = false
        requirementsView.addSubview(requirementsLabel)
        
        NSLayoutConstraint.activate([
            requirementsLabel.topAnchor.constraint(equalTo: requirementsView.topAnchor, constant: 16),
            requirementsLabel.leadingAnchor.constraint(equalTo: requirementsView.leadingAnchor, constant: 16),
            requirementsLabel.trailingAnchor.constraint(equalTo: requirementsView.trailingAnchor),
            requirementsLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        requirementsStackView.axis = .vertical
        requirementsStackView.spacing = 0 // Adjust spacing between items
        
        for item in jobRequirementItems {
            let bulletLabelText = "\u{2022} " // Unicode bullet symbol with a space
            let attributedText = NSMutableAttributedString(string: bulletLabelText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black])
            
            let text = NSAttributedString(string: item, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor(hex: "#344054")])
            
            attributedText.append(text)
            
            let bulletLabel = UILabel()
            bulletLabel.attributedText = attributedText
            bulletLabel.numberOfLines = 0 // Allow multiline text
            requirementsStackView.addArrangedSubview(bulletLabel)
        }
        
        requirementsStackView.translatesAutoresizingMaskIntoConstraints = false
        requirementsView.addSubview(requirementsStackView)
        
        NSLayoutConstraint.activate([
            requirementsStackView.topAnchor.constraint(equalTo: requirementsLabel.bottomAnchor, constant: 10),
            requirementsStackView.leadingAnchor.constraint(equalTo: requirementsView.leadingAnchor, constant: 16),
            requirementsStackView.trailingAnchor.constraint(equalTo: requirementsView.trailingAnchor, constant: -16),
            requirementsStackView.bottomAnchor.constraint(equalTo: requirementsView.bottomAnchor, constant: 0)
        ])
    }
    
    func setupSeparatorLine3() {
        separatorLine3.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine3.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine3)
        
        NSLayoutConstraint.activate([
            separatorLine3.topAnchor.constraint(equalTo: requirementsView.bottomAnchor, constant: 16),
            separatorLine3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine3.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupMoreJobInfo() {
        moreJobInfo.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(moreJobInfo)
        
        NSLayoutConstraint.activate([
            moreJobInfo.topAnchor.constraint(equalTo: separatorLine3.bottomAnchor),
            moreJobInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moreJobInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        let sector = UILabel()
        sector.text = "Sector :"
        sector.font = .boldSystemFont(ofSize: 16)
        sector.tintColor = UIColor(hex: "#101828")
        
        sector.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(sector)
        
        sectorLabel.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(sectorLabel)
        
        NSLayoutConstraint.activate([
            sector.topAnchor.constraint(equalTo: moreJobInfo.topAnchor, constant: 16),
            sector.leadingAnchor.constraint(equalTo: moreJobInfo.leadingAnchor, constant: 16),
            sector.heightAnchor.constraint(equalToConstant: 18),
            
            sectorLabel.topAnchor.constraint(equalTo: sector.topAnchor),
            sectorLabel.leadingAnchor.constraint(equalTo: sector.trailingAnchor, constant: 10),
            sectorLabel.trailingAnchor.constraint(equalTo: moreJobInfo.trailingAnchor, constant: -16)
        ])
        
        let jobType = UILabel()
        jobType.text = "Job type :"
        jobType.font = .boldSystemFont(ofSize: 16)
        jobType.tintColor = UIColor(hex: "#101828")
        
        jobType.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(jobType)
        
        let jobTypeTopAnchorConstraint: NSLayoutConstraint
        if sectorLabel.text?.isEmpty ?? true {
            jobTypeTopAnchorConstraint = jobType.topAnchor.constraint(equalTo: sector.bottomAnchor, constant: 10)
        } else {
            jobTypeTopAnchorConstraint = jobType.topAnchor.constraint(equalTo: sectorLabel.bottomAnchor, constant: 10)
        }
        
        jobTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(jobTypeLabel)
        
        NSLayoutConstraint.activate([
            jobTypeTopAnchorConstraint,
            jobType.leadingAnchor.constraint(equalTo: moreJobInfo.leadingAnchor, constant: 16),
            jobType.heightAnchor.constraint(equalToConstant: 18),
            
            jobTypeLabel.topAnchor.constraint(equalTo: jobType.topAnchor),
            jobTypeLabel.leadingAnchor.constraint(equalTo: jobType.trailingAnchor,constant: 10),
            jobTypeLabel.trailingAnchor.constraint(equalTo: moreJobInfo.trailingAnchor, constant: -16)
        ])
        
        let location = UILabel()
        location.text = "Location :"
        location.font = .boldSystemFont(ofSize: 16)
        location.tintColor = UIColor(hex: "#101828")
        
        location.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(location)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            location.topAnchor.constraint(equalTo: jobType.bottomAnchor, constant: 16),
            location.leadingAnchor.constraint(equalTo: moreJobInfo.leadingAnchor, constant: 16),
            location.heightAnchor.constraint(equalToConstant: 18),
            
            locationLabel.topAnchor.constraint(equalTo: location.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: location.trailingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: moreJobInfo.trailingAnchor, constant: -16)
        ])
        
        let vacancy = UILabel()
        vacancy.text = "Vacancy :"
        vacancy.font = .boldSystemFont(ofSize: 16)
        vacancy.tintColor = UIColor(hex: "#101828")
        
        vacancy.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(vacancy)
        
        vacancyLabel.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(vacancyLabel)
        
        NSLayoutConstraint.activate([
            vacancy.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            vacancy.leadingAnchor.constraint(equalTo: moreJobInfo.leadingAnchor, constant: 16),
            vacancy.heightAnchor.constraint(equalToConstant: 18),
            
            vacancyLabel.topAnchor.constraint(equalTo: vacancy.topAnchor),
            vacancyLabel.leadingAnchor.constraint(equalTo: vacancy.trailingAnchor, constant: 10),
            vacancyLabel.trailingAnchor.constraint(equalTo: moreJobInfo.trailingAnchor, constant: -16)
        ])
        
        let salary = UILabel()
        salary.text = "Salary :"
        salary.font = .boldSystemFont(ofSize: 16)
        salary.tintColor = UIColor(hex: "#101828")
        
        salary.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(salary)
        
        salaryLabel.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(salaryLabel)
        
        NSLayoutConstraint.activate([
            salary.topAnchor.constraint(equalTo: vacancyLabel.bottomAnchor, constant: 16),
            salary.leadingAnchor.constraint(equalTo: moreJobInfo.leadingAnchor, constant: 16),
            salary.heightAnchor.constraint(equalToConstant: 18),
            
            salaryLabel.topAnchor.constraint(equalTo: salary.topAnchor),
            salaryLabel.leadingAnchor.constraint(equalTo: salary.trailingAnchor, constant: 10),
            salaryLabel.trailingAnchor.constraint(equalTo: moreJobInfo.trailingAnchor, constant: -16)
        ])
        
        let workmode = UILabel()
        workmode.text = "Workmode :"
        workmode.font = .boldSystemFont(ofSize: 16)
        workmode.tintColor = UIColor(hex: "#101828")
        
        workmode.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(workmode)
        
        workmodeLabel.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(workmodeLabel)
        
        NSLayoutConstraint.activate([
            workmode.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 16),
            workmode.leadingAnchor.constraint(equalTo: moreJobInfo.leadingAnchor, constant: 16),
            workmode.heightAnchor.constraint(equalToConstant: 18),
            
            workmodeLabel.topAnchor.constraint(equalTo: workmode.topAnchor),
            workmodeLabel.leadingAnchor.constraint(equalTo: workmode.trailingAnchor, constant: 10),
            workmodeLabel.trailingAnchor.constraint(equalTo: moreJobInfo.trailingAnchor, constant: -16)
        ])
    }
    
    func setupSeparatorLine4() {
        separatorLine4.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine4.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(separatorLine4)
        
        NSLayoutConstraint.activate([
            separatorLine4.topAnchor.constraint(equalTo: workmodeLabel.bottomAnchor, constant: 16),
            separatorLine4.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine4.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine4.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func additionalJobInfo() {
        let qualifications = UILabel()
        qualifications.text = "Qualifications :"
        qualifications.font = .boldSystemFont(ofSize: 16)
        qualifications.tintColor = UIColor(hex: "#101828")
        
        qualifications.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(qualifications)
        
        qualificationsLabel.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(qualificationsLabel)
        
        NSLayoutConstraint.activate([
            qualifications.topAnchor.constraint(equalTo: separatorLine4.bottomAnchor, constant: 16),
            qualifications.leadingAnchor.constraint(equalTo: moreJobInfo.leadingAnchor, constant: 16),
            qualifications.heightAnchor.constraint(equalToConstant: 18),
            
            qualificationsLabel.topAnchor.constraint(equalTo: qualifications.bottomAnchor, constant: 6),
            qualificationsLabel.leadingAnchor.constraint(equalTo: moreJobInfo.leadingAnchor, constant: 16),
            qualificationsLabel.trailingAnchor.constraint(equalTo: moreJobInfo.trailingAnchor, constant: -16)
        ])
        
        let softwares = UILabel()
        softwares.text = "Softwares :"
        softwares.font = .boldSystemFont(ofSize: 16)
        softwares.tintColor = UIColor(hex: "#101828")
        
        softwares.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(softwares)
        
        softwaresLabel.translatesAutoresizingMaskIntoConstraints = false
        moreJobInfo.addSubview(softwaresLabel)
        
        NSLayoutConstraint.activate([
            softwares.topAnchor.constraint(equalTo: qualificationsLabel.bottomAnchor, constant: 16),
            softwares.leadingAnchor.constraint(equalTo: moreJobInfo.leadingAnchor, constant: 16),
            softwares.heightAnchor.constraint(equalToConstant: 18),
            
            softwaresLabel.topAnchor.constraint(equalTo: softwares.bottomAnchor, constant: 6),
            softwaresLabel.leadingAnchor.constraint(equalTo: moreJobInfo.leadingAnchor, constant: 16),
            softwaresLabel.trailingAnchor.constraint(equalTo: moreJobInfo.trailingAnchor, constant: -16)
        ])
    }
    
    func attributedStringForExperience(_ experience: String) -> NSAttributedString {
        // Create a mutable attributed string
        let attributedString = NSMutableAttributedString()
        
        attributedString.append(NSAttributedString(string: "|"))
        
        attributedString.append(NSAttributedString(string: "  "))
        
        let symbolAttachment = NSTextAttachment()
        symbolAttachment.image = UIImage(systemName: "briefcase")?.withTintColor(UIColor(hex: "#667085"))
        
        let symbolString = NSAttributedString(attachment: symbolAttachment)
        attributedString.append(symbolString)
        
        attributedString.append(NSAttributedString(string: " "))
        attributedString.append(NSAttributedString(string: experience))
        if !experience.hasSuffix("years") {
            attributedString.append(NSAttributedString(string: " years"))
        }

        return attributedString
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
