//
//  PreviewVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 23/05/24.
//


import UIKit

class PreviewVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
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
    
    let separatorLine0 = UIView()
    let separatorLine1 = UIView()
    let separatorLine2 = UIView()
    let separatorLine3 = UIView()
    let separatorLine4 = UIView()
    let separatorLine5 = UIView()
    let separatorLine6 = UIView()
    let separatorLine7 = UIView()
    
    
//   *************************************************  New changes in this controller ******************************************************
    
    var employmentCV : UICollectionView!
    var empDataArray : [Employment] = []
    var employmentCVHeightConstraint: NSLayoutConstraint!
    
    
    var educationCV : UICollectionView!
    var eduDataArray : [Education] = []
    var educationCVHeightConstraint: NSLayoutConstraint!
    
    
    var projectCV : UICollectionView!
    var projectDataArray : [Project] = []
    var projectCVHeightConstraint: NSLayoutConstraint!
    
    
    let preferencesVC = PreferencesVC()
    let headlineVC = HeadlineAndSummary()
    
    var softwaresArray : [String] = []
    var skillsArray : [String] = []
    
    
    var bottomView : UIView!
    
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
        setupTitle()
        
        setupScrollView()
        setupHeaderView()
        setupProfileEditButton()
        
        setupProfileCircleView()
        
        setupSeparatorLine0()
        setupPersonalInfoView()
        
        setupSeparatorLine1()
        setupEmploymentsView()
        
        setupSeparatorLine2()
        setupEducationView()
        
        setupSeparatorLine3()
        setupProjectView()
        
        setupSeparatorLine4()
        setupPreferencesView()
        
        setupSeparatorLine5()
        setupHeadlineAndSummary()
        
        setupSeparatorLine6()
        setupSoftwares()
        
        setupSeparatorLine7()
        setupSkills()
        
        setupBottomView()
    }
    
    var previewTitle = UILabel()
    func setupTitle() {
        previewTitle.text = "Preview"
        previewTitle.font = .boldSystemFont(ofSize: 24)
        previewTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(previewTitle)
        
        NSLayoutConstraint.activate([
            previewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            previewTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupProfileEditButton() {
        profileEditButton.isHidden = true
        profileEditButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(profileEditButton)
        
        NSLayoutConstraint.activate([
            profileEditButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 6),
            profileEditButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            profileEditButton.widthAnchor.constraint(equalToConstant: 36),
            profileEditButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupScrollView() {
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: previewTitle.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        let extraSpaceHeight: CGFloat = 2200
        
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
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
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
    
    
    func setupSeparatorLine0(){
        separatorLine0.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine0.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine0)
        
        NSLayoutConstraint.activate([
            separatorLine0.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            separatorLine0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine0.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    var dobLabel : UILabel!
    var nationalityLabel : UILabel!
    var genderLabel : UILabel!
    var permanentAddressLabel : UILabel!
    var currentAddressLabel : UILabel!
    var stateLabel : UILabel!
    var cityLabel : UILabel!
    var pincodeLabel : UILabel!
    var uidLabel : UILabel!
    var passportLabel : UILabel!
    var pancardLabel : UILabel!
    var languageLabel : UILabel!
    
    
    func setupPersonalInfoView() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(hex: "#1E293B")
        bgView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bgView)
        
        let personalInfoLabel : UILabel = {
            let label = UILabel()
            label.text = "Personal Information"
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        personalInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(personalInfoLabel)
        
        let editButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Edit", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            return btn
        }()
        editButton.isHidden = true
        
        scrollView.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: separatorLine0.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 40),
            
            personalInfoLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            personalInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            editButton.topAnchor.constraint(equalTo: separatorLine0.bottomAnchor, constant: 5),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            editButton.widthAnchor.constraint(equalToConstant: 70),
            editButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        var dob = createStaticLabel()
        dob.text = "Date of Birth"
        scrollView.addSubview(dob)
        dobLabel = createDynamicLabel()
        scrollView.addSubview(dobLabel)
        
        var nationality = createStaticLabel()
        nationality.text = "Nationality"
        scrollView.addSubview(nationality)
        nationalityLabel = createDynamicLabel()
        scrollView.addSubview(nationalityLabel)
        
        var gender = createStaticLabel()
        gender.text = "Gender"
        scrollView.addSubview(gender)
        genderLabel = createDynamicLabel()
        scrollView.addSubview(genderLabel)
        
        var permanent = createStaticLabel()
        permanent.text = "Permanent Address"
        scrollView.addSubview(permanent)
        permanentAddressLabel = createDynamicLabel()
        permanentAddressLabel.numberOfLines = 0
        scrollView.addSubview(permanentAddressLabel)
        
        var current = createStaticLabel()
        current.text = "Current Address"
        scrollView.addSubview(current)
        currentAddressLabel = createDynamicLabel()
        currentAddressLabel.numberOfLines = 0
        scrollView.addSubview(currentAddressLabel)
        
        var state = createStaticLabel()
        state.text = "State"
        scrollView.addSubview(state)
        stateLabel = createDynamicLabel()
        stateLabel.numberOfLines = 0
        scrollView.addSubview(stateLabel)
        
        var city = createStaticLabel()
        city.text = "City"
        scrollView.addSubview(city)
        cityLabel = createDynamicLabel()
        scrollView.addSubview(cityLabel)
        
        var pin = createStaticLabel()
        pin.text = "Pin Code"
        scrollView.addSubview(pin)
        pincodeLabel = createDynamicLabel()
        scrollView.addSubview(pincodeLabel)
        
        var uid = createStaticLabel()
        uid.text = "UID Number"
        scrollView.addSubview(uid)
        uidLabel = createDynamicLabel()
        scrollView.addSubview(uidLabel)
        
        var passport = createStaticLabel()
        passport.text = "Passport Number"
        scrollView.addSubview(passport)
        passportLabel = createDynamicLabel()
        scrollView.addSubview(passportLabel)
        
        var pan = createStaticLabel()
        pan.text = "PanCard Number"
        scrollView.addSubview(pan)
        pancardLabel = createDynamicLabel()
        scrollView.addSubview(pancardLabel)
        
        var lang = createStaticLabel()
        lang.text = "Languages"
        scrollView.addSubview(lang)
        languageLabel = createDynamicLabel()
        languageLabel.numberOfLines = 0
        scrollView.addSubview(languageLabel)
        
        
        NSLayoutConstraint.activate([
            dob.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 20),
            dob.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dob.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dobLabel.topAnchor.constraint(equalTo: dob.bottomAnchor, constant: 10),
            dobLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            nationality.topAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 20),
            nationality.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            nationalityLabel.topAnchor.constraint(equalTo: nationality.bottomAnchor, constant: 10),
            nationalityLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            gender.topAnchor.constraint(equalTo: nationalityLabel.bottomAnchor, constant: 20),
            gender.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            genderLabel.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 10),
            genderLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            permanent.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20),
            permanent.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            permanentAddressLabel.topAnchor.constraint(equalTo: permanent.bottomAnchor, constant: 10),
            permanentAddressLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            permanentAddressLabel.trailingAnchor.constraint(equalTo: dob.trailingAnchor),
            
            current.topAnchor.constraint(equalTo: permanentAddressLabel.bottomAnchor, constant: 20),
            current.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            currentAddressLabel.topAnchor.constraint(equalTo: current.bottomAnchor, constant: 10),
            currentAddressLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            currentAddressLabel.trailingAnchor.constraint(equalTo: dob.trailingAnchor),
            
            state.topAnchor.constraint(equalTo: currentAddressLabel.bottomAnchor, constant: 20),
            state.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            stateLabel.topAnchor.constraint(equalTo: state.bottomAnchor, constant: 10),
            stateLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            city.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 20),
            city.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            cityLabel.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 10),
            cityLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            pin.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            pin.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            pincodeLabel.topAnchor.constraint(equalTo: pin.bottomAnchor, constant: 10),
            pincodeLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            uid.topAnchor.constraint(equalTo: pincodeLabel.bottomAnchor, constant: 20),
            uid.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            uidLabel.topAnchor.constraint(equalTo: uid.bottomAnchor, constant: 10),
            uidLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            passport.topAnchor.constraint(equalTo: uidLabel.bottomAnchor, constant: 20),
            passport.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            passportLabel.topAnchor.constraint(equalTo: passport.bottomAnchor, constant: 10),
            passportLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            pan.topAnchor.constraint(equalTo: passportLabel.bottomAnchor, constant: 20),
            pan.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            pancardLabel.topAnchor.constraint(equalTo: pan.bottomAnchor, constant: 10),
            pancardLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            
            lang.topAnchor.constraint(equalTo: pancardLabel.bottomAnchor, constant: 20),
            lang.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            languageLabel.topAnchor.constraint(equalTo: lang.bottomAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: dob.leadingAnchor),
            languageLabel.trailingAnchor.constraint(equalTo: dob.trailingAnchor)
        ])
    }
    
    
    func setupSeparatorLine1() {
        separatorLine1.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine1.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine1)
        
        NSLayoutConstraint.activate([
            separatorLine1.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 20),
            separatorLine1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine1.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
    func setupEmploymentsView() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(hex: "#1E293B")
        bgView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bgView)
        
        let employmentLabel : UILabel = {
            let label = UILabel()
            label.text = "Employments"
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        employmentLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(employmentLabel)
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Add", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            return btn
        }()
        addButton.isHidden = true
        addButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: separatorLine1.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 40),
            
            employmentLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            employmentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            addButton.topAnchor.constraint(equalTo: separatorLine1.bottomAnchor, constant: 5),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 30),
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
        let bgView = UIView()
        bgView.backgroundColor = UIColor(hex: "#1E293B")
        bgView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bgView)
        
        let educationLabel : UILabel = {
            let label = UILabel()
            label.text = "Education"
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        educationLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(educationLabel)
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Add", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            return btn
        }()
        addButton.isHidden = true
        scrollView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: separatorLine2.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 40),
            
            educationLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            educationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            addButton.topAnchor.constraint(equalTo: separatorLine2.bottomAnchor, constant: 5),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 30),
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
        let bgView = UIView()
        bgView.backgroundColor = UIColor(hex: "#1E293B")
        bgView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bgView)
        
        let projectLabel : UILabel = {
            let label = UILabel()
            label.text = "Projects"
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        projectLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(projectLabel)
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Add", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            return btn
        }()
        addButton.isHidden = true
//        addButton.addTarget(self, action: #selector(didTapAddProject), for: .touchUpInside)
        
        scrollView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: separatorLine3.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 40),
            
            projectLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            projectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            addButton.topAnchor.constraint(equalTo: separatorLine3.bottomAnchor, constant: 5),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 30),
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
    var willingToRelocate : UILabel!
    var currentlyEmployed : UILabel!
    var worktypeLabel : UILabel!
    
    var preferencesSaveButton: UIButton!
    var preferencesCancelButton: UIButton!
    
    
    func setupPreferencesView() {
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor(hex: "#1E293B")
        bgView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bgView)
        
        let preferencesTitleLabel : UILabel = {
            let label = UILabel()
            label.text = "Preferences"
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        preferencesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(preferencesTitleLabel)
        
        let addButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Edit", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            return btn
        }()
        addButton.isHidden = true
        
        scrollView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: separatorLine4.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 40),
            
            preferencesTitleLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            preferencesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            addButton.topAnchor.constraint(equalTo: separatorLine4.bottomAnchor, constant: 5),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        let pfLabel = createStaticLabel()
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
        
        NSLayoutConstraint.activate([
            pfLabel.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 20),
            pfLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            portfolioLabel.topAnchor.constraint(equalTo: pfLabel.bottomAnchor, constant: 10),
            portfolioLabel.leadingAnchor.constraint(equalTo: pfLabel.leadingAnchor),
            portfolioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            ccLabel.topAnchor.constraint(equalTo: portfolioLabel.bottomAnchor, constant: 20),
            ccLabel.leadingAnchor.constraint(equalTo: pfLabel.leadingAnchor),
            currCtcLabel.topAnchor.constraint(equalTo: ccLabel.bottomAnchor, constant: 10),
            currCtcLabel.leadingAnchor.constraint(equalTo: ccLabel.leadingAnchor),
            
            ecLabel.topAnchor.constraint(equalTo: currCtcLabel.bottomAnchor, constant: 20),
            ecLabel.leadingAnchor.constraint(equalTo: ccLabel.leadingAnchor),
            expectedCtcLabel.topAnchor.constraint(equalTo: ecLabel.bottomAnchor, constant: 10),
            expectedCtcLabel.leadingAnchor.constraint(equalTo: ecLabel.leadingAnchor),
            
            npLabel.topAnchor.constraint(equalTo: expectedCtcLabel.bottomAnchor, constant: 20),
            npLabel.leadingAnchor.constraint(equalTo: ecLabel.leadingAnchor),
            noticePeriodLabel.topAnchor.constraint(equalTo: npLabel.bottomAnchor, constant: 10),
            noticePeriodLabel.leadingAnchor.constraint(equalTo: npLabel.leadingAnchor),
            
            wtrLabel.topAnchor.constraint(equalTo: noticePeriodLabel.bottomAnchor, constant: 20),
            wtrLabel.leadingAnchor.constraint(equalTo:noticePeriodLabel.leadingAnchor),
            willingToRelocate.topAnchor.constraint(equalTo: wtrLabel.bottomAnchor, constant: 10),
            willingToRelocate.leadingAnchor.constraint(equalTo: wtrLabel.leadingAnchor),
            
            ceLabel.topAnchor.constraint(equalTo: willingToRelocate.bottomAnchor, constant: 20),
            ceLabel.leadingAnchor.constraint(equalTo: wtrLabel.leadingAnchor),
            currentlyEmployed.topAnchor.constraint(equalTo: ceLabel.bottomAnchor, constant: 10),
            currentlyEmployed.leadingAnchor.constraint(equalTo: ceLabel.leadingAnchor),
            
            pwtLabel.topAnchor.constraint(equalTo: currentlyEmployed.bottomAnchor, constant: 20),
            pwtLabel.leadingAnchor.constraint(equalTo: ceLabel.leadingAnchor),
            worktypeLabel.topAnchor.constraint(equalTo: pwtLabel.bottomAnchor, constant: 10),
            worktypeLabel.leadingAnchor.constraint(equalTo: pwtLabel.leadingAnchor),
        ])
        
        
        
    }
    
    
    func setupSeparatorLine5() {
        separatorLine5.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine5.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine5)
        NSLayoutConstraint.activate([
            separatorLine5.topAnchor.constraint(equalTo: worktypeLabel.bottomAnchor, constant: 20),
            separatorLine5.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine5.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine5.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
    // Headline and Summary :
    var headlineEditButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit", for: .normal)
        btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 8
        btn.isHidden = true
        return btn
    }()
    var headlineSaveButton : UIButton!
    
    func setupHeadlineAndSummary() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(hex: "#1E293B")
        bgView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bgView)
        
        let prefer = UILabel()
        prefer.text = "Headline and Summary"
        prefer.font = .boldSystemFont(ofSize: 20)
        prefer.textColor = .white
        prefer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(prefer)
        
        headlineEditButton.addTarget(self, action: #selector(didTapEditHeadline), for: .touchUpInside)
        scrollView.addSubview(headlineEditButton)
        headlineEditButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: separatorLine5.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 40),
            
            prefer.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            prefer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                
            headlineEditButton.topAnchor.constraint(equalTo: separatorLine5.bottomAnchor, constant: 5),
            headlineEditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headlineEditButton.widthAnchor.constraint(equalToConstant: 70),
            headlineEditButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        
        
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
        headlineVC.scrollView.isScrollEnabled = false
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
            
            headlineSaveButton.bottomAnchor.constraint(equalTo: tempView.bottomAnchor, constant: -180),
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
    
    
    func setupSeparatorLine6() {
        separatorLine6.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine6.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine6)
        NSLayoutConstraint.activate([
            separatorLine6.topAnchor.constraint(equalTo: headlineSaveButton.bottomAnchor, constant: -30),
            separatorLine6.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine6.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine6.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
    var softwaresContainerView = UIView()
    
    func setupSoftwares() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(hex: "#1E293B")
        bgView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bgView)
        
        let title = UILabel()
        title.text = "Softwares"
        title.font = .boldSystemFont(ofSize: 20)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(title)
        
        let softwareEditButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Edit", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            return btn
        }()
        softwareEditButton.isHidden = true
        scrollView.addSubview(softwareEditButton)
        softwareEditButton.translatesAutoresizingMaskIntoConstraints = false
        
        softwaresContainerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(softwaresContainerView)
        NSLayoutConstraint.activate([
            softwaresContainerView.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 20),
            softwaresContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            softwaresContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: separatorLine6.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 40),
            
            title.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                
            softwareEditButton.topAnchor.constraint(equalTo: separatorLine6.bottomAnchor, constant: 5),
            softwareEditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            softwareEditButton.widthAnchor.constraint(equalToConstant: 70),
            softwareEditButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
    }
    
    func addLabelsInSoftwares() {
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        let spacing: CGFloat = 10
        let maxWidth: CGFloat = view.bounds.width - 32  // Adjust for left and right padding
        
        for string in softwaresArray {
            let label = PaddedLabel()
            label.text = string
            label.font = .boldSystemFont(ofSize: 16)
            label.backgroundColor = .white
            label.textColor = .black
            label.layer.borderColor = UIColor.lightGray.cgColor
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            
            // Ensure the label fits the text with padding
            let labelSize = label.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
            
            // Check if the label fits in the current line
            if currentX + labelSize.width > maxWidth {
                // Move to the next line
                currentX = 0
                currentY += labelSize.height + spacing
            }
            
            label.frame = CGRect(origin: CGPoint(x: currentX, y: currentY), size: labelSize)
            softwaresContainerView.addSubview(label)
            
            // Update currentX to the next position
            currentX += labelSize.width + spacing
        }
        
        softwaresContainerView.heightAnchor.constraint(equalToConstant: currentY + 28).isActive = true
    }
    
    
    func setupSeparatorLine7() {
        separatorLine7.backgroundColor = UIColor(hex: "#EAECF0")
        separatorLine7.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine7)
        NSLayoutConstraint.activate([
            separatorLine7.topAnchor.constraint(equalTo: softwaresContainerView.bottomAnchor, constant: 40),
            separatorLine7.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine7.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine7.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
    var skillsContainerView = UIView()
    
    func setupSkills() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(hex: "#1E293B")
        bgView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bgView)
        
        let title = UILabel()
        title.text = "Skills"
        title.font = .boldSystemFont(ofSize: 20)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(title)
        
        var skillsEditButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("Edit", for: .normal)
            btn.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 8
            return btn
        }()
        skillsEditButton.isHidden = true
        scrollView.addSubview(skillsEditButton)
        skillsEditButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        skillsContainerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(skillsContainerView)
        NSLayoutConstraint.activate([
            skillsContainerView.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 20),
            skillsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: separatorLine7.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 40),
            
            title.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                
            skillsEditButton.topAnchor.constraint(equalTo: separatorLine7.bottomAnchor, constant: 5),
            skillsEditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skillsEditButton.widthAnchor.constraint(equalToConstant: 70),
            skillsEditButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
    }
    
    func addLabelsInSkills() {
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        let spacing: CGFloat = 10
        let maxWidth: CGFloat = view.bounds.width - 32  // Adjust for left and right padding
        
        for string in skillsArray {
            let label = PaddedLabel()
            label.text = string
            label.font = .boldSystemFont(ofSize: 16)
            label.backgroundColor = .white
            label.textColor = .black
            label.layer.borderColor = UIColor.lightGray.cgColor
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            
            // Ensure the label fits the text with padding
            let labelSize = label.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
            
            // Check if the label fits in the current line
            if currentX + labelSize.width > maxWidth {
                // Move to the next line
                currentX = 0
                currentY += labelSize.height + spacing
            }
            
            label.frame = CGRect(origin: CGPoint(x: currentX, y: currentY), size: labelSize)
            skillsContainerView.addSubview(label)
            
            // Update currentX to the next position
            currentX += labelSize.width + spacing
        }
        
        skillsContainerView.heightAnchor.constraint(equalToConstant: currentY + 28).isActive = true
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
    
    
    // *********************************************************************************************************
    
    
    func setupBottomView() {
        bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        
        let nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 20)
        nextButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        nextButton.backgroundColor = UIColor(hex: "#0079C4")
        nextButton.layer.cornerRadius = 8
        
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(nextButton)
        
        let backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 20)
        backButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        backButton.backgroundColor = UIColor(hex: "#FFFFFF")
        backButton.layer.cornerRadius = 8
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        
        backButton.isUserInteractionEnabled = true
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(backButton)
        
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            
            backButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15),
            backButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            
            nextButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    @objc func didTapNextButton() {
        setOnboardingTrue()
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






extension PreviewVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
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
            
            cell.deleteButton.isHidden = true
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            cell.layer.cornerRadius = 12
            
            return cell
        }
        if collectionView == educationCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "edu", for: indexPath) as! EducationCell
            
            let edu = eduDataArray[indexPath.row]
            
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
            
            cell.deleteButton.isHidden = true
            
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
            
            cell.deleteButton.isHidden = true
            
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
    
    
    
}

// Extension for APIs
extension PreviewVC {
    
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
                print("User fetched: \(user.hasCompletedOnboarding)")
                
                let initialsOfName = self.extractInitials(from: user.name)
                let userName = user.name ?? ""
                
                DispatchQueue.main.async {
                    self.profileCircleLabel.text = initialsOfName
                    self.userNameLabel.text = "\(userName)"
                    self.jobTitleLabel.text = user.designation
                    self.locationLabel.text = user.currentAddress?.city ?? "cityNil"
                    
                    self.fetchProfilePicture(size: "m", userID: user._id)
                    
                    self.dobLabel.text = user.dateOfBirth
                    self.nationalityLabel.text = user.nationality
                    self.genderLabel.text = user.gender?.trimmingCharacters(in: .whitespaces)
                    self.permanentAddressLabel.text = user.permanentAddress
                    self.currentAddressLabel.text = user.currentAddress?.address
                    self.stateLabel.text = user.currentAddress?.state
                    self.cityLabel.text = user.currentAddress?.city
                    self.pincodeLabel.text = user.currentAddress?.pincode
                    self.uidLabel.text = user.uidNumber ?? "UID nil"
                    self.passportLabel.text = user.passportNo ?? "Passport nil"
                    self.pancardLabel.text = user.panNo ?? "PAN nil"
                    
                    var a : [String] = []
                    for s in user.language! {
                        a.append(s.language)
                    }
                    self.languageLabel.text = a.joined(separator: ", ")
                    
                    
                    self.empDataArray = user.experience!
                    self.reloadEmploymentsCollectionView()
                    
                    self.eduDataArray = user.education!
                    self.reloadEducationCollectionView()
                    
                    self.projectDataArray = user.projects!
                    self.reloadProjectCollectionView()
                    
                    
                    self.preferencesVC.portfolioTextField.text = user.portfolio
                    self.preferencesVC.currentCtcTextField.text = user.currentCtc
                    self.preferencesVC.expectedCtcTextField.text = user.expectedCtc
                    
                    self.headlineVC.resumeTextView.text = user.headline
                    self.headlineVC.summaryTextView.text = user.summary
                    
                    
                    self.portfolioLabel.text = user.portfolio
                    self.currCtcLabel.text = user.currentCtc
                    self.expectedCtcLabel.text = user.expectedCtc
            
                    self.noticePeriodLabel.text = user.noticePeriod?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.willingToRelocate.text = user.willingToRelocate?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.currentlyEmployed.text = user.currentlyEmployed?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.worktypeLabel.text = user.preferredWorkType?.trimmingCharacters(in: .whitespacesAndNewlines)
                    
//                    for s in user.softwares! {
//                        self.softwaresArray.append(s)
//                    }
                    
                    for subview in self.softwaresContainerView.subviews {
                        subview.removeFromSuperview()
                    }
                    self.softwaresArray = user.softwares!
                    self.addLabelsInSoftwares()
                    
                    for subview in self.skillsContainerView.subviews {
                        subview.removeFromSuperview()
                    }
                    self.skillsArray = user.skills!
                    self.addLabelsInSkills()
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
    
    func setOnboardingTrue() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/update-by-resume") else {
            print("Invalid URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let hasCompletedOnboarding: [String: Bool] = ["hasCompletedOnboarding": true]
        
        do {
            let jsonData = try JSONEncoder().encode(hasCompletedOnboarding)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode user profile to JSON: \(error)")
            return
        }
        
        let loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        
        DispatchQueue.main.async {
            loader.startAnimating()
            self.view.addSubview(loader)
            self.scrollView.alpha = 0.1
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to upload user profile, status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return
            }
            
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Server response: \(responseString)")
            }
            if let error = error {
                print("Error uploading user profile: \(error.localizedDescription)")
            } else {
                print("User Preferences successfully uploaded.")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                loader.stopAnimating()
                loader.removeFromSuperview()
                self.scrollView.alpha = 1
                
                let viewController = ViewController()
                viewController.modalPresentationStyle = .overFullScreen
                viewController.overrideUserInterfaceStyle = .light
                self.present(viewController, animated: true)
            }
        }.resume()
    }
}



