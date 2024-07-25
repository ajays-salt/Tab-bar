//
//  InboxController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class CompanyController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, CompanyFiltersDelegate {
    
    
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
            case "fields":
                let fields = item.value?.split(separator: ",").map { String($0) } ?? []
                fields.forEach { field in
                    queryItems.append(URLQueryItem(name: "field[]", value: field))
                }
            case "sectors":
                let sectors = item.value?.split(separator: ",").map { String($0) } ?? []
                sectors.forEach { sector in
                    queryItems.append(URLQueryItem(name: "sector[]", value: sector))
                }
            case "categories":
                let categories = item.value?.split(separator: ",").map { String($0) } ?? []
                categories.forEach { category in
                    queryItems.append(URLQueryItem(name: "category[]", value: category))
                }
            case "companySizes":
                let companySizes = item.value?.split(separator: ",").map { String($0) } ?? []
                companySizes.forEach { size in
                    queryItems.append(URLQueryItem(name: "companySize[]", value: size))
                }
            default:
                queryItems.append(item)
            }
        }
        
        urlComponents.queryItems = queryItems
        let correctedUrlString = urlComponents.url?.absoluteString ?? ""
        
        print("New URL in correct format: ", correctedUrlString)
        companiesArray.removeAll()
        urlWithFilters = correctedUrlString
        fetchCompany(page: 1)
    }

    var selectedFields = Set<String>()
    var selectedSectors = Set<String>()
    var selectedCategories = Set<String>()
    var selectedCompanySizes = Set<String>()
    
    
    
    var searchURL = "\(Config.serverURL)/api/v1/company"
    var urlWithFilters = ""
    var urlString = "\(Config.serverURL)/api/v1/company"
    var companiesArray: [Company] = []
    var companiesLabel: UILabel!
    
    
    var searchCompanySection : UIView = UIView()
    var companySearchIS : UIView = UIView()
    var companySearchIS2 : UIView = UIView()
    
    var searchIcon : UIImageView = UIImageView()
    let companyNameTextField = UITextField()
    var locationIcon : UIImageView = UIImageView()
    let locationTextField = UITextField()
    var searchCompanyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Search Companies", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#0079C4")
        button.layer.cornerRadius = 12
        return button
    }()
    
    var companiesCollectionView: UICollectionView!
    
    var currentPage: Int = 1
    var totalPages: Int = 1
    var isLoadingData = false
    
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
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        
        setupViews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapFilterIcon))
        filterIcon.addGestureRecognizer(tap)
        fetchCompany(page: currentPage)
    }
    
    func setupViews() {
        setupFilterIcon()
        setupCompaniesLabel()
        setupCompanySearchSection()
        setupCompanySearchInnerSection()
        setupSearchCompanyButton()
        setupCompaniesCollectionView()
        setupNoJobsView()
    }
    
    func setupFilterIcon() {
        filterIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterIcon)
        NSLayoutConstraint.activate([
            filterIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            filterIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterIcon.widthAnchor.constraint(equalToConstant: 30),
            filterIcon.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    @objc func didTapFilterIcon() {
        print(#function)
        let filtersVC = CompanyFilterVC(selectedFields: selectedFields, selectedSectors: selectedSectors, selectedCategories: selectedCategories, selectedCompanySizes: selectedCompanySizes)
        filtersVC.delegate = self
        navigationController?.pushViewController(filtersVC, animated: true)
    }
    
    func setupCompaniesLabel() {
        companiesLabel = UILabel()
        companiesLabel.text = "COMPANIES"
        companiesLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        companiesLabel.textAlignment = .center
        companiesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(companiesLabel)
        
        NSLayoutConstraint.activate([
            companiesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            companiesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    func setupCompanySearchSection() {
        searchCompanySection.backgroundColor = UIColor(hex: "#1E293B")
        searchCompanySection.layer.cornerRadius = 8
        searchCompanySection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchCompanySection)
        
        let ready = UILabel()
        ready.text = "Let's find your dream company"
        ready.textColor = UIColor(hex: "#FFFFFF")
        ready.font = .boldSystemFont(ofSize: 20)
        ready.translatesAutoresizingMaskIntoConstraints = false
        
        searchCompanySection.addSubview(ready)
        
        NSLayoutConstraint.activate([
            searchCompanySection.topAnchor.constraint(equalTo: companiesLabel.bottomAnchor, constant: 10),
            searchCompanySection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchCompanySection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchCompanySection.heightAnchor.constraint(equalToConstant: 178),
            
            ready.topAnchor.constraint(equalTo: searchCompanySection.topAnchor, constant: 16),
            ready.leadingAnchor.constraint(equalTo: searchCompanySection.leadingAnchor, constant: 16),
        ])
    }
        
    func setupCompanySearchInnerSection() {
        companySearchIS.backgroundColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.06)
        companySearchIS.layer.cornerRadius = 12
        companySearchIS.layer.borderWidth = 1
        let borderColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.06)
        companySearchIS.layer.borderColor = borderColor.cgColor
        
        companySearchIS.translatesAutoresizingMaskIntoConstraints = false
        searchCompanySection.addSubview(companySearchIS)
        
        
        var searchIcon : UIImageView = UIImageView()
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.tintColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.6)
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        companySearchIS.addSubview(searchIcon)
        
        
        let placeholderText = "Enter Company name"
        let placeholderColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.64)
        companyNameTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        
        companyNameTextField.delegate = self
        companyNameTextField.addDoneButtonOnKeyboard()
        companyNameTextField.textColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.64)
        companyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        companySearchIS.addSubview(companyNameTextField)
        
        NSLayoutConstraint.activate([
            companySearchIS.topAnchor.constraint(equalTo:         searchCompanySection.topAnchor, constant: 56),
            companySearchIS.leadingAnchor.constraint(equalTo:         searchCompanySection.leadingAnchor, constant: 16),
            companySearchIS.trailingAnchor.constraint(equalTo:         searchCompanySection.trailingAnchor, constant: -16),
            companySearchIS.heightAnchor.constraint(equalToConstant: 45),
            
            searchIcon.topAnchor.constraint(equalTo: companySearchIS.topAnchor, constant: 12),
            searchIcon.leadingAnchor.constraint(equalTo: companySearchIS.leadingAnchor, constant: 16),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22),
            
            companyNameTextField.topAnchor.constraint(equalTo: companySearchIS.topAnchor, constant: 10),
            companyNameTextField.leadingAnchor.constraint(equalTo: companySearchIS.leadingAnchor, constant: 46),
            companyNameTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            companyNameTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
        companySearchIS2.isHidden = true
        
        companySearchIS2.backgroundColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.06)
        companySearchIS2.layer.cornerRadius = 12
        companySearchIS2.layer.borderWidth = 1
        companySearchIS2.layer.borderColor = borderColor.cgColor
        
        companySearchIS2.translatesAutoresizingMaskIntoConstraints = false
                searchCompanySection.addSubview(companySearchIS2)
        
        
        var locationIcon : UIImageView = UIImageView()
        locationIcon.image = UIImage(named: "location-dot")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        companySearchIS2.addSubview(locationIcon)
        
        
        let placeholderText2 = "City, state or zip code"
        let placeholderColor2 = UIColor(hex: "#FFFFFF").withAlphaComponent(0.64)
        locationTextField.attributedPlaceholder = NSAttributedString(string: placeholderText2, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor2])
        locationTextField.delegate = self
        locationTextField.textColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.64)
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        companySearchIS2.addSubview(locationTextField)
        
        NSLayoutConstraint.activate([
            companySearchIS2.topAnchor.constraint(equalTo: companySearchIS.bottomAnchor, constant: 10),
            companySearchIS2.leadingAnchor.constraint(equalTo:         searchCompanySection.leadingAnchor, constant: 16),
            companySearchIS2.trailingAnchor.constraint(equalTo:         searchCompanySection.trailingAnchor, constant: -16),
            companySearchIS2.heightAnchor.constraint(equalToConstant: 45),
            
            locationIcon.topAnchor.constraint(equalTo: companySearchIS2.topAnchor, constant: 12),
            locationIcon.leadingAnchor.constraint(equalTo: companySearchIS2.leadingAnchor, constant: 18),
            locationIcon.widthAnchor.constraint(equalToConstant: 21),
            locationIcon.heightAnchor.constraint(equalToConstant: 26),
            
            locationTextField.topAnchor.constraint(equalTo: companySearchIS2.topAnchor, constant: 10),
            locationTextField.leadingAnchor.constraint(equalTo: companySearchIS2.leadingAnchor, constant: 47),
            locationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            locationTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
        
    }
    
    func setupSearchCompanyButton() {
        searchCompanyButton.addTarget(self, action: #selector(didTapSearchCompany), for: .touchUpInside)
        
        searchCompanyButton.translatesAutoresizingMaskIntoConstraints = false
        searchCompanySection.addSubview(searchCompanyButton)
        
        NSLayoutConstraint.activate([
            searchCompanyButton.topAnchor.constraint(equalTo: companySearchIS.bottomAnchor, constant: 18),
            searchCompanyButton.leadingAnchor.constraint(equalTo: searchCompanySection.leadingAnchor, constant: 16),
            searchCompanyButton.trailingAnchor.constraint(equalTo: searchCompanySection.trailingAnchor, constant: -16),
            searchCompanyButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    @objc func didTapSearchCompany() {
//        guard let companyName = companyNameTextField.text, !companyName.isEmpty else {
//            let alert = UIAlertController(title: "Missing Information", message: "Please enter company name", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default))
//            present(alert, animated: true)
//            return
//        }
        
        
        companyNameTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        
        // Reset the company array and start fetching from the first page
        companiesArray = []
        currentPage = 1
        fetchCompany(page: currentPage)
    }
    
    
    func setupCompaniesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        companiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        companiesCollectionView.register(CompaniesCell.self, forCellWithReuseIdentifier: "CompaniesCell")
        companiesCollectionView.register(LoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "LoadingFooter")
        companiesCollectionView.dataSource = self
        companiesCollectionView.delegate = self
        
        companiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(companiesCollectionView)
        
        NSLayoutConstraint.activate([
            companiesCollectionView.topAnchor.constraint(equalTo: searchCompanySection.bottomAnchor, constant: 20),
            companiesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            companiesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            companiesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    
    let noJobsView = UIView()
    private func setupNoJobsView() {
        noJobsView.isHidden = true
        noJobsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noJobsView)
    
        
        let title : UILabel = {
            let label = UILabel()
            label.text = "No Companies found"
            label.font = .boldSystemFont(ofSize: 18)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        noJobsView.addSubview(title)
        
        
        let label : UILabel = {
            let label = UILabel()
            label.text = "We couldn’t find any company matching your search, please try searching for something else."
            label.font = .systemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        noJobsView.addSubview(label)
        

        NSLayoutConstraint.activate([
            noJobsView.topAnchor.constraint(equalTo: searchCompanySection.bottomAnchor, constant: 50),
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
    
    
    
    // ************************************ collectionView bottom loader *********************************************
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.bounds.height
        
        
        if offsetY > contentHeight - height && !isLoadingData && currentPage < totalPages {
            print("Attempting to load more data..." , " Current Page: \(currentPage)")
            loadMoreData()
        }
    }
    func loadMoreData() {
        guard !isLoadingData else { return }
        isLoadingData = true
        
        DispatchQueue.main.async {
            self.companiesCollectionView.reloadSections(IndexSet(integer: 0)) // Assuming you have only one section
        }
        
        currentPage += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchCompany(page: self.currentPage)
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

extension CompanyController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companiesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompaniesCell", for: indexPath) as! CompaniesCell
        let company = companiesArray[indexPath.row]
        
        cell.companyName.text = company.name
        if let firstCharacter = company.name.first, !firstCharacter.isUppercase {
            cell.companyName.text = company.name.prefix(1).uppercased() + company.name.dropFirst()
        }
        
        cell.jobLocationLabel.text = company.location ?? "No Location"
        
        cell.categoryLabel.text = company.who
        cell.sectorLabel.text = company.sector?.joined(separator: ", ") ?? ""
        cell.fieldLabel.text = company.field
        
        // Fetch company logo
        let baseURLString = "\(Config.serverURL)/api/v1/company/company-pic?logo="
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
        
        cell.viewJobs.text = "View jobs(\(company.jobCount ?? 0))"
        
        cell.layer.borderColor = UIColor(hex: "#E2E8F0").cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 222)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let company = companiesArray[indexPath.row]
        let vc = CompanyDetailVC()
        vc.company = company
        navigationController?.pushViewController(vc, animated: true)
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
}

// Extension for API
extension CompanyController {
    func fetchCompany(page: Int) {
        if urlWithFilters != "" {
            urlString = "\(searchURL)\(urlWithFilters)&page=\(page)"
        }
        else {
            urlString = "\(searchURL)?page=\(page)"
        }
        
        // Check if a search was performed and modify the URL accordingly
        if let companyName = companyNameTextField.text, !companyName.isEmpty {
            urlString += "&search=\(companyName)"
        }
        
        print("Url String to fetch ", urlString)
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Retrieve the accessToken and set the Authorization header
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Access Token not found")
            return
        }

        // Execute the network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Ensure flag is reset after operation
            defer { self.isLoadingData = false }
            
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Raw response data: \(responseString)")
//            }

            do {
                let response = try JSONDecoder().decode(CompanyResponse.self, from: data)
                DispatchQueue.main.async {
//                    print("Current Page: \(response.currentPage)")
//                    print("Total Pages: \(response.totalPages)")
                    if response.totalPages == 0 {
                        self.noJobsView.isHidden = false
                    }
                    else {
                        self.noJobsView.isHidden = true
                    }
                    
                    self.totalPages = response.totalPages
                    self.companiesArray.append(contentsOf: response.companies)
                    self.companiesCollectionView.reloadData()
//                    print(self.companiesArray.count)
                }
                DispatchQueue.main.async {
                    self.isLoadingData = false
                    self.companiesCollectionView.reloadSections(IndexSet(integer: 0))
                    if response.totalPages == 0 {
                        self.noJobsView.isHidden = false
                    }
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }

        task.resume()
    }
}


// this class is to show loader at bottom of collectionView while loading more cells(pages) in that collectionView
class LoadingFooterView: UICollectionReusableView {
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupActivityIndicator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
}
 
