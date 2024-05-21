//
//  EditSoftwareVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 20/05/24.
//

import UIKit

class EditSoftwareVC: UIViewController, UITextFieldDelegate {
    
    var loader: UIActivityIndicatorView!
    
    var scrollView : UIScrollView!
    
    let skillsTextField = UITextField()
    var skillsArray = ["Java", "C", "C++", "C#", "Swift", "Tekla", "iOS", "UIKit", "Programming", "C-Sharp", "Programming2", "Programming3"]
    var filteredSkillsArray : [String] = []
    let skillsTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()
    
    var addedSkillsView : UICollectionView!
    var addedSkillsArray : [String] = []
    var addedSkillsHashSet = Set<String>()
    var addedSkillsViewHeightConstraint: NSLayoutConstraint!
    
    let suggestionsLabel : UILabel = {
        let label = UILabel()
        label.text = "Suggestions :"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(hex: "#667085")
        return label
    }()
    var suggestedSkillsView : UICollectionView!
    var suggestedSkillsHashSet = Set<String>()
    var suggestedSkillsArray : [String] = []
    var suggestedSkillsViewHeightConstraint: NSLayoutConstraint!
    
    var bottomView : UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground

        navigationItem.title = "Edit Softwares"
        navigationItem.hidesBackButton = true
        
        let backButtonImage = UIImage(systemName: "xmark") // Change "xmark" to any system image you prefer
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        skillsTextField.delegate = self
        skillsTableView.delegate = self
        skillsTableView.dataSource = self
        
//        fetchUserProfile()
        fetchAndProcessSoftwares()
        
        setupViews()
    }
    
    @objc func backButtonPressed() {
        let alertController = UIAlertController(title: "Warning", message: "Do you want to proceed without editing Profile?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let proceedAction = UIAlertAction(title: "Proceed", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true) // Pop to previous view controller
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(proceedAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func setupViews() {
        setupScrollView()
        
        setupUI()
        setupAddedSkillsView()
        setupSuggestedSkillsView()
        
        setupBottomView()
    }
    
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
        
        let extraSpaceHeight: CGFloat = 50
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    func setupUI() {
        let skillsLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Softwares")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(skillsLabel)
        
        skillsTextField.placeholder = "Add Softwares"
        skillsTextField.borderStyle = .roundedRect
        skillsTextField.layer.borderWidth = 1
        skillsTextField.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        skillsTextField.layer.cornerRadius = 8
        skillsTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(skillsTextField)
        
        skillsTableView.layer.borderWidth = 1
        skillsTableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        skillsTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(skillsTableView)
        scrollView.bringSubviewToFront(skillsTableView)
        
        
        NSLayoutConstraint.activate([
            skillsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            skillsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            skillsTextField.topAnchor.constraint(equalTo: skillsLabel.bottomAnchor, constant: 10),
            skillsTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skillsTextField.heightAnchor.constraint(equalToConstant: 50),
            
            skillsTableView.topAnchor.constraint(equalTo: skillsTextField.bottomAnchor, constant: 10),
            skillsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skillsTableView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func setupAddedSkillsView() {
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        addedSkillsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addedSkillsView.register(Skill_Software_Cell.self, forCellWithReuseIdentifier: "skill1")
        addedSkillsView.delegate = self
        addedSkillsView.dataSource = self
        
        addedSkillsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(addedSkillsView)
        NSLayoutConstraint.activate([
            addedSkillsView.topAnchor.constraint(equalTo: skillsTextField.bottomAnchor, constant: 20),
            addedSkillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addedSkillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        addedSkillsViewHeightConstraint = addedSkillsView.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        addedSkillsViewHeightConstraint.isActive = true
        
//        reloadAddedSkills()
    }
    
    func reloadAddedSkills() {
        addedSkillsView.reloadData()
            
        // Calculate the content size
        addedSkillsView.layoutIfNeeded()
        let contentSize = addedSkillsView.collectionViewLayout.collectionViewContentSize
        
        // Update the height constraint based on content size
        addedSkillsViewHeightConstraint.constant = contentSize.height
        
        // Update constraints
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    func setupSuggestedSkillsView() {
        suggestionsLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(suggestionsLabel)
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        suggestedSkillsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        suggestedSkillsView.register(Skill_Software_Cell.self, forCellWithReuseIdentifier: "skill1")
        suggestedSkillsView.delegate = self
        suggestedSkillsView.dataSource = self
        
        suggestedSkillsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(suggestedSkillsView)
        
        NSLayoutConstraint.activate([
            suggestionsLabel.topAnchor.constraint(equalTo:addedSkillsView.bottomAnchor, constant: 20),
            suggestionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            suggestedSkillsView.topAnchor.constraint(equalTo: suggestionsLabel.bottomAnchor, constant: 10),
            suggestedSkillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            suggestedSkillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        suggestedSkillsViewHeightConstraint = suggestedSkillsView.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        suggestedSkillsViewHeightConstraint.isActive = true
        
//        reloadSuggestedSkills()
    }
    
    func reloadSuggestedSkills() {
        suggestedSkillsView.reloadData()
            
        // Calculate the content size
        suggestedSkillsView.layoutIfNeeded()
        let contentSize = suggestedSkillsView.collectionViewLayout.collectionViewContentSize
        
        // Update the height constraint based on content size
        suggestedSkillsViewHeightConstraint.constant = contentSize.height
        
        // Update constraints
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == skillsTextField {
            let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            filterSkills(with: searchText)
        }
        
        return true
    }
    
    func filterSkills(with searchText: String) {
        filteredSkillsArray = skillsArray.filter { $0.lowercased().hasPrefix(searchText.lowercased()) }
        
        // If there are no matching skills, add a special row to prompt the user to add the skill
        if filteredSkillsArray.isEmpty && !searchText.isEmpty {
            filteredSkillsArray.append("\(searchText)")
        }
        
        // Show or hide the table view based on the filtered skills count
        skillsTableView.isHidden = filteredSkillsArray.isEmpty
        
        if !skillsTableView.isHidden {
            scrollView.bringSubviewToFront(skillsTableView)
        }
        
        skillsTableView.reloadData()
    }
    
    
    func setupBottomView() {
        bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 20)
        saveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        saveButton.backgroundColor = UIColor(hex: "#0079C4")
        saveButton.layer.cornerRadius = 8
        
        saveButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(saveButton)
        
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            
            
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
        ])
    }
    
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNextButton() {
        uploadAddedSkills()
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


extension EditSoftwareVC : UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == suggestedSkillsView {
            return suggestedSkillsArray.count
        }
        return addedSkillsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skill1", for: indexPath) as! Skill_Software_Cell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        if collectionView == addedSkillsView {
            cell.textLabel.text = "  \(addedSkillsArray[indexPath.row])"
            cell.symbolLabel.text = "  X"
            cell.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            cell.textLabel.textColor = UIColor(hex: "#0079C4")
            cell.symbolLabel.textColor = UIColor(hex: "#0079C4")
        }
        else {
            if addedSkillsHashSet.contains(suggestedSkillsArray[indexPath.row]) {
                cell.layer.borderColor = UIColor(hex: "#0079C4").cgColor
                cell.textLabel.textColor = UIColor(hex: "#0079C4")
                cell.symbolLabel.textColor = UIColor(hex: "#0079C4")
            }
            else {
                cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
                cell.textLabel.textColor = UIColor(hex: "#98A2B3")
                cell.symbolLabel.textColor = UIColor(hex: "#344054")
            }
            
            cell.textLabel.text = " +"
            cell.textLabel.font = .boldSystemFont(ofSize: 20)
            cell.symbolLabel.text =  " \(suggestedSkillsArray[indexPath.row])"
            cell.symbolLabel.font = .systemFont(ofSize: 16)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var text = ""
        var width : CGFloat
        if collectionView == addedSkillsView {
            text = addedSkillsArray[indexPath.row]
            width = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width
        }
        else {
            text = suggestedSkillsArray[indexPath.row]
            width = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width + 2
        }
        // Adjust spacing
        return CGSize(width: width + 40, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == addedSkillsView {
            let t = addedSkillsArray[indexPath.row]
            addedSkillsArray.remove(at: indexPath.row)
            addedSkillsHashSet.remove(t)
            suggestedSkillsArray.append(t)
            if suggestedSkillsArray.contains(t) {
                reloadSuggestedSkills()
            }
            reloadAddedSkills()
        }
        else {
            let t = suggestedSkillsArray[indexPath.row]
            if !addedSkillsHashSet.contains(t) {
                addedSkillsArray.append(t)
                addedSkillsHashSet.insert(t)
                
                suggestedSkillsArray.remove(at: indexPath.row)
                
                reloadAddedSkills()
                reloadSuggestedSkills()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredSkillsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = filteredSkillsArray[indexPath.row]
        cell.selectionStyle = .none
        if addedSkillsHashSet.contains(filteredSkillsArray[indexPath.row]) {
            cell.backgroundColor = UIColor(hex: "#EAECF0")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if addedSkillsHashSet.contains(filteredSkillsArray[indexPath.row]) == false {
            
            addedSkillsArray.append(filteredSkillsArray[indexPath.row])
            addedSkillsHashSet.insert(filteredSkillsArray[indexPath.row])
            
            reloadAddedSkills()
            reloadSuggestedSkills()
            
            skillsTextField.text = nil
            skillsTableView.isHidden = true
        }
    }
}

extension EditSoftwareVC {
    struct SoftwareFetchResponse: Codable {
        let softwareSuggestions: String
        let softwares: String
    }
    
    
    func fetchUserProfile() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/profile") else {
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
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                print(user)
                self.addedSkillsArray = user.softwares!
                DispatchQueue.main.async {
                    self.reloadAddedSkills()
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }

        task.resume()
    }

    // Fetch and process softwares from API
    func fetchAndProcessSoftwares() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/candidate/softwares") else {
            print("Invalid URL")
            return
        }
        
        loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
//        loader.center = view.center
        loader.hidesWhenStopped = true
        
        loader.translatesAutoresizingMaskIntoConstraints = false // Disable autoresizing mask
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: 60), // Set width to 40
            loader.heightAnchor.constraint(equalToConstant: 60) // Set height to 40
        ])
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Include accessToken for Authorization
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        DispatchQueue.main.async {
            self.scrollView.alpha = 0
            self.loader.startAnimating()
            print("Loader should be visible now")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.fetchUserProfile()
            }
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                // Decode the JSON into the SoftwareFetchResponse struct
                let response = try JSONDecoder().decode(SoftwareFetchResponse.self, from: data)
                
                let processedSoftwares = self.processSoftwareString(softwareString: response.softwares)
                print("Processed Softwares: \(processedSoftwares)")
                let pss = self.processSoftwareString(softwareString: response.softwareSuggestions)
                print("Processed Suggestions: \(pss)")
                
                self.suggestedSkillsArray = pss
                DispatchQueue.main.async {
                    self.reloadSuggestedSkills()
                }
                
            } catch {
                print("Failed to decode or process data: \(error)")
            }
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.scrollView.alpha = 1
                print("loader stopped")
            }
        }.resume()
    }
    
    // Function to process the software string
    func processSoftwareString(softwareString: String) -> [String] {
        // Check if the string is in JSON-like array format
        if softwareString.hasPrefix("[") {
            // Attempt to parse it as JSON
            if let data = softwareString.data(using: .utf8),
               let jsonArray = try? JSONDecoder().decode([String].self, from: data) {
                return jsonArray.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            }
        }
        
        // Normalize the string by removing newline characters
        let normalizedString = softwareString.replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\"", with: "") // Remove quotes
        
        // Split the string based on commas if not JSON
        return normalizedString.components(separatedBy: ", ")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
    func parseNumberedSoftwareSuggestions(suggestions: String) -> [String] {
        // Split the string into individual lines assuming each new line is a separate suggestion
        let lines = suggestions.components(separatedBy: .newlines)
        
        // Use a regular expression to extract the software name after the number and period
        let regexPattern = "\\d+\\.\\s*(.+)"
        
        var softwareNames = [String]()
        
        for line in lines {
            if let regex = try? NSRegularExpression(pattern: regexPattern),
               let match = regex.firstMatch(in: line, range: NSRange(line.startIndex..., in: line)),
               let range = Range(match.range(at: 1), in: line) {
                let name = line[range].trimmingCharacters(in: .whitespacesAndNewlines)
                softwareNames.append(name)
            }
        }
        
        return softwareNames
    }
    
    func uploadAddedSkills() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
        
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        // Prepare the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Include accessToken for Authorization if needed
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Prepare the JSON body
        let json: [String: Any] = ["softwares": addedSkillsArray]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            print("Failed to encode softwares to JSON: \(error)")
            return
        }
        
        // Perform the URLSession task
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error in URLSession data task: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Successfully uploaded softwares")
            } else {
                print("Failed to upload softwares with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
                self.navigationController?.popViewController(animated: true)
            }
            
        }.resume()
    }
}
