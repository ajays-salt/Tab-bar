//
//  JobFilterVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 28/05/24.
//

import UIKit

class JobFilterVC: UIViewController, UITextFieldDelegate {
    
    private var activeSearchTextField: UITextField?
    
    var searchTextFields: [UITextField] = []
    var filteredProfessions: [String] = []
    var filteredQualifications: [String] = []
    var filteredLocations: [String] = []
    var filteredWorkPlaces: [String] = []


    weak var delegate: CompanyFiltersDelegate?
    var filtersURL = ""
    
    init(selectedProfessions: Set<String>, selectedEducations: Set<String>, selectedLocations: Set<String>, selectedWorkplaces: Set<String>) {
        self.selectedProfessions = selectedProfessions
        self.selectedEducations = selectedEducations
        self.selectedLocations = selectedLocations
        self.selectedWorkplaces = selectedWorkplaces
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var professions = ["Field 1", "Field 2", "Field 3", "Field 4"]
    var qualifications = ["Sector 1", "Sector 2", "Sector 3", "Sector 4"]
    var locations = ["Category 1", "Category 2", "Category 3", "Category 4"]
    var workPlaces = ["Small", "Medium", "Large", "Enterprise"]

    var selectedProfessions = Set<String>()
    var selectedEducations = Set<String>()
    var selectedLocations = Set<String>()
    var selectedWorkplaces = Set<String>()

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
        
        filteredProfessions = professions
        filteredQualifications = qualifications
        filteredLocations = locations
        filteredWorkPlaces = workPlaces
        
        for _ in 0..<4 {
            let searchTextField = UITextField()
            searchTextField.placeholder = "Search"
            searchTextField.borderStyle = .roundedRect
            searchTextField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
            searchTextFields.append(searchTextField)
        }
        
        for searchTextField in searchTextFields {
            searchTextField.delegate = self
        }
         
    }
    
    @objc private func searchTextChanged(_ textField: UITextField) {
        activeSearchTextField = textField
        guard let searchText = textField.text else {
            return
        }

        switch textField {
        case searchTextFields[0]:
            filteredProfessions = searchText.isEmpty ? professions : professions.filter { $0.lowercased().contains(searchText.lowercased()) }
        case searchTextFields[1]:
            filteredQualifications = searchText.isEmpty ? qualifications : qualifications.filter { $0.lowercased().contains(searchText.lowercased()) }
        case searchTextFields[2]:
            filteredLocations = searchText.isEmpty ? locations : locations.filter { $0.lowercased().contains(searchText.lowercased()) }
        case searchTextFields[3]:
            filteredWorkPlaces = searchText.isEmpty ? workPlaces : workPlaces.filter { $0.lowercased().contains(searchText.lowercased()) }
        default:
            break
        }
        
        tableView.reloadData()
        activeSearchTextField?.becomeFirstResponder()
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
        selectedProfessions.removeAll()
        selectedEducations.removeAll()
        selectedLocations.removeAll()
        selectedWorkplaces.removeAll()
        tableView.reloadData()
    }
    
    @objc private func saveFilters() {
        // Handle saving filters logic, e.g., pass data back to previous VC
        delegate?.didApplyFilters(filtersURL)
        
        // Pass the selected filters back to CompanyController
        if let delegate = delegate as? JobSearchResult {
            delegate.selectedProfessions = selectedProfessions
            delegate.selectedEducations = selectedEducations
            delegate.selectedLocations = selectedLocations
            delegate.selectedWorkplaces = selectedWorkplaces
        }
        
        navigationController?.popViewController(animated: true)
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

extension JobFilterVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expandedSections[section] {
            switch section {
            case 0: return filteredProfessions.count
            case 1: return filteredQualifications.count
            case 2: return filteredLocations.count
            case 3: return filteredWorkPlaces.count
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
            text = filteredProfessions[indexPath.row]
            isSelected = selectedProfessions.contains(text)
        case 1:
            text = filteredQualifications[indexPath.row]
            isSelected = selectedEducations.contains(text)
        case 2:
            text = filteredLocations[indexPath.row]
            isSelected = selectedLocations.contains(text)
        case 3:
            text = filteredWorkPlaces[indexPath.row]
            isSelected = selectedWorkplaces.contains(text)
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
            text = filteredProfessions[indexPath.row]
            if selectedProfessions.contains(text) {
                selectedProfessions.remove(text)
            } else {
                selectedProfessions.insert(text)
            }
        case 1:
            text = filteredQualifications[indexPath.row]
            if selectedEducations.contains(text) {
                selectedEducations.remove(text)
            } else {
                selectedEducations.insert(text)
            }
        case 2:
            text = filteredLocations[indexPath.row]
            if selectedLocations.contains(text) {
                selectedLocations.remove(text)
            } else {
                selectedLocations.insert(text)
            }
        case 3:
            text = filteredWorkPlaces[indexPath.row]
            if selectedWorkplaces.contains(text) {
                selectedWorkplaces.remove(text)
            } else {
                selectedWorkplaces.insert(text)
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
        
        let searchTextField = searchTextFields[section]
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            searchTextField.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 30), // Adjust the position to be inside the header view
            searchTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return headerView
    }
    
    private func getTitleForSection(_ section: Int) -> String {
        switch section {
        case 0: return "Profession"
        case 1: return "Education"
        case 2: return "Job Location"
        case 3: return "Workplace"
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
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 4),
            
            chevronImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            chevronImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 4),
        ])

        return headerView
    }

    
    @objc private func handleHeaderTap(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        
        expandedSections[section] = !expandedSections[section]
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70 // Adjust the height as needed
    }

    private func updateFiltersURL() {
        var urlComponents = URLComponents()
        var queryItems = [URLQueryItem]()
        
        if !selectedProfessions.isEmpty {
            let fieldsItem = URLQueryItem(name: "jobTitles", value: selectedProfessions.joined(separator: ","))
            queryItems.append(fieldsItem)
        }
        
        if !selectedEducations.isEmpty {
            let sectorsItem = URLQueryItem(name: "qualifications", value: selectedEducations.joined(separator: ","))
            queryItems.append(sectorsItem)
        }
        
        if !selectedLocations.isEmpty {
            let categoriesItem = URLQueryItem(name: "cities", value: selectedLocations.joined(separator: ","))
            queryItems.append(categoriesItem)
        }
        
        if !selectedWorkplaces.isEmpty {
            let sizesItem = URLQueryItem(name: "workPlaces", value: selectedWorkplaces.joined(separator: ","))
            queryItems.append(sizesItem)
        }
        
        urlComponents.queryItems = queryItems
        filtersURL = urlComponents.url?.absoluteString ?? ""
    }
    
}

protocol JobFiltersDelegate: AnyObject {
    func didApplyFilters(_ filtersURL: String)
}


extension JobFilterVC {
    
    private func fetchFiltersData() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/filters") else {
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
            
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Raw response data: \(responseString)")
//            }
            
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
        
        if let fieldsArray = json["jobTitles"] as? [[String: Any]] {
            professions = fieldsArray.compactMap { item in
                if let count = item["count"] as? Int, let jobTitle = item["jobTitle"] as? String {
                    return "\(jobTitle.capitalized)(\(count))"
                }
                return nil
            }
            filteredProfessions = professions
        }
        
        if let sectorsArray = json["qualifications"] as? [[String: Any]] {
            qualifications = sectorsArray.compactMap { item in
                if let count = item["count"] as? Int, let qualification = item["qualification"] as? String {
                    return "\(qualification.trimmingCharacters(in: .whitespacesAndNewlines).capitalized)(\(count))"
                }
                return nil
            }
            filteredQualifications = qualifications
        }
        
        if let categoriesArray = json["cities"] as? [[String: Any]] {
            locations = categoriesArray.compactMap { item in
                if let count = item["count"] as? Int, let city = item["city"] as? String {
                    return "\(city.capitalized)(\(count))"
                }
                return nil
            }
            filteredLocations = locations
        }
        
        if let sizesArray = json["workPlaces"] as? [[String: Any]] {
            workPlaces = sizesArray.compactMap { item in
                if let count = item["count"] as? Int, let workPlace = item["workPlace"] as? String {
                    return "\(workPlace.capitalized)(\(count))"
                }
                return nil
            }
            filteredWorkPlaces = workPlaces
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activeSearchTextField?.becomeFirstResponder()
        }
    }

}
