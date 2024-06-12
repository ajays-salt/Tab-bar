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
        label.text = ""
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
        
        navigationController?.navigationBar.isHidden = true
        
        if isSelected == "Recommended" {
            recommendedButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        }
        
        fetchTotalRecommendedJobs()
        fetchAppliedJobIDs()
        
        setupViews()
    }
    
    
    func setupViews() {
        setupCategorySection()
        setupLineView()
        setupJobsCountLabel()
        setupJobsCollectionView()
        setupNoJobsImageView()
    }
    
    
    func setupCategorySection() {
        categorySection.backgroundColor = UIColor(hex: "#C7EAFF")
        categorySection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categorySection)
        
        NSLayoutConstraint.activate([
            categorySection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
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
    
    @objc func didTapRecommendedButton() {
        if isSelected != "Recommended" {
            fetchTotalRecommendedJobs()
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
            fetchTotalAppliedJobs()
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
            fetchTotalSavedJobs()
            isSelected = "Saved"
            savedButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            recommendedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            appliedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            
            UIView.animate(withDuration: 0.7) {
                self.leadingConstraint.constant = 290
                self.widthConstraint.constant = 60
                self.view.layoutIfNeeded()
            }
            collectionState = .saved
        }
        
//        jobsCountLabel.text = "\(savedJobs.count) saved jobs"
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
        fetchAppliedJobIDs()
        fetchSavedJobIDs()
    }
    
    
    var savedJobs2 : [String] = []

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
            
            let attributedString = getAttributedString(image: "bookmark", tintColor: UIColor(hex: "#2563EB"), title: "Save")
            cell.saveButton.tintColor = UIColor(hex: "#2563EB")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        
        else {  // Not saved, save this job
            savedJobs2.append(job.id)
            
            saveOrUnsaveJob(id: job.id)
            
            let attributedString = getAttributedString(image: "bookmark.fill", tintColor: UIColor(hex: "#2563EB"), title: "Saved")
            cell.saveButton.tintColor = UIColor(hex: "#2563EB")
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

}


extension MyJobsController :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id2", for: indexPath) as! JobsCell
        let job = jobs[indexPath.row]
        
        if appliedJobs.contains(job.id) {
            cell.appliedLabel.isHidden = false
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
        
        cell.saveButton.tag = indexPath.row
        cell.saveButton.addTarget(self, action: #selector(didTapSaveJob(_:)), for: .touchUpInside)
        
        cell.jobTitle.text = job.title
        cell.companyName.text = job.companyName
        if isSelected == "Recommended" {
            cell.companyName.text = job.company?.name
        }
        
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
        
        let expText = attributedStringForExperience("\(job.minExperience ?? "nil") - \(job.maxExperience ?? "nil")")
        cell.jobExperienceLabel.attributedText = expText
        
        // Fetch company logo asynchronously
        let baseURLString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/company-pic?logo="
        var companyLogoURLString = ""
        companyLogoURLString = baseURLString + ((job.company?.logo ?? job.companyLogo) ?? "")
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionState {
        case .recommended:
            return jobs.count
        case .applied:
            return jobs.count
        case .saved:
            return jobs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 250)
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


extension MyJobsController {
    
    func fetchTotalRecommendedJobs() {
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
            
            //            if let responseString = String(data: data, encoding: .utf8) {
            //                print("Raw response data: \(responseString)")
            //            }
            
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
                        else {
                            self.noJobsImageView.isHidden = true
                        }
                        self.jobsCountLabel.text = "\(jobs.count) recommended jobs"
                        self.jobsCollectionView.reloadData()
                    }
                }
            } catch {
                print("Failed to decode Recommended JSON: \(error)")
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
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw response data: \(responseString)")
            }
            
            do {
                // Decode directly as an array of dictionaries
                let decoder = JSONDecoder()
                let responseDict = try decoder.decode([String: [Job]].self, from: data)
                
                // Extract the "jobs" array
                if let jobs = responseDict["jobs"] {
                    
                    // Update the jobs array on the main thread
                    DispatchQueue.main.async {
                        self.jobs.removeAll()
                        self.jobs = jobs
                        if jobs.count == 0 {
                            self.noJobsImageView.isHidden = false
                        }
                        else {
                            self.noJobsImageView.isHidden = true
                        }
                        self.jobsCountLabel.text = "\(jobs.count) applied jobs"
                        self.jobsCollectionView.reloadData()
                    }
                } else {
                    print("Failed to find jobs in the response")
                }
            } catch {
                print("Failed to decode Applied Jobs JSON: \(error)")
                self.jobs.removeAll()
            }
            DispatchQueue.main.async {
                if self.jobs.count == 0 {
                    self.noJobsImageView.isHidden = false
                    self.jobsCollectionView.reloadData()
                }
            }
        }
        task.resume()
    }
    func fetchAppliedJobIDs() {
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
                    //                    print("Job IDs: \(jobIds)")
                    DispatchQueue.main.async {
                        self.appliedJobs = jobIds
                        self.jobsCollectionView.reloadData()
                    }
                } else {
                    print("Failed to find job IDs in the response")
                }
            } catch {
                print("Failed to decode Applied IDs JSON: \(error)")
            }
        }
        task.resume()
    }
    
    
    func fetchTotalSavedJobs() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/save-job/saved-jobs") else {
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
                // Decode directly as an array of Job
                let decoder = JSONDecoder()
                let jobs = try decoder.decode([Job].self, from: data)
                
                // Update the jobs array on the main thread
                DispatchQueue.main.async {
                    self.jobs = jobs
                    self.noJobsImageView.isHidden = !jobs.isEmpty
                    self.jobsCountLabel.text = "\(jobs.count) saved jobs"
                    self.jobsCollectionView.reloadData()
                }
            } catch {
                print("Failed to decode Saved JSON: \(error)")
                DispatchQueue.main.async {
                    self.jobs.removeAll()
                    self.noJobsImageView.isHidden = false
                    self.jobsCountLabel.text = "No saved jobs"
                    self.jobsCollectionView.reloadData()
                }
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
            
            do {
                let response = try JSONDecoder().decode(SavedJobsResponse.self, from: data)
                let jobIDs = response.savedJobs.savedJobs
                
                DispatchQueue.main.async {
                    self.savedJobs2 = jobIDs
                }
                
            } catch {
                print("Failed to decode Saved IDs JSON: \(error)")
            }
        }
        task.resume()
        
    }
}
