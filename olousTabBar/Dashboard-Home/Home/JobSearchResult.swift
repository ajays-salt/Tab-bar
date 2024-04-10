//
//  JobSearchResult.swift
//  olousTabBar
//
//  Created by Salt Technologies on 11/03/24.
//

import UIKit

class JobSearchResult: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var jobs: [Job] = []
    let urlString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/jobs"
    
    var topSection : UIView!
    var filterScrollView : UIScrollView!
    var filterOptions = [
        "Date posted": ["Last 24 hrs", "Last week", "Last month"],
        "Workplace": ["Office", "Remote", "Hybrid"],
        "Location": ["Pune", "Mumbai", "Bangalore", "Hyderabad", "Gurgaon", "Delhi"],
        "Sector": ["Residential", "Commercial", "Industrial", "Irrigation"],
        "Experience": ["Fresher", "0-2", "2-4", "4-10"],
        "Salary": ["0-3", "3-6", "6-10", "10+"],
        "Job type": ["Full-time", "Part-time", "Internship", "Contract"],
    ]
    
    var selectedFilterArray: [String] = []
    
    var filterTableView : UITableView!
    var isFilterOptionsHidden = true
    
    var blurView : UIView!
    
    var jobsCountLabel : UILabel = {
        let label = UILabel()
        label.text = "267 jobs"
        label.font = .systemFont(ofSize: 14)
        label.tintColor = UIColor(hex: "#344054")
        return label
    }()
    
    var jobsCollectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        // Call the fetchData function to fetch data and store it in an array
        fetchData { result in
            switch result {
            case .success(let fetchedJobs):
                self.jobs = fetchedJobs
                print("Fetched \(self.jobs.count) jobs.")
                // Here you can perform further operations with the fetched data
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
            
            DispatchQueue.main.async {
                self.setupViews()
            }
        }
        print(jobs.count)
//        setupViews()
    }
    
    func setupViews() {
        setupFilterScrollView()
        
        setupFilterButtons()
        
        setupJobsCountLabel()
        setupJobsCollectionView()
        
        setupFilterTableView()
    }
    
    func setupFilterScrollView() {
        
        topSection = UIView()
        
        topSection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topSection)
        NSLayoutConstraint.activate([
            topSection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSection.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        filterScrollView = UIScrollView()
        filterScrollView.translatesAutoresizingMaskIntoConstraints = false
        filterScrollView.showsHorizontalScrollIndicator = false
        
        let contentWidth = (view.frame.width - 48) * CGFloat(2) - 16 // Total width of subviews including spacing
        filterScrollView.contentSize = CGSize(width: contentWidth, height: 80)
        
        filterScrollView.translatesAutoresizingMaskIntoConstraints = false
        topSection.addSubview(filterScrollView)
        NSLayoutConstraint.activate([
            filterScrollView.topAnchor.constraint(equalTo: topSection.topAnchor, constant: 20),
            filterScrollView.leadingAnchor.constraint(equalTo: topSection.leadingAnchor),
            filterScrollView.trailingAnchor.constraint(equalTo: topSection.trailingAnchor),
            filterScrollView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    func setupFilterButtons() {
        addFilterButton(title: "Date posted", at: 0)
        addFilterButton(title: "Workplace", at: 1)
        addFilterButton(title: "Location", at: 2)
        addFilterButton(title: "Sector", at: 3)
        addFilterButton(title: "Experience", at: 4)
        addFilterButton(title: "Salary", at: 5)
        addFilterButton(title: "Job type", at: 6)
    }
    
    func addFilterButton(title: String, at index: Int) {
        let filterButton = UIButton(type: .system)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.layer.borderWidth = 1.0 // Add border
        filterButton.layer.cornerRadius = 8
        filterButton.layer.borderColor = UIColor(hex: "#EAECF0").cgColor // Set border color
        filterButton.contentHorizontalAlignment = .left // Align content to the left
        filterButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        filterButton.backgroundColor = .systemBackground
        
        // Set title and drop-down icon
        if let dropDownImage = UIImage(systemName: "chevron.down") {
            let titleWithIcon = NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 16)]) // Customize font size as needed
            let attributedTitle = NSMutableAttributedString(string: "   ") // Add empty spaces at the start
            attributedTitle.append(titleWithIcon)
            
            // Add drop-down icon to the end of the title
            let attachment = NSTextAttachment()
            attachment.image = dropDownImage
            let attachmentString = NSAttributedString(attachment: attachment)
            attributedTitle.append(NSAttributedString(string: " "))
            attributedTitle.append(attachmentString)
            attributedTitle.append(NSAttributedString(string: "   "))
            
            filterButton.setAttributedTitle(attributedTitle, for: .normal)
            filterButton.semanticContentAttribute = .forceRightToLeft
        }
        
        filterScrollView.addSubview(filterButton)
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            filterButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        if index > 0 {
            let previousButton = filterScrollView.subviews[index - 1] // Get the previous button
            filterButton.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 10).isActive = true // Adjust spacing as needed
        } else {
            // For the first button, set its leading anchor to the scroll view's leading anchor
            filterButton.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor, constant: 20).isActive = true // Adjust spacing as needed
        }

        
        filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        filterButton.tag = index // Assign a tag to identify the filter
    }
    
    func setupFilterTableView() {
        filterTableView = UITableView()
        filterTableView.register(FilterOptionsCell.self, forCellReuseIdentifier: "FilterOptionsCell")
        filterTableView.delegate = self
        filterTableView.dataSource = self
        
        filterTableView.isHidden = true
        filterTableView.layer.borderWidth = 1
        filterTableView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        
        filterTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterTableView)
        NSLayoutConstraint.activate([
            filterTableView.topAnchor.constraint(equalTo: filterScrollView.bottomAnchor, constant: -20),
            filterTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterTableView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: - Filter Button Actions
    @objc func filterButtonTapped(_ sender: UIButton) {
        if isFilterOptionsHidden == false {
            isFilterOptionsHidden = true
            filterTableView.isHidden = true
            blurView.removeFromSuperview()
            return
        }
        else {
            filterTableView.isHidden = false
            isFilterOptionsHidden = false
            
            blurView = UIView()
            blurView.backgroundColor = .black
            blurView.alpha = 0.4
            blurView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(blurView)
            NSLayoutConstraint.activate([
                blurView.topAnchor.constraint(equalTo: filterTableView.bottomAnchor),
                blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        switch sender.tag {
        case 0:
            datePostedButtonTapped()
        case 1:
            workplaceButtonTapped()
        case 2:
            locationButtonTapped()
        case 3 :
            sectorButtonTapped()
        case 4:
            experienceButtonTapped()
        case 5:
            salaryButtonTapped()
        case 6:
            jobTypeButtonTapped()
        default:
            break
        }
    }
    
    // Separate methods for handling taps on each button
    
    func datePostedButtonTapped() {
        guard let options = filterOptions["Date posted"] else {
            return
        }
        selectedFilterArray = options
        filterTableView.allowsMultipleSelection = false
        filterTableView.reloadData()
    }
    
    func workplaceButtonTapped() {
        guard let options = filterOptions["Workplace"] else {
            return
        }
        selectedFilterArray = options
        filterTableView.allowsMultipleSelection = true
        filterTableView.reloadData()
    }
    
    func locationButtonTapped() {
        guard let options = filterOptions["Location"] else {
            return
        }
        selectedFilterArray = options
        filterTableView.allowsMultipleSelection = true
        filterTableView.reloadData()
    }
    
    func sectorButtonTapped() {
        guard let options = filterOptions["Sector"] else {
            return
        }
        selectedFilterArray = options
        
        filterTableView.reloadData()
    }
    func experienceButtonTapped() {
        guard let options = filterOptions["Experience"] else {
            return
        }
        selectedFilterArray = options
        filterTableView.allowsMultipleSelection = false
        filterTableView.reloadData()
    }
    func salaryButtonTapped() {
        guard let options = filterOptions["Salary"] else {
            return
        }
        selectedFilterArray = options
        filterTableView.allowsMultipleSelection = true
        filterTableView.reloadData()
    }
    func jobTypeButtonTapped() {
        guard let options = filterOptions["Job type"] else {
            return
        }
        selectedFilterArray = options
        filterTableView.allowsMultipleSelection = false
        filterTableView.reloadData()
    }
    
    
    
    
    
    
    
    
    
    func setupJobsCountLabel() {
        jobsCountLabel.text = "\(jobs.count) jobs found"
        jobsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(jobsCountLabel)
        
        NSLayoutConstraint.activate([
            jobsCountLabel.topAnchor.constraint(equalTo: topSection.bottomAnchor, constant: 6),
            jobsCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jobsCountLabel.heightAnchor.constraint(equalToConstant: 128),
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id2", for: indexPath) as! JobsCell
        let job = jobs[indexPath.row]
        
        
        
        cell.jobTitle.text = job.title
        cell.companyName.text = job.companyName
        cell.jobLocationLabel.text = "\(job.location.city), \(job.location.state)"
        
        let s = getTimeAgoString(from: job.createdAt)
        cell.jobPostedTime.text = s
        
        let expText = attributedStringForExperience(job.yearsOfExperience)
        cell.jobExperienceLabel.attributedText = expText
        
        // Fetch company logo asynchronously
        let baseURLString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/company-pic?logo="
        let companyLogoURLString = baseURLString + job.companyLogo
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
        return .init(width: view.frame.width - 32, height: 198)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedJob = jobs[indexPath.row]
        let jobDetailVC = JobDetailScreen()
        jobDetailVC.selectedJob = selectedJob
        navigationController?.pushViewController(jobDetailVC, animated: true)
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

extension JobSearchResult : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(selectedFilterArray.count)
        return selectedFilterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterOptionsCell", for: indexPath) as! FilterOptionsCell
        let option = selectedFilterArray[indexPath.row]
        cell.label.text = option
        cell.selectionStyle = .none
        // Assuming isChecked property in FilterOptionsCell indicates whether the option is selected
        cell.isChecked = true// Implement isSelected method accordingly
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        let cell = tableView.cellForRow(at: indexPath) as! FilterOptionsCell
        
        cell.checkboxButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(#function)
        let cell = tableView.cellForRow(at: indexPath) as! FilterOptionsCell
        
        cell.checkboxButton.setImage(UIImage(systemName: ""), for: .normal)
    }
    
}

extension JobSearchResult { // extension for networking use

    // Define a function to fetch data from the API
    func fetchData(completion: @escaping (Result<[Job], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown Error", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let jobResponse = try JSONDecoder().decode(JobResponse.self, from: data)
                completion(.success(jobResponse.jobs))
            } catch {
                completion(.failure(error))
            }
        }.resume()
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
        attributedString.append(NSAttributedString(string: " years"))
        
//        let textString = NSAttributedString(string: "1-5 years")
//        attributedString.append(textString)

        return attributedString
    }

    
}
