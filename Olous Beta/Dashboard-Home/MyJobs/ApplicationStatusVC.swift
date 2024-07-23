//
//  ApplicationStatusVC.swift
//  Olous Beta
//
//  Created by Salt Technologies on 19/07/24.
//

import UIKit

class ApplicationStatusVC: UIViewController, UITextFieldDelegate {
    
    var dataArray : [ApplicationStatus] = []
    
    
    var sortButton = UIButton()
    var sortOptions = ["Newest", "Oldest"]
    var sortPicker = UIPickerView()
    var isSortVisible : Bool = false
    
    
    var searchView = UIView()
    var jobsTextField = UITextField()
    
    
    var statusCollectionView : UICollectionView!
    var currentPage: Int = 1
    var totalPages: Int = 1
    var isLoadingData = false
    
    
    let filters = ["Applied", "Technical", "HR", "Disqualified"]
    let filterPicker = UIPickerView()
    var isFilterVisible : Bool = false
    let toolbar = UIToolbar()
    
    var appliedFilter = "applied"
    var appliedSort = "Newest"
    var searchJobTitle = ""
    

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
        setupSortButton()
        setupSearchBar()
        setupCollectionView()
        setupNoJobsView()
    }
    
    
    
    func setupSortButton() {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "arrow.up.arrow.down")?.withTintColor(UIColor(hex: "#475467"))
        
        let imageOffsetY: CGFloat = -2.0 // Adjust this value to vertically align the image with the text if needed
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 14, height: 14)
        
        // Create attributed string with image and text
        let imageString = NSAttributedString(attachment: imageAttachment)
        let textString = NSAttributedString(string: " Sort", attributes: [
            .font: UIFont.systemFont(ofSize: 14) // Customize font size if needed
        ])
        
        let combinedString = NSMutableAttributedString()
        combinedString.append(imageString)
        combinedString.append(textString)
        
        // Set the attributed title to the button
        sortButton.setAttributedTitle(combinedString, for: .normal)
        sortButton.addTarget(self, action: #selector(didTapSortButton), for: .touchUpInside)
        sortButton.layer.borderWidth = 1
        sortButton.layer.cornerRadius = 8
        sortButton.layer.borderColor = UIColor(hex: "#667085").cgColor
        
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sortButton)
        NSLayoutConstraint.activate([
            sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 17),
            sortButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sortButton.widthAnchor.constraint(equalToConstant: 70),
            sortButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func didTapSortButton() {
        if isFilterVisible {
            filterPicker.removeFromSuperview()
            toolbar.removeFromSuperview()
            isFilterVisible = false
        }
        if !isSortVisible {
            isSortVisible = true
            
            sortPicker.delegate = self
            sortPicker.dataSource = self
            sortPicker.backgroundColor = .systemGray6
            sortPicker.tag = 2
            
            toolbar.sizeToFit()
            
            let title = UIBarButtonItem(title: "Select sorting order", style: .plain, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissSortPicker))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            toolbar.setItems([ title, flexibleSpace, doneButton], animated: false)
            
            toolbar.isUserInteractionEnabled = true
            toolbar.translatesAutoresizingMaskIntoConstraints = false
            
            sortPicker.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(sortPicker)
            view.addSubview(toolbar)
            
            NSLayoutConstraint.activate([
                sortPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                sortPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                sortPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                sortPicker.heightAnchor.constraint(equalToConstant: 150),
                
                toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                toolbar.bottomAnchor.constraint(equalTo: sortPicker.topAnchor),
                toolbar.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        else {
            sortPicker.removeFromSuperview()
            toolbar.removeFromSuperview()
            isSortVisible = false
        }
    }
    
    @objc func dismissSortPicker() {
        sortPicker.removeFromSuperview()
        toolbar.removeFromSuperview()
        isSortVisible = false
        
        DispatchQueue.main.async {
            self.currentPage = 1
            self.dataArray.removeAll()
            self.fetchApplicationStatus()
        }
    }
    
    
    func setupSearchBar() {
//        searchView.isHidden = true
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor(hex: "#667085").cgColor
        searchView.layer.cornerRadius = 12
        searchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchView)
        
        var searchIcon : UIImageView = UIImageView()
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.tintColor = UIColor(hex: "#667085").withAlphaComponent(0.6)
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchView.addSubview(searchIcon)
        
        jobsTextField.delegate = self
        jobsTextField.placeholder = "Enter Job Title"
//        jobsTextField.borderStyle = .roundedRect
        jobsTextField.textColor = UIColor(hex: "#101828").withAlphaComponent(0.64)
        jobsTextField.translatesAutoresizingMaskIntoConstraints = false
        searchView.addSubview(jobsTextField)
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchView.trailingAnchor.constraint(equalTo: sortButton.leadingAnchor, constant: -16),
            searchView.heightAnchor.constraint(equalToConstant: 45),
            
            searchIcon.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 10),
            searchIcon.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 10),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22),
            
            jobsTextField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 10),
            jobsTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 46),
            jobsTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            jobsTextField.heightAnchor.constraint(equalToConstant: 25)
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
            statusCollectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20),
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
    
    

    @objc func didTapFilterIcon() {
        if isSortVisible {
            sortPicker.removeFromSuperview()
            toolbar.removeFromSuperview()
            isSortVisible = false
        }
        
        if !isFilterVisible {
            isFilterVisible = true
            
            filterPicker.delegate = self
            filterPicker.dataSource = self
            filterPicker.backgroundColor = .systemGray6
            filterPicker.tag = 1
            
            toolbar.sizeToFit()
            
            let title = UIBarButtonItem(title: "Select Pipeline Status", style: .plain, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissFilterPicker))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            toolbar.setItems([ title, flexibleSpace, doneButton], animated: false)
            
            toolbar.isUserInteractionEnabled = true
            toolbar.translatesAutoresizingMaskIntoConstraints = false
            
            filterPicker.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(filterPicker)
            view.addSubview(toolbar)
            
            NSLayoutConstraint.activate([
                filterPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                filterPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                filterPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                filterPicker.heightAnchor.constraint(equalToConstant: 150),
                
                toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                toolbar.bottomAnchor.constraint(equalTo: filterPicker.topAnchor),
                toolbar.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        else {
            filterPicker.removeFromSuperview()
            toolbar.removeFromSuperview()
            isFilterVisible = false
        }
    }
    
    @objc func dismissFilterPicker() {
        filterPicker.removeFromSuperview()
        toolbar.removeFromSuperview()
        isFilterVisible = false
        
        DispatchQueue.main.async {
            self.currentPage = 1
            self.dataArray.removeAll()
            self.fetchApplicationStatus()
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            searchJobTitle = text.replacingCharacters(in: range, with: string).lowercased()
            fetchApplicationStatus()
        }
        return true
    }
    
    
    let noJobsView = UIView()
    private func setupNoJobsView() {
        noJobsView.isHidden = true
        noJobsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noJobsView)
    
        
        let title : UILabel = {
            let label = UILabel()
            label.text = "No Applications found"
            label.font = .boldSystemFont(ofSize: 18)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        noJobsView.addSubview(title)
        
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "We couldn’t find any application matching your search/filters, please try searching for something else or adjust your filters."
            label.font = .systemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        noJobsView.addSubview(label)
        

        NSLayoutConstraint.activate([
            noJobsView.topAnchor.constraint(equalTo: statusCollectionView.topAnchor, constant: 50),
            noJobsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noJobsView.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 100),
            noJobsView.heightAnchor.constraint(equalToConstant: 400),
            
            title.topAnchor.constraint(equalTo: noJobsView.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: noJobsView.centerXAnchor),
            
            label.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: noJobsView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: noJobsView.trailingAnchor),
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
}


extension ApplicationStatusVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return filters.count
        }
        else if pickerView.tag == 2 {
            return sortOptions.count
        }
        
        return 0
    }
    
    // UIPickerViewDelegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return filters[row]
        }
        else if pickerView.tag == 2 {
            return sortOptions[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            DispatchQueue.main.async {
                self.appliedFilter = self.filters[row].lowercased()
            }
            self.view.endEditing(true)
        }
        else if pickerView.tag == 2 {
            DispatchQueue.main.async {
                self.appliedSort = self.sortOptions[row]
            }
            self.view.endEditing(true)
        }
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
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/get-jobs-applied?jobTitle=\(searchJobTitle)&filter=\(appliedFilter)&sort=\(appliedSort)&page=\(currentPage)") else {
            print("Invalid URL")
            return
        }
        
        print(url)
        
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
            DispatchQueue.main.async {
                if self.dataArray.count == 0 {
                    self.noJobsView.isHidden = false
                }
            }
        }
        task.resume()
    }
}
