//
//  InboxController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class CompanyController: UIViewController, UIScrollViewDelegate {
    
    var searchURL = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company"
    var companiesArray: [Company] = []
    var companiesLabel: UILabel!
    
    var searchCompanySection : UIView = UIView()
    var searchCompanyInnerSection : UIView = UIView()
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
        let vc = CompanyFilterVC()
        navigationController?.pushViewController(vc, animated: true)
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
        searchCompanySection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchCompanySection)
        
        NSLayoutConstraint.activate([
            searchCompanySection.topAnchor.constraint(equalTo: companiesLabel.bottomAnchor, constant: 10),
            searchCompanySection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchCompanySection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchCompanySection.heightAnchor.constraint(equalToConstant: 190)
        ])
    }
        
    func setupCompanySearchInnerSection() {
        searchCompanyInnerSection.backgroundColor = .systemBackground
        searchCompanyInnerSection.layer.cornerRadius = 12
        searchCompanyInnerSection.layer.borderWidth = 1
        
        let borderColor = UIColor(hex: "#EAECF0")
        searchCompanyInnerSection.layer.borderColor = borderColor.cgColor
        
        searchCompanyInnerSection.translatesAutoresizingMaskIntoConstraints = false
        searchCompanySection.addSubview(searchCompanyInnerSection)
        
        NSLayoutConstraint.activate([
            searchCompanyInnerSection.topAnchor.constraint(equalTo: searchCompanySection.topAnchor, constant: 16),
            searchCompanyInnerSection.leadingAnchor.constraint(equalTo: searchCompanySection.leadingAnchor, constant: 16),
            searchCompanyInnerSection.trailingAnchor.constraint(equalTo: searchCompanySection.trailingAnchor, constant: -16),
            searchCompanyInnerSection.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.tintColor = UIColor(hex: "#667085")
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchCompanyInnerSection.addSubview(searchIcon)
        
        NSLayoutConstraint.activate([
            searchIcon.topAnchor.constraint(equalTo: searchCompanyInnerSection.topAnchor, constant: 14),
            searchIcon.leadingAnchor.constraint(equalTo: searchCompanyInnerSection.leadingAnchor, constant: 16),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor(hex: "#EAECF0")
        searchCompanyInnerSection.addSubview(separatorLine)
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorLine.leadingAnchor.constraint(equalTo: searchCompanyInnerSection.leadingAnchor).isActive = true
        separatorLine.trailingAnchor.constraint(equalTo: searchCompanyInnerSection.trailingAnchor).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: searchCompanyInnerSection.bottomAnchor, constant: -49).isActive = true
        
        
        companyNameTextField.placeholder = "Enter Company name (Required)"
        companyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        searchCompanyInnerSection.addSubview(companyNameTextField)
        
        NSLayoutConstraint.activate([
            companyNameTextField.topAnchor.constraint(equalTo: searchCompanyInnerSection.topAnchor, constant: 14),
            companyNameTextField.leadingAnchor.constraint(equalTo: searchCompanyInnerSection.leadingAnchor, constant: 46),
            companyNameTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            companyNameTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        locationIcon.image = UIImage(named: "locationLogo")
        locationIcon.tintColor = UIColor(hex: "#667085")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        searchCompanyInnerSection.addSubview(locationIcon)
        
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: searchCompanyInnerSection.topAnchor, constant: 63),
            locationIcon.leadingAnchor.constraint(equalTo: searchCompanyInnerSection.leadingAnchor, constant: 18),
            locationIcon.widthAnchor.constraint(equalToConstant: 21),
            locationIcon.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        locationTextField.placeholder = "Enter Location (Optional)"
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        searchCompanyInnerSection.addSubview(locationTextField)
        
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: searchCompanyInnerSection.topAnchor, constant: 63),
            locationTextField.leadingAnchor.constraint(equalTo: searchCompanyInnerSection.leadingAnchor, constant: 47),
            locationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            locationTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
        
    }
    
    func setupSearchCompanyButton() {
        searchCompanyButton.addTarget(self, action: #selector(didTapSearchCompany), for: .touchUpInside)
        
        searchCompanyButton.translatesAutoresizingMaskIntoConstraints = false
        searchCompanySection.addSubview(searchCompanyButton)
        
        NSLayoutConstraint.activate([
            searchCompanyButton.topAnchor.constraint(equalTo: searchCompanyInnerSection.bottomAnchor, constant: 16),
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
        
        // Fetch company logo
        let baseURLString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/company-pic?logo="
        let companyLogoURLString = baseURLString + company.logo
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
        return .init(width: view.frame.width - 32, height: 182)
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
//        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company?page=\(page)") else {
//            print("Invalid URL")
//            return
//        }
        
        var urlString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company?page=\(page)"
        
        // Check if a search was performed and modify the URL accordingly
        if let companyName = companyNameTextField.text, !companyName.isEmpty {
            urlString += "&search=\(companyName)"
        }
        
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

            do {
                let response = try JSONDecoder().decode(CompanyResponse.self, from: data)
                DispatchQueue.main.async {
                    // Now you have a populated CompanyResponse object
                    // You can use it to update your UI or perform other actions
                    print("Current Page: \(response.currentPage)")
                    print("Total Pages: \(response.totalPages)")
                    
                    self.totalPages = response.totalPages
                    self.companiesArray.append(contentsOf: response.companies)
                    self.companiesCollectionView.reloadData()
                    print(self.companiesArray.count)
                }
                DispatchQueue.main.async {
                    self.isLoadingData = false
                    self.companiesCollectionView.reloadSections(IndexSet(integer: 0))
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
 
