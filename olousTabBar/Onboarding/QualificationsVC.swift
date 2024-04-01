//
//  QualificationsVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/04/24.
//

import UIKit

class QualificationsVC: UIViewController, UITextFieldDelegate {
    
    var headerView : UIView!
    var circleContainerView : UIView!
    
    var scrollView : UIScrollView!
    
    var qualificationOptionsScrollView : UIScrollView!
    var selectedSpecializationOption : UIButton?
    
    var isOtherComponentsHidden : Bool = true
    
    let specializationTextField = UITextField()
    var degreeDropdownButton : UIButton!
    var degreeArray = ["Civil Engineering", "Btech Architecture", "Interior Designing", "xyz degree", "No degree", "Piece of Paper"]
    let degreeTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()
    
    let collegeTextField = UITextField()
    var collegeArray = ["Civil Engineering", "B.Tech Architecture", "Bsc Interior Design", "xyz degree", "No degree", "Piece of Paper"]
    var filteredCollegeArray : [String] = []
    let collegeTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()
    
    var selectedCourseTypeOption : UIButton?
    
    var startButton : UIButton!
    let startYearPlaceholder : UILabel = {
        let label = UILabel()
        label.text = "Start Year"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    var startArray = ["2024", "2023", "2022", "2021", "2020", "2019", "2018", "2017", "2016", "2015"]
    var startTableView : UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()
    
    var bottomView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        degreeTableView.delegate = self
        degreeTableView.dataSource = self
        
        collegeTextField.delegate = self
        collegeTableView.delegate = self
        collegeTableView.dataSource = self
        
        startTableView.delegate = self
        startTableView.dataSource = self
        
        setupViews()
    }
    
    func setupViews() {
        setupHeaderView()
        setupScrollView()
        
        setupQualification()
        
        setupUI()
        setupUI2()
        
        setupBottomView()
    }
    
    func setupHeaderView() {
        
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        
        circleContainerView = UIView(frame: CGRect(x: 60, y: 60, width: 60, height: 60))
        circleContainerView.layer.cornerRadius = 30
        
        circleContainerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(circleContainerView)
        NSLayoutConstraint.activate([
            circleContainerView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            circleContainerView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            circleContainerView.widthAnchor.constraint(equalToConstant: 60),
            circleContainerView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let profileCircleLabel : UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = UIColor(hex: "#000000")
            label.font = .boldSystemFont(ofSize: 24)
            return label
        }()
        profileCircleLabel.text = "5/7"
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        circleContainerView.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: circleContainerView.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: circleContainerView.centerYAnchor)
        ])
        
        
        // Calculate the center and radius of the circle
        let center = CGPoint(x: circleContainerView.bounds.midX, y: circleContainerView.bounds.midY)
        let radius = min(circleContainerView.bounds.width, circleContainerView.bounds.height) / 2
        
        // Calculate the end angle based on the percentage (0.75 for 75%)
        let percentage: CGFloat = 5 / 7
        let greenEndAngle = CGFloat.pi * 2 * percentage + CGFloat.pi / 2
        let normalEndAngle = CGFloat.pi * 2 + CGFloat.pi / 2
        
        // Create a circular path for the green layer
        let greenPath = UIBezierPath(arcCenter: center,
                                     radius: radius,
                                     startAngle: CGFloat.pi / 2,
                                     endAngle: greenEndAngle,
                                     clockwise: true)
        
        let greenBorderLayer : CAShapeLayer = {
            let greenBorderLayer = CAShapeLayer()
            greenBorderLayer.path = greenPath.cgPath
            greenBorderLayer.lineWidth = 6 // Border width
            greenBorderLayer.strokeColor = UIColor(hex: "#0079C4").cgColor // Border color
            greenBorderLayer.fillColor = UIColor.clear.cgColor
            return greenBorderLayer
        }()
        circleContainerView.layer.addSublayer(greenBorderLayer)
        
        
        // regular border without green color
        let normalPath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: greenEndAngle,
                                      endAngle: normalEndAngle,
                                      clockwise: true)
        
        // Create shape layer for the normal circle border
        let normalBorderLayer : CAShapeLayer = {
            let normalBorderLayer = CAShapeLayer()
            normalBorderLayer.path = normalPath.cgPath
            normalBorderLayer.lineWidth = 6 // Border width
            normalBorderLayer.strokeColor = UIColor(hex: "#D9D9D9").cgColor // Border color
            normalBorderLayer.fillColor = UIColor.clear.cgColor
            return normalBorderLayer
        }()
        circleContainerView.layer.addSublayer(normalBorderLayer)
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Qualification"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
        ])
        
        let borderView = UIView()
        borderView.backgroundColor = UIColor(hex: "#EAECF0")
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(borderView)
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -1),
            borderView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            borderView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            borderView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
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
    
    func setupQualification() {
        var qualificationsLabel : UILabel =  {
            let label = UILabel()
            label.text = "QUALIFICATIONS"
            label.font = .boldSystemFont(ofSize: 20)
            label.textColor = UIColor(hex: "#101828")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(qualificationsLabel)
        
        
        let highestQualificationLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Highest qualifications")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(highestQualificationLabel)
        
        let qualificationOptions = ["Masters", "Bachelors", "Diploma", "ITI", "12th", "10th"]
        
        qualificationOptionsScrollView = UIScrollView()
        qualificationOptionsScrollView.showsHorizontalScrollIndicator = false
        qualificationOptionsScrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(qualificationOptionsScrollView)
        
        // Create and configure the stack view for options
        let qualificationOptionsStackView = UIStackView()
        qualificationOptionsStackView.axis = .horizontal
        qualificationOptionsStackView.spacing = 12
        qualificationOptionsStackView.translatesAutoresizingMaskIntoConstraints = false
        qualificationOptionsScrollView.addSubview(qualificationOptionsStackView)
        
        // Add options buttons to the stack view
        for option in qualificationOptions {
            let optionButton = UIButton(type: .system)
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            optionButton.layer.cornerRadius = 8
            optionButton.setTitle("  \(option)  ", for: .normal)
            optionButton.titleLabel?.font = .systemFont(ofSize: 16)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.addTarget(self, action: #selector(specializationOptionButtonTapped(_:)), for: .touchUpInside)
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            qualificationOptionsStackView.addArrangedSubview(optionButton)
        }
        
        NSLayoutConstraint.activate([
            qualificationsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            qualificationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            highestQualificationLabel.topAnchor.constraint(equalTo: qualificationsLabel.bottomAnchor, constant: 20),
            highestQualificationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            qualificationOptionsScrollView.topAnchor.constraint(equalTo: highestQualificationLabel.bottomAnchor, constant: 10),
            qualificationOptionsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            qualificationOptionsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            qualificationOptionsScrollView.heightAnchor.constraint(equalToConstant: 40),
            qualificationOptionsStackView.topAnchor.constraint(equalTo: qualificationOptionsScrollView.topAnchor),
            qualificationOptionsStackView.leadingAnchor.constraint(equalTo: qualificationOptionsScrollView.leadingAnchor),
            qualificationOptionsStackView.trailingAnchor.constraint(equalTo: qualificationOptionsScrollView.trailingAnchor),
            qualificationOptionsStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    @objc func specializationOptionButtonTapped(_ sender: UIButton) {
        // Deselect previous selected button
        selectedSpecializationOption?.backgroundColor = nil
        selectedSpecializationOption?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedSpecializationOption?.titleLabel?.textColor = nil

        // Highlight the selected button
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        sender.titleLabel?.textColor = UIColor(hex: "#0079C4")
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        
        selectedSpecializationOption = sender
        
    }
    
    func setupUI() {
        let specializationLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Specialization")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(specializationLabel)
        
        specializationTextField.placeholder = "E.g. Civil Engineering"
        specializationTextField.borderStyle = .none
        specializationTextField.inputView = nil
        specializationTextField.isUserInteractionEnabled = false
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.borderWidth = 1 // Add border to the container
        container.layer.cornerRadius = 5 // Add corner radius for rounded corners
        container.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor // Set border color
        scrollView.addSubview(container)
        
        specializationTextField.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(specializationTextField)
        
        // Create a dropdown button
        degreeDropdownButton = UIButton(type: .system)
        degreeDropdownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        degreeDropdownButton.tintColor = UIColor(hex: "#667085")
        degreeDropdownButton.addTarget(self, action: #selector(degreeDropdownButtonTapped), for: .touchUpInside)
        
        degreeDropdownButton.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(degreeDropdownButton)
        
        degreeTableView.layer.borderWidth = 1
        degreeTableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        degreeTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(degreeTableView)
        
        
        NSLayoutConstraint.activate([
            specializationLabel.topAnchor.constraint(equalTo: qualificationOptionsScrollView.bottomAnchor, constant: 20),
            specializationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            container.topAnchor.constraint(equalTo: specializationLabel.bottomAnchor, constant: 10),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            container.heightAnchor.constraint(equalToConstant: 50),
            
            specializationTextField.topAnchor.constraint(equalTo: container.topAnchor),
            specializationTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8), // Adjust left padding
            specializationTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -28),
            specializationTextField.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            degreeDropdownButton.widthAnchor.constraint(equalToConstant: 40), // Adjust the width as needed
            degreeDropdownButton.heightAnchor.constraint(equalToConstant: 20), // Adjust the height as needed
            degreeDropdownButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            degreeDropdownButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16), // Adjust spacing from right edge of container
            
            degreeTableView.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 10),
            degreeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            degreeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            degreeTableView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        
        let collegeLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "University / Institute")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(collegeLabel)
        
        collegeTextField.placeholder = "E.g. IIT Bombay"
        collegeTextField.borderStyle = .roundedRect
        collegeTextField.layer.borderWidth = 1
        collegeTextField.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        collegeTextField.layer.cornerRadius = 8
        collegeTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(collegeTextField)
        
        collegeTableView.layer.borderWidth = 1
        collegeTableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        collegeTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(collegeTableView)
        scrollView.bringSubviewToFront(collegeTableView)
        
        NSLayoutConstraint.activate([
            collegeLabel.topAnchor.constraint(equalTo: specializationTextField.bottomAnchor, constant: 20),
            collegeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            collegeTextField.topAnchor.constraint(equalTo: collegeLabel.bottomAnchor, constant: 10),
            collegeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collegeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collegeTextField.heightAnchor.constraint(equalToConstant: 50),
            
            collegeTableView.topAnchor.constraint(equalTo: collegeTextField.bottomAnchor, constant: 10),
            collegeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collegeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collegeTableView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc func degreeDropdownButtonTapped(_ sender : UIButton) {
        print(#function)
        if sender.imageView?.image == UIImage(systemName: "chevron.down") {
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            degreeTableView.isHidden = false
            scrollView.bringSubviewToFront(degreeTableView)
        }
        else {
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            degreeTableView.isHidden = true
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == collegeTextField {
            let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            filterCollege(with: searchText)
        }
        
        return true
    }
    func filterCollege(with searchText: String) {
        filteredCollegeArray = collegeArray.filter { $0.lowercased().hasPrefix(searchText.lowercased()) }
        collegeTableView.isHidden = filteredCollegeArray.isEmpty
        if(filteredCollegeArray.count == collegeArray.count) {
            filteredCollegeArray.removeAll()
            collegeTableView.isHidden = true
        }
        collegeTableView.reloadData()
    }
    
    func setupUI2() {
        let courseTypeLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Course type")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(courseTypeLabel)
        
        let courseTypeOptions = ["Full-Time", "Part-Time", "Distance Education"]
        
        let courseTypeStackView = UIStackView()
        courseTypeStackView.axis = .horizontal
        courseTypeStackView.spacing = 12
        courseTypeStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(courseTypeStackView)
        
        // Add options buttons to the stack view
        for option in courseTypeOptions {
            let optionButton = UIButton(type: .system)
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            optionButton.layer.cornerRadius = 8
            optionButton.setTitle("  \(option)  ", for: .normal)
            optionButton.titleLabel?.font = .systemFont(ofSize: 16)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.addTarget(self, action: #selector(courseTypeButtonTapped(_:)), for: .touchUpInside)
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            courseTypeStackView.addArrangedSubview(optionButton)
        }
        
        
        NSLayoutConstraint.activate([
            courseTypeLabel.topAnchor.constraint(equalTo: collegeTextField.bottomAnchor, constant: 20),
            courseTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            courseTypeStackView.topAnchor.constraint(equalTo: courseTypeLabel.bottomAnchor, constant: 10),
            courseTypeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
        ])
        
        
        let startYearLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Starting year")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(startYearLabel)
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.borderWidth = 1 // Add border to the container
        container.layer.cornerRadius = 5 // Add corner radius for rounded corners
        container.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor // Set border color
        scrollView.addSubview(container)
        
        
        
        startYearPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(startYearPlaceholder)
        
        // Create a dropdown button
        startButton = UIButton(type: .system)
        startButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        startButton.tintColor = UIColor(hex: "#667085")
        startButton.addTarget(self, action: #selector(startDropdownButtonTapped), for: .touchUpInside)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(startButton)
        
        startTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(startTableView)
        
        NSLayoutConstraint.activate([
            startYearLabel.topAnchor.constraint(equalTo: courseTypeStackView.bottomAnchor, constant: 20),
            startYearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            container.topAnchor.constraint(equalTo: startYearLabel.bottomAnchor, constant: 10),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.widthAnchor.constraint(equalToConstant: 150),
            container.heightAnchor.constraint(equalToConstant: 50),
            
            startYearPlaceholder.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            startYearPlaceholder.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            
            startButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            startButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            startTableView.topAnchor.constraint(equalTo: container.bottomAnchor),
            startTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startTableView.widthAnchor.constraint(equalToConstant: 150),
            startTableView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc func courseTypeButtonTapped(_ sender: UIButton) {
        // Deselect previous selected button
        selectedCourseTypeOption?.backgroundColor = nil
        selectedCourseTypeOption?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedCourseTypeOption?.titleLabel?.textColor = nil

        // Highlight the selected button
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        sender.titleLabel?.textColor = UIColor(hex: "#0079C4")
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        
        selectedCourseTypeOption = sender
        
    }
    
    @objc func startDropdownButtonTapped(_ sender : UIButton) {
        print(#function)
        if sender.imageView?.image == UIImage(systemName: "chevron.down") {
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            startTableView.isHidden = false
            scrollView.bringSubviewToFront(startTableView)
        }
        else {
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            startTableView.isHidden = true
        }
        
    }
    
    
    
    
    
    
    
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
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNextButton() {
        print(#function)
//        let vc = QualificationsVC()
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension QualificationsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == degreeTableView {
            return degreeArray.count
        }
        else if tableView == startTableView {
            return startArray.count
        }
        else {
            return filteredCollegeArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if tableView == degreeTableView {
            cell.textLabel?.text = degreeArray[indexPath.row]
        }
        else if tableView == startTableView {
            cell.textLabel?.text = startArray[indexPath.row]
        }
        else {
            cell.textLabel?.text = filteredCollegeArray[indexPath.row]
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == degreeTableView {
            specializationTextField.text = degreeArray[indexPath.row]
            degreeDropdownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            degreeTableView.isHidden = true
        }
        if tableView == collegeTableView {
            collegeTextField.text = filteredCollegeArray[indexPath.row]
            collegeTableView.isHidden = true
        }
        if tableView == startTableView {
            
        }
    }
    
}
