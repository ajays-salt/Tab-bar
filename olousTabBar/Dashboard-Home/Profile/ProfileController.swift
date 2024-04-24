//
//  ProfileController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class ProfileController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    var employments = [EmploymentTemp]()
    var educations = [EducationTemp]()
    
    
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
    
    let preferenceEditButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = UIColor(hex: "#667085")
        button.backgroundColor = .systemBackground
        
        let image = UIImage(systemName: "pencil")?.withRenderingMode(.alwaysTemplate)
        let resizedImage = image?.resized(to: CGSize(width: 20, height: 20))
        button.setImage(resizedImage, for: .normal)
        
        return button
    }()
    
    let jobTypeLabel : UILabel = {
        let label = UILabel()
        label.text = "Job"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    let noticePeriodLabel : UILabel = {
        let label = UILabel()
        label.text = "30 Days"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    let preferredLocationLabel : UILabel = {
        let label = UILabel()
        label.text = "Pune,Bangalore,Hyderabad"
        label.textColor = UIColor(hex: "#101828")
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let separatorLine1 = UIView()
    
    let companyNameTextField = UITextField()
    var employmentsBottomAnchor: NSLayoutYAxisAnchor!
    
    let separatorLine2 = UIView()
    
    var educationBottomAnchor: NSLayoutYAxisAnchor!
    
    
    
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        fetchAndParseExperience()
        fetchAndParseEducation()
        fetchUserProfile()
        
        educations = [
            EducationTemp(collegeName: "Dr D Y Patil University, Pune", startYear: 2020, endYear: 2023, courseType: "Full-Time")
        ]
        
        companyNameTextField.delegate = self
        
        setupViews()
    }
    
    func setupViews() {
        setupScrollView()
        setupHeaderView()
        setupProfileEditButton()
        
        setupProfileCircleView()
        setupUserNameLabel()
        setupUserJobTitleLabel()
        setupLocationLabel()
        setupPreferences()
        setupSeparatorLine1()
        
        
        setupEmploymentsView()
        setupEmpEditView()
        
        setupSeparatorLine2()
        
        setupEducationView()
        setupEducationEditView()
        
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
        
        let extraSpaceHeight: CGFloat = 200
        
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
//        profileCircleLabel.isHidden = true
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: profileCircle.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: profileCircle.centerYAnchor)
        ])
        
        
        
        profileImageView = UIImageView(image: UIImage(systemName: "pencil"))
        profileImageView.isHidden = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileCircle.frame.width / 2
        
        // Add the selected image view to the profile circle
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: profileCircle.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: profileCircle.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: profileCircle.trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: profileCircle.bottomAnchor)
        ])
    }
    func setupUserNameLabel() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: profileCircle.topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
            userNameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    func setupUserJobTitleLabel() {
        jobTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(jobTitleLabel)
        
        NSLayoutConstraint.activate([
            jobTitleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 12),
            jobTitleLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
        ])
    }
    func setupLocationLabel() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 6),
            locationLabel.leadingAnchor.constraint(equalTo: profileCircle.trailingAnchor, constant: 16),
        ])
    }
    
    func setupPreferences() {
        let preferenceLabel : UILabel = {
            let label = UILabel()
            label.text = "Your Carrer Preferences"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        preferenceLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(preferenceLabel)
        
        NSLayoutConstraint.activate([
            preferenceLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            preferenceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
        
        preferenceEditButton.addTarget(self, action: #selector(didTapEditPreference), for: .touchUpInside)
        preferenceEditButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(preferenceEditButton)
        NSLayoutConstraint.activate([
            preferenceEditButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            preferenceEditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            preferenceEditButton.widthAnchor.constraint(equalToConstant: 20),
            preferenceEditButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        let preferredJobType : UILabel = {
            let label = UILabel()
            label.text = "Your carrer preferences"
            label.textColor = UIColor(hex: "#667085")
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        preferredJobType.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(preferredJobType)
        NSLayoutConstraint.activate([
            preferredJobType.topAnchor.constraint(equalTo: preferenceLabel.bottomAnchor, constant: 16),
            preferredJobType.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        jobTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(jobTypeLabel)
        NSLayoutConstraint.activate([
            jobTypeLabel.topAnchor.constraint(equalTo: preferredJobType.bottomAnchor, constant: 6),
            jobTypeLabel.leadingAnchor.constraint(equalTo: preferredJobType.leadingAnchor)
        ])
        
        
        
        let noticePeriod : UILabel = {
            let label = UILabel()
            label.text = "Notice Period"
            label.textColor = UIColor(hex: "#667085")
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        noticePeriod.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(noticePeriod)
        NSLayoutConstraint.activate([
            noticePeriod.topAnchor.constraint(equalTo: preferenceLabel.bottomAnchor, constant: 16),
            noticePeriod.leadingAnchor.constraint(equalTo: preferredJobType.trailingAnchor, constant: 32)
        ])
        
        noticePeriodLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(noticePeriodLabel)
        NSLayoutConstraint.activate([
            noticePeriodLabel.topAnchor.constraint(equalTo: noticePeriod.bottomAnchor, constant: 6),
            noticePeriodLabel.leadingAnchor.constraint(equalTo: noticePeriod.leadingAnchor)
        ])
        
        
        let preferredLocation : UILabel = {
            let label = UILabel()
            label.text = "Preferred Location"
            label.textColor = UIColor(hex: "#667085")
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        preferredLocation.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(preferredLocation)
        NSLayoutConstraint.activate([
            preferredLocation.topAnchor.constraint(equalTo: jobTypeLabel.bottomAnchor, constant: 16),
            preferredLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        preferredLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(preferredLocationLabel)
        NSLayoutConstraint.activate([
            preferredLocationLabel.topAnchor.constraint(equalTo: preferredLocation.bottomAnchor, constant: 6),
            preferredLocationLabel.leadingAnchor.constraint(equalTo: preferredLocation.leadingAnchor),
            preferredLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func didTapEditPreference() {
        
    }
    
    func setupSeparatorLine1() {
        separatorLine1.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine1.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine1)
        
        NSLayoutConstraint.activate([
            separatorLine1.topAnchor.constraint(equalTo: preferredLocationLabel.bottomAnchor, constant: 16),
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
        
        let expandButton : UIButton = {
            let btn = UIButton()
            btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 30)
            return btn
        }()
        
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(expandButton)
        NSLayoutConstraint.activate([
            expandButton.topAnchor.constraint(equalTo: employmentLabel.topAnchor, constant: -10),
            expandButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            expandButton.widthAnchor.constraint(equalToConstant: 30),
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
            addButton.topAnchor.constraint(equalTo: employmentLabel.bottomAnchor, constant: -5),
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
        print(#function)
        guard let cell = sender.superview as? EmploymentCell, // Adjust the number of superviews according to your cell's hierarchy
            let indexPath = employmentCV.indexPath(for: cell)
        else {
            return
        }
        
        empDataArray.remove(at: indexPath.row)
        reloadEmploymentsCollectionView()
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
        guard let selectedIndexPath = employmentCV.indexPathsForSelectedItems?.first else { return }
        
        // Ensure all fields are non-empty
        guard let companyName = editExpCompanyTF.text, !companyName.isEmpty,
              let yearsOfExperience = editYearsOfExpTF.text, !yearsOfExperience.isEmpty,
              let employmentDesignation = editExpTitleTF.text, !employmentDesignation.isEmpty,
              let employmentPeriod = editExpPeriodTF.text, !employmentPeriod.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields")
            return
        }
        
        // Create the updated employment object
        let updatedExp = Employment(companyName: companyName, yearsOfExperience: yearsOfExperience,
                                    employmentDesignation: employmentDesignation, employmentPeriod: employmentPeriod,
                                    employmentType: "") // Assuming employmentType is optional or handled elsewhere
        
        // Update the data array and reload the specific item
        empDataArray[selectedIndexPath.row] = updatedExp
        employmentCV.reloadItems(at: [selectedIndexPath])
        dismissEmpEditView()
    }
    @objc func cancelEmpEdit() {
        dismissEmpEditView()
    }
    func dismissEmpEditView() {
        UIView.animate(withDuration: 0.3) {
            self.empEditView.transform = .identity
        }
    }
    
    
    @objc func didTapAddEmployment() {
//        employmentCV.isHidden = !employmentCV.isHidden
//        let vc = AddEmploymentVC()
//        navigationController?.pushViewController(vc, animated: true)
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
        guard let selectedIndexPath = educationCV.indexPathsForSelectedItems?.first else { return }
        
        // Ensure all fields are non-empty
        guard let educationName = editEducationTF.text, !educationName.isEmpty,
              let yearOfPassing = editPassYearTF.text, !yearOfPassing.isEmpty,
              let boardOrUniversity = editCollegeTF.text, !boardOrUniversity.isEmpty,
              let marks = editMarksTF.text, !marks.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields before saving.")
            return
        }
        
        // Create the updated education object, assuming marksObtained is not editable or is handled differently
        let updatedEducation = Education(educationName: educationName,
                                         yearOfPassing: yearOfPassing,
                                         boardOrUniversity: boardOrUniversity,
                                         marksObtained: marks)  // Modify according to your data model if necessary
        
        // Update the data array and reload the specific item
        eduDataArray[selectedIndexPath.row] = updatedEducation
        educationCV.reloadItems(at: [selectedIndexPath])
        dismissEduEditView()
    }
    @objc func cancelEduEdit() {
        dismissEduEditView()
    }
    func dismissEduEditView() {
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
        
        eduDataArray.remove(at: indexPath.row)
        reloadEducationCollectionView()
    }
    
    @objc func didTapAddEducation() {
        let vc = AddEducationVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    // ******************* Common Methods ***********************************
    func updateScrollViewContentSize() {
        let combinedContentHeight = employmentCVHeightConstraint.constant + educationCVHeightConstraint.constant
        // Add other collection view heights if there are more
        let extraSpaceHeight: CGFloat = 500 // Change this if you need more space at the bottom
        
        let totalContentHeight = combinedContentHeight + extraSpaceHeight
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: totalContentHeight)
    }
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    
    
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
            
            let vc = RegistrationVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
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
        else {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 80)
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
    }
    
}


extension ProfileController { // Extension for APIs
    func fetchAndParseExperience() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/candidate/experience") else {
            print("Invalid URL")
            return
        }
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not found")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
//            self.scrollView.alpha = 0
//            self.loader.startAnimating()
            print("Loader should be visible now")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "No error description")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let softwaresResponse = try decoder.decode(SoftwaresResponse.self, from: data)
                let cleanedString = softwaresResponse.softwares
                    .replacingOccurrences(of: "\\n", with: "")
                    .replacingOccurrences(of: "\\\"", with: "\"")
                    .replacingOccurrences(of: "\\", with: "") // Additional cleaning for any leftover backslashes
                
                // Regex to find the JSON array
                let regex = try NSRegularExpression(pattern: "\\[.*?\\]", options: .dotMatchesLineSeparators)
                if let match = regex.firstMatch(in: cleanedString, options: [], range: NSRange(cleanedString.startIndex..., in: cleanedString)) {
                    let range = Range(match.range, in: cleanedString)!
                    let jsonArrayString = String(cleanedString[range])
                    
                    if let jsonData = jsonArrayString.data(using: .utf8),
                       let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [Any] {
                        
//                        print(jsonObject)
                        
                        do {
                            let decoder = JSONDecoder()
                            self.empDataArray = try decoder.decode([Employment].self, from: jsonData)
                            print("Decoded data: \(self.empDataArray)")
                            DispatchQueue.main.async {
                                self.reloadEmploymentsCollectionView()
                            }
                        } catch {
                            print("Failed to decode JSON: \(error)")
                        }
                        
                    }
                } else {
                    print("No JSON array found")
                }
            } catch {
                print("Failed to decode or clean JSON: \(error)")
            }
            DispatchQueue.main.async {
//                self.loader.stopAnimating()
//                self.scrollView.alpha = 1
                print("loader stopped")
            }
        }.resume()
    }
    
    func fetchAndParseEducation() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/candidate/qualifications") else {
            print("Invalid URL")
            return
        }
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access Token not found")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
//            self.scrollView.alpha = 0
//            self.loader.startAnimating()
            print("Loader should be visible now")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "No error description")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let softwaresResponse = try decoder.decode(SoftwaresResponse.self, from: data)
                let cleanedString = softwaresResponse.softwares
                    .replacingOccurrences(of: "\\n", with: "")
                    .replacingOccurrences(of: "\\\"", with: "\"")
                    .replacingOccurrences(of: "\\", with: "") // Additional cleaning for any leftover backslashes
                
                // Regex to find the JSON array
                let regex = try NSRegularExpression(pattern: "\\[.*?\\]", options: .dotMatchesLineSeparators)
                if let match = regex.firstMatch(in: cleanedString, options: [], range: NSRange(cleanedString.startIndex..., in: cleanedString)) {
                    let range = Range(match.range, in: cleanedString)!
                    let jsonArrayString = String(cleanedString[range])
                    
                    if let jsonData = jsonArrayString.data(using: .utf8),
                       let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [Any] {
                        
//                        print(jsonObject)
                        
                        do {
                            let decoder = JSONDecoder()
                            self.eduDataArray = try decoder.decode([Education].self, from: jsonData)
                            print("Decoded data: \(self.eduDataArray)")
                            DispatchQueue.main.async {
                                self.reloadEducationCollectionView()
                            }
                        } catch {
                            print("Failed to decode JSON: \(error)")
                        }
                        
                    }
                } else {
                    print("No JSON array found")
                }
            } catch {
                print("Failed to decode or clean JSON: \(error)")
            }
            DispatchQueue.main.async {
//                self.loader.stopAnimating()
//                self.scrollView.alpha = 1
                print("loader stopped")
            }
        }.resume()
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
                print("User fetched: \(user)")
                
                let initialsOfName = self.extractInitials(from: user.name)
                let userName = user.name ?? ""
                
                DispatchQueue.main.async {
                    self.profileCircleLabel.text = initialsOfName
                    self.userNameLabel.text = "\(userName)"
                    self.jobTitleLabel.text = user.designation
                    self.locationLabel.text = user.city ?? "cityNil"
                }
            } catch {
                print("Failed to decode JSON: \(error)")
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
