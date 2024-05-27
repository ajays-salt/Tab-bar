//
//  JobSearchResult2.swift
//  olousTabBar
//
//  Created by Salt Technologies on 23/04/24.
//

import UIKit


class JobSearchResult2: UIViewController {
    
    var jobTitle: String?
    var jobLocation: String?
    var baseURL = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/jobs"
//    var baseURL = "https://5fd4-2405-201-a41f-d872-51a2-9f17-9c9b-d71f.ngrok-free.app/api/v1/job/jobs"
    var finalURL = ""
    
    var jobLocationArray: [String] = []
    
    // Filter data
    var filter = Filter()
    var activeFilterCategory: FilterCategory?
    
    var selectedOptionsDict = [String: [String]]()
    
    var lastActiveCategory: FilterCategory?
    
    // UI Components
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let optionsTableView = UITableView()
    let applyButton = UIButton(type: .system) // Apply button
    
    var jobsCountLabel : UILabel = {
        let label = UILabel()
        label.text = "267 jobs"
        label.font = .systemFont(ofSize: 14)
        label.tintColor = UIColor(hex: "#344054")
        return label
    }()
    var jobsCollectionView : UICollectionView!
    var jobs: [Job] = []
    
    var blurView : UIView!
    
    
    var currentPage: Int = 1
    var totalPages: Int = 1
    var isLoadingData = false
    
    
    var appliedJobs : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white // Set the background color for the view
        
        baseURL = "\(baseURL)?jobTitle=\(jobTitle!)"
        urlSettings()
    }
    
    
    func urlSettings() {
        
        if let  jobLocation2 = jobLocation, jobLocation2 != "" {
            jobLocationArray.append(jobLocation2)
        }
        
        
        var components = URLComponents(string: baseURL)!
        var queryItems: [URLQueryItem] = []

        if let jobTitle = jobTitle {
            queryItems.append(URLQueryItem(name: "jobTitle", value: jobTitle))
        }
        
//        jobLocationArray.append("Pimpri-Chinchwad")
        
        if !jobLocationArray.isEmpty {
            queryItems.append(URLQueryItem(name: "City", value: "\(jobLocationArray)"))
        }

        components.queryItems = queryItems
        finalURL = components.url?.absoluteString ?? baseURL
        
        
        
        fetchData { result in
            switch result {
            case .success(let fetchedJobs):
                self.jobs = fetchedJobs
                print("jobs fetched successfully")
                DispatchQueue.main.async {
                    self.setupViews()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    
    func setupViews() {
        setupFilters()
        setupScrollView()
        setupStackView()
        
        setupJobsCountLabel()
        setupJobsCollectionView()
        
        setupTableView()
        
        addFilterButtons()
        
        setupBlurView()
        setupApplyButton()
        
        optionsTableView.allowsMultipleSelection = true
        optionsTableView.isHidden = true  // Initially hidden
        applyButton.isHidden = true  // Initially hidden

    }
    
    func setupBlurView() {
        blurView = UIView()
        blurView.backgroundColor = .black
        blurView.alpha = 0.4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.isHidden = true
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: optionsTableView.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    // MARK: - Setup Methods
    func setupFilters() {
        filter.categories = [
            FilterCategory(name: "Experience", options: ["1-2 years", "3-5 years", "5+ years"], selectedOptions: []),
            FilterCategory(name: "City", options: ["Pune", "Mumbai", "Austin"], selectedOptions: []),
            FilterCategory(name: "Salary", options: ["$40k - $50k", "$50k - $60k", "$60k - $70k"], selectedOptions: []),
            FilterCategory(name: "Sector", options: ["$40k - $50k", "$50k - $60k", "$60k - $70k"], selectedOptions: []),
            FilterCategory(name: "Date Posted", options: ["$40k", "$50k", "$60k", "$70k", "$80k", "$90k"], selectedOptions: []),
            FilterCategory(name: "Xyzzzzzzzz", options: ["$40k - $50k", "$50k - $60k", "$60k - $70k"], selectedOptions: [])
        ]
        
        // Initialize the dictionary for storing selected options
        for category in filter.categories {
            selectedOptionsDict[category.name] = category.selectedOptions
        }
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor(hex: "#1E293B")
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            scrollView.heightAnchor.constraint(equalToConstant: 46) // Example height, adjust as needed
        ])
    }
    
    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 7),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -50)
        ])
    }
    
    func setupTableView() {
        optionsTableView.translatesAutoresizingMaskIntoConstraints = false
        optionsTableView.layer.borderWidth = 1
        optionsTableView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.register(FilterOptionsCell.self, forCellReuseIdentifier: "FilterOptionCell")
        view.addSubview(optionsTableView)
        NSLayoutConstraint.activate([
            optionsTableView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 12),
            optionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            optionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            optionsTableView.heightAnchor.constraint(lessThanOrEqualToConstant: 200)
        ])
    }
    
    func setupApplyButton() {
        applyButton.setTitle("Apply", for: .normal)
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.backgroundColor = UIColor(hex: "#0079C4")
        applyButton.layer.cornerRadius = 8
        applyButton.addTarget(self, action: #selector(applyFilterSelections), for: .touchUpInside)
        
        view.addSubview(applyButton)
        view.bringSubviewToFront(applyButton)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            applyButton.topAnchor.constraint(equalTo: optionsTableView.bottomAnchor, constant: 10),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            applyButton.widthAnchor.constraint(equalToConstant: 100),
            applyButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc func applyFilterSelections() {
        
        blurView.isHidden = true
        
        // Initialize an array to hold all parts of the query string
        var queryItems = [String]()
        
        // Iterate through each filter category and their selected options
        for (category, options) in selectedOptionsDict where !options.isEmpty {
            let formattedCategory = category.lowercased()  // Assuming category matches the expected query parameter key
            switch formattedCategory {
            case "city":  // Special formatting for locations as array
                let value = options.map { "\"\($0)\"" }.joined(separator: ",")
                queryItems.append("\(formattedCategory)=[\(value)]")
            default:  // For single selection parameters
                let value = options.joined(separator: "&\(formattedCategory)=").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if !value.isEmpty {
                    queryItems.append("\(formattedCategory)=\(value)")
                }
            }
        }
        
        // Combine the base URL with the query items if any
//        finalURL = queryItems.isEmpty ? baseURL : "\(baseURL)?\(queryItems.joined(separator: "&"))"
        finalURL = queryItems.isEmpty ? baseURL : "\(baseURL)&\(queryItems.joined(separator: "&"))"
        print("Final URL with filters ", finalURL)
        
        fetchData { result in
            switch result {
            case .success(let fetchedJobs):
                self.jobs = fetchedJobs
                print("jobs fetched successfully")
                DispatchQueue.main.async {
                    self.setupViews()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
        print("Final URL: \(finalURL)")
        
        optionsTableView.isHidden = true  // Hide the table view
        applyButton.isHidden = true  // Hide the apply button
    }
    
    var i = 0
    
    func addFilterButtons() {
        if i != 0 {
            return
        }
        for category in filter.categories {
            
            let filterButton = CategoryButton(type: .system)
            filterButton.categoryName = category.name
            
            filterButton.layer.borderWidth = 1.0 // Add border
            filterButton.layer.cornerRadius = 8
            filterButton.layer.borderColor = UIColor(hex: "#EAECF0").cgColor // Set border color
            filterButton.contentHorizontalAlignment = .left // Align content to the left
            filterButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
            filterButton.backgroundColor = .systemBackground
            
            // Set title and drop-down icon
            if let dropDownImage = UIImage(systemName: "chevron.down") {
                let titleWithIcon = NSAttributedString(string: category.name, attributes: [.font: UIFont.systemFont(ofSize: 16)]) // Customize font size as needed
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
            
            filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
            
            filterButton.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(filterButton)
        }
        i = i + 1
    }
    
    @objc func filterButtonTapped(_ sender: UIButton) {
        guard let button = sender as? CategoryButton,
              let categoryName = button.categoryName,
              let category = filter.categories.first(where: { $0.name == categoryName }) else { return }

        if let lastActive = lastActiveCategory, lastActive.name == categoryName {
            // If the same category is tapped again, toggle visibility
            blurView.isHidden = !blurView.isHidden
            optionsTableView.isHidden = !optionsTableView.isHidden
            applyButton.isHidden = !applyButton.isHidden
            lastActiveCategory = optionsTableView.isHidden ? nil : lastActive  // Clear or set the last active category based on visibility
        } else {
            // Different category or first-time tap
            activeFilterCategory = category
            optionsTableView.reloadData()
            
            blurView.isHidden = false
            optionsTableView.isHidden = false  // Always show the table view
            applyButton.isHidden = false  // Always show the apply button
            lastActiveCategory = category  // Update the last active category
        }
    }
    
    
    func setupJobsCountLabel() {
        jobsCountLabel.text = "\(jobs.count) jobs found"
        jobsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(jobsCountLabel)
        
        NSLayoutConstraint.activate([
            jobsCountLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            jobsCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jobsCountLabel.heightAnchor.constraint(equalToConstant: 128),
            jobsCountLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setupJobsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        jobsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        jobsCollectionView.register(JobsCell.self, forCellWithReuseIdentifier: "id2")
        jobsCollectionView.register(LoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "LoadingFooter")
        
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
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.bounds.height
        
        print(offsetY , contentHeight - height)
        
        if offsetY > 0 && offsetY > contentHeight - height && !isLoadingData && currentPage < totalPages {
            print("Attempting to load more data..." , " Current Page: \(currentPage)")
            loadMoreData()
        }
    }
    func loadMoreData() {
        guard !isLoadingData else { return }
        isLoadingData = true
        
        DispatchQueue.main.async {
            self.jobsCollectionView.reloadSections(IndexSet(integer: 0)) // Assuming you have only one section
        }
        
        currentPage += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchData { result in
                switch result {
                case .success(let fetchedJobs):
                    self.jobs.append(contentsOf: fetchedJobs)
                    print("jobs fetched successfully")
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        fetchTotalAppliedJobs()
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
}

extension JobSearchResult2 : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id2", for: indexPath) as! JobsCell
        let job = jobs[indexPath.row]
        
        if appliedJobs.contains(job.id) {
            cell.appliedLabel.isHidden = false
        }
        else {
            cell.appliedLabel.isHidden = true
        }
        
        cell.jobTitle.text = job.title
        cell.companyName.text = job.companyName
        cell.jobLocationLabel.text = "\(job.location.city), \(job.location.state)"
        
        let s = getTimeAgoString(from: job.createdAt)
        cell.jobPostedTime.text = s
        
        let expText = attributedStringForExperience("\(job.minExperience ?? "nil") - \(job.maxExperience ?? "nil")")
        cell.jobExperienceLabel.attributedText = expText
        
        // Fetch company logo asynchronously
        let baseURLString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/company-pic?logo="
        let companyLogoURLString = baseURLString + (job.companyLogo ?? "" )
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return isLoadingData ? CGSize(width: collectionView.bounds.width, height: 50) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            return UICollectionReusableView()
        }
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoadingFooter", for: indexPath) as! LoadingFooterView
        return footer
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

extension JobSearchResult2: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeFilterCategory?.options.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterOptionCell", for: indexPath) as? FilterOptionsCell,
              let option = activeFilterCategory?.options[indexPath.row],
              let categoryName = activeFilterCategory?.name else {
            return UITableViewCell()
        }

        let isSelected = selectedOptionsDict[categoryName]?.contains(option) ?? false
        cell.selectionStyle = .none
        cell.label.text = option
        cell.isChecked = isSelected
        cell.checkboxButton.setImage(isSelected ? UIImage(systemName: "checkmark.circle.fill") : nil, for: .normal)
        cell.checkboxButton.tintColor = isSelected ? .systemBlue : nil

        if isSelected {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let option = activeFilterCategory?.options[indexPath.row],
              let categoryName = activeFilterCategory?.name,
              let cell = tableView.cellForRow(at: indexPath) as? FilterOptionsCell else { return }

        // Add the option to selected options if it's not already selected
        var selections = selectedOptionsDict[categoryName] ?? []
        if !selections.contains(option) {
            selections.append(option)
            selectedOptionsDict[categoryName] = selections
            cell.isChecked = true
            cell.checkboxButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            cell.checkboxButton.tintColor = .systemBlue
        }
        
        tableView.reloadRows(at: [indexPath], with: .none)  // Refresh the cell to ensure UI consistency
    }

    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let option = activeFilterCategory?.options[indexPath.row],
              let categoryName = activeFilterCategory?.name,
              let cell = tableView.cellForRow(at: indexPath) as? FilterOptionsCell else { return }

        // Remove the option from selected options if it's currently selected
        var selections = selectedOptionsDict[categoryName] ?? []
        if let index = selections.firstIndex(of: option) {
            selections.remove(at: index)
            selectedOptionsDict[categoryName] = selections
            cell.isChecked = false
            cell.checkboxButton.setImage(nil, for: .normal)
            cell.checkboxButton.tintColor = nil
        }
        
        tableView.reloadRows(at: [indexPath], with: .none)  // Refresh the cell to ensure UI consistency
    }

}

extension JobSearchResult2 { // extension for API
    
    func fetchData(completion: @escaping (Result<[Job], Error>) -> Void) {
        
        var urlStr = "\(finalURL)&page=\(currentPage)"
        print(urlStr)
        
        guard let url = URL(string: urlStr) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            defer { self.isLoadingData = false }
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown Error", code: 0, userInfo: nil)))
                return
            }
            print(data)
            do {
                let jobResponse = try JSONDecoder().decode(JobResponse.self, from: data)
                completion(.success(jobResponse.jobs))
                DispatchQueue.main.async {
                    self.totalPages = jobResponse.totalPages
                    self.isLoadingData = false
                    self.jobsCollectionView.reloadSections(IndexSet(integer: 0))
                    self.jobsCountLabel.text = "\(self.jobs.count) jobs found"
                }
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
}





class CategoryButton: UIButton {
    var categoryName: String?
}

struct Filter {
    var categories: [FilterCategory] = []

    mutating func updateSelection(forCategory categoryName: String, withOptions selectedOptions: [String]) {
        if let index = categories.firstIndex(where: { $0.name == categoryName }) {
            categories[index].selectedOptions = selectedOptions
        }
    }
}

struct FilterCategory {
    let name: String
    var options: [String]
    var selectedOptions: [String]
}
