//
//  EmploymentsVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 05/04/24.
//

import UIKit

class EmploymentsVC: UIViewController, UITextFieldDelegate {
    
    var headerView : UIView!
    var circleContainerView : UIView!
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "ADD YOUR EMPLOYMENT"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hex: "#101828")
        return label
    }()
    
    var scrollView : UIScrollView!
    
    var employmentsCV : UICollectionView!
//    var dataArray: [Experience] = [
//        Experience(titleLabel: "iOS Developer", companyNameLabel: "Salt Technologies", noOfYearsLabel: 1, jobTypeLabel: "Full time"),
//        Experience(titleLabel: "Android Developer", companyNameLabel: "Tech Co.", noOfYearsLabel: 2, jobTypeLabel: "Part time"),
//        Experience(titleLabel: "Web Developer", companyNameLabel: "Web Corp", noOfYearsLabel: 3, jobTypeLabel: "Full time")
//    ]
    var dataArray : [Experience] = []
    var employmentsCVHeightConstraint: NSLayoutConstraint!
    
    
    var companyTextField : UITextField!
    var jobTitleTextField : UITextField!
    
    
    var startButton : UIButton!
    let startYearPlaceholder : UILabel = {
        let label = UILabel()
        label.text = "Select years"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    var startArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "20+",]
    var startTableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        tableView.isHidden = true
        return tableView
    }()
    
    var passingButton : UIButton!
    let passYearPlaceholder : UILabel = {
        let label = UILabel()
        label.text = "Select months"
        label.textColor = UIColor(hex: "#667085")
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    var passArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    var passTableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        tableView.isHidden = true
        return tableView
    }()
    
    var selectedEmploymentTypeOption : UIButton?
    
    var saveButton : UIButton!
    
    var bottomView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground

        setupViews()
    }
    
    func setupViews() {
        setupHeaderView()
        setupTitle()
        setupScrollView()
        
        setupEmploymentsView()
        setupAddEmployment()
        
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
        profileCircleLabel.text = "3/7"
        
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
        let percentage: CGFloat = 3 / 7
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
        titleLabel.text = "Employment"
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
    
    func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
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
    
    func setupEmploymentsView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        employmentsCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        employmentsCV.register(EmploymentCell.self, forCellWithReuseIdentifier: "exp")
        employmentsCV.delegate = self
        employmentsCV.dataSource = self
        
        employmentsCV.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(employmentsCV)
        NSLayoutConstraint.activate([
            employmentsCV.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            employmentsCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            employmentsCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        employmentsCVHeightConstraint = employmentsCV.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        employmentsCVHeightConstraint.isActive = true
        
        reloadCollectionView()
    }
    
    func reloadCollectionView() {
        employmentsCV.reloadData()
            
        // Calculate the content size
        employmentsCV.layoutIfNeeded()
        let contentSize = employmentsCV.collectionViewLayout.collectionViewContentSize
        
        // Update the height constraint based on content size
        employmentsCVHeightConstraint.constant = contentSize.height
        
        // Update constraints
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setupAddEmployment() {
        
        let addNewExpLabel : UILabel = {
            let label = UILabel()
            label.text = "Add New Employment"
            label.font = .boldSystemFont(ofSize: 18)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(addNewExpLabel)
        
        let companyLabel = UILabel()
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText2 = NSMutableAttributedString(string: "Company name")
        let asterisk2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText2.append(asterisk2)
        companyLabel.attributedText = attributedText2
        companyLabel.font = .boldSystemFont(ofSize: 16)
        companyLabel.textColor = UIColor(hex: "#344054")
        scrollView.addSubview(companyLabel)
        
        // company TextField
        companyTextField = UITextField()
        companyTextField.translatesAutoresizingMaskIntoConstraints = false
        companyTextField.borderStyle = .roundedRect
        companyTextField.placeholder = "E.g. Salt Technologies"
        companyTextField.delegate = self // Set delegate for this text field
        scrollView.addSubview(companyTextField)
        
        let jobTitleLabel = UILabel()
        jobTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText3 = NSMutableAttributedString(string: "Designation")
        let asterisk3 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText3.append(asterisk3)
        jobTitleLabel.attributedText = attributedText3
        jobTitleLabel.font = .boldSystemFont(ofSize: 16)
        jobTitleLabel.textColor = UIColor(hex: "#344054")
        scrollView.addSubview(jobTitleLabel)
        
        // jobTitle TextField
        jobTitleTextField = UITextField()
        jobTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        jobTitleTextField.borderStyle = .roundedRect
        jobTitleTextField.placeholder = "E.g. Civil Engineer"
        jobTitleTextField.delegate = self // Set delegate for this text field
        scrollView.addSubview(jobTitleTextField)
        
        
        let startYearLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Total year")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(startYearLabel)
        
        let container : UIView = {
            let views = UIView()
            views.translatesAutoresizingMaskIntoConstraints = false
            views.layer.borderWidth = 1 // Add border to the container
            views.layer.cornerRadius = 5 // Add corner radius for rounded corners
            views.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor // Set border color
            
            return views
        }()
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
        
        startTableView.delegate = self
        startTableView.dataSource = self
        startTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(startTableView)
        
        // passing year UI
        let passYearLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Months")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(passYearLabel)
        
        let container2 : UIView = {
            let views = UIView()
            views.translatesAutoresizingMaskIntoConstraints = false
            views.layer.borderWidth = 1 // Add border to the container
            views.layer.cornerRadius = 5 // Add corner radius for rounded corners
            views.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor // Set border color
            
            return views
        }()
        scrollView.addSubview(container2)
        
        passYearPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        container2.addSubview(passYearPlaceholder)
        
        passingButton = UIButton(type: .system)
        passingButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        passingButton.tintColor = UIColor(hex: "#667085")
        passingButton.addTarget(self, action: #selector(passDropdownButtonTapped), for: .touchUpInside)
        
        passingButton.translatesAutoresizingMaskIntoConstraints = false
        container2.addSubview(passingButton)
        
        passTableView.delegate = self
        passTableView.dataSource = self
        passTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(passTableView)
        
        
        let jobTypeLabel : UILabel = {
            let label = UILabel()
            let attributedText1 = NSMutableAttributedString(string: "Employment type")
            let asterisk1 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
            attributedText1.append(asterisk1)
            label.attributedText = attributedText1
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(jobTypeLabel)
        
        let jobTypeOptions = ["Full-Time", "Part-Time", "Freelance"]
        
        let jobStackView = UIStackView()
        jobStackView.axis = .horizontal
        jobStackView.spacing = 12
        jobStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(jobStackView)
        
        // Add options buttons to the stack view
        for option in jobTypeOptions {
            let optionButton = UIButton(type: .system)
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            optionButton.layer.cornerRadius = 8
            optionButton.setTitle("  \(option)  ", for: .normal)
            optionButton.titleLabel?.font = .systemFont(ofSize: 16)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.addTarget(self, action: #selector(employmentTypeButtonTapped(_:)), for: .touchUpInside)
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            jobStackView.addArrangedSubview(optionButton)
            
            if option == "Full-Time" {
                optionButton.layer.borderColor = UIColor(hex: "#0079C4").cgColor
                optionButton.titleLabel?.textColor = UIColor(hex: "#0079C4")
                optionButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
                
                selectedEmploymentTypeOption = optionButton
            }
        }
        
        saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 20)
        saveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        saveButton.backgroundColor = UIColor(hex: "#0079C4")
        saveButton.layer.cornerRadius = 8
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(saveButton)
        
        let width = (view.frame.width - 52) / 2
        
        NSLayoutConstraint.activate([
            
            addNewExpLabel.topAnchor.constraint(equalTo: employmentsCV.bottomAnchor, constant: 30),
            addNewExpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            companyLabel.topAnchor.constraint(equalTo: addNewExpLabel.bottomAnchor, constant: 15),
            companyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            companyTextField.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            companyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            companyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            companyTextField.heightAnchor.constraint(equalToConstant: 50),
            
            jobTitleLabel.topAnchor.constraint(equalTo: companyTextField.bottomAnchor, constant: 20),
            jobTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            jobTitleTextField.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 10),
            jobTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jobTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            jobTitleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            startYearLabel.topAnchor.constraint(equalTo: jobTitleTextField.bottomAnchor, constant: 20),
            startYearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            container.topAnchor.constraint(equalTo: startYearLabel.bottomAnchor, constant: 10),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.widthAnchor.constraint(equalToConstant: width),
            container.heightAnchor.constraint(equalToConstant: 40),
            
            startYearPlaceholder.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            startYearPlaceholder.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            
            startButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            startButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            startTableView.topAnchor.constraint(equalTo: container.bottomAnchor),
            startTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startTableView.widthAnchor.constraint(equalToConstant: width),
            startTableView.heightAnchor.constraint(equalToConstant: 100),
            
            passYearLabel.topAnchor.constraint(equalTo: startYearLabel.topAnchor),
            passYearLabel.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 20),
            
            container2.topAnchor.constraint(equalTo: passYearLabel.bottomAnchor, constant: 10),
            container2.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 20),
            container2.widthAnchor.constraint(equalToConstant: width),
            container2.heightAnchor.constraint(equalToConstant: 40),
            
            passYearPlaceholder.centerYAnchor.constraint(equalTo: container2.centerYAnchor),
            passYearPlaceholder.leadingAnchor.constraint(equalTo: container2.leadingAnchor, constant: 10),
            
            passingButton.centerYAnchor.constraint(equalTo: container2.centerYAnchor),
            passingButton.trailingAnchor.constraint(equalTo: container2.trailingAnchor, constant: -10),
            
            passTableView.topAnchor.constraint(equalTo: container2.bottomAnchor),
            passTableView.leadingAnchor.constraint(equalTo: container2.leadingAnchor),
            passTableView.widthAnchor.constraint(equalToConstant: width),
            passTableView.heightAnchor.constraint(equalToConstant: 100),
            
            jobTypeLabel.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 20),
            jobTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            jobStackView.topAnchor.constraint(equalTo: jobTypeLabel.bottomAnchor, constant: 10),
            jobStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            saveButton.topAnchor.constraint(equalTo: jobStackView.bottomAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.widthAnchor.constraint(equalToConstant: 80),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        
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
    
    @objc func passDropdownButtonTapped(_ sender : UIButton) {
        print(#function)
        if sender.imageView?.image == UIImage(systemName: "chevron.down") {
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            passTableView.isHidden = false
            scrollView.bringSubviewToFront(passTableView)
        }
        else {
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            passTableView.isHidden = true
        }
        
    }
    
    @objc func employmentTypeButtonTapped(_ sender: UIButton) {
        // Deselect previous selected button
        selectedEmploymentTypeOption?.backgroundColor = nil
        selectedEmploymentTypeOption?.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        selectedEmploymentTypeOption?.titleLabel?.textColor = nil

        // Highlight the selected button
        sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        sender.titleLabel?.textColor = UIColor(hex: "#0079C4")
        sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        
        selectedEmploymentTypeOption = sender
    }
    
    @objc func saveButtonTapped() {
        let cText = companyTextField.text
        let jobText = jobTitleTextField.text
        let start = startYearPlaceholder.text
        let pass = passYearPlaceholder.text
        let jobtype = selectedEmploymentTypeOption?.titleLabel?.text
        
        var isEmpty = false
        
        [cText, jobText, start, pass, jobtype].forEach { x in
            if x == "" {
                isEmpty = true
                let alertController = UIAlertController(title: "Alert!", message: "Fill in all the details", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alertController.addAction(cancelAction)
                
                present(alertController, animated: true, completion: nil)
            }
        }
        
        if isEmpty {
            return
        }
        
        let firstInt = Int(start!)!
        let secondInt = Int(pass!)!
        let combined = Double(firstInt) + Double(secondInt) / 100
        
        let exp = Experience(titleLabel: jobText!, companyNameLabel: cText!, noOfYearsLabel: combined, jobTypeLabel: jobtype!)
        dataArray.append(exp)
        reloadCollectionView()
        
        
    }
    
    @objc func deleteCell(_ sender : UIButton) {
        print(#function)
        guard let cell = sender.superview as? EmploymentCell, // Adjust the number of superviews according to your cell's hierarchy
            let indexPath = employmentsCV.indexPath(for: cell)
        else {
            return
        }
        
        dataArray.remove(at: indexPath.row)
        reloadCollectionView()
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
            bottomView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5),
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
        let vc = ProjectsVC()
        navigationController?.pushViewController(vc, animated: true)
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

extension EmploymentsVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == startTableView {
            return startArray.count
        }
        else {
            return passArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if tableView == startTableView {
            cell.textLabel?.text = startArray[indexPath.row]
        }
        else if tableView == passTableView {
            cell.textLabel?.text = passArray[indexPath.row]
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == startTableView {
            startYearPlaceholder.text = startArray[indexPath.row]
            startYearPlaceholder.textColor = UIColor.black
            startButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            startTableView.isHidden = true
        }
        if tableView == passTableView {
            passYearPlaceholder.text = passArray[indexPath.row]
            passYearPlaceholder.textColor = UIColor.black
            passingButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            passTableView.isHidden = true
        }
    }
    
    
    
    // collectionView delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exp", for: indexPath) as! EmploymentCell
        let exp = dataArray[indexPath.row]
        
        cell.titleLabel.text = exp.titleLabel
        cell.companyNameLabel.text = "| \(exp.companyNameLabel)"
        cell.noOfYearsLabel.text = "\(exp.noOfYearsLabel) Year ,"
        cell.jobTypeLabel.text = exp.jobTypeLabel
        
        cell.deleteButton.addTarget(self, action: #selector(deleteCell(_:)), for: .touchUpInside)
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        cell.layer.cornerRadius = 12
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 80)
    }
}


struct Experience {
    let titleLabel: String
    let companyNameLabel: String
    let noOfYearsLabel: Double
    let jobTypeLabel: String
}
