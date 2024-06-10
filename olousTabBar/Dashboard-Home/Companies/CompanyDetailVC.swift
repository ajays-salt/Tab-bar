//
//  CompanyDetailScreen.swift
//  olousTabBar
//
//  Created by Salt Technologies on 09/05/24.
//

import UIKit

class CompanyDetailVC: UIViewController {
        
    var company : Company!
    let nameLabel = UILabel()
    let companyTypeAndLocation = UILabel()
    
    var categorySection = UIView()
    var aboutButton : UIButton = {
        let button = UIButton()
        button.setTitle("About", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(hex: "#475467"), for: .normal)
        return button
    }()
    var jobsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Jobs", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(hex: "#475467"), for: .normal)
        return button
    }()
    var isSelected : String = "About"
    
    let lineView = UIView()
    var leadingConstraint: NSLayoutConstraint!
    var widthConstraint: NSLayoutConstraint!

    
    var aboutView = UIScrollView()
    var jobsCollectionView: UICollectionView!
    
    var jobs: [Job] = []
    var appliedJobs : [String] = []
    var savedJobs2 : [String] = []
    
    var noJobsImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        print("Company " ,company)
//        fetchData { result in
//            switch result {
//            case .success(let fetchedJobs):
//                self.jobs = fetchedJobs
//                print("jobs fetched successfully")
////                DispatchQueue.main.async {
////                    self.setupViews()
////                }
//            case .failure(let error):
//                print("Error fetching data: \(error)")
//            }
//        }
        
        setupViews()
    }
    
    
    private func setupViews() {
        setupImagesAndName()
        setupTypeAndLocationLabel()
        setupCategorySection()
        setupLineView()
        
        setupAboutView()
        setupJobsCollectionView()
        updateViewSelection()
        setupNoJobsImageView()
    }
    
    private func setupImagesAndName() {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "backgroundImage") // Use the correct image name
        backgroundImageView.backgroundColor = .systemGray6
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(systemName: "photo.artframe") // Provide your logo image name
//        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        let baseURLString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/company-pic?logo="
        let companyLogoURLString = baseURLString + (company.logo ?? "")
        if let companyLogoURL = URL(string: companyLogoURLString) {
            URLSession.shared.dataTask(with: companyLogoURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        logoImageView.image = image
                    }
                }
                DispatchQueue.main.async {
                    if logoImageView.image == nil {
                        logoImageView.image = UIImage(systemName: "photo.artframe")
                    }
                }
            }.resume()
        }
        
        
        if let firstCharacter = company.name.first, !firstCharacter.isUppercase {
            nameLabel.text = company.name.prefix(1).uppercased() + company.name.dropFirst()
        } else {
            nameLabel.text = company.name
        }
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        let visitWebsiteButton = UIButton(type: .system)
        visitWebsiteButton.setTitle("Visit Website", for: .normal)
        visitWebsiteButton.setTitleColor(.white, for: .normal)
        visitWebsiteButton.backgroundColor = UIColor(hex: "#0079C4")
        visitWebsiteButton.layer.cornerRadius = 12
        visitWebsiteButton.addTarget(self, action: #selector(visitWebsite), for: .touchUpInside)
        visitWebsiteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(visitWebsiteButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            visitWebsiteButton.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 10),
            visitWebsiteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            visitWebsiteButton.widthAnchor.constraint(equalToConstant: 120),
            visitWebsiteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
    
    @objc func visitWebsite() {
        guard let url = URL(string: company.website ?? "") else {
            print("Invalid URL")
            return
        }
        UIApplication.shared.open(url)
    }
    
    
    private func setupTypeAndLocationLabel() {
        
        companyTypeAndLocation.text = "\(company.who ?? "NA") • \(company.location ?? "No Location")"
        companyTypeAndLocation.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        companyTypeAndLocation.textAlignment = .center
        companyTypeAndLocation.textColor = .systemGray2
        companyTypeAndLocation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(companyTypeAndLocation)
        
        NSLayoutConstraint.activate([
            companyTypeAndLocation.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            companyTypeAndLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    func setupCategorySection() {
        categorySection.backgroundColor = UIColor(hex: "#C7EAFF")
        categorySection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categorySection)
        
        NSLayoutConstraint.activate([
            categorySection.topAnchor.constraint(equalTo: companyTypeAndLocation.bottomAnchor, constant: 20),
            categorySection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categorySection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categorySection.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        aboutButton.addTarget(self, action: #selector(didTapAboutButton), for: .touchUpInside)
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        categorySection.addSubview(aboutButton)
        
        NSLayoutConstraint.activate([
            aboutButton.topAnchor.constraint(equalTo: categorySection.topAnchor, constant: 10),
            aboutButton.leadingAnchor.constraint(equalTo: categorySection.leadingAnchor, constant: 24),
            aboutButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        
        jobsButton.addTarget(self, action: #selector(didTapJobsButton), for: .touchUpInside)
        jobsButton.translatesAutoresizingMaskIntoConstraints = false
        categorySection.addSubview(jobsButton)
        
        NSLayoutConstraint.activate([
            jobsButton.topAnchor.constraint(equalTo: categorySection.topAnchor, constant: 10),
            jobsButton.leadingAnchor.constraint(equalTo: aboutButton.trailingAnchor, constant: 36),
            jobsButton.widthAnchor.constraint(equalToConstant: 70),
            jobsButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
    }
    
    func setupLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        lineView.backgroundColor = UIColor(hex: "#0079C4")
        
        lineView.topAnchor.constraint(equalTo: categorySection.topAnchor, constant: 37).isActive = true
        leadingConstraint = lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        leadingConstraint.isActive = true
        widthConstraint = lineView.widthAnchor.constraint(equalToConstant: 60)
        widthConstraint.isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    @objc func didTapAboutButton() {
        if isSelected != "About" {
            isSelected = "About"
            updateViewSelection()
            aboutButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            jobsButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            
            UIView.animate(withDuration: 0.5) {
                self.leadingConstraint.constant = 21
                self.widthConstraint.constant = 60
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func didTapJobsButton() {
        if isSelected != "Jobs" {
            isSelected = "Jobs"
            updateViewSelection()
            jobsButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            aboutButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            
            UIView.animate(withDuration: 0.5) {
                self.leadingConstraint.constant = 122
                self.widthConstraint.constant = 52
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func setupAboutView() {
        aboutView.backgroundColor = UIColor(hex: "#FAFAFA")
        aboutView.contentSize = CGSize(width: view.bounds.width, height: 1000)
        aboutView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutView)

        NSLayoutConstraint.activate([
            aboutView.topAnchor.constraint(equalTo: categorySection.bottomAnchor, constant: 10),
            aboutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        var lastBottomAnchor = aboutView.topAnchor
        
        let sections: [(String, String)] = [
            ("Company Description", company.description ?? ""),
            ("Website", company.website ?? ""),
            ("Sectors", company.sector?.joined(separator: ",") ?? ""),
            ("Category", company.who ?? ""),
            ("Field", company.field ?? ""),
            ("Company Size", "\(company.size ?? "NA")")
        ]
        
        for section in sections {
            lastBottomAnchor = addSection(title: section.0, content: section.1, toView: aboutView, topAnchor: lastBottomAnchor)
        }
        
        // This is critical to make the UIScrollView scrollable
        aboutView.bottomAnchor.constraint(equalTo: lastBottomAnchor, constant: 20).isActive = true
    }
    
    private func addSection(title: String, content: String, toView parentView: UIView, topAnchor: NSLayoutYAxisAnchor) -> NSLayoutYAxisAnchor {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.text = title
        parentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        let contentLabel = UILabel()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        contentLabel.text = content
        parentView.addSubview(contentLabel)

        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        return contentLabel.bottomAnchor
    }
    

    private func setupJobsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        jobsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        jobsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        jobsCollectionView.isHidden = true
        
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
        view.addSubview(jobsCollectionView)

        NSLayoutConstraint.activate([
            jobsCollectionView.topAnchor.constraint(equalTo: categorySection.bottomAnchor, constant: 10),
            jobsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            jobsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            jobsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)  // Adjust based on your content
        ])

        jobsCollectionView.register(JobsCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func setupNoJobsImageView() {
        noJobsImageView = UIImageView()
        noJobsImageView.image = UIImage(named: "no-jobs")  // Ensure you have this image in your assets
        
        noJobsImageView.translatesAutoresizingMaskIntoConstraints = false
        noJobsImageView.isHidden = true  // Hide it by default
        view.addSubview(noJobsImageView)

        NSLayoutConstraint.activate([
            noJobsImageView.topAnchor.constraint(equalTo: categorySection.bottomAnchor, constant: 50),
            noJobsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noJobsImageView.widthAnchor.constraint(equalToConstant: 300),
            noJobsImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }

    private func updateViewSelection() {
        aboutView.isHidden = isSelected != "About"
        jobsCollectionView.isHidden = isSelected != "Jobs"
        
        jobsCollectionView.reloadData()
        
        noJobsImageView.isHidden = true
        
        if jobsCollectionView.isHidden == false {
            if jobs.isEmpty {
                jobsCollectionView.isHidden = true
                noJobsImageView.isHidden = false
            }
        }
    }

    
    @objc func didTapSaveJob(_ sender : UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        guard let cell = jobsCollectionView.cellForItem(at: indexPath) as? JobsCell else {
            return
        }
        
        let job = jobs[indexPath.row]
        
        if savedJobs2.contains(job.id) {  // Already saved, remove it from saved jobs
            let index = savedJobs2.firstIndex(of: job.id)
            savedJobs2.remove(at: index!)
            
            saveOrUnsaveJob(id: job.id)
            
            let attributedString = getAttributedString(image: "bookmark", tintColor: UIColor(hex: "#475467"), title: "Save")
            cell.saveButton.tintColor = UIColor(hex: "#475467")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        
        else {  // Not saved, save this job
            savedJobs2.append(job.id)
            
            saveOrUnsaveJob(id: job.id)
            
            let attributedString = getAttributedString(image: "bookmark.fill", tintColor: UIColor(hex: "#667085"), title: "Saved")
            cell.saveButton.tintColor = UIColor(hex: "#667085")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
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
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
        
        fetchData { result in
            switch result {
            case .success(let fetchedJobs):
                self.jobs = fetchedJobs
                print("jobs fetched successfully")
//                DispatchQueue.main.async {
//                    self.setupViews()
//                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
        
        fetchTotalAppliedJobs()
        fetchSavedJobIDs()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
}

extension CompanyDetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! JobsCell
        let job = jobs[indexPath.row]
        
        if appliedJobs.contains(job.id) {
            cell.appliedLabel.isHidden = false
        }
        else {
            cell.appliedLabel.isHidden = true
        }
        
        if savedJobs2.contains(job.id) {
            let attributedString = getAttributedString(image: "bookmark.fill", tintColor: UIColor(hex: "#2563EB"), title: "Saved")
            cell.saveButton.tintColor = UIColor(hex: "#2563EB")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        else {
            let attributedString = getAttributedString(image: "bookmark",tintColor: UIColor(hex: "#2563EB"), title: "Save")
            cell.saveButton.tintColor = UIColor(hex: "#475467")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        
        cell.saveButton.addTarget(self, action: #selector(didTapSaveJob(_:)), for: .touchUpInside)
        cell.saveButton.tag = indexPath.row
        
        cell.jobTitle.text = job.title
        cell.companyName.text = job.companyName ?? job.companyName
        
        if job.workPlace == "office based" {
            cell.workPlaceLabel.text = "Office Based"
            cell.workPlaceView.backgroundColor = UIColor(hex: "#FEF3F2")
            cell.workPlaceLabel.textColor = UIColor(hex: "#D92D20")
        }
        else {
            cell.workPlaceLabel.text = "Hybrid(Office + Site)"
            cell.workPlaceView.backgroundColor = UIColor(hex: "#ECFDF3")
            cell.workPlaceLabel.textColor = UIColor(hex: "#067647")
            
            if let widthConstraint = cell.workPlaceView.constraints.first(where: { $0.firstAttribute == .width }) {
                cell.workPlaceView.removeConstraint(widthConstraint)
            }
            let widthConstraint = cell.workPlaceView.widthAnchor.constraint(equalToConstant: 160)
            widthConstraint.isActive = true
        }
        
        cell.jobLocationLabel.text = "\(job.location?.city ?? ""), \(job.location?.state ?? "")"
        
        var text = "\(job.salaryRangeFrom ?? "NA") - \(job.salaryRangeTo ?? "NA")"
        if text.hasSuffix("LPA") {
            cell.salaryLabel.text = text
        }
        else {
            cell.salaryLabel.text = "\(text) LPA"
        }
        
        cell.jobTypeLabel.text = job.jobType
        
        let s = getTimeAgoString(from: job.createdAt ?? "")
        cell.jobPostedTime.text = s
        
        let expText = attributedStringForExperience("\(job.minExperience ?? "")-\(job.maxExperience ?? "")")
        cell.jobExperienceLabel.attributedText = expText
        
        // Fetch company logo asynchronously
        let baseURLString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/company-pic?logo="
        let companyLogoURLString = baseURLString + (company.logo ?? "")
        if let companyLogoURL = URL(string: companyLogoURLString) {
            URLSession.shared.dataTask(with: companyLogoURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.companyLogo.image = image
                    }
                }
            }.resume()
        }
        
        cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedJob = jobs[indexPath.row]
        let jobDetailVC = JobDetailScreen()
        jobDetailVC.selectedJob = selectedJob
        navigationController?.pushViewController(jobDetailVC, animated: true)
    }
    
    
    func getAttributedString(image: String, tintColor: UIColor, title : String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        
        let symbolAttachment = NSTextAttachment()
        symbolAttachment.image = UIImage(systemName: image)?.withTintColor(tintColor)
        
        let symbolString = NSAttributedString(attachment: symbolAttachment)
        attributedString.append(symbolString)
        
//        attributedString.append(NSAttributedString(string: " "))
//        
//        let textString = NSAttributedString(string: title)
//        attributedString.append(textString)
        
        return attributedString
    }
    
    func getTimeAgoString(from createdAt: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = dateFormatter.date(from: createdAt) else {
            return "Invalid date"
        }
        
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: now)
        
        if let year = components.year, year > 0 {
            return "\(year) year\(year == 1 ? "" : "s") ago"
        } else if let month = components.month, month > 0 {
            return "\(month) month\(month == 1 ? "" : "s") ago"
        } else if let day = components.day, day > 0 {
            return "\(day) day\(day == 1 ? "" : "s") ago"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour) hour\(hour == 1 ? "" : "s") ago"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute) minute\(minute == 1 ? "" : "s") ago"
        } else {
            return "Just now"
        }
    }
    
    func attributedStringForExperience(_ experience: String) -> NSAttributedString {
        // Create a mutable attributed string
        let attributedString = NSMutableAttributedString()
        
//        attributedString.append(NSAttributedString(string: "|"))
//        attributedString.append(NSAttributedString(string: "  "))
        
        let symbolAttachment = NSTextAttachment()
        symbolAttachment.image = UIImage(systemName: "briefcase")?.withTintColor(UIColor(hex: "#667085"))
        
        let symbolString = NSAttributedString(attachment: symbolAttachment)
//        attributedString.append(symbolString)
        
//        attributedString.append(NSAttributedString(string: "      "))
        attributedString.append(NSAttributedString(string: experience))
        if !experience.hasSuffix("years") {
            attributedString.append(NSAttributedString(string: " years"))
        }
        
//        let textString = NSAttributedString(string: "1-5 years")
//        attributedString.append(textString)

        return attributedString
    }
}

extension CompanyDetailVC {
    
    func fetchData(completion: @escaping (Result<[Job], Error>) -> Void) {
        
        let urlStr = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/jobs/\(company.id)"
        print("Company ID ",company.id)
        
        guard let url = URL(string: urlStr) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown Error", code: 0, userInfo: nil)))
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw response data: \(responseString)")
            }
            
            do {
                   if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                       print(jsonObject)
                   } else {
                       print("Data is not a valid JSON object")
                   }
               } catch {
                   print("Failed to convert data to JSON:", error)
               }
            
            do {
                let jobResponse = try JSONDecoder().decode(CompanyJobResponse.self, from: data)
                completion(.success(jobResponse.jobs))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchTotalAppliedJobs() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/appliedJobs") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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
            
            // Print the raw response data as a string
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Raw response data: \(responseString)")
//            }

            do {
                // Decode the JSON response as a dictionary with jobIds array
                let responseDict = try JSONDecoder().decode([String: [String]].self, from: data)
                
                if let jobIds = responseDict["jobIds"] {
                    print("Job IDs: \(jobIds)")
                    
                    // Process the job IDs as needed
                    DispatchQueue.main.async {
                        self.appliedJobs = jobIds
                        if self.jobsCollectionView != nil {
                            self.jobsCollectionView.reloadData()
                        }
                    }
                } else {
                    print("Failed to find job IDs in the response")
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        task.resume()
    }
    
    func fetchSavedJobIDs() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/save-job/get-saved-jobs") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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
            
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Raw response data: \(responseString)")
//            }
            
            do {
                let response = try JSONDecoder().decode(SavedJobsResponse.self, from: data)
                let jobIDs = response.savedJobs.savedJobs
                
                DispatchQueue.main.async {
                    self.savedJobs2 = jobIDs
                    print("saved Job IDs " , self.savedJobs2)
                }
                
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        task.resume()
    }
}
