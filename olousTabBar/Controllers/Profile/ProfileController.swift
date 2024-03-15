//
//  ProfileController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class ProfileController: UIViewController, UITextFieldDelegate {
    
    var employments = [Employment]()
    var educations = [Education]()
    
    
    let barsButton : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(hex: "#344054")
        imageView.image = UIImage(systemName: "line.3.horizontal")
        return imageView
    }()
    let scrollView = UIScrollView()
    
    let profileCircle = UIView()
    let profileCircleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#0079C4")
        label.font = .boldSystemFont(ofSize: 48)
        return label
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employments = [
            Employment(companyName: "ABC Company", startYear: 2018, endYear: 2022, jobType: "Full-time"),
            Employment(companyName: "XYZ Inc.", startYear: 2020, endYear: 2021, jobType: "Part-time"),
            Employment(companyName: "Salt Tech", startYear: 2020, endYear: 2021, jobType: "Full-time")
        ]
        
        educations = [
            Education(collegeName: "Dr D Y Patil University, Pune", startYear: 2020, endYear: 2023, courseType: "Full-Time")
        ]
        
        companyNameTextField.delegate = self
        
        setupViews()
    }
    
    func setupViews() {
        setupBarsButton()
        setupScrollView()
        setupProfileCircleView()
        setupUserNameLabel()
        setupUserJobTitleLabel()
        setupLocationLabel()
        setupOtherUI()
        setupSeparatorLine1()
        setupOtherUI2()
        setupSeparatorLine2()
        setupOtherUI3()
    }
    
    func setupBarsButton() {
        barsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(barsButton)
        
        NSLayoutConstraint.activate([
            barsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            barsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            barsButton.widthAnchor.constraint(equalToConstant: 35),
            barsButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupScrollView() {
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: barsButton.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
        
        let extraSpaceHeight: CGFloat = 100
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }

    func setupProfileCircleView() {
        profileCircle.backgroundColor = UIColor(hex: "#D7F0FF")
        profileCircle.layer.cornerRadius = 60
        
        profileCircle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(profileCircle)
        NSLayoutConstraint.activate([
            profileCircle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            profileCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.width / 2 ) - 60),
            profileCircle.widthAnchor.constraint(equalToConstant: 120),
            profileCircle.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        // Calculate initials
        let arr = userNameLabel.text!.components(separatedBy: " ")
        let initials = "\(arr[0].first ?? "A")\(arr[1].first ?? "B")".uppercased()
        
        
        profileCircleLabel.text = initials
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: profileCircle.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: profileCircle.centerYAnchor)
        ])
    }
    func setupUserNameLabel() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            userNameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: profileCircle.bottomAnchor, constant: 12),
            userNameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    func setupUserJobTitleLabel() {
        jobTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(jobTitleLabel)
        
        NSLayoutConstraint.activate([
            jobTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            jobTitleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 12)
        ])
    }
    func setupLocationLabel() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            locationLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 6)
        ])
    }
    
    func setupOtherUI() {
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
            preferenceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            preferenceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
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
    
    func setupOtherUI2() {
        let employmentLabel : UILabel = {
            let label = UILabel()
            label.text = "Employment"
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
            addButton.topAnchor.constraint(equalTo: separatorLine1.bottomAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        
        
        employmentsBottomAnchor = employmentLabel.bottomAnchor
        var i = 0;
        while i < employments.count {
            let employment = employments[i]
            let employmentView = createEmploymentView(employment: employment)
            employmentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(employmentView)
            if i == 0 {
                NSLayoutConstraint.activate([
                    employmentView.topAnchor.constraint(equalTo: employmentsBottomAnchor, constant: 20),
                    employmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    employmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    employmentView.heightAnchor.constraint(equalToConstant: 50)
                ])
            }
            else {
                NSLayoutConstraint.activate([
                    employmentView.topAnchor.constraint(equalTo: employmentsBottomAnchor, constant: 6),
                    employmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    employmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    employmentView.heightAnchor.constraint(equalToConstant: 50)
                ])
            }
            employmentsBottomAnchor = employmentView.bottomAnchor
            i += 1
        }
    }
    @objc func didTapAddEmployment() {
        print(#function)
        
        // Create a container view
        let tempView = UIView()
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.backgroundColor = .systemGray6
        tempView.layer.borderWidth = 1
        tempView.layer.cornerRadius = 10
        
        // Add text field for company name
        
        companyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        companyNameTextField.placeholder = "Company Name"
        companyNameTextField.borderStyle = .roundedRect
        tempView.addSubview(companyNameTextField)
        
        // Add start year picker
        let start = UILabel()
        start.text = "Start Date :"
        let startYearPicker = UIDatePicker()
        startYearPicker.translatesAutoresizingMaskIntoConstraints = false
        startYearPicker.datePickerMode = .date
        tempView.addSubview(startYearPicker)
        
        // Add end year picker
        let end = UILabel()
        end.text = "End Date :"
        let endYearPicker = UIDatePicker()
        endYearPicker.translatesAutoresizingMaskIntoConstraints = false
        endYearPicker.datePickerMode = .date
        tempView.addSubview(endYearPicker)
        
        // Add option field for job type
        let jobTypeOptionField = UISegmentedControl(items: ["Full Time", "Part Time"])
        jobTypeOptionField.translatesAutoresizingMaskIntoConstraints = false
        jobTypeOptionField.selectedSegmentIndex = 0 // Default to Full Time
        tempView.addSubview(jobTypeOptionField)
        
        // Add save button
        let saveButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        saveButton.layer.cornerRadius = 10
        saveButton.tintColor = .white
        saveButton.backgroundColor = UIColor(hex: "#0079C4")
        saveButton.addTarget(self, action: #selector(saveEmployment(_:)), for: .touchUpInside)
        tempView.addSubview(saveButton)
        
        // Add cancel button
        let cancelButton = UIButton(type: .system)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        cancelButton.layer.cornerRadius = 10
        cancelButton.tintColor = UIColor(hex: "#344054")
        cancelButton.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        tempView.addSubview(cancelButton)
        
        // Add the container view to the main view
        self.view.addSubview(tempView)
        self.scrollView.layer.opacity = 0.1

        // Set constraints
        NSLayoutConstraint.activate([
            
            tempView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tempView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tempView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 32),
            tempView.heightAnchor.constraint(equalToConstant: 350),
            
            companyNameTextField.topAnchor.constraint(equalTo: tempView.topAnchor, constant: 20),
            companyNameTextField.leadingAnchor.constraint(equalTo: tempView.leadingAnchor, constant: 20),
            companyNameTextField.trailingAnchor.constraint(equalTo: tempView.trailingAnchor, constant: -20),
            
            
            startYearPicker.topAnchor.constraint(equalTo: companyNameTextField.bottomAnchor, constant: 20),
            startYearPicker.leadingAnchor.constraint(equalTo: tempView.leadingAnchor, constant: 20),
            startYearPicker.trailingAnchor.constraint(equalTo: tempView.trailingAnchor, constant: -20),
            
            endYearPicker.topAnchor.constraint(equalTo: startYearPicker.bottomAnchor, constant: 20),
            endYearPicker.leadingAnchor.constraint(equalTo: tempView.leadingAnchor, constant: 20),
            endYearPicker.trailingAnchor.constraint(equalTo: tempView.trailingAnchor, constant: -20),
            
            jobTypeOptionField.topAnchor.constraint(equalTo: endYearPicker.bottomAnchor, constant: 20),
            jobTypeOptionField.leadingAnchor.constraint(equalTo: tempView.leadingAnchor, constant: 20),
            jobTypeOptionField.trailingAnchor.constraint(equalTo: tempView.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: jobTypeOptionField.bottomAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: tempView.trailingAnchor, constant: -20),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            cancelButton.topAnchor.constraint(equalTo: jobTypeOptionField.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: tempView.leadingAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalToConstant: 120),
            cancelButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func saveEmployment(_ sender: UIButton) {
        // Retrieve values from UI components
        guard let companyName = (sender.superview?.subviews[0] as? UITextField)?.text,
              let startYearPicker = (sender.superview?.subviews[1] as? UIDatePicker),
              let endYearPicker = (sender.superview?.subviews[2] as? UIDatePicker) else {
            return // Exit if any required field is nil
        }
        
        let calendar = Calendar.current
        let startYear = calendar.component(.year, from: startYearPicker.date)
        let endYear = calendar.component(.year, from: endYearPicker.date)
        
        // Determine job type based on selected segment
        let jobType: String
        if let segmentedControl = sender.superview?.subviews[3] as? UISegmentedControl {
            jobType = segmentedControl.selectedSegmentIndex == 0 ? "Full Time" : "Part Time"
        } else {
            jobType = ""
        }
        
        // Create Employment instance
        let employment = Employment(companyName: companyName, startYear: startYear, endYear: endYear, jobType: jobType)
        
        // Add to employments array
        employments.append(employment)
        print(employments[employments.count - 1])
        
        // Close the temp view
        sender.superview?.removeFromSuperview()
        self.scrollView.layer.opacity = 1
    }

    @objc func cancel(_ sender: UIButton) {
        // Close the temp view
        self.scrollView.layer.opacity = 1
        sender.superview?.removeFromSuperview()
    }

    func createEmploymentView(employment: Employment) -> UIView {
        let employmentView = UIView()
        
        // Add companyName label
        let companyNameLabel: UILabel = {
            let label = UILabel()
            label.text = employment.companyName
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        employmentView.addSubview(companyNameLabel)
        NSLayoutConstraint.activate([
            companyNameLabel.topAnchor.constraint(equalTo: employmentView.topAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: employmentView.leadingAnchor)
        ])
        
        // Add startYear to endYear label
        let yearsLabel: UILabel = {
            let label = UILabel()
            label.text = "\(employment.startYear) to \(employment.endYear),"
            label.font = .systemFont(ofSize: 14)
            label.textColor = UIColor(hex: "#667085")
            return label
        }()
        yearsLabel.translatesAutoresizingMaskIntoConstraints = false
        employmentView.addSubview(yearsLabel)
        NSLayoutConstraint.activate([
            yearsLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 6),
            yearsLabel.leadingAnchor.constraint(equalTo: employmentView.leadingAnchor)
        ])
        
        // Add jobType label
        let jobTypeLabel: UILabel = {
            let label = UILabel()
            label.text = employment.jobType
            label.font = .systemFont(ofSize: 14)
            label.textColor = UIColor(hex: "#667085")
            return label
        }()
        jobTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        employmentView.addSubview(jobTypeLabel)
        NSLayoutConstraint.activate([
            jobTypeLabel.topAnchor.constraint(equalTo: yearsLabel.topAnchor),
            jobTypeLabel.leadingAnchor.constraint(equalTo: yearsLabel.trailingAnchor, constant: 16),
        ])
        
        return employmentView
    }
    
    func setupSeparatorLine2() {
        separatorLine2.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine2.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine2)
        
        NSLayoutConstraint.activate([
            separatorLine2.topAnchor.constraint(equalTo: employmentsBottomAnchor, constant: 16),
            separatorLine2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine2.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupOtherUI3() {
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
        
        educationBottomAnchor = educationLabel.bottomAnchor
        var i = 0;
        while i < educations.count {
            let education = educations[i]
            let educationView = createEducationView(education: education)
            educationView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(educationView)
            if i == 0 {
                NSLayoutConstraint.activate([
                    educationView.topAnchor.constraint(equalTo: educationBottomAnchor, constant: 20),
                    educationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    educationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    educationView.heightAnchor.constraint(equalToConstant: 50)
                ])
            }
            else {
                NSLayoutConstraint.activate([
                    educationView.topAnchor.constraint(equalTo: educationBottomAnchor , constant: 6),
                    educationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    educationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    educationView.heightAnchor.constraint(equalToConstant: 50)
                ])
            }
            educationBottomAnchor = educationView.bottomAnchor
            i += 1
        }
    }
    @objc func didTapAddEducation() {
        print(#function)
    }
    func createEducationView(education: Education) -> UIView {
        let educationView = UIView()
        
        // Add companyName label
        let companyNameLabel: UILabel = {
            let label = UILabel()
            label.text = education.collegeName
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        educationView.addSubview(companyNameLabel)
        NSLayoutConstraint.activate([
            companyNameLabel.topAnchor.constraint(equalTo: educationView.topAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: educationView.leadingAnchor)
        ])
        
        // Add startYear to endYear label
        let yearsLabel: UILabel = {
            let label = UILabel()
            label.text = "\(education.startYear) to \(education.endYear),"
            label.font = .systemFont(ofSize: 14)
            label.textColor = UIColor(hex: "#667085")
            return label
        }()
        yearsLabel.translatesAutoresizingMaskIntoConstraints = false
        educationView.addSubview(yearsLabel)
        NSLayoutConstraint.activate([
            yearsLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 6),
            yearsLabel.leadingAnchor.constraint(equalTo: educationView.leadingAnchor)
        ])
        
        // Add jobType label
        let jobTypeLabel: UILabel = {
            let label = UILabel()
            label.text = education.courseType
            label.font = .systemFont(ofSize: 14)
            label.textColor = UIColor(hex: "#667085")
            return label
        }()
        jobTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        educationView.addSubview(jobTypeLabel)
        NSLayoutConstraint.activate([
            jobTypeLabel.topAnchor.constraint(equalTo: yearsLabel.topAnchor),
            jobTypeLabel.leadingAnchor.constraint(equalTo: yearsLabel.trailingAnchor, constant: 16),
        ])
        
        return educationView
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

struct Employment {
    let companyName: String
    let startYear: Int
    let endYear: Int
    let jobType: String
}

struct Education {
    let collegeName: String
    let startYear: Int
    let endYear: Int
    let courseType: String
}


