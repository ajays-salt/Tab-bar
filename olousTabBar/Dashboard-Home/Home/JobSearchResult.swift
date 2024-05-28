//
//  JobSearchResult2.swift
//  olousTabBar
//
//  Created by Salt Technologies on 23/04/24.
//

import UIKit


class JobSearchResult: UIViewController, JobFiltersDelegate, CompanyFiltersDelegate {
    
    var flag = false
    
    func didApplyFilters(_ filtersURL: String) {
        print("Applied filters URL: \(filtersURL)")
        
        // Remove brackets from the URL
        let pattern = "\\(\\d+\\)"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: filtersURL.utf16.count)
        let newUrlString = regex.stringByReplacingMatches(in: filtersURL, options: [], range: range, withTemplate: "")
        
        // Parse the new URL string to get individual components
        var urlComponents = URLComponents(string: newUrlString)!
        var queryItems: [URLQueryItem] = []
        
        // Separate the parameters into correct format
        for item in urlComponents.queryItems ?? [] {
            switch item.name {
            case "jobTitles":
                let fields = item.value?.split(separator: ",").map { String($0) } ?? []
                fields.forEach { field in
                    queryItems.append(URLQueryItem(name: "jobTitle[]", value: field))
                }
            case "qualifications":
                let sectors = item.value?.split(separator: ",").map { String($0) } ?? []
                sectors.forEach { sector in
                    queryItems.append(URLQueryItem(name: "qualification[]", value: sector))
                }
            case "cities":
                let categories = item.value?.split(separator: ",").map { String($0) } ?? []
                categories.forEach { category in
                    queryItems.append(URLQueryItem(name: "city[]", value: category))
                }
            case "workPlaces":
                let companySizes = item.value?.split(separator: ",").map { String($0) } ?? []
                companySizes.forEach { size in
                    queryItems.append(URLQueryItem(name: "workplace[]", value: size))
                }
            default:
                queryItems.append(item)
            }
        }
        
        urlComponents.queryItems = queryItems
        let correctedUrlString = urlComponents.url?.absoluteString ?? ""
        
        print("New URL in correct format: ", correctedUrlString)
        jobs.removeAll()
        urlWithFilters = correctedUrlString
        currentPage = 1
        flag = true
        fetchData()
    }
    
    var selectedProfessions = Set<String>()
    var selectedEducations = Set<String>()
    var selectedLocations = Set<String>()
    var selectedWorkplaces = Set<String>()
    
    
    
    var jobTitle: String?
    var jobLocation: String?
    var baseURL = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/jobs"
    var urlWithFilters = ""
    var urlString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/jobs"
    var finalURL = ""
    
    var jobLocationArray: [String] = []
    
    var jobsCountLabel : UILabel = {
        let label = UILabel()
        label.text = "267 jobs"
        label.font = .systemFont(ofSize: 14)
        label.tintColor = UIColor(hex: "#344054")
        return label
    }()
    var jobsCollectionView : UICollectionView!
    var jobs: [Job] = []
    
    var currentPage: Int = 1
    var totalPages: Int = 1
    var isLoadingData = false
    
    var appliedJobs : [String] = []
    
    var filterIcon : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "slider.horizontal.3")
        imgView.tintColor = UIColor(hex: "#000000")
        imgView.contentMode = .scaleAspectFit
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white // Set the background color for the view
        
        navigationItem.title = jobTitle ?? ""
        
//        baseURL = "\(baseURL)?jobTitle=\(jobTitle!)"
        urlSettings()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapFilterIcon))
        filterIcon.addGestureRecognizer(tap)
        
        let image = UIImage(systemName: "slider.horizontal.3")
        let filterButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapFilterIcon))
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.rightBarButtonItem?.tintColor = .black
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
        
        if !jobLocationArray.isEmpty {
            queryItems.append(URLQueryItem(name: "City", value: "\(jobLocationArray)"))
        }

        components.queryItems = queryItems
        finalURL = components.url?.absoluteString ?? baseURL
        
        
        fetchData()
        setupViews()
    }
    
    func setupViews() {
        setupJobsCountLabel()
        setupJobsCollectionView()
    }
    
    
    @objc func didTapFilterIcon() {
        print(#function)
        let filtersVC = JobFilterVC(selectedProfessions: selectedProfessions, selectedEducations: selectedEducations, selectedLocations: selectedLocations, selectedWorkplaces: selectedWorkplaces)
        filtersVC.delegate = self
        navigationController?.pushViewController(filtersVC, animated: true)
    }

    
    func setupJobsCountLabel() {
        jobsCountLabel.text = "\(jobs.count) jobs found"
        jobsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(jobsCountLabel)
        
        NSLayoutConstraint.activate([
            jobsCountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
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
            jobsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.bounds.height
        
//        print(offsetY , contentHeight - height)
        
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
            self.fetchData()
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

extension JobSearchResult : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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


extension JobSearchResult { // extension for API
    
    func fetchData() {
//        if urlWithFilters != "" {
//            urlString = "\(baseURL)\(urlWithFilters)&page=\(currentPage)&jobTitle[]=\(jobTitle!)"
//        }
//        else {
//            urlString = "\(baseURL)?page=\(currentPage)&jobTitle[]=\(jobTitle!)"
//        }
        if urlWithFilters != "" {
            urlString = "\(baseURL)\(urlWithFilters)&page=\(currentPage)"
        }
        else {
            urlString = "\(baseURL)?page=\(currentPage)"
        }
        print("Url String to fetch ", urlString)

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        isLoadingData = true

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            defer { self.isLoadingData = false }
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if self.flag == true {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Raw response data: \(responseString)")
                }
            }
            
            do {
                let jobResponse = try JSONDecoder().decode(JobResponse.self, from: data)
                DispatchQueue.main.async {
                    self.jobs.append(contentsOf: jobResponse.jobs)
                    self.totalPages = jobResponse.totalPages
                    self.isLoadingData = false
                    self.jobsCollectionView.reloadSections(IndexSet(integer: 0))
                    self.jobsCountLabel.text = "\(self.jobs.count) jobs found"
                }
            } catch {
                print("Decoding error: \(error)")
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


