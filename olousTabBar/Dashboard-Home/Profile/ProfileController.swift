//
//  ProfileController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class ProfileController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    
    var headerView = UIView()
    
    let profileCircle = UIView()
    let profileCircleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#0079C4")
        label.font = .boldSystemFont(ofSize: 48)
        return label
    }()
    var profileImageView : UIImageView!
    
    let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Ajay Sarkate"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    let jobTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.textColor = UIColor(hex: "#475467")
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    let locationLabel : UILabel = {
        let label = UILabel()
        label.text = "Pune, Maharashtra"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let profileEditButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.tintColor = UIColor(hex: "#667085")
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    let scrollView = UIScrollView()
    
    var preferenceEditButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit", for: .normal)
        btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    let separatorLine1 = UIView()
    let separatorLine2 = UIView()
    let separatorLine3 = UIView()
    let separatorLine4 = UIView()
    let separatorLine5 = UIView()
    
    
//   ******************************  New changes in this controller **************************************************************
    
    var employmentCV : UICollectionView!
    var empDataArray : [Employment] = []
    var employmentCVHeightConstraint: NSLayoutConstraint!
    
    var empEditView : UIView!
    var editExpTitleTF : UITextField!
    var editExpCompanyTF : UITextField!
    var editYearsOfExpTF : UITextField!
    var editExpPeriodTF : UITextField!
    var empSaveButton: UIButton!
    var empCancelButton: UIButton!
    
    
    var educationCV : UICollectionView!
    var eduDataArray : [Education] = []
    var educationCVHeightConstraint: NSLayoutConstraint!
    
    var eduEditView : UIView!
    var editEducationTF : UITextField!
    var editCollegeTF : UITextField!
    var editPassYearTF : UITextField!
    var editMarksTF : UITextField!
    var eduSaveButton: UIButton!
    var eduCancelButton: UIButton!
    
    
    var projectCV : UICollectionView!
    var projectDataArray : [Project] = []
    var projectCVHeightConstraint: NSLayoutConstraint!
    
    var projectEditView: UIScrollView!
    var editProjectNameTF: UITextField!
    var editProjectRoleTF: UITextField!
    var editProjectDescTF: UITextView!
    var editProjectRespTF: UITextView!
    var projectSaveButton: UIButton!
    var projectCancelButton: UIButton!
    
    var projectDescLoader: UIActivityIndicatorView!
    var projectRespLoader: UIActivityIndicatorView!
    
    
    let preferencesVC = PreferencesVC()
    let headlineVC = HeadlineAndSummary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
//        fetchUserProfile()
                
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserProfile()
    }
    
    
    func setupViews() {
        setupScrollView()
        setupHeaderView()
        setupProfileEditButton()
        
        setupProfileCircleView()
        
        setupSeparatorLine1()
        
        setupEmploymentsView()
        setupEmpEditView()
        
        setupSeparatorLine2()
        
        setupEducationView()
        setupEducationEditView()
        
        setupSeparatorLine3()
        
        setupProjectView()
        setupProjectEditView()
        setupLoaderForProjectEdit()
        
        setupSeparatorLine4()
        setupPreferencesVC()
        setupEditPreferencesVC()
        
        setupHeadlineAndSummary()
        
        setupLogOut()
    }
    
    func setupProfileEditButton() {
        profileEditButton.addTarget(self, action: #selector(didTapProfileEditButton), for: .touchUpInside)
        profileEditButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(profileEditButton)
        
        NSLayoutConstraint.activate([
            profileEditButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 24),
            profileEditButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            profileEditButton.widthAnchor.constraint(equalToConstant: 40),
            profileEditButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func didTapProfileEditButton(gesture: UITapGestureRecognizer) {
        let vc = EditProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupScrollView() {
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
        
        let extraSpaceHeight: CGFloat = 1800
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    func setupHeaderView() {
        headerView.backgroundColor = UIColor(hex: "#F0F9FF")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }

    func setupProfileCircleView() {
        profileCircle.backgroundColor = UIColor(hex: "#D7F0FF")
        profileCircle.layer.cornerRadius = 60
        
        profileCircle.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(profileCircle)
        NSLayoutConstraint.activate([
//            profileCircle.topAnchor.constraint(equalTo: headerView.top, constant: 30),
            profileCircle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            profileCircle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            profileCircle.widthAnchor.constraint(equalToConstant: 120),
            profileCircle.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        // Calculate initials
        let arr = userNameLabel.text!.components(separatedBy: " ")
        let initials = "\(arr[0].first ?? "A")\(arr[1].first ?? "B")".uppercased()
        
        
        profileCircleLabel.text = initials
        profileCircleLabel.isHidden = true
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: profileCircle.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: profileCircle.centerYAnchor)
        ])
        
        
        
        profileImageView = UIImageView()
//        profileImageView.isHidden = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 60
        
        // Add the selected image view to the profile circle
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: profileCircle.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: profileCircle.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: profileCircle.trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: profileCircle.bottomAnchor)
        ])
        
        [userNameLabel, jobTitleLabel, locationLabel].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: profileCircle.topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
            userNameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            jobTitleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 12),
            jobTitleLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
            jobTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            locationLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 6),
            locationLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    
    func setupSeparatorLine1() {
        separatorLine1.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine1.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine1)
        
        NSLayoutConstraint.activate([
            separatorLine1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            separatorLine1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine1.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
    func setupEmploymentsView() {
        let employmentLabel : UILabel = {
            let label = UILabel()
            label.text = "Employments"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        employmentLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(employmentLabel)
        NSLayoutConstraint.activate([
            employmentLabel.topAnchor.constraint(equalTo: separatorLine1.bottomAnchor, constant: 16),
            employmentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Add", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            return btn
        }()
        addButton.addTarget(self, action: #selector(didTapAddEmployment), for: .touchUpInside)
        
        scrollView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: employmentLabel.topAnchor, constant: 0),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        employmentCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        employmentCV.register(EmploymentCell.self, forCellWithReuseIdentifier: "exp")
        employmentCV.delegate = self
        employmentCV.dataSource = self
        
        employmentCV.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(employmentCV)
        NSLayoutConstraint.activate([
            employmentCV.topAnchor.constraint(equalTo: employmentLabel.bottomAnchor, constant: 30),
            employmentCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            employmentCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        employmentCVHeightConstraint = employmentCV.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        employmentCVHeightConstraint.isActive = true
        
        
//        reloadEmploymentsCollectionView()
    }
    
    func reloadEmploymentsCollectionView() {
        employmentCV.reloadData()
            
        // Calculate the content size
        employmentCV.layoutIfNeeded()
        let contentSize = employmentCV.collectionViewLayout.collectionViewContentSize
        employmentCVHeightConstraint.constant = contentSize.height
        
        updateScrollViewContentSize()
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @objc func deleteEmpCell(_ sender : UIButton) {
        guard let cell = sender.superview as? EmploymentCell, // Adjust the number of superviews according to your cell's hierarchy
            let indexPath = employmentCV.indexPath(for: cell)
        else {
            return
        }
        
        // Call the confirmation alert
        askUserConfirmation(title: "Delete Employment", message: "Are you sure you want to delete this item?") {
            // This closure is executed if the user confirms
            self.empDataArray.remove(at: indexPath.row)
            
            // Perform batch updates for animation
            self.employmentCV.performBatchUpdates({
                self.employmentCV.deleteItems(at: [indexPath])
            }, completion: { _ in
                self.reloadEmploymentsCollectionView()
            })
            
            // Assume uploadEmploymentArray() syncs data with a server or updates the local storage
            self.uploadEmploymentArray()
        }
    }
    
    func setupEmpEditView() {
        // Initialize and configure editView
        empEditView = UIView()
        empEditView.backgroundColor = .white
        empEditView.layer.cornerRadius = 12
        empEditView.layer.shadowOpacity = 0.25
        empEditView.layer.shadowRadius = 5
        empEditView.layer.shadowOffset = CGSize(width: 0, height: 2)
        empEditView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(empEditView)
        
        // Set initial off-screen position
        NSLayoutConstraint.activate([
            empEditView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            empEditView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            empEditView.heightAnchor.constraint(equalToConstant: view.frame.height - 100),
            empEditView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)  // Top of editView to the bottom of the main view
        ])

        // Setup text fields and labels
        let labelsTitles = ["Designation", "Company", "Years of Experience", "Employment Period"]
        let textFields = [UITextField(), UITextField(), UITextField(), UITextField()]
        var lastBottomAnchor = empEditView.topAnchor
        
        for (index, title) in labelsTitles.enumerated() {
            let label = UILabel()
            label.text = title
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            empEditView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: lastBottomAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: empEditView.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: empEditView.trailingAnchor, constant: -20)
            ])
            
            let textField = textFields[index]
            textField.borderStyle = .roundedRect
            textField.placeholder = "Enter \(title)"
            textField.translatesAutoresizingMaskIntoConstraints = false
            empEditView.addSubview(textField)
            
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                textField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: label.trailingAnchor)
            ])
            
            lastBottomAnchor = textField.bottomAnchor
        }
        
        editExpTitleTF = textFields[0]
        editExpTitleTF.delegate = self
        editExpCompanyTF = textFields[1]
        editExpCompanyTF.delegate = self
        editYearsOfExpTF = textFields[2]
        editYearsOfExpTF.delegate = self
        editExpPeriodTF = textFields[3]
        editExpPeriodTF.delegate = self
        
        // Setup buttons
        empSaveButton = UIButton(type: .system)
        empSaveButton.setTitle("Save", for: .normal)
        empSaveButton.titleLabel?.font = .systemFont(ofSize: 20)
        empSaveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        empSaveButton.backgroundColor = UIColor(hex: "#0079C4")
        empSaveButton.layer.cornerRadius = 8
        empSaveButton.addTarget(self, action: #selector(saveEmpChanges), for: .touchUpInside)
        
        
        
        empCancelButton = UIButton(type: .system)
        empCancelButton.setTitle("Cancel", for: .normal)
        empCancelButton.titleLabel?.font = .systemFont(ofSize: 20)
        empCancelButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        empCancelButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        empCancelButton.layer.borderWidth = 1
        empCancelButton.layer.cornerRadius = 8
        empCancelButton.addTarget(self, action: #selector(cancelEmpEdit), for: .touchUpInside)
        
        
        empSaveButton.translatesAutoresizingMaskIntoConstraints = false
        empCancelButton.translatesAutoresizingMaskIntoConstraints = false
        empEditView.addSubview(empSaveButton)
        empEditView.addSubview(empCancelButton)
        
        NSLayoutConstraint.activate([
//            saveButton.bottomAnchor.constraint(equalTo: editView.bottomAnchor, constant: -60),
            empSaveButton.topAnchor.constraint(equalTo: editExpPeriodTF.bottomAnchor, constant: 20),
            empSaveButton.trailingAnchor.constraint(equalTo: empEditView.trailingAnchor, constant: -20),
            empSaveButton.widthAnchor.constraint(equalToConstant: 80),
            empSaveButton.heightAnchor.constraint(equalToConstant: 40),
            
            empCancelButton.bottomAnchor.constraint(equalTo: empSaveButton.bottomAnchor),
            empCancelButton.leadingAnchor.constraint(equalTo: empEditView.leadingAnchor, constant: 20),
            empCancelButton.widthAnchor.constraint(equalToConstant: 80),
            empCancelButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    @objc func saveEmpChanges() {
        // Attempt to get the selected index path, if any
        let selectedIndexPath = employmentCV.indexPathsForSelectedItems?.first
        
        // Ensure all fields are non-empty
        guard let companyName = editExpCompanyTF.text, !companyName.isEmpty,
              let yearsOfExperience = editYearsOfExpTF.text, !yearsOfExperience.isEmpty,
              let employmentDesignation = editExpTitleTF.text, !employmentDesignation.isEmpty,
              let employmentPeriod = editExpPeriodTF.text, !employmentPeriod.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields")
            return
        }
        
        // Create the employment object
        let newEmployment = Employment(companyName: companyName, yearsOfExperience: yearsOfExperience,
                                       employmentDesignation: employmentDesignation, employmentPeriod: employmentPeriod,
                                       employmentType: "") // Assuming employmentType is optional or handled elsewhere

        if let indexPath = selectedIndexPath {
            // Update the existing item in the data array
            empDataArray[indexPath.row] = newEmployment
            employmentCV.reloadItems(at: [indexPath])
        } else {
            // Add new item to the data array
            empDataArray.append(newEmployment)
            employmentCV.insertItems(at: [IndexPath(row: empDataArray.count - 1, section: 0)])
            reloadEmploymentsCollectionView()
        }
        
        uploadEmploymentArray()
        cancelEmpEdit()
    }
    
    var totalExperience : Double!
    
    func uploadEmploymentArray() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL for updating resume")
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not found")
            return
        }
        
        guard let experienceArray = empDataArray as? [Employment], !experienceArray.isEmpty else {
            print("Employment data array is empty or not properly cast.")
            return
        }

        guard let jsonData = encodeEmploymentArray(experienceArray: experienceArray, totalExperience: totalExperience ?? 0) else {
            print("Failed to encode employment data")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response from server: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if httpResponse.statusCode == 200 {
                print("Data successfully uploaded")
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Server response: \(responseString)")
                }
            } else {
                print("Failed to upload data, status code: \(httpResponse.statusCode)")
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response details: \(responseString)")
                }
            }
        }.resume()
    }
    
    func encodeEmploymentArray(experienceArray: [Employment], totalExperience: Double) -> Data? {
        guard let firstDesignation = experienceArray.first?.employmentDesignation else {
            print("No employment designation available in the first item of the array.")
            return nil
        }

        let employmentData = EmploymentData(
            experience: experienceArray,
            designation: firstDesignation,
            totalExperience: "\(totalExperience)"
        )

        do {
            let jsonData = try JSONEncoder().encode(employmentData)
            return jsonData
        } catch {
            print("Error encoding employment data to JSON: \(error)")
            return nil
        }
    }

    @objc func cancelEmpEdit() {
        editExpTitleTF.text = ""
        editExpCompanyTF.text = ""
        editYearsOfExpTF.text = ""
        editExpPeriodTF.text = ""
        UIView.animate(withDuration: 0.3) {
            self.empEditView.transform = .identity
        }
    }
    
    
    @objc func didTapAddEmployment() {
        UIView.animate(withDuration: 0.3) {
            self.empEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)  // Move up by 300 points
        }
    }

    
    
    func setupSeparatorLine2() {
        separatorLine2.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine2.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine2)
        
        NSLayoutConstraint.activate([
            separatorLine2.topAnchor.constraint(equalTo: employmentCV.bottomAnchor, constant: 20),
            separatorLine2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine2.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
    func setupEducationView() {
        let educationLabel : UILabel = {
            let label = UILabel()
            label.text = "Education"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        educationLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(educationLabel)
        NSLayoutConstraint.activate([
            educationLabel.topAnchor.constraint(equalTo: separatorLine2.bottomAnchor, constant: 16),
            educationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Add", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            return btn
        }()
        addButton.addTarget(self, action: #selector(didTapAddEducation), for: .touchUpInside)
        
        scrollView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: separatorLine2.bottomAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        educationCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        educationCV.register(EducationCell.self, forCellWithReuseIdentifier: "edu")
        educationCV.delegate = self
        educationCV.dataSource = self
        
        educationCV.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(educationCV)
        NSLayoutConstraint.activate([
            educationCV.topAnchor.constraint(equalTo: educationLabel.bottomAnchor, constant: 30),
            educationCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            educationCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        educationCVHeightConstraint = educationCV.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        educationCVHeightConstraint.isActive = true
        
//        reloadCollectionView()
    }
    func reloadEducationCollectionView() {
        educationCV.reloadData()
        educationCV.layoutIfNeeded()
        
        let contentSize = educationCV.collectionViewLayout.collectionViewContentSize
        educationCVHeightConstraint.constant = contentSize.height
        
        updateScrollViewContentSize()
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setupEducationEditView() {
        // Initialize and configure editView
        eduEditView = UIView()
        eduEditView.backgroundColor = .white
        eduEditView.layer.cornerRadius = 12
        eduEditView.layer.shadowOpacity = 0.25
        eduEditView.layer.shadowRadius = 5
        eduEditView.layer.shadowOffset = CGSize(width: 0, height: 2)
        eduEditView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(eduEditView)
        
        // Set initial off-screen position
        NSLayoutConstraint.activate([
            eduEditView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eduEditView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eduEditView.heightAnchor.constraint(equalToConstant: view.frame.height - 100),
            eduEditView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)  // Top of editView to the bottom of the main view
        ])

        // Setup text fields and labels
        let labelsTitles = ["Education", "College", "Passing Year", "Marks Obtained"]
        let textFields = [UITextField(), UITextField(), UITextField(), UITextField()]
        var lastBottomAnchor = eduEditView.topAnchor
        
        for (index, title) in labelsTitles.enumerated() {
            let label = UILabel()
            label.text = title
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            eduEditView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: lastBottomAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: eduEditView.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: eduEditView.trailingAnchor, constant: -20)
            ])
            
            let textField = textFields[index]
            textField.borderStyle = .roundedRect
            textField.placeholder = "Enter \(title)"
            textField.translatesAutoresizingMaskIntoConstraints = false
            eduEditView.addSubview(textField)
            
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                textField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: label.trailingAnchor)
            ])
            
            lastBottomAnchor = textField.bottomAnchor
        }
        
        editEducationTF = textFields[0]
        editEducationTF.delegate = self
        editCollegeTF = textFields[1]
        editCollegeTF.delegate = self
        editPassYearTF = textFields[2]
        editPassYearTF.keyboardType = .numberPad
        editMarksTF = textFields[3]
        editMarksTF.keyboardType = .decimalPad
        
        // Setup buttons
        eduSaveButton = UIButton(type: .system)
        eduSaveButton.setTitle("Save", for: .normal)
        eduSaveButton.titleLabel?.font = .systemFont(ofSize: 20)
        eduSaveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        eduSaveButton.backgroundColor = UIColor(hex: "#0079C4")
        eduSaveButton.layer.cornerRadius = 8
        eduSaveButton.addTarget(self, action: #selector(saveEduChanges), for: .touchUpInside)
        
        
        
        eduCancelButton = UIButton(type: .system)
        eduCancelButton.setTitle("Cancel", for: .normal)
        eduCancelButton.titleLabel?.font = .systemFont(ofSize: 20)
        eduCancelButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        eduCancelButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        eduCancelButton.layer.borderWidth = 1
        eduCancelButton.layer.cornerRadius = 8
        eduCancelButton.addTarget(self, action: #selector(cancelEduEdit), for: .touchUpInside)
        
        
        eduSaveButton.translatesAutoresizingMaskIntoConstraints = false
        eduCancelButton.translatesAutoresizingMaskIntoConstraints = false
        eduEditView.addSubview(eduSaveButton)
        eduEditView.addSubview(eduCancelButton)
        
        NSLayoutConstraint.activate([
            eduSaveButton.bottomAnchor.constraint(equalTo: eduEditView.bottomAnchor, constant: -60),
            eduSaveButton.trailingAnchor.constraint(equalTo: eduEditView.trailingAnchor, constant: -20),
            eduSaveButton.widthAnchor.constraint(equalToConstant: 80),
            eduSaveButton.heightAnchor.constraint(equalToConstant: 40),
            
            eduCancelButton.bottomAnchor.constraint(equalTo: eduSaveButton.bottomAnchor),
            eduCancelButton.leadingAnchor.constraint(equalTo: eduEditView.leadingAnchor, constant: 20),
            eduCancelButton.widthAnchor.constraint(equalToConstant: 80),
            eduCancelButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    @objc func saveEduChanges() {
        // Attempt to get the selected index path, if any
        let selectedIndexPath = educationCV.indexPathsForSelectedItems?.first
        
        // Ensure all fields are non-empty
        guard let educationName = editEducationTF.text, !educationName.isEmpty,
              let yearOfPassing = editPassYearTF.text, !yearOfPassing.isEmpty,
              let boardOrUniversity = editCollegeTF.text, !boardOrUniversity.isEmpty,
              let marks = editMarksTF.text, !marks.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields before saving.")
            return
        }
        
        // Create the education object
        let newEducation = Education(educationName: educationName,
                                     yearOfPassing: yearOfPassing,
                                     boardOrUniversity: boardOrUniversity,
                                     marksObtained: marks)  // Modify according to your data model if necessary
        
        if let indexPath = selectedIndexPath {
            // Update the existing item in the data array
            eduDataArray[indexPath.row] = newEducation
            educationCV.reloadItems(at: [indexPath])
        } else {
            // Add new item to the data array
            eduDataArray.append(newEducation)
            educationCV.insertItems(at: [IndexPath(row: eduDataArray.count - 1, section: 0)])
            reloadEducationCollectionView()
        }
        
        uploadEducationArray()
        cancelEduEdit()
    }
    
    func uploadEducationArray() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not found")
            return
        }
        
        
        
        let educationDictionary = ["education": eduDataArray]
        var jsonData: Data? = nil
        do {
            jsonData = try JSONEncoder().encode(educationDictionary)
        } catch {
            print("Error encoding dataArray to JSON: \(error)")
        }
        
//        guard let jsonData = encodeEducationArray() else {
//            print("Failed to encode education data")
//            return
//        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization") // Replace `accessToken` with your actual token
        request.httpBody = jsonData
        

        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response from server: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Data successfully uploaded")
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Server response: \(responseString)")
                }
            } else {
                print("Failed to upload data, status code: \(httpResponse.statusCode)")
                print(data , error)
            }
            
        }.resume()
    }

    @objc func cancelEduEdit() {
        editEducationTF.text = ""
        editCollegeTF.text = ""
        editPassYearTF.text = ""
        editMarksTF.text = ""
        UIView.animate(withDuration: 0.3) {
            self.eduEditView.transform = .identity
        }
    }
    
    @objc func deleteEduCell(_ sender : UIButton) {
        guard let cell = sender.superview as? EducationCell, // Adjust the number of superviews according to your cell's hierarchy
            let indexPath = educationCV.indexPath(for: cell)
        else {
            return
        }
        
        // Call the confirmation alert
        askUserConfirmation(title: "Delete Education", message: "Are you sure you want to delete this item?") {
            // This closure is executed if the user confirms
            self.eduDataArray.remove(at: indexPath.row)
            
            // Perform batch updates for animation
            self.educationCV.performBatchUpdates({
                self.educationCV.deleteItems(at: [indexPath])
            }, completion: { _ in
                self.reloadEducationCollectionView()
            })
            
            // Assume uploadEducationArray() syncs data with a server or updates the local storage
            self.uploadEducationArray()
        }
    }
    
    @objc func didTapAddEducation() {
        UIView.animate(withDuration: 0.3) {
            self.eduEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)  // Move up by 300 points
        }
    }
    
    
    func setupSeparatorLine3() {
        separatorLine3.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine3.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine3)
        
        NSLayoutConstraint.activate([
            separatorLine3.topAnchor.constraint(equalTo: educationCV.bottomAnchor, constant: 20),
            separatorLine3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine3.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupProjectView() {
        let projectLabel : UILabel = {
            let label = UILabel()
            label.text = "Project"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        projectLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(projectLabel)
        NSLayoutConstraint.activate([
            projectLabel.topAnchor.constraint(equalTo: separatorLine3.bottomAnchor, constant: 16),
            projectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Add", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            return btn
        }()
        addButton.addTarget(self, action: #selector(didTapAddProject), for: .touchUpInside)
        
        scrollView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: separatorLine3.bottomAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        projectCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        projectCV.register(ProjectCell.self, forCellWithReuseIdentifier: "project")
        projectCV.delegate = self
        projectCV.dataSource = self
        
        projectCV.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(projectCV)
        NSLayoutConstraint.activate([
            projectCV.topAnchor.constraint(equalTo: projectLabel.bottomAnchor, constant: 30),
            projectCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            projectCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        projectCVHeightConstraint = projectCV.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        projectCVHeightConstraint.isActive = true
    }
    func reloadProjectCollectionView() {
        projectCV.reloadData()
        projectCV.layoutIfNeeded()
        
        let contentSize = projectCV.collectionViewLayout.collectionViewContentSize
        projectCVHeightConstraint.constant = contentSize.height
        
        updateScrollViewContentSize()
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func deleteProjectCell(_ sender : UIButton) {
        guard let cell = sender.superview as? ProjectCell, // Adjust the number of superviews according to your cell's hierarchy
            let indexPath = projectCV.indexPath(for: cell)
        else {
            return
        }
        
        askUserConfirmation(title: "Delete Item", message: "Are you sure you want to delete this item?") {
            // This closure is executed if the user confirms
            self.projectDataArray.remove(at: indexPath.row)
            self.projectCV.performBatchUpdates({
                self.projectCV.deleteItems(at: [indexPath])
            }, completion: { _ in
                self.reloadProjectCollectionView()
            })
            self.uploadProjectDataArray()
        }
    }
    
    
    @objc func didTapAddProject() {
        UIView.animate(withDuration: 0.3) {
            self.projectEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)  // Move up by 300 points
        }
    }
    
    func setupProjectEditView() {
        // Initialize and configure editView
        projectEditView = UIScrollView()
        projectEditView.contentSize = CGSize(width: view.bounds.width, height: view.frame.height + 100)
        projectEditView.backgroundColor = .white
        projectEditView.layer.cornerRadius = 12
        projectEditView.layer.shadowOpacity = 0.25
        projectEditView.layer.shadowRadius = 5
        projectEditView.layer.shadowOffset = CGSize(width: 0, height: 2)
        projectEditView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(projectEditView)

        // Set initial off-screen position
        NSLayoutConstraint.activate([
            projectEditView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            projectEditView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            projectEditView.heightAnchor.constraint(equalToConstant: view.frame.height - 100),
            projectEditView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)  // Top of editView to the bottom of the main view
        ])

        // Setup text fields and text views along with labels
        let labelsTitles = ["Project Name", "Role", "Description", "Responsibility"]
        let controls = [UITextField(), UITextField(), UITextView(), UITextView()]
        var lastBottomAnchor = projectEditView.topAnchor
        
        for (index, title) in labelsTitles.enumerated() {
            let label = UILabel()
            label.text = title
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            projectEditView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: lastBottomAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: projectEditView.leadingAnchor, constant: 16)
            ])
            
            let control = controls[index]
            control.translatesAutoresizingMaskIntoConstraints = false
            projectEditView.addSubview(control)
            
            if let textField = control as? UITextField {
                textField.borderStyle = .roundedRect
                textField.placeholder = "Enter \(title)"
                NSLayoutConstraint.activate([
                    textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                    textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
                ])
                lastBottomAnchor = textField.bottomAnchor
            } else if let textView = control as? UITextView {
                textView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
                textView.layer.borderWidth = 1.0
                textView.layer.cornerRadius = 5
                textView.font = .systemFont(ofSize: 14)
                textView.isScrollEnabled = true  // Enable scrolling for larger content
                NSLayoutConstraint.activate([
                    textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
                    textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    textView.heightAnchor.constraint(equalToConstant: 120)  // Fixed height for UITextView
                ])
                lastBottomAnchor = textView.bottomAnchor
                
                let generateButton = createGenerateButton()
                if index == 2 {
                    generateButton.addTarget(self, action: #selector(generateDescription), for: .touchUpInside)
                } else if index == 3 {
                    generateButton.addTarget(self, action: #selector(generateResponsibility), for: .touchUpInside)
                }
                
                projectEditView.addSubview(generateButton)
                NSLayoutConstraint.activate([
                    generateButton.topAnchor.constraint(equalTo: label.topAnchor, constant: -3),
                    generateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    generateButton.heightAnchor.constraint(equalToConstant: 36),
                    generateButton.widthAnchor.constraint(equalToConstant: 180),
                ])
            }
            
            if index == 0 {
                editProjectNameTF = control as? UITextField
                editProjectNameTF.delegate = self
            } else if index == 1 {
                editProjectRoleTF = control as? UITextField
                editProjectRoleTF.delegate = self
            } else if index == 2 {
                editProjectDescTF = control as? UITextView
                editProjectDescTF.addDoneButtonOnKeyboard()
            } else if index == 3 {
                editProjectRespTF = control as? UITextView
                editProjectRespTF.addDoneButtonOnKeyboard()
            }
        }

        setupSaveAndCancelButtons()  // A separate method for setting up buttons
    }
    func setupSaveAndCancelButtons() {
        // Assume saveButton and cancelButton are already initialized
        projectSaveButton = UIButton(type: .system)
        projectSaveButton.setTitle("Save", for: .normal)
        projectSaveButton.titleLabel?.font = .systemFont(ofSize: 20)
        projectSaveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        projectSaveButton.backgroundColor = UIColor(hex: "#0079C4")
        projectSaveButton.layer.cornerRadius = 8
        projectSaveButton.addTarget(self, action: #selector(saveProjectChanges), for: .touchUpInside)
        
        
        
        projectCancelButton = UIButton(type: .system)
        projectCancelButton.setTitle("Cancel", for: .normal)
        projectCancelButton.titleLabel?.font = .systemFont(ofSize: 20)
        projectCancelButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        projectCancelButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        projectCancelButton.layer.borderWidth = 1
        projectCancelButton.layer.cornerRadius = 8
        projectCancelButton.addTarget(self, action: #selector(cancelProjectEdit), for: .touchUpInside)
        
        // Layout
        projectSaveButton.translatesAutoresizingMaskIntoConstraints = false
        projectCancelButton.translatesAutoresizingMaskIntoConstraints = false
        projectEditView.addSubview(projectSaveButton)
        projectEditView.addSubview(projectCancelButton)
        
        NSLayoutConstraint.activate([
            projectSaveButton.bottomAnchor.constraint(equalTo: editProjectRespTF.bottomAnchor, constant: 60),
            projectSaveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            projectSaveButton.widthAnchor.constraint(equalToConstant: 80),
            projectSaveButton.heightAnchor.constraint(equalToConstant: 40),
            
            projectCancelButton.bottomAnchor.constraint(equalTo: projectSaveButton.bottomAnchor),
            projectCancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            projectCancelButton.widthAnchor.constraint(equalToConstant: 80),
            projectCancelButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    func createGenerateButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(" Generate content", for: .normal)
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.tintColor = UIColor(hex: "#0079C4")
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    private func setupLoaderForProjectEdit() {
        projectDescLoader = UIActivityIndicatorView(style: .large)
        projectDescLoader.center = view.center
        projectDescLoader.translatesAutoresizingMaskIntoConstraints = false
        projectEditView.addSubview(projectDescLoader)
        
        NSLayoutConstraint.activate([
            projectDescLoader.centerXAnchor.constraint(equalTo: editProjectDescTF.centerXAnchor),
            projectDescLoader.centerYAnchor.constraint(equalTo: editProjectDescTF.centerYAnchor)
        ])
        
        projectRespLoader = UIActivityIndicatorView(style: .large)
        projectRespLoader.center = view.center
        projectRespLoader.translatesAutoresizingMaskIntoConstraints = false
        projectEditView.addSubview(projectRespLoader)
        
        NSLayoutConstraint.activate([
            projectRespLoader.centerXAnchor.constraint(equalTo: editProjectRespTF.centerXAnchor),
            projectRespLoader.centerYAnchor.constraint(equalTo: editProjectRespTF.centerYAnchor)
        ])
    }


    @objc func generateDescription() {
        if let text = editProjectDescTF.text {
            fetchContentAndUpdateTextView(forURL: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/candidate/project-description",
                                          withText: editProjectNameTF.text ?? "", updateTextView: editProjectDescTF)
        }
    }

    @objc func generateResponsibility() {
        if let text = editProjectRespTF.text {
            fetchContentAndUpdateTextView(forURL: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/candidate/project-responsibility",
                                          withText: editProjectNameTF.text ?? "", updateTextView: editProjectRespTF)
        }
    }
    
    func fetchContentAndUpdateTextView(forURL urlString: String, withText text: String, updateTextView textView: UITextView) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        if textView == editProjectDescTF {
            DispatchQueue.main.async {
                self.projectDescLoader.startAnimating()  // Start the loader before the request
            }
        }
        if textView == editProjectRespTF {
            DispatchQueue.main.async {
                self.projectRespLoader.startAnimating()  // Start the loader before the request
            }
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["inputText": text]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        // Include accessToken for Authorization if needed
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if textView == self.editProjectDescTF {
                DispatchQueue.main.async {
                    self.projectDescLoader.stopAnimating()  // Start the loader before the request
                }
            }
            if textView == self.editProjectRespTF {
                DispatchQueue.main.async {
                    self.projectRespLoader.stopAnimating()  // Start the loader before the request
                }
            }
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let responseString = String(data: data, encoding: .utf8) {
                if textView == self.editProjectDescTF {
                    DispatchQueue.main.async {
                        var s = responseString
                        if s.hasPrefix("\"") {
                            s = String(s.dropFirst().dropLast())
                        }
                        textView.text = s  // Update the UITextView on the main thread
                    }
                }
                if textView == self.editProjectRespTF {
                    DispatchQueue.main.async {
                        let lines = responseString.split(separator: "\n", omittingEmptySubsequences: false)
                        
                        // Mapping each line to remove the leading "- " if it exists
                        let processedLines = lines.map { line -> String in
                            var modifiedLine = String(line)
                            // Check if the line starts with "- " and remove it
                            if modifiedLine.hasPrefix("- ") {
                                modifiedLine = String(modifiedLine.dropFirst(2))
                            }
                            return modifiedLine
                        }
                        
                        let cleanedSummary = processedLines.joined(separator: " ")
                        
                        var s = cleanedSummary
                        s = String(s.dropFirst().dropLast())
                        textView.text = s
                        
                        // Output to check
                        let components = responseString.split(separator: ".").map { line -> String in
                            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                            return trimmedLine.hasPrefix("- ") ? String(trimmedLine.dropFirst(2)) : trimmedLine
                        }
                        var cleanedArray: [String] = []
                        
                        for string in components {
                            // Find the index of the first space
                            if let index = string.firstIndex(of: " ") {
                                // Create a substring from the first space to the end of the string
                                let cleanedString = String(string[index...].dropFirst())
                                cleanedArray.append(cleanedString)
                            } else {
                                // If there is no space, append the original string
                                cleanedArray.append(string)
                            }
                        }
                        
                        let modifiedStrings = cleanedArray.map { $0 + "." }
                        
                        // Join all the modified strings into a single string, separating them by a space
                        var finalString = modifiedStrings.joined(separator: " ")
                        finalString = String(finalString.dropLast().dropLast())
                        
                        textView.text = finalString  // Update the UITextView on the main thread
                    }
                }
            }
        }.resume()
    }

    
    @objc func saveProjectChanges() {
        // Attempt to get the selected index path, if any
        let selectedIndexPath = projectCV.indexPathsForSelectedItems?.first
        
        // Ensure all fields are non-empty
        guard let name = editProjectNameTF.text, !name.isEmpty,
              let role = editProjectRoleTF.text, !role.isEmpty,
              let desc = editProjectDescTF.text, !desc.isEmpty,
              let resp = editProjectRespTF.text, !resp.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields")
            return
        }
        
        // Create the project object
        let newProject = Project(projectName: name, role: role, responsibility: resp, description: desc)
        
        if let indexPath = selectedIndexPath {
            // Update the existing item in the data array
            projectDataArray[indexPath.row] = newProject
            projectCV.reloadItems(at: [indexPath])
        } else {
            // Add new item to the data array
            projectDataArray.append(newProject)
            projectCV.insertItems(at: [IndexPath(row: projectDataArray.count - 1, section: 0)])
            reloadProjectCollectionView()
        }
        
        uploadProjectDataArray()
        cancelProjectEdit()
    }
    
    func uploadProjectDataArray() {
        // upload to server
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let projectsData = ["projects": projectDataArray]
            let jsonData = try JSONEncoder().encode(projectsData)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode projects to JSON: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Failed to upload projects, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Projects successfully uploaded.")
            } else {
                print("Failed to upload projects, status code: \(httpResponse.statusCode)")
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Server response: \(responseString)")
            }
            if let error = error {
                print("Error uploading projects: \(error.localizedDescription)")
            }
            
        }.resume()
    }

    @objc func cancelProjectEdit() {
        editProjectNameTF.text = ""
        editProjectRoleTF.text = ""
        editProjectDescTF.text = ""
        editProjectRespTF.text = ""
        UIView.animate(withDuration: 0.3) {
            self.projectEditView.transform = .identity
        }
    }
    
    
    func setupSeparatorLine4() {
        separatorLine4.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine4.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine4)
        
        NSLayoutConstraint.activate([
            separatorLine4.topAnchor.constraint(equalTo: projectCV.bottomAnchor, constant: 20),
            separatorLine4.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine4.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine4.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    
    func createStaticLabel() -> UILabel {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#344054")
        return label
    }
    
    func createDynamicLabel() -> UILabel {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#667085")
        return label
    }
    
    var portfolioLabel : UILabel!
    var currCtcLabel : UILabel!
    var expectedCtcLabel : UILabel!
    var noticePeriodLabel : UILabel!
    var genderLabel : UILabel!
    var willingToRelocate : UILabel!
    var currentlyEmployed : UILabel!
    var worktypeLabel : UILabel!
    var permanentAddress : UILabel!
    var permanentPin : UILabel!
    var currentAddress : UILabel!
    var currentPin : UILabel!
    
    var preferencesSaveButton: UIButton!
    var preferencesCancelButton: UIButton!
    
    // separator line 5 inside this function
    func setupPreferencesVC() {
        let projectLabel : UILabel = {
            let label = UILabel()
            label.text = "Preferences"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        projectLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(projectLabel)
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Edit", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            return btn
        }()
        addButton.addTarget(self, action: #selector(didTapEditPreferencesButton), for: .touchUpInside)
        
        scrollView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            projectLabel.topAnchor.constraint(equalTo: separatorLine4.bottomAnchor, constant: 16),
            projectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addButton.topAnchor.constraint(equalTo: separatorLine4.bottomAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        var pfLabel = createStaticLabel()
        pfLabel.text = "Portfolio Link"
        scrollView.addSubview(pfLabel)
        
        portfolioLabel = createDynamicLabel()
        portfolioLabel.numberOfLines = 0
        scrollView.addSubview(portfolioLabel)
        
        var ccLabel = createStaticLabel()
        ccLabel.text = "Current CTC"
        scrollView.addSubview(ccLabel)
        
        currCtcLabel = createDynamicLabel()
        scrollView.addSubview(currCtcLabel)
        
        var ecLabel = createStaticLabel()
        ecLabel.text = "Expected CTC"
        scrollView.addSubview(ecLabel)
        
        expectedCtcLabel = createDynamicLabel()
        scrollView.addSubview(expectedCtcLabel)
        
        var npLabel = createStaticLabel()
        npLabel.text = "Notice Period"
        scrollView.addSubview(npLabel)
        
        noticePeriodLabel = createDynamicLabel()
        scrollView.addSubview(noticePeriodLabel)
        
        var gLabel = createStaticLabel()
        gLabel.text = "Gender"
        scrollView.addSubview(gLabel)
        
        genderLabel = createDynamicLabel()
        scrollView.addSubview(genderLabel)
        
        var wtrLabel = createStaticLabel()
        wtrLabel.text = "Willing to Relocate"
        scrollView.addSubview(wtrLabel)
        
        willingToRelocate = createDynamicLabel()
        scrollView.addSubview(willingToRelocate)
        
        var ceLabel = createStaticLabel()
        ceLabel.text = "Currently Employed"
        scrollView.addSubview(ceLabel)
        
        currentlyEmployed = createDynamicLabel()
        scrollView.addSubview(currentlyEmployed)
        
        var pwtLabel = createStaticLabel()
        pwtLabel.text = "Preferred Work Type"
        scrollView.addSubview(pwtLabel)
        
        worktypeLabel = createDynamicLabel()
        scrollView.addSubview(worktypeLabel)
        
        var paLabel = createStaticLabel()
        paLabel.text = "Permanent Address"
        scrollView.addSubview(paLabel)
        
        permanentAddress = createDynamicLabel()
        scrollView.addSubview(permanentAddress)
        
        var ppLabel = createStaticLabel()
        ppLabel.text = "Permanent Pin"
        scrollView.addSubview(ppLabel)
        
        permanentPin = createDynamicLabel()
        scrollView.addSubview(permanentPin)
        
        var caLabel = createStaticLabel()
        caLabel.text = "Current Address"
        scrollView.addSubview(caLabel)
        
        currentAddress = createDynamicLabel()
        scrollView.addSubview(currentAddress)
        
        var cpLabel = createStaticLabel()
        cpLabel.text = "Current Pin"
        scrollView.addSubview(cpLabel)
        
        currentPin = createDynamicLabel()
        scrollView.addSubview(currentPin)
        
        NSLayoutConstraint.activate([
            pfLabel.topAnchor.constraint(equalTo: projectLabel.bottomAnchor, constant: 20),
            pfLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            portfolioLabel.topAnchor.constraint(equalTo: pfLabel.bottomAnchor, constant: 10),
            portfolioLabel.leadingAnchor.constraint(equalTo: pfLabel.leadingAnchor, constant: 4),
            portfolioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            ccLabel.topAnchor.constraint(equalTo: portfolioLabel.bottomAnchor, constant: 20),
            ccLabel.leadingAnchor.constraint(equalTo: pfLabel.leadingAnchor),
            
            currCtcLabel.topAnchor.constraint(equalTo: ccLabel.bottomAnchor, constant: 10),
            currCtcLabel.leadingAnchor.constraint(equalTo: ccLabel.leadingAnchor, constant: 4),
            
            ecLabel.topAnchor.constraint(equalTo: currCtcLabel.bottomAnchor, constant: 20),
            ecLabel.leadingAnchor.constraint(equalTo: ccLabel.leadingAnchor),
            
            expectedCtcLabel.topAnchor.constraint(equalTo: ecLabel.bottomAnchor, constant: 10),
            expectedCtcLabel.leadingAnchor.constraint(equalTo: ecLabel.leadingAnchor, constant: 4),
            
            npLabel.topAnchor.constraint(equalTo: expectedCtcLabel.bottomAnchor, constant: 20),
            npLabel.leadingAnchor.constraint(equalTo: ecLabel.leadingAnchor),
            
            noticePeriodLabel.topAnchor.constraint(equalTo: npLabel.bottomAnchor, constant: 10),
            noticePeriodLabel.leadingAnchor.constraint(equalTo: npLabel.leadingAnchor, constant: 4),
            
            gLabel.topAnchor.constraint(equalTo: noticePeriodLabel.bottomAnchor, constant: 20),
            gLabel.leadingAnchor.constraint(equalTo:npLabel.leadingAnchor),
            
            genderLabel.topAnchor.constraint(equalTo: gLabel.bottomAnchor, constant: 10),
            genderLabel.leadingAnchor.constraint(equalTo: gLabel.leadingAnchor, constant: 4),
            
            wtrLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20),
            wtrLabel.leadingAnchor.constraint(equalTo:gLabel.leadingAnchor),
            
            willingToRelocate.topAnchor.constraint(equalTo: wtrLabel.bottomAnchor, constant: 10),
            willingToRelocate.leadingAnchor.constraint(equalTo: wtrLabel.leadingAnchor, constant: 4),
            
            ceLabel.topAnchor.constraint(equalTo: willingToRelocate.bottomAnchor, constant: 20),
            ceLabel.leadingAnchor.constraint(equalTo: wtrLabel.leadingAnchor),
            
            currentlyEmployed.topAnchor.constraint(equalTo: ceLabel.bottomAnchor, constant: 10),
            currentlyEmployed.leadingAnchor.constraint(equalTo: ceLabel.leadingAnchor, constant: 4),
            
            pwtLabel.topAnchor.constraint(equalTo: currentlyEmployed.bottomAnchor, constant: 20),
            pwtLabel.leadingAnchor.constraint(equalTo: ceLabel.leadingAnchor),
            
            worktypeLabel.topAnchor.constraint(equalTo: pwtLabel.bottomAnchor, constant: 10),
            worktypeLabel.leadingAnchor.constraint(equalTo: pwtLabel.leadingAnchor, constant: 4),
            
            paLabel.topAnchor.constraint(equalTo: pwtLabel.bottomAnchor, constant: 40),
            paLabel.leadingAnchor.constraint(equalTo: pwtLabel.leadingAnchor),
            
            permanentAddress.topAnchor.constraint(equalTo: paLabel.bottomAnchor, constant: 10),
            permanentAddress.leadingAnchor.constraint(equalTo: paLabel.leadingAnchor, constant: 4),
            
            ppLabel.topAnchor.constraint(equalTo: permanentAddress.bottomAnchor, constant: 20),
            ppLabel.leadingAnchor.constraint(equalTo: paLabel.leadingAnchor),
            
            permanentPin.topAnchor.constraint(equalTo: ppLabel.bottomAnchor, constant: 10),
            permanentPin.leadingAnchor.constraint(equalTo: ppLabel.leadingAnchor, constant: 4),
            
            caLabel.topAnchor.constraint(equalTo: permanentPin.bottomAnchor, constant: 20),
            caLabel.leadingAnchor.constraint(equalTo: ppLabel.leadingAnchor),
            
            currentAddress.topAnchor.constraint(equalTo: caLabel.bottomAnchor, constant: 10),
            currentAddress.leadingAnchor.constraint(equalTo: caLabel.leadingAnchor, constant: 4),
            
            cpLabel.topAnchor.constraint(equalTo: currentAddress.bottomAnchor, constant: 20),
            cpLabel.leadingAnchor.constraint(equalTo: caLabel.leadingAnchor),
            
            currentPin.topAnchor.constraint(equalTo: cpLabel.bottomAnchor, constant: 10),
            currentPin.leadingAnchor.constraint(equalTo: cpLabel.leadingAnchor, constant: 4),
        ])
        
        
        separatorLine5.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine5.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine5)
        NSLayoutConstraint.activate([
            separatorLine5.topAnchor.constraint(equalTo: currentPin.bottomAnchor, constant: 40),
            separatorLine5.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine5.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine5.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    var editPreferencesView : UIView!
    func setupEditPreferencesVC() {
        
        editPreferencesView = preferencesVC.view!
        view.backgroundColor = .systemBackground
        
        preferencesVC.headerHeightConstraint?.constant = 0
        preferencesVC.headerHeightConstraint?.isActive = true
        preferencesVC.headerView.isHidden = true
        
        preferencesVC.bottomHeightConstraint?.constant = 0
        preferencesVC.bottomHeightConstraint?.isActive = true
        preferencesVC.bottomView.isHidden = true
        
        let contentHeight = view.bounds.height + 400
        preferencesVC.scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
        editPreferencesView.layoutIfNeeded()
        
        view.addSubview(editPreferencesView)
        addChild(preferencesVC)
        preferencesVC.didMove(toParent: self)
        
        overrideUserInterfaceStyle = .light
        
        editPreferencesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editPreferencesView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
            editPreferencesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editPreferencesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editPreferencesView.heightAnchor.constraint(equalToConstant: view.frame.height - 100)
        ])
        
        
        preferencesSaveButton = UIButton(type: .system)
        preferencesSaveButton.setTitle("Save", for: .normal)
        preferencesSaveButton.titleLabel?.font = .systemFont(ofSize: 20)
        preferencesSaveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        preferencesSaveButton.backgroundColor = UIColor(hex: "#0079C4")
        preferencesSaveButton.layer.cornerRadius = 8
        preferencesSaveButton.addTarget(self, action: #selector(savePreferencesChanges), for: .touchUpInside)
        
        
        
        preferencesCancelButton = UIButton(type: .system)
        preferencesCancelButton.setTitle("Cancel", for: .normal)
        preferencesCancelButton.titleLabel?.font = .systemFont(ofSize: 20)
        preferencesCancelButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        preferencesCancelButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        preferencesCancelButton.layer.borderWidth = 1
        preferencesCancelButton.layer.cornerRadius = 8
        preferencesCancelButton.addTarget(self, action: #selector(cancelPreferencesChanges), for: .touchUpInside)
        
        
        preferencesSaveButton.translatesAutoresizingMaskIntoConstraints = false
        preferencesCancelButton.translatesAutoresizingMaskIntoConstraints = false
        editPreferencesView.addSubview(preferencesSaveButton)
        editPreferencesView.addSubview(preferencesCancelButton)
        
        NSLayoutConstraint.activate([
            preferencesSaveButton.bottomAnchor.constraint(equalTo: editPreferencesView.bottomAnchor, constant: -60),
            preferencesSaveButton.trailingAnchor.constraint(equalTo: editPreferencesView.trailingAnchor, constant: -20),
            preferencesSaveButton.widthAnchor.constraint(equalToConstant: 80),
            preferencesSaveButton.heightAnchor.constraint(equalToConstant: 40),
            
            preferencesCancelButton.bottomAnchor.constraint(equalTo: preferencesSaveButton.bottomAnchor),
            preferencesCancelButton.leadingAnchor.constraint(equalTo: editPreferencesView.leadingAnchor, constant: 20),
            preferencesCancelButton.widthAnchor.constraint(equalToConstant: 80),
            preferencesCancelButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
    
    
    @objc func didTapEditPreferencesButton() {
        UIView.animate(withDuration: 0.36) {
            self.editPreferencesView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)
        }
    }
    
    @objc func savePreferencesChanges() {
        
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        guard let portfolio = preferencesVC.portfolioTextField.text, !portfolio.isEmpty,
              let currentCtcText = preferencesVC.currentCtcTextField.text, !currentCtcText.isEmpty, let currentCtc = Double(currentCtcText),
              let expectedCtcText = preferencesVC.expectedCtcTextField.text, !expectedCtcText.isEmpty, let expectedCtc = Double(expectedCtcText),
              let permanentAddress = preferencesVC.permanentTextField.text, !permanentAddress.isEmpty,
              let permanentPin = preferencesVC.permanentPinTextField.text, !permanentPin.isEmpty,
              let currentAddress = preferencesVC.currentTextField.text, !currentAddress.isEmpty,
              let currentPin = preferencesVC.currentPinTextField.text, !currentPin.isEmpty,
              let noticePeriod = preferencesVC.selectedNoticeOptionsButton?.titleLabel?.text,
              let gender = preferencesVC.selectedGenderButton?.titleLabel?.text,
              let willingToRelocate = preferencesVC.selectedRelocateButton?.titleLabel?.text,
              let currentlyEmployed = preferencesVC.selectedEmployedButton?.titleLabel?.text,
              let preferredWorkType = preferencesVC.selectedWorkTypeButton?.titleLabel?.text
        else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the details")
            return
        }
        
        let userProfileUpdate = UserProfileUpdate(
            hobbies: "",
            preferredWorkType: preferredWorkType,
            willingToRelocate: willingToRelocate,
            gender: gender,
            noticePeriod: noticePeriod,
            currentlyEmployed: currentlyEmployed,
            permanentAddress: permanentAddress,
            currentAddress: Address(address: currentAddress, pincode: currentPin, state: "", city: ""),
            currentCtc: currentCtc,
            expectedCtc: expectedCtc,
            language: preferencesVC.languageArray,
            portfolio: portfolio
        )
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        
        do {
            let jsonData = try JSONEncoder().encode(userProfileUpdate)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode user profile to JSON: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to upload user profile, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                print(response)
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Server response: \(responseString)")
            }
            if let error = error {
                print("Error uploading user profile: \(error.localizedDescription)")
            } else {
                print("User profile successfully uploaded.")
                self.fetchUserProfile()
            }
        }.resume()
        
        
        UIView.animate(withDuration: 0.36) {
            self.editPreferencesView.transform = .identity
        }
    }
    
    @objc func cancelPreferencesChanges() {
        UIView.animate(withDuration: 0.36) {
            self.editPreferencesView.transform = .identity
        }
    }
    
    
    var headlineEditButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit", for: .normal)
        btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return btn
    }()
    
    var headlineSaveButton : UIButton!
    
    func setupHeadlineAndSummary() {
        
        let prefer = UILabel()
        prefer.text = "Headline and Summary"
        prefer.font = .boldSystemFont(ofSize: 20)
        
        prefer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(prefer)
        
        
        headlineEditButton.addTarget(self, action: #selector(didTapEditHeadline), for: .touchUpInside)
        
        scrollView.addSubview(headlineEditButton)
        headlineEditButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            prefer.topAnchor.constraint(equalTo: separatorLine5.bottomAnchor, constant: 20),
            prefer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headlineEditButton.topAnchor.constraint(equalTo: separatorLine5.bottomAnchor, constant: 16),
            headlineEditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        scrollView.bringSubviewToFront(prefer)
        
        
        
        let tempView = headlineVC.view!
        view.backgroundColor = .systemBackground
        
        headlineVC.headerHeightConstraint?.constant = 0
        headlineVC.headerHeightConstraint?.isActive = true
        headlineVC.headerView.isHidden = true
        
        headlineVC.bottomHeightConstraint?.constant = 0
        headlineVC.bottomHeightConstraint?.isActive = true
        headlineVC.bottomView.isHidden = true
        
        headlineVC.generateResume.isHidden = true
        headlineVC.generateSummary.isHidden = true
        headlineVC.resumeTextView.isEditable = false
        headlineVC.summaryTextView.isEditable = false
        headlineVC.resumeTextView.inputAccessoryView = nil
        headlineVC.summaryTextView.inputAccessoryView = nil
        
        tempView.layoutIfNeeded()
        
        let contentHeight = view.bounds.height - 300
        headlineVC.scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
        tempView.layoutIfNeeded()
        
        tempView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(tempView)
        addChild(headlineVC)
        headlineVC.didMove(toParent: self)
        
        overrideUserInterfaceStyle = .light
        
        
        headlineSaveButton = UIButton(type: .system)
        headlineSaveButton.setTitle("Save", for: .normal)
        headlineSaveButton.titleLabel?.font = .systemFont(ofSize: 20)
        headlineSaveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        headlineSaveButton.backgroundColor = UIColor(hex: "#0079C4")
        headlineSaveButton.layer.cornerRadius = 8
        headlineSaveButton.addTarget(self, action: #selector(saveHeadlineChanges), for: .touchUpInside)
        headlineSaveButton.isHidden = true
        
        headlineSaveButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headlineSaveButton)
        
        
        
        NSLayoutConstraint.activate([
            tempView.topAnchor.constraint(equalTo: prefer.bottomAnchor, constant: 10),
            tempView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tempView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tempView.heightAnchor.constraint(equalToConstant: 700),
            
            headlineSaveButton.bottomAnchor.constraint(equalTo: tempView.bottomAnchor, constant: -100),
            headlineSaveButton.trailingAnchor.constraint(equalTo: tempView.trailingAnchor, constant: -20),
            headlineSaveButton.widthAnchor.constraint(equalToConstant: 80),
            headlineSaveButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func didTapEditHeadline() {
        if headlineEditButton.titleLabel?.text == "Edit" {
            headlineEditButton.setTitle("Cancel", for: .normal)
            headlineSaveButton.isHidden = false
            headlineVC.generateResume.isHidden = false
            headlineVC.generateSummary.isHidden = false
            
            headlineVC.resumeTextView.isEditable = true
            headlineVC.summaryTextView.isEditable = true
            
            headlineVC.resumeTextView.addDoneButtonOnKeyboard()
            headlineVC.summaryTextView.addDoneButtonOnKeyboard()
        }
        else {
            headlineEditButton.setTitle("Edit", for: .normal)
            headlineSaveButton.isHidden = true
            headlineVC.generateResume.isHidden = true
            headlineVC.generateSummary.isHidden = true
            
            headlineVC.resumeTextView.isEditable = false
            headlineVC.summaryTextView.isEditable = false
            
            headlineVC.resumeTextView.inputAccessoryView = nil
            headlineVC.summaryTextView.inputAccessoryView = nil
            
            fetchUserProfile()
        }
    }
    
    @objc func saveHeadlineChanges() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        

        guard let headline = headlineVC.resumeTextView.text, !headline.isEmpty,
              let summary = headlineVC.summaryTextView.text, !summary.isEmpty
        else {
            
            let alert = UIAlertController(title: "Missing Information", message: "Fill all the details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let resumeData = ResumeData(headline: headline, summary: summary)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        do {
            let jsonData = try JSONEncoder().encode(resumeData)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode resume data: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response from server: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Data successfully uploaded")
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Server response: \(responseString)")
                }
            } else {
                print("Failed to upload data, status code: \(httpResponse.statusCode)")
            }
            
            if let error = error {
                print("Error uploading data: \(error.localizedDescription)")
                self.fetchUserProfile()
            }
        }.resume()
        
        headlineEditButton.setTitle("Edit", for: .normal)
        headlineSaveButton.isHidden = true
        headlineVC.generateResume.isHidden = true
        headlineVC.generateSummary.isHidden = true
        
        headlineVC.resumeTextView.isEditable = false
        headlineVC.summaryTextView.isEditable = false
        
        headlineVC.resumeTextView.inputAccessoryView = nil
        headlineVC.summaryTextView.inputAccessoryView = nil
    }
    
    
    
    // ******************* Common Methods ***********************************
    func updateScrollViewContentSize() {
        let combinedContentHeight = employmentCVHeightConstraint.constant + educationCVHeightConstraint.constant + projectCVHeightConstraint.constant
        // Add other collection view heights if there are more
        let extraSpaceHeight: CGFloat = 1000 // Change this if you need more space at the bottom
        
        let totalContentHeight = combinedContentHeight + extraSpaceHeight
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: totalContentHeight)
    }
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    func askUserConfirmation(title: String, message: String, confirmedAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // 'Yes' action
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            confirmedAction()  // Perform the action passed in the closure
        }
        
        // 'No' action
        let noAction = UIAlertAction(title: "No", style: .cancel)

        alertController.addAction(yesAction)
        alertController.addAction(noAction)

        present(alertController, animated: true)
    }
    
    
    // ***********************************************************************************************************************
    
    func setupLogOut() {
        let logOutButton = UIButton()
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.titleLabel?.font = .systemFont(ofSize: 20)
        logOutButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        logOutButton.backgroundColor = UIColor(hex: "#0079C4")
        logOutButton.layer.cornerRadius = 8
        
        logOutButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logOutButton)
        
        NSLayoutConstraint.activate([
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logOutButton.heightAnchor.constraint(equalToConstant: 60),
            logOutButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
        ])
    }
    @objc func didTapLogOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            // Perform the logout operation
            UserDefaults.standard.removeObject(forKey: "accessToken")
            UserDefaults.standard.synchronize() // To ensure the accessToken is removed
            
            let vc = BasicDetails1()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.isHidden = true
            self.present(navVC, animated: true)
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel)

        alertController.addAction(yesAction)
        alertController.addAction(noAction)

        present(alertController, animated: true)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            tabBarController?.tabBar.isHidden = true
        }
        else {
            tabBarController?.tabBar.isHidden = false
        }
    }
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}




extension ProfileController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case employmentCV:
                return empDataArray.count
            case educationCV:
                return eduDataArray.count
            case projectCV:
                return projectDataArray.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == employmentCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exp", for: indexPath) as! EmploymentCell
            let exp = empDataArray[indexPath.row]
            
            cell.titleLabel.text = exp.employmentDesignation
            cell.companyNameLabel.text = "l  \(exp.companyName)"
            cell.noOfYearsLabel.text = "\(exp.yearsOfExperience),"
            cell.jobTypeLabel.text = exp.employmentPeriod
            
            cell.deleteButton.addTarget(self, action: #selector(deleteEmpCell(_:)), for: .touchUpInside)
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            cell.layer.cornerRadius = 12
            
            return cell
        }
        if collectionView == educationCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "edu", for: indexPath) as! EducationCell
            
            let edu = eduDataArray[indexPath.row]
            print(edu)
            
            cell.educationLabel.text = edu.educationName
            cell.collegeLabel.text = "l  \(edu.boardOrUniversity ?? "nil")"
            cell.passYearLabel.text = "\(edu.yearOfPassing ?? "nil"),"
            let m = edu.marksObtained ?? ""
            if m.hasSuffix("%") {
                cell.courseTypeLabel.text = m
            }
            else {
                cell.courseTypeLabel.text = "\(m)%"
            }
            
            cell.deleteButton.addTarget(self, action: #selector(deleteEduCell(_:)), for: .touchUpInside)
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            cell.layer.cornerRadius = 12
        
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "project", for: indexPath) as! ProjectCell
            let project = projectDataArray[indexPath.row]
            
            cell.projectName.text = project.projectName
            cell.projectRole.text = project.role
            cell.projectDescription.text = project.description
            cell.projectResponsibility.text = project.responsibility
            
            cell.deleteButton.addTarget(self, action: #selector(deleteProjectCell(_:)), for: .touchUpInside)
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            cell.layer.cornerRadius = 12
        
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == projectCV {
            let project = projectDataArray[indexPath.row]

            let padding: CGFloat = 6 // Adjust padding as necessary
            let labelWidth = collectionView.bounds.width - (padding * 2)

            let descriptionFont = UIFont.systemFont(ofSize: 14)
            let responsibilityFont = UIFont.systemFont(ofSize: 14)
            let fixedHeightFont = UIFont.systemFont(ofSize: 18) // Assuming the single-line labels use this

            // Calculate maximum heights for the labels with limited lines
            let maxLines: CGFloat = 3
            let descriptionHeight = min(descriptionFont.lineHeight * maxLines, project.description.heightWithConstrainedWidth(width: labelWidth, font: descriptionFont))
            let responsibilityHeight = min(responsibilityFont.lineHeight * maxLines, project.responsibility.heightWithConstrainedWidth(width: labelWidth, font: responsibilityFont))

            // Add heights for the fixed single-line labels
            let fixedHeight = fixedHeightFont.lineHeight // Since they are single line, we can use line height directly

            // Calculate total height
            let totalHeight = descriptionHeight + responsibilityHeight + (fixedHeight * 2) + (padding * 3) // Adjust number of paddings as needed

            return CGSize(width: view.frame.width - 32, height: totalHeight + 30)
        }
        else {
            return CGSize(width: view.frame.width - 32, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == employmentCV {
            let exp = empDataArray[indexPath.row]
            editExpTitleTF.text = exp.employmentDesignation
            editExpCompanyTF.text = exp.companyName
            editYearsOfExpTF.text = exp.yearsOfExperience
            editExpPeriodTF.text = exp.employmentPeriod
            
            UIView.animate(withDuration: 0.3) {
                self.empEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)  // Move up by 300 points
            }
        }
        if collectionView == educationCV {
            let edu = eduDataArray[indexPath.row]
            editEducationTF.text = edu.educationName
            editCollegeTF.text = edu.boardOrUniversity
            editPassYearTF.text = edu.yearOfPassing
            editMarksTF.text = edu.marksObtained
            
            UIView.animate(withDuration: 0.3) {
                self.eduEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)  // Move up by 300 points
            }
        }
        if collectionView == projectCV {  // projectCV
            let project = projectDataArray[indexPath.row]
            editProjectNameTF.text = project.projectName
            editProjectRoleTF.text = project.role
            editProjectDescTF.text = project.description
            editProjectRespTF.text = project.responsibility
            
            UIView.animate(withDuration: 0.3) {
                self.projectEditView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 0)  // Move up by 300 points
            }
        }
    }
    
}


extension ProfileController { // Extension for APIs
    
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
                print("User fetched: \(user)")
                
                let initialsOfName = self.extractInitials(from: user.name)
                let userName = user.name ?? ""
                
                DispatchQueue.main.async {
                    self.profileCircleLabel.text = initialsOfName
                    self.userNameLabel.text = "\(userName)"
                    self.jobTitleLabel.text = user.designation
                    self.locationLabel.text = user.currentAddress?.address ?? "cityNil"
                    
                    self.fetchProfilePicture(size: "m", userID: user._id)
                    
                    self.empDataArray = user.experience!
                    self.reloadEmploymentsCollectionView()
                    
                    self.eduDataArray = user.education!
                    self.reloadEducationCollectionView()
                    
                    self.projectDataArray = user.projects!
                    self.reloadProjectCollectionView()
                    
                    self.totalExperience = user.totalExperience
                    
                    self.preferencesVC.portfolioTextField.text = user.portfolio
                    self.preferencesVC.currentCtcTextField.text = user.currentCtc
                    self.preferencesVC.expectedCtcTextField.text = user.expectedCtc
                    let noticePeriod = user.noticePeriod
                    self.preferencesVC.permanentTextField.text = user.permanentAddress
                    self.preferencesVC.permanentPinTextField.text = user.permanentAddress
                    self.preferencesVC.currentTextField.text = user.currentAddress?.address
                    self.preferencesVC.currentPinTextField.text = user.currentAddress?.pincode
                    self.preferencesVC.languageArray = user.language!
                    self.preferencesVC.reloadCollectionView()
                    
                    self.headlineVC.resumeTextView.text = user.headline
                    self.headlineVC.summaryTextView.text = user.summary
                    
                    
                    self.portfolioLabel.text = user.portfolio
                    self.currCtcLabel.text = user.currentCtc
                    self.expectedCtcLabel.text = user.expectedCtc
            
                    self.noticePeriodLabel.text = user.noticePeriod?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.genderLabel.text = user.gender?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.willingToRelocate.text = user.willingToRelocate?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.currentlyEmployed.text = user.currentlyEmployed?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.worktypeLabel.text = user.preferredWorkType?.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    self.permanentAddress.text = user.permanentAddress
                    self.permanentPin.text = user.permanentAddress
                    self.currentAddress.text = user.currentAddress?.address
                    self.currentPin.text = user.currentAddress?.pincode
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }

        task.resume()
    }
    
    func fetchProfilePicture(size: String, userID: String) {
        let urlString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/profile/\(size)/\(userID)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    // Use the image in your app, e.g., assign it to an UIImageView
                    self.profileImageView.image = image
                    print("Image Fetched Successfully")
                } else {
                    print("Failed to decode image")
                }
            }
        }

        task.resume()
    }
    
    private func extractInitials(from name: String?) -> String {
        guard let name = name, !name.isEmpty else { return "" }
        let parts = name.split(separator: " ").map(String.init)
        let initials = parts.compactMap { $0.first }.prefix(2)
        return initials.map(String.init).joined().uppercased()
    }
}
