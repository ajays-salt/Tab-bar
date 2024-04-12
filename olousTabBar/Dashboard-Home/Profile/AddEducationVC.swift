//
//  AddEducationVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 15/03/24.
//

import UIKit

class AddEducationVC: UIViewController {

    let collegeNameTextField = UITextField()
    
    var employments = [Employment]()
    var educations = [EducationTemp]()
    
    var isMadeChanges : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        let pvc = ProfileController()
        employments = pvc.employments
        educations = pvc.educations
        
        navigationItem.title = "Add Education"
        navigationItem.hidesBackButton = true
        
        let backButtonImage = UIImage(systemName: "xmark") // Change "xmark" to any system image you prefer
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        setupViews()
    }
    
    @objc func backButtonPressed() {
//        if isMadeChanges == false {
//            self.navigationController?.popViewController(animated: true)
//            return
//        }
        let alertController = UIAlertController(title: "Warning", message: "Do you want to proceed without adding Education?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let proceedAction = UIAlertAction(title: "Proceed", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true) // Pop to previous view controller
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(proceedAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func setupViews() {
        let tempView = UIView()
        tempView.translatesAutoresizingMaskIntoConstraints = false
        
        
        collegeNameTextField.translatesAutoresizingMaskIntoConstraints = false
        collegeNameTextField.placeholder = "College Name"
        collegeNameTextField.borderStyle = .roundedRect
        collegeNameTextField.layer.borderWidth = 1
        collegeNameTextField.layer.cornerRadius = 6
        collegeNameTextField.layer.borderColor = UIColor(hex: "#667085").cgColor
        tempView.addSubview(collegeNameTextField)
        
        // Add start year picker
        let start = UILabel()
        start.text = "Start Date :"
        start.translatesAutoresizingMaskIntoConstraints = false
        tempView.addSubview(start)
        let startYearPicker = UIDatePicker()
        startYearPicker.translatesAutoresizingMaskIntoConstraints = false
        startYearPicker.datePickerMode = .date
        tempView.addSubview(startYearPicker)
        
        // Add end year picker
        let end = UILabel()
        end.text = "End Date :"
        end.translatesAutoresizingMaskIntoConstraints = false
        tempView.addSubview(end)
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
        
        
        self.view.addSubview(tempView)
        NSLayoutConstraint.activate([
            
            tempView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tempView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tempView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            tempView.heightAnchor.constraint(equalToConstant: 350),
            
            collegeNameTextField.topAnchor.constraint(equalTo: tempView.topAnchor, constant: 20),
            collegeNameTextField.leadingAnchor.constraint(equalTo: tempView.leadingAnchor, constant: 20),
            collegeNameTextField.trailingAnchor.constraint(equalTo: tempView.trailingAnchor, constant: -20),
            collegeNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            start.topAnchor.constraint(equalTo: collegeNameTextField.bottomAnchor, constant: 30),
            start.leadingAnchor.constraint(equalTo: tempView.leadingAnchor, constant: 20),
            start.widthAnchor.constraint(equalToConstant: 100),
            startYearPicker.topAnchor.constraint(equalTo: collegeNameTextField.bottomAnchor, constant: 20),
            startYearPicker.trailingAnchor.constraint(equalTo: tempView.trailingAnchor, constant: -20),
            
            end.topAnchor.constraint(equalTo: start.bottomAnchor, constant: 35),
            end.leadingAnchor.constraint(equalTo: tempView.leadingAnchor, constant: 20),
            end.widthAnchor.constraint(equalToConstant: 100),
            endYearPicker.topAnchor.constraint(equalTo: startYearPicker.bottomAnchor, constant: 20),
            endYearPicker.trailingAnchor.constraint(equalTo: tempView.trailingAnchor, constant: -20),
            
            jobTypeOptionField.topAnchor.constraint(equalTo: endYearPicker.bottomAnchor, constant: 20),
            jobTypeOptionField.leadingAnchor.constraint(equalTo: tempView.leadingAnchor, constant: 20),
            jobTypeOptionField.trailingAnchor.constraint(equalTo: tempView.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: jobTypeOptionField.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: tempView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 160),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    
    @objc func saveEmployment(_ sender: UIButton) {
        // Retrieve values from UI components
        print(#function)
        guard let companyNameField = sender.superview?.subviews[0] as? UITextField,
              let companyName = companyNameField.text, !companyName.isEmpty,
              let startYearPicker = sender.superview?.subviews[2] as? UIDatePicker,
              let endYearPicker = sender.superview?.subviews[4] as? UIDatePicker else {
            collegeNameTextField.placeholder = "College can't be empty"
            collegeNameTextField.layer.borderColor = UIColor.systemRed.cgColor
            return // Exit if any required field is nil or companyName is empty
        }
        
        let calendar = Calendar.current
        let startYear = calendar.component(.year, from: startYearPicker.date)
        let endYear = calendar.component(.year, from: endYearPicker.date)
        
        // Determine job type based on selected segment
        let jobType: String
        if let segmentedControl = sender.superview?.subviews[5] as? UISegmentedControl {
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
        self.navigationController?.popViewController(animated: true)
    }

    @objc func cancel(_ sender: UIButton) {
        // Close the temp view
        sender.superview?.removeFromSuperview()
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
