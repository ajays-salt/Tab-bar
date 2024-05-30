//
//  CompanyFilterVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 27/05/24.
//

import UIKit

class CompanyFilterVC: UIViewController {
    
    weak var delegate: CompanyFiltersDelegate?
    var filtersURL = ""
    
    init(selectedFields: Set<String>, selectedSectors: Set<String>, selectedCategories: Set<String>, selectedCompanySizes: Set<String>) {
        self.selectedFields = selectedFields
        self.selectedSectors = selectedSectors
        self.selectedCategories = selectedCategories
        self.selectedCompanySizes = selectedCompanySizes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var fields = ["Field 1", "Field 2", "Field 3", "Field 4"]
    var sectors = ["Sector 1", "Sector 2", "Sector 3", "Sector 4"]
    var categories = ["Category 1", "Category 2", "Category 3", "Category 4"]
    var companySizes = ["Small", "Medium", "Large", "Enterprise"]

    var selectedFields = Set<String>()
    var selectedSectors = Set<String>()
    var selectedCategories = Set<String>()
    var selectedCompanySizes = Set<String>()

    let tableView = UITableView()
    
    var expandedSections: [Bool] = [true, true, true, true]

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground

        navigationItem.title = "Apply Filters"

        fetchFiltersData()
        
        setupTableView()
        setupButtons()
    }
    
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80) // Space for buttons
        ])
    }

    private func setupButtons() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(hex: "#F7F8F9")
        bgView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgView)
        
        let clearButton = UIButton(type: .system)
        clearButton.setTitle("Clear Filters", for: .normal)
        clearButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        clearButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        clearButton.backgroundColor = UIColor(hex: "#FFFFFF")
        clearButton.layer.cornerRadius = 8
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        clearButton.clipsToBounds = true
        clearButton.titleLabel?.textAlignment = .center
        clearButton.addTarget(self, action: #selector(clearFilters), for: .touchUpInside)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clearButton)
        
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        saveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        saveButton.backgroundColor = UIColor(hex: "#0079C4")
        saveButton.layer.cornerRadius = 8
        saveButton.clipsToBounds = true
        saveButton.titleLabel?.textAlignment = .center
        saveButton.addTarget(self, action: #selector(saveFilters), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgView.widthAnchor.constraint(equalToConstant: view.frame.width),
            bgView.heightAnchor.constraint(equalToConstant: 80),
            
            clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            clearButton.widthAnchor.constraint(equalToConstant: 120),
            clearButton.heightAnchor.constraint(equalToConstant: 36),
            
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            saveButton.widthAnchor.constraint(equalToConstant: 70),
            saveButton.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    @objc private func clearFilters() {
        selectedFields.removeAll()
        selectedSectors.removeAll()
        selectedCategories.removeAll()
        selectedCompanySizes.removeAll()
        tableView.reloadData()
    }
    
    @objc private func saveFilters() {
        // Handle saving filters logic, e.g., pass data back to previous VC
        delegate?.didApplyFilters(filtersURL)
        
        // Pass the selected filters back to CompanyController
        if let delegate = delegate as? CompanyController {
            delegate.selectedFields = selectedFields
            delegate.selectedSectors = selectedSectors
            delegate.selectedCategories = selectedCategories
            delegate.selectedCompanySizes = selectedCompanySizes
        }
        
        navigationController?.popViewController(animated: true)
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


extension CompanyFilterVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expandedSections[section] {
            switch section {
            case 0: return fields.count
            case 1: return sectors.count
            case 2: return categories.count
            case 3: return companySizes.count
            default: return 0
            }
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var text: String
        var isSelected: Bool

        switch indexPath.section {
        case 0:
            text = fields[indexPath.row]
            isSelected = selectedFields.contains(text)
        case 1:
            text = sectors[indexPath.row]
            isSelected = selectedSectors.contains(text)
        case 2:
            text = categories[indexPath.row]
            isSelected = selectedCategories.contains(text)
        case 3:
            text = companySizes[indexPath.row]
            isSelected = selectedCompanySizes.contains(text)
        default:
            text = ""
            isSelected = false
        }

        cell.textLabel?.text = text
        cell.accessoryType = isSelected ? .checkmark : .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var text: String

        switch indexPath.section {
        case 0:
            text = fields[indexPath.row]
            if selectedFields.contains(text) {
                selectedFields.remove(text)
            } else {
                selectedFields.insert(text)
            }
        case 1:
            text = sectors[indexPath.row]
            if selectedSectors.contains(text) {
                selectedSectors.remove(text)
            } else {
                selectedSectors.insert(text)
            }
        case 2:
            text = categories[indexPath.row]
            if selectedCategories.contains(text) {
                selectedCategories.remove(text)
            } else {
                selectedCategories.insert(text)
            }
        case 3:
            text = companySizes[indexPath.row]
            if selectedCompanySizes.contains(text) {
                selectedCompanySizes.remove(text)
            } else {
                selectedCompanySizes.insert(text)
            }
        default:
            return
        }

        updateFiltersURL()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = createSectionHeader(title: getTitleForSection(section), isExpanded: expandedSections[section])
        headerView.tag = section
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHeaderTap(_:)))
        headerView.addGestureRecognizer(tapGesture)
        headerView.isUserInteractionEnabled = true
        
        return headerView
    }
    
    private func getTitleForSection(_ section: Int) -> String {
        switch section {
        case 0: return "Fields"
        case 1: return "Sectors"
        case 2: return "Categories"
        case 3: return "Company Size"
        default: return ""
        }
    }
    
    private func createSectionHeader(title: String, isExpanded: Bool) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(hex: "#1E293B") // Adjust the background color

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 20) // Adjust the font size
        titleLabel.textColor = .white // Adjust the text color
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)

        let chevronImageView = UIImageView()
        let chevronImage = UIImage(systemName: isExpanded ? "chevron.up" : "chevron.down")
        chevronImageView.image = chevronImage
        chevronImageView.tintColor = .white
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(chevronImageView)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),
            
            chevronImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        return headerView
    }

    
    @objc private func handleHeaderTap(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        
        expandedSections[section] = !expandedSections[section]
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 // Adjust the height as needed
    }

    private func updateFiltersURL() {
        var urlComponents = URLComponents()
        var queryItems = [URLQueryItem]()
        
        if !selectedFields.isEmpty {
            let fieldsItem = URLQueryItem(name: "fields", value: selectedFields.joined(separator: ","))
            queryItems.append(fieldsItem)
        }
        
        if !selectedSectors.isEmpty {
            let sectorsItem = URLQueryItem(name: "sectors", value: selectedSectors.joined(separator: ","))
            queryItems.append(sectorsItem)
        }
        
        if !selectedCategories.isEmpty {
            let categoriesItem = URLQueryItem(name: "categories", value: selectedCategories.joined(separator: ","))
            queryItems.append(categoriesItem)
        }
        
        if !selectedCompanySizes.isEmpty {
            let sizesItem = URLQueryItem(name: "companySizes", value: selectedCompanySizes.joined(separator: ","))
            queryItems.append(sizesItem)
        }
        
        urlComponents.queryItems = queryItems
        filtersURL = urlComponents.url?.absoluteString ?? ""
    }
    
}

protocol CompanyFiltersDelegate: AnyObject {
    func didApplyFilters(_ filtersURL: String)
}


extension CompanyFilterVC {
    private func fetchFiltersData() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/filters") else {
            print("Invalid URL")
            return
        }
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access token not found in UserDefaults")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                self.parseFiltersData(json: json)
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        task.resume()
    }
    
    private func parseFiltersData(json: [String: Any]?) {
        guard let json = json else { return }
        
        if let fieldsArray = json["fields"] as? [[String: Any]] {
            fields = fieldsArray.compactMap { item in
                if let count = item["count"] as? Int, let field = item["field"] as? String {
                    return "\(field.capitalized)(\(count))"
                }
                return nil
            }
        }
        
        if let sectorsArray = json["sectors"] as? [[String: Any]] {
            sectors = sectorsArray.compactMap { item in
                if let count = item["count"] as? Int, let sector = item["sector"] as? String {
                    return "\(sector.trimmingCharacters(in: .whitespacesAndNewlines).capitalized)(\(count))"
                }
                return nil
            }
        }
        
        if let categoriesArray = json["whos"] as? [[String: Any]] {
            categories = categoriesArray.compactMap { item in
                if let count = item["count"] as? Int, let category = item["who"] as? String {
                    return "\(category.capitalized)(\(count))"
                }
                return nil
            }
        }
        
        if let sizesArray = json["sizes"] as? [[String: Any]] {
            companySizes = sizesArray.compactMap { item in
                if let count = item["count"] as? Int, let size = item["size"] as? String {
                    return "\(size.capitalized)(\(count))"
                }
                return nil
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
