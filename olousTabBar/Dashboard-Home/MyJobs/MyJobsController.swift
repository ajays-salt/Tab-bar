//
//  JobsController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class MyJobsController: UIViewController {
    
    var isSelected : String = "Recommended"
    var savedJobs = [IndexPath]()
    var jobs: [Job] = []
    var appliedJobs : [String] = []
    
    enum CollectionState {
        case recommended
        case applied
        case saved
    }
    var collectionState: CollectionState = .recommended {
        didSet {
            // Reload collection view data when collectionState changes
            jobsCollectionView.reloadData()
        }
    }
    
    var notificationBellIcon : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "bell")
        imgView.tintColor = UIColor(hex: "#000000")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    var categorySection = UIView()
    var recommendedButton : UIButton = {
        let button = UIButton()
        button.setTitle("Recommended", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(hex: "#475467"), for: .normal)
        return button
    }()
    var appliedButton : UIButton = {
        let button = UIButton()
        button.setTitle("Applied", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(hex: "#475467"), for: .normal)
        return button
    }()
    var savedButton : UIButton = {
        let button = UIButton()
        button.setTitle("Saved", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(hex: "#475467"), for: .normal)
        return button
    }()
    
    let lineView = UIView()
    var leadingConstraint: NSLayoutConstraint!
    var widthConstraint: NSLayoutConstraint!
    
    
    var jobsCountLabel : UILabel = {
        let label = UILabel()
        label.text = "26 recommended jobs"
        label.font = .systemFont(ofSize: 14)
        label.tintColor = UIColor(hex: "#344054")
        return label
    }()
    
    var jobsCollectionView : UICollectionView!
    
    
    var noJobsImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        if isSelected == "Recommended" {
            recommendedButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        }
        
        fetchRecommendedJobs()
        fetchTotalAppliedJobs()
        
        setupViews()
    }
    
    
    func setupViews() {
        setupBellIcon()
        setupCategorySection()
        setupLineView()
        setupJobsCountLabel()
        setupJobsCollectionView()
        setupNoJobsImageView()
    }
    
    func setupBellIcon() {
        notificationBellIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notificationBellIcon)
        NSLayoutConstraint.activate([
            notificationBellIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            notificationBellIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            notificationBellIcon.widthAnchor.constraint(equalToConstant: 30),
            notificationBellIcon.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupCategorySection() {
        categorySection.backgroundColor = UIColor(hex: "#C7EAFF")
        categorySection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categorySection)
        
        NSLayoutConstraint.activate([
            categorySection.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            categorySection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categorySection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categorySection.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        recommendedButton.addTarget(self, action: #selector(didTapRecommendedButton), for: .touchUpInside)
        recommendedButton.translatesAutoresizingMaskIntoConstraints = false
        categorySection.addSubview(recommendedButton)
        
        NSLayoutConstraint.activate([
            recommendedButton.topAnchor.constraint(equalTo: categorySection.topAnchor, constant: 15),
            recommendedButton.leadingAnchor.constraint(equalTo: categorySection.leadingAnchor, constant: 16),
            recommendedButton.widthAnchor.constraint(equalToConstant: 130),
            recommendedButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        appliedButton.addTarget(self, action: #selector(didTapAppliedButton), for: .touchUpInside)
        appliedButton.translatesAutoresizingMaskIntoConstraints = false
        categorySection.addSubview(appliedButton)
        
        NSLayoutConstraint.activate([
            appliedButton.topAnchor.constraint(equalTo: categorySection.topAnchor, constant: 15),
            appliedButton.leadingAnchor.constraint(equalTo: recommendedButton.trailingAnchor, constant: 36),
            appliedButton.widthAnchor.constraint(equalToConstant: 70),
            appliedButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        savedButton.addTarget(self, action: #selector(didTapSavedButton), for: .touchUpInside)
        savedButton.translatesAutoresizingMaskIntoConstraints = false
        categorySection.addSubview(savedButton)
        
        NSLayoutConstraint.activate([
            savedButton.topAnchor.constraint(equalTo: categorySection.topAnchor, constant: 15),
            savedButton.leadingAnchor.constraint(equalTo: appliedButton.trailingAnchor, constant: 32),
            savedButton.widthAnchor.constraint(equalToConstant: 70),
            savedButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        lineView.backgroundColor = UIColor(hex: "#0079C4")
        
        lineView.topAnchor.constraint(equalTo: categorySection.topAnchor, constant: 47).isActive = true
        leadingConstraint = lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        leadingConstraint.isActive = true
        widthConstraint = lineView.widthAnchor.constraint(equalToConstant: 130)
        widthConstraint.isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    func setupJobsCountLabel() {
        jobsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(jobsCountLabel)
        
        NSLayoutConstraint.activate([
            jobsCountLabel.topAnchor.constraint(equalTo: categorySection.bottomAnchor, constant: 20),
            jobsCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jobsCountLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setupJobsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        jobsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        jobsCollectionView.register(JobsCell.self, forCellWithReuseIdentifier: "id2")
        
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
        
        jobsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(jobsCollectionView)
        
        NSLayoutConstraint.activate([
            jobsCollectionView.topAnchor.constraint(equalTo: jobsCountLabel.bottomAnchor, constant: 20),
            jobsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jobsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            jobsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    @objc func didTapSaveJobButton(_ sender : UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        guard let cell = jobsCollectionView.cellForItem(at: indexPath) as? JobsCell else {
            return
        }
            
        if savedJobs.contains(indexPath) == false {
            savedJobs.append(indexPath)
            
            let attributedString = getAttributedString(image: "bookmark.fill", tintColor: UIColor(hex: "#667085"))
            cell.saveButton.tintColor = UIColor(hex: "#667085")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        else {
            if let indexToRemove = savedJobs.firstIndex(where: { $0 == indexPath }) {
                savedJobs.remove(at: indexToRemove)
            }
            let attributedString = getAttributedString(image: "bookmark", tintColor: UIColor(hex: "#475467"))
            cell.saveButton.tintColor = UIColor(hex: "#475467")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
            
        }
    }
    
    func getAttributedString(image: String, tintColor: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        
        let symbolAttachment = NSTextAttachment()
        symbolAttachment.image = UIImage(systemName: image)?.withTintColor(tintColor)
        
        let symbolString = NSAttributedString(attachment: symbolAttachment)
        attributedString.append(symbolString)
        
        attributedString.append(NSAttributedString(string: " "))
        
        let textString = NSAttributedString(string: "Save")
        attributedString.append(textString)
        
        return attributedString
    }
    
    @objc func didTapRecommendedButton() {
        if isSelected != "Recommended" {
            fetchRecommendedJobs()
            isSelected = "Recommended"
            recommendedButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            appliedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            savedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            
            UIView.animate(withDuration: 0.7) {
                self.leadingConstraint.constant = 16
                self.widthConstraint.constant = 130
                self.view.layoutIfNeeded()
            }
            collectionState = .recommended
        }
        
//        jobsCountLabel.text = "\(jobs.count) recommended jobs"
    }
    
    @objc func didTapAppliedButton() {
        if isSelected != "Applied" {
            fetchAppliedJobs()
            isSelected = "Applied"
            appliedButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            recommendedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            savedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            
            UIView.animate(withDuration: 0.7) {
                self.leadingConstraint.constant = 184
                self.widthConstraint.constant = 68
                self.view.layoutIfNeeded()
            }
            collectionState = .applied
        }
        
//        jobsCountLabel.text = "\(jobs.count) applied jobs"
    }
    
    @objc func didTapSavedButton() {
        if isSelected != "Saved" {
            isSelected = "Saved"
            savedButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            recommendedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            appliedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            
            UIView.animate(withDuration: 0.7) {
                self.leadingConstraint.constant = 290
                self.widthConstraint.constant = 60
                self.view.layoutIfNeeded()
            }
        }
        collectionState = .saved
        jobsCountLabel.text = "\(savedJobs.count) saved jobs"
    }
    
    
    private func setupNoJobsImageView() {
        noJobsImageView = UIImageView()
        noJobsImageView.image = UIImage(named: "no-jobs")  // Ensure you have this image in your assets
        
        noJobsImageView.translatesAutoresizingMaskIntoConstraints = false
        noJobsImageView.isHidden = true  // Hide it by default
        view.addSubview(noJobsImageView)

        NSLayoutConstraint.activate([
            noJobsImageView.topAnchor.constraint(equalTo: jobsCountLabel.bottomAnchor, constant: 50),
            noJobsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noJobsImageView.widthAnchor.constraint(equalToConstant: 300),
            noJobsImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTotalAppliedJobs()
    }
}


extension MyJobsController :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id2", for: indexPath) as! JobsCell
        let job = jobs[indexPath.row]
        
        if appliedJobs.contains(job.id) {
            cell.appliedLabel.isHidden = false
        }
        
        cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        cell.saveButton.addTarget(self, action: #selector(didTapSaveJobButton(_:)), for: .touchUpInside)
        cell.saveButton.tag = indexPath.row
        
        if savedJobs.contains(indexPath) {
            let attributedString = getAttributedString(image: "bookmark.fill", tintColor: UIColor(hex: "#667085"))
            cell.saveButton.tintColor = UIColor(hex: "#667085")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        else {
            let attributedString = getAttributedString(image: "bookmark",tintColor: UIColor(hex: "#475467"))
            cell.saveButton.tintColor = UIColor(hex: "#475467")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        
        
        cell.jobTitle.text = job.title
        cell.companyName.text = job.company.name
        if isSelected == "Applied" {
            cell.companyName.text = job.companyName
        }
        cell.jobLocationLabel.text = "\(job.location.city), \(job.location.state)"
        
        let s = getTimeAgoString(from: job.createdAt)
        cell.jobPostedTime.text = s
        
        let expText = attributedStringForExperience("\(job.minExperience ?? "nil") - \(job.maxExperience ?? "nil")")
        cell.jobExperienceLabel.attributedText = expText
        
        // Fetch company logo asynchronously
        let baseURLString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/company-pic?logo="
        let companyLogoURLString = baseURLString + (job.company.logo)
        if let companyLogoURL = URL(string: companyLogoURLString) {
            URLSession.shared.dataTask(with: companyLogoURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.companyLogo.image = image
                    }
                }
            }.resume()
        }
        
//        cell.saveButton.isHidden = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionState {
        case .recommended:
            return jobs.count
        case .applied:
            return jobs.count
        case .saved:
            return savedJobs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 198)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Recommended is not done yet")
//        return
        
        let selectedJob = jobs[indexPath.row]
        let jobDetailVC = JobDetailScreen()
        jobDetailVC.selectedJob = selectedJob
        navigationController?.pushViewController(jobDetailVC, animated: true)
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
        
//        let textString = NSAttributedString(string: "1-5 years")
//        attributedString.append(textString)

        return attributedString
    }
}


extension MyJobsController {
    
    func fetchRecommendedJobs() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/recommended-jobs") else {
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
            
            do {
                // Decode directly as an array of dictionaries
                if let jobArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    
                    // Map dictionaries to Job objects
                    let decoder = JSONDecoder()
                    let jobData = try JSONSerialization.data(withJSONObject: jobArray, options: [])
                    let jobs = try decoder.decode([Job].self, from: jobData)
                    
                    // Update the jobs array on the main thread
                    DispatchQueue.main.async {
                        self.jobs = jobs
                        if jobs.count == 0 {
                            self.noJobsImageView.isHidden = false
                        }
                        self.jobsCountLabel.text = "\(jobs.count) recommended jobs"
                        self.jobsCollectionView.reloadData()
                    }
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
            DispatchQueue.main.async {
                if self.jobs.count == 0 {
                    self.noJobsImageView.isHidden = false
                }
            }
        }
        task.resume()
    }
    
    func fetchAppliedJobs() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/applied-jobs") else {
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
            
            do {
                // Decode directly as an array of dictionaries
                let decoder = JSONDecoder()
                let responseDict = try decoder.decode([String: [Job]].self, from: data)
                
                // Extract the "jobs" array
                if let jobs = responseDict["jobs"] {
                    
                    // Update the jobs array on the main thread
                    DispatchQueue.main.async {
                        self.jobs = jobs
                        if jobs.count == 0 {
                             self.noJobsImageView.isHidden = false
                        }
                        self.jobsCountLabel.text = "\(jobs.count) applied jobs"
                        self.jobsCollectionView.reloadData()
                    }
                } else {
                    print("Failed to find jobs in the response")
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
            DispatchQueue.main.async {
                if self.jobs.count == 0 {
                    self.noJobsImageView.isHidden = false
                }
            }
        }
        task.resume()
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
                        self.jobsCollectionView.reloadData()
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

}
