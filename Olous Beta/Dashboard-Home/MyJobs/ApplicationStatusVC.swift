//
//  ApplicationStatusVC.swift
//  Olous Beta
//
//  Created by Salt Technologies on 19/07/24.
//

import UIKit

class ApplicationStatusVC: UIViewController {
    
    
    var dataArray : [ApplicationStatus] = []
    
    var statusCollectionView : UICollectionView!
    var currentPage: Int = 1
    var totalPages: Int = 1
    var isLoadingData = false
    
    var filterView = UIView()
    var isFiltersVisible = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground

        navigationItem.title = "Application Status"
        
        let image = UIImage(systemName: "slider.horizontal.3")
        let filterButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapFilterIcon))
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        setupViews()
    }
    
    func setupViews() {
        fetchApplicationStatus()
        setupCollectionView()
        setupFilterView()
    }
    
    func setupContentView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: view.topAnchor),
            view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        statusCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        statusCollectionView.register(StatusCell.self, forCellWithReuseIdentifier: "StatusCell")
        statusCollectionView.register(LoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "LoadingFooter")
        
        statusCollectionView.dataSource = self
        statusCollectionView.delegate = self
        
        statusCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusCollectionView)
        
        NSLayoutConstraint.activate([
            statusCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            statusCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            statusCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
            self.statusCollectionView.reloadSections(IndexSet(integer: 0))
        }
        
        currentPage += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchApplicationStatus()
        }
    }
    
    
    
    func setupFilterView() {
        filterView.backgroundColor = UIColor(hex: "#F3F4F6")
        filterView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterView)
        
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            filterView.leadingAnchor.constraint(equalTo: view.trailingAnchor),
            filterView.widthAnchor.constraint(equalToConstant: view.frame.width - 100),
            filterView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc func didTapFilterIcon() {
        if !isFiltersVisible {
            UIView.animate(withDuration: 0.36) {
                self.filterView.transform = CGAffineTransform(translationX: -self.view.frame.width + 100, y: 0)
            }
            isFiltersVisible = true
        }
        else {
            UIView.animate(withDuration: 0.36) {
                self.filterView.transform = .identity
            }
            isFiltersVisible = false
        }
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


extension ApplicationStatusVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatusCell", for: indexPath) as! StatusCell
        let apclStatus = dataArray[indexPath.row]
        
        cell.jobTitle.text = apclStatus.jobTitle
        cell.companyName.text = apclStatus.companyName
        
        let str = getColorForScoreLabel(text: apclStatus.overallScore)
        if let index = str.firstIndex(of: "#") {
            let bgColor = String(str[..<index])
            let textColor = String(str[str.index(after: index)...])
            cell.scoreView.backgroundColor = UIColor(hex: "#\(bgColor)")
            cell.scoreLabel.textColor = UIColor(hex: "#\(textColor)")
            cell.scoreView.layer.borderColor = UIColor(hex: "#\(textColor)").cgColor
        }
        
        cell.scoreLabel.text = getScoreText(text: apclStatus.overallScore)
        cell.statusLabel.text = apclStatus.viewStatus.capitalized
        
        let time = getTimeAgoString(from: apclStatus.applicationDate)
        cell.appliedTime.text = time
        
        cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 160)
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
    
    
    
    func getScoreText(text: String) -> String {
        var result = ""
        if text.contains("N/A/100") {
            return "N/A"
        }
        
        if let index = text.firstIndex(of: "/") {
            result = String(text[..<index])
        }
        
        result = "\(result)% matched"
        
        return result
    }
    
    func getColorForScoreLabel(text : String) -> String {
        var color = ""
        if let index = text.firstIndex(of: "/") {
            let result = String(text[..<index])
            if let x = Int(result) {
                // first half before # symbol, will be used as background color
                // second half will be used as textColor
                
                if x > 80 {
                    color = "ECFDF3#067647"
                }
                else if(x > 40) {
                    color = "fffbeb#f59e0b"
                }
                else {
                    color = "FEF3F2#D92D20"
                }
            }
            else {
                // if NA/100 is response
                color = "FEF3F2#D92D20"
            }
        }
        
        return color
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
}


extension ApplicationStatusVC {
    func fetchApplicationStatus() {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/get-jobs-applied?sort=Newest&page=\(currentPage)") else {
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
        
        isLoadingData = true
        
        // Execute the network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            defer { self.isLoadingData = false }
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Raw response data: \(responseString)")
//            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ApplicationStatusResponse.self, from: data)
                
                // Update the jobs array on the main thread
                DispatchQueue.main.async {
                    self.dataArray.append(contentsOf: response.results)
                    self.totalPages = response.totalPages
                    self.isLoadingData = false
                    self.statusCollectionView.reloadSections(IndexSet(integer: 0))
                }
            } catch {
                DispatchQueue.main.async {
                    print("Failed to decode Recent JSON: \(error)")
                    self.isLoadingData = false
                }
            }
//            DispatchQueue.main.async {
//                if self.jobs.count == 0 {
//                    self.noJobsView.isHidden = false
//                }
//            }
        }
        task.resume()
    }
}
