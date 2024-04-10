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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
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
        setupScrollView()
        setupHeaderView()
        setupProfileEditButton()
        
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
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
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
        UserDefaults.standard.removeObject(forKey: "accessToken")
        let vc = RegistrationVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
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
        let vc = AddEmploymentVC()
        navigationController?.pushViewController(vc, animated: true)
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
        let vc = AddEducationVC()
        navigationController?.pushViewController(vc, animated: true)
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

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}




