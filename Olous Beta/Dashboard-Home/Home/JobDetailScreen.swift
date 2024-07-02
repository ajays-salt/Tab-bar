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
    
    
    let companyDescView = UIView()
    let companyDescLabel : UILabel = {
        let label = UILabel()
        label.text = "Nil"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    
    
    let jobSummaryView = UIView()
    let jobSummaryLabel : UILabel = {
        let label = UILabel()
        label.text = "Nil"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    
    
    let responsibilityView = UIView()
    var jobResponsibilityItems : [String] = []
    var jobResponsibilityItemsDesc : [String] = []
    
    
    let requirementsView = UIView()
    var jobRequirementItems : [String] = []
    var jobRequirementItemsDesc : [String] = []
    
    
    let qualificationView = UIView()
    let qualificationsLabel : UILabel = {
        let label = UILabel()
        label.text = "Nil"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    
    
    let whatWeOfferView = UIView()
    let whatWeOfferLabel : UILabel = {
        let label = UILabel()
        label.text = "Nil"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    var whatWeOfferArray : [String] = []
    
    
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
    let softwaresLabel : UILabel = {
        let label = UILabel()
        label.text = "Nil"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#344054")
        label.numberOfLines = 0
        return label
    }()
    
    
    
    var savedJobs2 : [String] = []
    
    
//    var selectedJob: Job! {
//        didSet {
//            DispatchQueue.main.async {
//                self.assignValues()
//                self.setupViews()
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        print(selectedJob!)
        
        
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
        
//        companyDescLabel.text = company?.description
        
        jobSummaryLabel.text = selectedJob.jobSummary
        
        
        jobResponsibilityItems.removeAll()
        jobResponsibilityItemsDesc.removeAll()
        if let responsibilities = selectedJob.keyResponsibilities {
            for responsibility in responsibilities {
                let title = String(responsibility.title.dropFirst(0))
                let desc = responsibility.shortDescription
                jobResponsibilityItems.append(title)
                jobResponsibilityItemsDesc.append(desc)
            }
        }
        
        jobRequirementItems.removeAll()
        jobRequirementItemsDesc.removeAll()
        for requirement in selectedJob.requirements {
            let title = String(requirement.title.dropFirst(0))
            let desc = requirement.shortDescription
            jobRequirementItems.append(title)
            jobRequirementItemsDesc.append(desc)
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
        
        let qualificationTitle = selectedJob.preferredQualification.map { $0 }
        let qString = qualificationTitle?.joined(separator: ", ") ?? ""
        qualificationsLabel.text = qString
        
        
        whatWeOfferArray.removeAll()
        if let whatWeOffer = selectedJob.whatWeOffer {
            for item in whatWeOffer {
                whatWeOfferArray.append(item)
            }
        }
        
        
        
        let softwareItems = selectedJob.softwares.map { $0 }
        let softwares = softwareItems.joined(separator: ", ")
        softwaresLabel.text = softwares
        
        
        
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
    
    func assignValues2ForSavedJob() {
        
        jobSummaryLabel.text = selectedJob.jobSummary
        
        jobResponsibilityItems.removeAll()
        jobResponsibilityItemsDesc.removeAll()
        if let responsibilities = selectedJob.keyResponsibilities {
            for responsibility in responsibilities {
                let title = String(responsibility.title.dropFirst(0))
                let desc = responsibility.shortDescription
                jobResponsibilityItems.append(title)
                jobResponsibilityItemsDesc.append(desc)
            }
        }
        
        jobRequirementItems.removeAll()
        jobRequirementItemsDesc.removeAll()
        for requirement in selectedJob.requirements {
            let title = String(requirement.title.dropFirst(0))
            let desc = requirement.shortDescription
            jobRequirementItems.append(title)
            jobRequirementItemsDesc.append(desc)
        }
        
        whatWeOfferArray.removeAll()
        if let whatWeOffer = selectedJob.whatWeOffer {
            for item in whatWeOffer {
                whatWeOfferArray.append(item)
            }
        }
    }
    
    @objc func shareButtonTapped() {
        print("Share button tapped")
    }
    
    func setupViews() {
        setupScrollView()
        setupHeaderView()
        
        setupCompanyDescView()
        
        setupJobSummaryView()
        
        setupResponsibilityView()
        
        setupRequirementsView()
        
        setupQualificationView()
        
        setupWhatWeOfferView()
        
        setupMoreJobInfo()
                
//        view.layoutIfNeeded()
//        scrollView.layoutIfNeeded()
        DispatchQueue.main.async {
            self.updateScrollViewHeight()
        }
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
//        let contentHeight = view.bounds.height - 300
//        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    func updateScrollViewHeight() {
        let h = moreJobInfo.frame.origin.y + moreJobInfo.frame.height
        scrollView.contentSize = CGSize(width: view.frame.width, height: h + 40)
    }

    func setupHeaderView() {
        headerView = UIView()
        headerView.backgroundColor = UIColor(hex: "#F9FAFB")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 170)
        ])
        
        companyLogo.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(companyLogo)
        
        jobTitle.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(jobTitle)
        
        companyName.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(companyName)
        
        NSLayoutConstraint.activate([
            companyLogo.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            companyLogo.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            companyLogo.widthAnchor.constraint(equalToConstant: 48),
            companyLogo.heightAnchor.constraint(equalToConstant: 46),
            
            jobTitle.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            jobTitle.leadingAnchor.constraint(equalTo: companyLogo.trailingAnchor, constant: 16),
            jobTitle.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            jobTitle.heightAnchor.constraint(equalToConstant: 24),
            
            companyName.topAnchor.constraint(equalTo: jobTitle.bottomAnchor, constant: 4),
            companyName.leadingAnchor.constraint(equalTo: companyLogo.trailingAnchor, constant: 16),
            companyName.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
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
        
//        print(savedJobs2)
        if savedJobs2.contains(selectedJob.id) {
            saveButton.setTitle("Saved", for: .normal)
        }
        else {
            saveButton.setTitle("Save", for: .normal)
        }
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        saveButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        saveButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 12
        saveButton.clipsToBounds = true
        saveButton.titleLabel?.textAlignment = .center
        
//        saveButton.addTarget(self, action: #selector(didTapSaveJob), for: .touchUpInside)
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

//            if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                print("Response from server: \(responseString)")
//            }

            if httpResponse.statusCode == 200 {
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let msg = json["msg"] as? String, msg == "not applied" {
//                    print("Job is not applied")
                } else {
//                    print("Job is already applied")
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

        let jobId = selectedJob.id

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
            
//            if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                print("Response from server: \(responseString)")
//            }
            
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

    
    func setupCompanyDescView() {
        companyDescView.layer.borderWidth = 1
        companyDescView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        companyDescView.layer.cornerRadius = 12
        companyDescView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(companyDescView)
        
        
        let description = UILabel()
        description.text = "Company Overview"
        description.font = .boldSystemFont(ofSize: 16)
        description.tintColor = UIColor(hex: "#101828")
        
        description.translatesAutoresizingMaskIntoConstraints = false
        companyDescView.addSubview(description)
        
        companyDescLabel.translatesAutoresizingMaskIntoConstraints = false
        companyDescView.addSubview(companyDescLabel)
        
        NSLayoutConstraint.activate([
            companyDescView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            companyDescView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            companyDescView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            description.topAnchor.constraint(equalTo: companyDescView.topAnchor, constant: 20),
            description.leadingAnchor.constraint(equalTo: companyDescView.leadingAnchor, constant: 16),
            description.heightAnchor.constraint(equalToConstant: 18),
            
            companyDescLabel.topAnchor.constraint(equalTo: description.bottomAnchor, constant: 6),
            companyDescLabel.leadingAnchor.constraint(equalTo: companyDescView.leadingAnchor, constant: 16),
            companyDescLabel.trailingAnchor.constraint(equalTo: companyDescView.trailingAnchor, constant: -16),
            
            companyDescView.bottomAnchor.constraint(equalTo: companyDescLabel.bottomAnchor, constant: 20)
        ])
    }
    
    
    func setupJobSummaryView() {
        jobSummaryView.layer.borderWidth = 1
        jobSummaryView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        jobSummaryView.layer.cornerRadius = 12
        jobSummaryView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(jobSummaryView)
        
        
        let description = UILabel()
        description.text = "Job Summary"
        description.font = .boldSystemFont(ofSize: 16)
        description.tintColor = UIColor(hex: "#101828")
        
        description.translatesAutoresizingMaskIntoConstraints = false
        jobSummaryView.addSubview(description)
        
        jobSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        jobSummaryView.addSubview(jobSummaryLabel)
        
        NSLayoutConstraint.activate([
            jobSummaryView.topAnchor.constraint(equalTo: companyDescView.bottomAnchor, constant: 20),
            jobSummaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jobSummaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            description.topAnchor.constraint(equalTo: jobSummaryView.topAnchor, constant: 20),
            description.leadingAnchor.constraint(equalTo: jobSummaryView.leadingAnchor, constant: 16),
            description.heightAnchor.constraint(equalToConstant: 18),
            
            jobSummaryLabel.topAnchor.constraint(equalTo: description.bottomAnchor, constant: 6),
            jobSummaryLabel.leadingAnchor.constraint(equalTo: jobSummaryView.leadingAnchor, constant: 16),
            jobSummaryLabel.trailingAnchor.constraint(equalTo: jobSummaryView.trailingAnchor, constant: -16),
            
            jobSummaryView.bottomAnchor.constraint(equalTo: jobSummaryLabel.bottomAnchor, constant: 20)
        ])
    }
    
    
    func setupResponsibilityView() {
        responsibilityView.layer.borderWidth = 1
        responsibilityView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        responsibilityView.layer.cornerRadius = 12
        responsibilityView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(responsibilityView)
        
        NSLayoutConstraint.activate([
            responsibilityView.topAnchor.constraint(equalTo: jobSummaryView.bottomAnchor, constant: 20),
            responsibilityView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            responsibilityView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
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
        
        let descriptionStackView = UIStackView()
        descriptionStackView.axis = .vertical
        descriptionStackView.spacing = 0 // Adjust spacing between items
        
        for (index, item) in jobResponsibilityItems.enumerated() {
            let bulletLabelText = "\u{2022} " // Unicode bullet symbol with a space
            let attributedText = NSMutableAttributedString(string: bulletLabelText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black])
            
            let text = NSAttributedString(string: item, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor(hex: "#101828")])
            
            attributedText.append(text)
            
            let bulletLabel = UILabel()
            bulletLabel.attributedText = attributedText
            bulletLabel.numberOfLines = 0 // Allow multiline text
            descriptionStackView.addArrangedSubview(bulletLabel)
            
            // Add the corresponding item from jobResponsibilityItemsDesc
            if index < jobResponsibilityItemsDesc.count {
                let descText = jobResponsibilityItemsDesc[index]
                
                let descLabel = UILabel()
                descLabel.text = descText
                descLabel.font = UIFont.systemFont(ofSize: 14)
                descLabel.textColor = UIColor(hex: "#344054")
                descLabel.numberOfLines = 0 // Allow multiline text
                descriptionStackView.addArrangedSubview(descLabel)
            }
        }

        
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        responsibilityView.addSubview(descriptionStackView)
        
        NSLayoutConstraint.activate([
            descriptionStackView.topAnchor.constraint(equalTo: rolesLabel.bottomAnchor, constant: 10),
            descriptionStackView.leadingAnchor.constraint(equalTo: responsibilityView.leadingAnchor, constant: 16),
            descriptionStackView.trailingAnchor.constraint(equalTo: responsibilityView.trailingAnchor, constant: -16),
            descriptionStackView.bottomAnchor.constraint(equalTo: responsibilityView.bottomAnchor, constant: 0),
            
            responsibilityView.bottomAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 20)
        ])
    }
    
    
    func setupRequirementsView() {
        requirementsView.layer.borderWidth = 1
        requirementsView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        requirementsView.layer.cornerRadius = 12
        requirementsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(requirementsView)
        
        NSLayoutConstraint.activate([
            requirementsView.topAnchor.constraint(equalTo: responsibilityView.bottomAnchor, constant: 20),
            requirementsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            requirementsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
        
        let requirementsStackView = UIStackView()
        requirementsStackView.axis = .vertical
        requirementsStackView.spacing = 0 // Adjust spacing between items
        
//        for item in jobRequirementItems {
//            let bulletLabelText = "\u{2022} " // Unicode bullet symbol with a space
//            let attributedText = NSMutableAttributedString(string: bulletLabelText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black])
//            
//            let text = NSAttributedString(string: item, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor(hex: "#344054")])
//            
//            attributedText.append(text)
//            
//            let bulletLabel = UILabel()
//            bulletLabel.attributedText = attributedText
//            bulletLabel.numberOfLines = 0 // Allow multiline text
//            requirementsStackView.addArrangedSubview(bulletLabel)
//        }
        
        for (index, item) in jobRequirementItems.enumerated() {
            let bulletLabelText = "\u{2022} " // Unicode bullet symbol with a space
            let attributedText = NSMutableAttributedString(string: bulletLabelText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black])
            
            let text = NSAttributedString(string: item, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor(hex: "#101828")])
            
            attributedText.append(text)
            
            let bulletLabel = UILabel()
            bulletLabel.attributedText = attributedText
            bulletLabel.numberOfLines = 0 // Allow multiline text
            requirementsStackView.addArrangedSubview(bulletLabel)
            
            // Add the corresponding item from jobResponsibilityItemsDesc
            if index < jobRequirementItemsDesc.count {
                let descText = jobRequirementItemsDesc[index]
                
                let descLabel = UILabel()
                descLabel.text = descText
                descLabel.font = UIFont.systemFont(ofSize: 14)
                descLabel.textColor = UIColor(hex: "#344054")
                descLabel.numberOfLines = 0 // Allow multiline text
                requirementsStackView.addArrangedSubview(descLabel)
            }
        }
        
        requirementsStackView.translatesAutoresizingMaskIntoConstraints = false
        requirementsView.addSubview(requirementsStackView)
        
        NSLayoutConstraint.activate([
            requirementsStackView.topAnchor.constraint(equalTo: requirementsLabel.bottomAnchor, constant: 10),
            requirementsStackView.leadingAnchor.constraint(equalTo: requirementsView.leadingAnchor, constant: 16),
            requirementsStackView.trailingAnchor.constraint(equalTo: requirementsView.trailingAnchor, constant: -16),
            requirementsStackView.bottomAnchor.constraint(equalTo: requirementsView.bottomAnchor, constant: 0),
            
            requirementsView.bottomAnchor.constraint(equalTo: requirementsStackView.bottomAnchor, constant: 20)
        ])
    }
    
    
    func setupQualificationView() {
        qualificationView.layer.borderWidth = 1
        qualificationView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        qualificationView.layer.cornerRadius = 12
        qualificationView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(qualificationView)
        
        
        let qualifications = UILabel()
        qualifications.text = "Qualifications :"
        qualifications.font = .boldSystemFont(ofSize: 16)
        qualifications.tintColor = UIColor(hex: "#101828")
        
        qualifications.translatesAutoresizingMaskIntoConstraints = false
        qualificationView.addSubview(qualifications)
        
        qualificationsLabel.translatesAutoresizingMaskIntoConstraints = false
        qualificationView.addSubview(qualificationsLabel)
        
        NSLayoutConstraint.activate([
            qualificationView.topAnchor.constraint(equalTo: requirementsView.bottomAnchor, constant: 20),
            qualificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            qualificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            qualifications.topAnchor.constraint(equalTo: qualificationView.topAnchor, constant: 20),
            qualifications.leadingAnchor.constraint(equalTo: qualificationView.leadingAnchor, constant: 16),
            qualifications.heightAnchor.constraint(equalToConstant: 18),
            
            qualificationsLabel.topAnchor.constraint(equalTo: qualifications.bottomAnchor, constant: 6),
            qualificationsLabel.leadingAnchor.constraint(equalTo: qualificationView.leadingAnchor, constant: 16),
            qualificationsLabel.trailingAnchor.constraint(equalTo: qualificationView.trailingAnchor, constant: -16),
            
            qualificationView.bottomAnchor.constraint(equalTo: qualificationsLabel.bottomAnchor, constant: 20)
        ])
    }
    
    
    func setupWhatWeOfferView() {
        whatWeOfferView.layer.borderWidth = 1
        whatWeOfferView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        whatWeOfferView.layer.cornerRadius = 12
        whatWeOfferView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(whatWeOfferView)
        
        
        let title = UILabel()
        title.text = "What we offer :"
        title.font = .boldSystemFont(ofSize: 16)
        title.tintColor = UIColor(hex: "#101828")
        
        title.translatesAutoresizingMaskIntoConstraints = false
        whatWeOfferView.addSubview(title)
        
        
        NSLayoutConstraint.activate([
            whatWeOfferView.topAnchor.constraint(equalTo: qualificationView.bottomAnchor, constant: 20),
            whatWeOfferView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            whatWeOfferView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            title.topAnchor.constraint(equalTo: whatWeOfferView.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: whatWeOfferView.leadingAnchor, constant: 16),
            title.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        
        for item in whatWeOfferArray {
            let bulletLabelText = "\u{2022} " // Unicode bullet symbol with a space
            let attributedText = NSMutableAttributedString(string: bulletLabelText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black])
            
            let text = NSAttributedString(string: item, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor(hex: "#344054")])
            
            attributedText.append(text)
            
            let bulletLabel = UILabel()
            bulletLabel.attributedText = attributedText
            bulletLabel.numberOfLines = 0 // Allow multiline text
            stackView.addArrangedSubview(bulletLabel)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        whatWeOfferView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: whatWeOfferView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: whatWeOfferView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: whatWeOfferView.bottomAnchor, constant: 0),
            
            whatWeOfferView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20)
        ])
    }
    
    
    func setupMoreJobInfo() {
        moreJobInfo.layer.borderWidth = 1
        moreJobInfo.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        moreJobInfo.layer.cornerRadius = 12
        moreJobInfo.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(moreJobInfo)
        
        NSLayoutConstraint.activate([
            moreJobInfo.topAnchor.constraint(equalTo: whatWeOfferView.bottomAnchor, constant: 20),
            moreJobInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            moreJobInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
            location.widthAnchor.constraint(equalToConstant: 80),
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
            workmodeLabel.trailingAnchor.constraint(equalTo: moreJobInfo.trailingAnchor, constant: -16),
            
            moreJobInfo.bottomAnchor.constraint(equalTo: workmodeLabel.bottomAnchor, constant: 20)
        ])
    }
    
    
    
    

    @objc func didTapSaveJob(_ sender : UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        let job = selectedJob
        
        if savedJobs2.contains(selectedJob.id) {  // Already saved, remove it from saved jobs
            let index = savedJobs2.firstIndex(of: selectedJob.id)
            savedJobs2.remove(at: index!)
            saveButton.setTitle("Save", for: .normal)
            saveOrUnsaveJob(id: selectedJob.id)
        }
        
        else {  // Not saved, save this job
            savedJobs2.append(selectedJob.id)
            saveButton.setTitle("Saved", for: .normal)
            saveOrUnsaveJob(id: selectedJob.id)
        }
    }
    
    func saveOrUnsaveJob(id: String) {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/save-job/save") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Access Token not found")
            return
        }

        let body: [String: Any] = ["jobId": id]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            print("Failed to encode jobId: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network request failed: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
        }.resume()
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
        
//        fetchJob()
        fetchCompany()
//        fetchSavedJobIDs()
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
    
}


extension JobDetailScreen {
    
    func fetchJob() {
        let urlString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/jobs/\(selectedJob.id)"
        print("Url String to fetch: \(urlString)")

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                // Decode the raw JSON into a dictionary
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let jobData = jsonObject["job"] {
                    // Convert the jobData to JSON data
                    let jobJSONData = try JSONSerialization.data(withJSONObject: jobData)
                    // Decode the jobJSONData into a Job struct
                    let job = try JSONDecoder().decode(Job.self, from: jobJSONData)
                    DispatchQueue.main.async {
//                        self.selectedJob = job
//                        self.setupViews()
//                        if self.savedJobs2.contains(self.selectedJob.id) {
//                            self.assignValues2ForSavedJob()
//                        }
                        
//                        self.assignValues()
//                        print(job)
                    }
                } else {
                    print("Invalid JSON structure")
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }

    func fetchCompany() {
        var urlString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/jobs/\(selectedJob.id)"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }


        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Raw response data: \(responseString)")
//            }
            
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let jobData = jsonObject["company"] {
                    // Convert the jobData to JSON data
                    let jobJSONData = try JSONSerialization.data(withJSONObject: jobData)
                    // Decode the jobJSONData into a Job struct
                    let company = try JSONDecoder().decode(Company.self, from: jobJSONData)
                    DispatchQueue.main.async {
                        self.companyDescLabel.text = company.description
                    }
                } else {
                    print("Invalid JSON structure")
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
    
    func fetchSavedJobIDs() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/save-job/get-saved-jobs") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            print(accessToken, " access token")
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
                let response = try JSONDecoder().decode(SavedJobsResponse.self, from: data)
                let jobIDs = response.savedJobs.savedJobs
                
                DispatchQueue.main.async {
                    self.savedJobs2 = jobIDs
//                    print(self.savedJobs2)
                    print("Fetching done")
                }
                
            } catch {
                print("Failed to decode Saved IDs JSON: \(error)")
            }
        }
        task.resume()
        
    }
}
