//
//  JobSearchController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 04/03/24.
//

import UIKit

class JobSearchScreen: UIViewController, UITextFieldDelegate {
    
    
//    var jobsArray = ["Paris", "New York", "Pimpri", "Lonar", "Berlin", "Partur", "Pune"]
//    var locationsArray = ["Paris", "New York", "Pimpri", "Lonar", "Berlin", "Partur", "Pune"]
//    var filteredJobs = [String]()
//    var filteredLocations = [String]()
//    
//    let jobsTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.isHidden = true
//        return tableView
//    }()
//    let locationsTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.isHidden = true
//        return tableView
//    }()
    
    var jobSearchButton : UIButton = {
        let button = UIButton()
        button.setTitle("Search Jobs", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#0079C4")
        button.layer.cornerRadius = 12
        return button
    }()
    
    var jobSearchSection : UIView = UIView()
    
    var jobSearchInnerSection : UIView = UIView()
    var searchIcon : UIImageView = UIImageView()
    let jobsTextField = UITextField()
    var locationIcon : UIImageView = UIImageView()
    let locationTextField = UITextField()

    
    var recJobsView = UIView()
    var jobsCollectionView : UICollectionView!
    var jobs: [Job] = []
    var appliedJobs : [String] = []
    
    var viewAllCompaniesButton : UIButton = {
        let button = UIButton()
        button.setTitle("View all", for: .normal)
        button.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        return button
    }()
    
    var noJobsImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        fetchRecommendedJobs()
        fetchTotalAppliedJobs()
        
        setupViews()
        
        jobsTextField.delegate = self
        jobsTextField.tag = 1
        locationTextField.delegate = self
        locationTextField.tag = 2
        
        
//        jobsTableView.delegate = self
//        jobsTableView.dataSource = self
//        locationsTableView.delegate = self
//        locationsTableView.dataSource = self
        
//        setupJobsTableView()
//        setupLocationsTableView()
        
        
        
        
    }
    
    func setupViews() {
        setupJobSearchSection()
        setupJobSearchInnerSection()
        setupSearchJobsButton()
        setupSeparatorView1()
        setupRecJobsView()
        setupJobsCollectionVC()
        setupNoJobsImageView()
    }
    
    func setupJobSearchSection() {
        jobSearchSection.backgroundColor = UIColor(hex: "#1E293B")
        // #007AFF systemBlue
        jobSearchSection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(jobSearchSection)
        
        NSLayoutConstraint.activate([
            jobSearchSection.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            jobSearchSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            jobSearchSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            jobSearchSection.heightAnchor.constraint(equalToConstant: 192)
        ])
    }
        
    func setupJobSearchInnerSection() {
        jobSearchInnerSection.backgroundColor = .systemBackground
        jobSearchInnerSection.layer.cornerRadius = 12
        jobSearchInnerSection.layer.borderWidth = 1
        
        let borderColor = UIColor(hex: "#EAECF0")
        jobSearchInnerSection.layer.borderColor = borderColor.cgColor
        
        jobSearchInnerSection.translatesAutoresizingMaskIntoConstraints = false
        jobSearchSection.addSubview(jobSearchInnerSection)
        
        NSLayoutConstraint.activate([
            jobSearchInnerSection.topAnchor.constraint(equalTo: jobSearchSection.topAnchor, constant: 16),
            jobSearchInnerSection.leadingAnchor.constraint(equalTo: jobSearchSection.leadingAnchor, constant: 16),
            jobSearchInnerSection.trailingAnchor.constraint(equalTo: jobSearchSection.trailingAnchor, constant: -16),
            jobSearchInnerSection.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.tintColor = UIColor(hex: "#667085")
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(searchIcon)
        
        NSLayoutConstraint.activate([
            searchIcon.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 14),
            searchIcon.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 16),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor(hex: "#EAECF0")
        jobSearchInnerSection.addSubview(separatorLine)
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorLine.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor).isActive = true
        separatorLine.trailingAnchor.constraint(equalTo: jobSearchInnerSection.trailingAnchor).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: jobSearchInnerSection.bottomAnchor, constant: -49).isActive = true
        
        
        jobsTextField.placeholder = "Enter Job Title (Required)"
        jobsTextField.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(jobsTextField)
        
        NSLayoutConstraint.activate([
            jobsTextField.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 14),
            jobsTextField.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 46),
            jobsTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            jobsTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        locationIcon.image = UIImage(named: "locationLogo")
        locationIcon.tintColor = UIColor(hex: "#667085")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(locationIcon)
        
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 63),
            locationIcon.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 18),
            locationIcon.widthAnchor.constraint(equalToConstant: 21),
            locationIcon.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        locationTextField.placeholder = "Enter Location (Optional)"
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(locationTextField)
        
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 63),
            locationTextField.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 47),
            locationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            locationTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
        
    }
    
//    func setupJobsTableView() {
//        jobsTableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(jobsTableView)
//        NSLayoutConstraint.activate([
//            jobsTableView.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 50),
//            jobsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            jobsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            jobsTableView.heightAnchor.constraint(equalToConstant: 150)
//        ])
//    }
//    func setupLocationsTableView() {
//        locationsTableView.layer.borderWidth = 1
//        locationsTableView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
//        locationsTableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(locationsTableView)
//        NSLayoutConstraint.activate([
//            locationsTableView.topAnchor.constraint(equalTo: jobSearchInnerSection.bottomAnchor, constant: 0),
//            locationsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            locationsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            locationsTableView.heightAnchor.constraint(equalToConstant: 130)
//        ])
//    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == jobsTextField {
//            let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//            filterJobs(with: searchText)
//        }
//        else {
//            let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//            filterLocations(with: searchText)
//        }
//        return true
//    }
    
    // Step 5: Filter locations based on search text
//    func filterJobs(with searchText: String) {
//        filteredJobs = jobsArray.filter { $0.lowercased().hasPrefix(searchText.lowercased()) }
//        jobsTableView.isHidden = filteredJobs.isEmpty
//        if(filteredJobs.count == jobsArray.count) {
//            filteredJobs.removeAll()
//            jobsTableView.isHidden = true
//        }
//        jobsTableView.reloadData()
//    }
//    func filterLocations(with searchText: String) {
//        filteredLocations = locationsArray.filter { $0.lowercased().hasPrefix(searchText.lowercased()) }
//        locationsTableView.isHidden = filteredLocations.isEmpty
//        if(filteredLocations.count == locationsArray.count) {
//            filteredLocations.removeAll()
//            locationsTableView.isHidden = true
//        }
//        locationsTableView.reloadData()
//    }
    
    func setupSearchJobsButton() {
        jobSearchButton.addTarget(self, action: #selector(didTapSearchJobs), for: .touchUpInside)
        
        jobSearchButton.translatesAutoresizingMaskIntoConstraints = false
        jobSearchSection.addSubview(jobSearchButton)
        
        NSLayoutConstraint.activate([
            jobSearchButton.topAnchor.constraint(equalTo: jobSearchInnerSection.bottomAnchor, constant: 16),
            jobSearchButton.leadingAnchor.constraint(equalTo: jobSearchSection.leadingAnchor, constant: 16),
            jobSearchButton.trailingAnchor.constraint(equalTo: jobSearchSection.trailingAnchor, constant: -16),
            jobSearchButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    @objc func didTapSearchJobs() {
        guard let jobTitle = jobsTextField.text, !jobTitle.isEmpty else {
            let alert = UIAlertController(title: "Missing Information", message: "Fill all the details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        let jobResultVC = JobSearchResult()
        jobResultVC.jobTitle = jobTitle
        jobResultVC.jobLocation = locationTextField.text!
        
        navigationController?.pushViewController(jobResultVC, animated: true)
    }
    
    func setupSeparatorView1() {
        let separatorLine = UIView()
        separatorLine.backgroundColor = .systemGray6
        view.addSubview(separatorLine)
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: jobSearchButton.bottomAnchor, constant: 30),
            separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 8)
        ])
        
    }
    
    
    func setupRecJobsView() {
        
        recJobsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recJobsView)
        
        NSLayoutConstraint.activate([
            recJobsView.topAnchor.constraint(equalTo: jobSearchButton.bottomAnchor, constant: 60),
            recJobsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recJobsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recJobsView.heightAnchor.constraint(equalToConstant: 301)
        ])
        
        let label = UILabel()
        label.text = "Recommended Jobs"
        label.font = .boldSystemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        recJobsView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: recJobsView.topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: recJobsView.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        viewAllCompaniesButton.addTarget(self, action: #selector(didTapViewAllCompanies), for: .touchUpInside)
        viewAllCompaniesButton.translatesAutoresizingMaskIntoConstraints = false
        recJobsView.addSubview(viewAllCompaniesButton)
        
        NSLayoutConstraint.activate([
            viewAllCompaniesButton.topAnchor.constraint(equalTo: recJobsView.topAnchor, constant: 5),
            viewAllCompaniesButton.leadingAnchor.constraint(equalTo: recJobsView.leadingAnchor, constant: view.frame.width - 93),
            viewAllCompaniesButton.widthAnchor.constraint(equalToConstant: 73),
            viewAllCompaniesButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    func setupJobsCollectionVC() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        jobsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        jobsCollectionView.register(JobsCell.self, forCellWithReuseIdentifier: "id")
        
        jobsCollectionView.showsHorizontalScrollIndicator = false
        
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
        
        jobsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        recJobsView.addSubview(jobsCollectionView)
        
        NSLayoutConstraint.activate([
            jobsCollectionView.topAnchor.constraint(equalTo: recJobsView.topAnchor, constant: 45),
            jobsCollectionView.leadingAnchor.constraint(equalTo: recJobsView.leadingAnchor, constant: 16),
            jobsCollectionView.trailingAnchor.constraint(equalTo: recJobsView.trailingAnchor),
            jobsCollectionView.bottomAnchor.constraint(equalTo: recJobsView.bottomAnchor, constant: -19)
        ])
    }
    @objc func didTapViewAllCompanies() {
        tabBarController?.selectedIndex = 1
        UIView.transition(with: tabBarController!.view!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    private func setupNoJobsImageView() {
        noJobsImageView = UIImageView()
        noJobsImageView.image = UIImage(named: "no-jobs")  // Ensure you have this image in your assets
        
        noJobsImageView.translatesAutoresizingMaskIntoConstraints = false
        noJobsImageView.isHidden = true  // Hide it by default
        view.addSubview(noJobsImageView)

        NSLayoutConstraint.activate([
            noJobsImageView.topAnchor.constraint(equalTo: recJobsView.topAnchor, constant: 50),
            noJobsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noJobsImageView.widthAnchor.constraint(equalToConstant: 300),
            noJobsImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
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
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // This method gets called when the user taps on the text field
        if(textField.tag == 1) {
            print("jobs text field")
        }
        else {
            print("locations text field")
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

extension JobSearchScreen : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == jobsTableView {
//            return filteredJobs.count
//        }
//        else {
//            return filteredLocations.count
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        if tableView == jobsTableView {
//            cell.textLabel?.text = filteredJobs[indexPath.row]
//        }
//        else {
//            cell.textLabel?.text = filteredLocations[indexPath.row]
//        }
//        
//        cell.backgroundColor = UIColor(hex: "#FFFFFF")
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView == jobsTableView {
//            let selectedJob = filteredJobs[indexPath.row]
//            jobsTextField.text = selectedJob
//            jobsTableView.isHidden = true
//        }
//        else {
//            let selectedLocation = filteredLocations[indexPath.row]
//            locationTextField.text = selectedLocation
//            locationsTableView.isHidden = true
//        }
//    }
//    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! JobsCell
        let job = jobs[indexPath.row]
        
        if appliedJobs.contains(job.id) {
            cell.appliedLabel.isHidden = false
        }
        
        cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        
        cell.jobTitle.text = job.title
        cell.companyName.text = job.company.name
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
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 40, height: 198)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tabBarController?.selectedIndex = 1
        UIView.transition(with: tabBarController!.view!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
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


extension JobSearchScreen {
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
