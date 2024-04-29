//
//  ProjectsVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/04/24.
//

import UIKit

class ProjectsVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var headerView : UIView!
    var circleContainerView : UIView!
    
    var loader: UIActivityIndicatorView!
    var loader2: UIActivityIndicatorView!
    var loader3: UIActivityIndicatorView!
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "ADD YOUR PROJECTS"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hex: "#101828")
        return label
    }()
    
    var scrollView : UIScrollView!
    
    var employmentsCV : UICollectionView!
    var dataArray : [Project] = []
    var employmentsCVHeightConstraint: NSLayoutConstraint!
    
    
    var nameTextField : UITextField!
    var roleTextField : UITextField!
    var descriptionTextView : UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = UIColor(hex: "#344054")
        textView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        textView.layer.borderWidth = 1.0 // Border width
        textView.layer.cornerRadius = 12.0
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Padding
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    var responsibilityTextView : UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = UIColor(hex: "#344054")
        textView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        textView.layer.borderWidth = 1.0 // Border width
        textView.layer.cornerRadius = 12.0
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Padding
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var saveProjectButton : UIButton!
    
    var bottomView : UIView!
    
    
    var editView: UIView!
    var editNameTF: UITextField!
    var editRoleTF: UITextField!
    var editDescTF: UITextView!
    var editRespTF: UITextView!
    var saveButton: UIButton!
    var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        fetchProjects()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loader.style = UIActivityIndicatorView.Style.medium
        loader.hidesWhenStopped = true
        
        loader.translatesAutoresizingMaskIntoConstraints = false // Disable autoresizing mask
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: 60), // Set width to 40
            loader.heightAnchor.constraint(equalToConstant: 60) // Set height to 40
        ])
    }
    
    private func setupLoader2() {
        loader2 = UIActivityIndicatorView(style: .large)
        loader2.center = view.center
        loader2.translatesAutoresizingMaskIntoConstraints = false
        editView.addSubview(loader2)
        
        NSLayoutConstraint.activate([
            loader2.centerXAnchor.constraint(equalTo: editDescTF.centerXAnchor),
            loader2.centerYAnchor.constraint(equalTo: editDescTF.centerYAnchor)
        ])
        
        loader3 = UIActivityIndicatorView(style: .large)
        loader3.center = view.center
        loader3.translatesAutoresizingMaskIntoConstraints = false
        editView.addSubview(loader3)
        
        NSLayoutConstraint.activate([
            loader3.centerXAnchor.constraint(equalTo: editRespTF.centerXAnchor),
            loader3.centerYAnchor.constraint(equalTo: editRespTF.centerYAnchor)
        ])
    }
    
    func setupViews() {
        setupHeaderView()
        setupTitle()
        setupScrollView()
        
        setupProjectsView()
        setupAddProject()
        
        setupBottomView()
        
        setupEditViewComponents()
        setupLoader2()
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
        profileCircleLabel.text = "5/8"
        
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
        let percentage: CGFloat = 5 / 8
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
        titleLabel.text = "Projects"
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
        
        let extraSpaceHeight: CGFloat = 300
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    func setupProjectsView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        employmentsCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        employmentsCV.register(ProjectCell.self, forCellWithReuseIdentifier: "project")
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
        
//        reloadCollectionView()
    }
    
    func reloadCollectionView() {
        employmentsCV.reloadData()
            
        // Calculate the content size
        employmentsCV.layoutIfNeeded()
        let contentSize = employmentsCV.collectionViewLayout.collectionViewContentSize
        
        // Update the height constraint based on content size
        employmentsCVHeightConstraint.constant = contentSize.height
//        print("Content Size ", contentSize.height)
        
        if contentSize.height > 500 {
            let extraSpaceHeight: CGFloat = 400
//            print(extraSpaceHeight)
            
            // Add extra space at the bottom
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
            
            // Calculate content size
            let contentHeight = view.bounds.height + extraSpaceHeight
            scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
        }
        
        if contentSize.height > 1000 {
            var extraSpaceHeight: CGFloat = 800
            if contentSize.height < 1200 {
                extraSpaceHeight = 600
            }
            if contentSize.height > 1500 {
                extraSpaceHeight = 1000
            }
            
            // Add extra space at the bottom
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
            
            // Calculate content size
            let contentHeight = view.bounds.height + extraSpaceHeight
            scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
        }
        
        
        
        
        // Update constraints
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setupAddProject() {
        
        let addNewProjectLabel : UILabel = {
            let label = UILabel()
            label.text = "Add New Project"
            label.font = .boldSystemFont(ofSize: 18)
            label.textColor = UIColor(hex: "#344054")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(addNewProjectLabel)
        
        let projectLabel = UILabel()
        projectLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText2 = NSMutableAttributedString(string: "Project name")
        let asterisk2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText2.append(asterisk2)
        projectLabel.attributedText = attributedText2
        projectLabel.font = .boldSystemFont(ofSize: 16)
        projectLabel.textColor = UIColor(hex: "#344054")
        scrollView.addSubview(projectLabel)
        
        // company TextField
        nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "E.g. Salt Technologies"
        nameTextField.delegate = self // Set delegate for this text field
        scrollView.addSubview(nameTextField)
        
        let roleLabel = UILabel()
        roleLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText3 = NSMutableAttributedString(string: "Role")
        let asterisk3 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText3.append(asterisk3)
        roleLabel.attributedText = attributedText3
        roleLabel.font = .boldSystemFont(ofSize: 16)
        roleLabel.textColor = UIColor(hex: "#344054")
        scrollView.addSubview(roleLabel)
        
        // jobTitle TextField
        roleTextField = UITextField()
        roleTextField.translatesAutoresizingMaskIntoConstraints = false
        roleTextField.borderStyle = .roundedRect
        roleTextField.placeholder = "E.g. Civil Engineer"
        roleTextField.delegate = self // Set delegate for this text field
        scrollView.addSubview(roleTextField)
        
        NSLayoutConstraint.activate([
            addNewProjectLabel.topAnchor.constraint(equalTo: employmentsCV.bottomAnchor, constant: 30),
            addNewProjectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            projectLabel.topAnchor.constraint(equalTo: addNewProjectLabel.bottomAnchor, constant: 15),
            projectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: projectLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            roleLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            roleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            roleTextField.topAnchor.constraint(equalTo: roleLabel.bottomAnchor, constant: 10),
            roleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            roleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            roleTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText4 = NSMutableAttributedString(string: "Description")
        let asterisk4 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText4.append(asterisk4)
        descriptionLabel.attributedText = attributedText4
        descriptionLabel.font = .boldSystemFont(ofSize: 16)
        descriptionLabel.textColor = UIColor(hex: "#344054")
        scrollView.addSubview(descriptionLabel)
        
        scrollView.addSubview(descriptionTextView)
        
        let responsibilityLabel = UILabel()
        responsibilityLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText5 = NSMutableAttributedString(string: "Responsibility")
        let asterisk5 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.baselineOffset: -1]) // Adjust baseline offset as needed
        attributedText5.append(asterisk5)
        responsibilityLabel.attributedText = attributedText5
        responsibilityLabel.font = .boldSystemFont(ofSize: 16)
        responsibilityLabel.textColor = UIColor(hex: "#344054")
        scrollView.addSubview(responsibilityLabel)
        
        scrollView.addSubview(responsibilityTextView)
        
        saveProjectButton = UIButton()
        saveProjectButton.setTitle("Save", for: .normal)
        saveProjectButton.titleLabel?.font = .systemFont(ofSize: 20)
        saveProjectButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        saveProjectButton.backgroundColor = UIColor(hex: "#0079C4")
        saveProjectButton.layer.cornerRadius = 8
        saveProjectButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        saveProjectButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(saveProjectButton)
        
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: roleTextField.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100),
            
            responsibilityLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            responsibilityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            responsibilityTextView.topAnchor.constraint(equalTo: responsibilityLabel.bottomAnchor, constant: 10),
            responsibilityTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            responsibilityTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            responsibilityTextView.heightAnchor.constraint(equalToConstant: 100),
            
            saveProjectButton.topAnchor.constraint(equalTo: responsibilityTextView.bottomAnchor, constant: 20),
            saveProjectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveProjectButton.widthAnchor.constraint(equalToConstant: 80),
            saveProjectButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func saveButtonTapped() {
        let cText = nameTextField.text!
        let jobText = roleTextField.text!
        let start = descriptionTextView.text!
        let pass = responsibilityTextView.text!
        
        var isEmpty = false
        
        [cText, jobText, start, pass].forEach { x in
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
        
//        let project = Project1(name: cText, role: jobText, responsibility: start, description: pass)
        let project = Project(projectName: cText, role: jobText, responsibility: start, description: pass)
        dataArray.append(project)
        
        nameTextField.text = ""
        roleTextField.text = ""
        descriptionTextView.text = ""
        responsibilityTextView.text = ""
        
        reloadCollectionView()
        
        
    }
    
    @objc func deleteCell(_ sender : UIButton) {
        print(#function)
        guard let cell = sender.superview as? ProjectCell, // Adjust the number of superviews according to your cell's hierarchy
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
        uploadProjects()
        let vc = SkillsVC()
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
    
    func setupEditViewComponents() {
        // Initialize and configure editView
        editView = UIView()
        editView.backgroundColor = .white
        editView.layer.cornerRadius = 12
        editView.layer.shadowOpacity = 0.25
        editView.layer.shadowRadius = 5
        editView.layer.shadowOffset = CGSize(width: 0, height: 2)
        editView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(editView)

        // Set initial off-screen position
        NSLayoutConstraint.activate([
            editView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editView.heightAnchor.constraint(equalToConstant: view.frame.height - 100),
            editView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)  // Top of editView to the bottom of the main view
        ])

        // Setup text fields and text views along with labels
        let labelsTitles = ["Project Name", "Role", "Description", "Responsibility"]
        let controls = [UITextField(), UITextField(), UITextView(), UITextView()]
        var lastBottomAnchor = editView.topAnchor
        
        for (index, title) in labelsTitles.enumerated() {
            let label = UILabel()
            label.text = title
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            editView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: lastBottomAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: 16)
            ])
            
            let control = controls[index]
            control.translatesAutoresizingMaskIntoConstraints = false
            editView.addSubview(control)
            
            if let textField = control as? UITextField {
                textField.borderStyle = .roundedRect
                textField.placeholder = "Enter \(title)"
                NSLayoutConstraint.activate([
                    textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                    textField.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: 16),
                    textField.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -16)
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
                    textView.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: 16),
                    textView.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -16),
                    textView.heightAnchor.constraint(equalToConstant: 120)  // Fixed height for UITextView
                ])
                lastBottomAnchor = textView.bottomAnchor
                
                let generateButton = createGenerateButton()
                if index == 2 {
                    generateButton.addTarget(self, action: #selector(generateDescription), for: .touchUpInside)
                } else if index == 3 {
                    generateButton.addTarget(self, action: #selector(generateResponsibility), for: .touchUpInside)
                }
                
                editView.addSubview(generateButton)
                NSLayoutConstraint.activate([
                    generateButton.topAnchor.constraint(equalTo: label.topAnchor, constant: -3),
                    generateButton.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -16),
                    generateButton.heightAnchor.constraint(equalToConstant: 36),
                    generateButton.widthAnchor.constraint(equalToConstant: 180),
                ])
            }
            
            if index == 0 {
                editNameTF = control as? UITextField
            } else if index == 1 {
                editRoleTF = control as? UITextField
            } else if index == 2 {
                editDescTF = control as? UITextView
            } else if index == 3 {
                editRespTF = control as? UITextView
            }
        }

        setupSaveAndCancelButtons()  // A separate method for setting up buttons
    }

    func setupSaveAndCancelButtons() {
        // Assume saveButton and cancelButton are already initialized
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 20)
        saveButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        saveButton.backgroundColor = UIColor(hex: "#0079C4")
        saveButton.layer.cornerRadius = 8
        saveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        
        
        
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 20)
        cancelButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        cancelButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 8
        cancelButton.addTarget(self, action: #selector(cancelEdit), for: .touchUpInside)
        
        // Layout
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        editView.addSubview(saveButton)
        editView.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: editView.bottomAnchor, constant: -60),
            saveButton.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -20),
            saveButton.widthAnchor.constraint(equalToConstant: 80),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            cancelButton.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalToConstant: 80),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
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
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }


    @objc func generateDescription() {
        if let text = editDescTF.text {
            fetchContentAndUpdateTextView(forURL: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/candidate/project-description",
                                          withText: editNameTF.text ?? "", updateTextView: editDescTF)
        }
    }

    @objc func generateResponsibility() {
        if let text = editRespTF.text {
            fetchContentAndUpdateTextView(forURL: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/candidate/project-responsibility",
                                          withText: editNameTF.text ?? "", updateTextView: editRespTF)
        }
    }
    
    func fetchContentAndUpdateTextView(forURL urlString: String, withText text: String, updateTextView textView: UITextView) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        if textView == editDescTF {
            DispatchQueue.main.async {
                self.loader2.startAnimating()  // Start the loader before the request
            }
        }
        if textView == editRespTF {
            DispatchQueue.main.async {
                self.loader3.startAnimating()  // Start the loader before the request
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
            if textView == self.editDescTF {
                DispatchQueue.main.async {
                    self.loader2.stopAnimating()  // Start the loader before the request
                }
            }
            if textView == self.editRespTF {
                DispatchQueue.main.async {
                    self.loader3.stopAnimating()  // Start the loader before the request
                }
            }
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let responseString = String(data: data, encoding: .utf8) {
                if textView == self.editDescTF {
                    DispatchQueue.main.async {
                        var s = responseString
                        if s.hasPrefix("\"") {
                            s = String(s.dropFirst().dropLast())
                        }
                        textView.text = s  // Update the UITextView on the main thread
                    }
                }
                if textView == self.editRespTF {
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

    
    @objc func saveChanges() {
        guard let selectedIndexPath = employmentsCV.indexPathsForSelectedItems?.first else { return }
        
        // Ensure all fields are non-empty
        guard let name = editNameTF.text, !name.isEmpty,
              let role = editRoleTF.text, !role.isEmpty,
              let desc = editDescTF.text, !desc.isEmpty,
              let resp = editRespTF.text, !resp.isEmpty else {
            showAlert(withTitle: "Missing Information", message: "Please fill all the fields")
            return
        }
        
        let updatedProject = Project(projectName: name, role: role, responsibility: resp, description: desc)
        
        // Update the data array and reload the specific item
        dataArray[selectedIndexPath.row] = updatedProject
        employmentsCV.reloadItems(at: [selectedIndexPath])
        dismissEditView()
    }

    @objc func cancelEdit() {
        dismissEditView()
    }
    
    @objc func dismissEditView() {
        UIView.animate(withDuration: 0.3) {
            self.editView.transform = .identity
        }
    }
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

}

extension ProjectsVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "project", for: indexPath) as! ProjectCell
        let project = dataArray[indexPath.row]
        
        cell.projectName.text = project.projectName
        cell.projectRole.text = project.role
        cell.projectDescription.text = project.description
        cell.projectResponsibility.text = project.responsibility
        
        cell.deleteButton.addTarget(self, action: #selector(deleteCell(_:)), for: .touchUpInside)
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        cell.layer.cornerRadius = 12
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let project = dataArray[indexPath.row]

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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let project = dataArray[indexPath.row]
        editNameTF.text = project.projectName
        editRoleTF.text = project.role
        editDescTF.text = project.description
        editRespTF.text = project.responsibility
        
        UIView.animate(withDuration: 0.3) {
            self.editView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height + 118)  // Move up by 300 points
        }
    }
}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}


struct Project1 {
    let name: String
    let role: String
    let responsibility: String
    let description: String
}


extension ProjectsVC {
    
    
    func fetchProjects() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/user/candidate/projects") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
            self.loader.startAnimating()
            self.scrollView.alpha = 0
            print("Loader should be visible now")
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            do {
                let outerResponse = try JSONDecoder().decode(ProjectsResponse.self, from: data)
                let projectsString = outerResponse.softwares
                
                // Extract the JSON part directly
                if let jsonStartIndex = projectsString.range(of: "\\[", options: .regularExpression)?.lowerBound {
                    let jsonPart = String(projectsString[jsonStartIndex...])
                    if let projectsData = jsonPart.data(using: .utf8) {
                        let projects = try JSONDecoder().decode([Project].self, from: projectsData)
                        DispatchQueue.main.async {
                            print("Fetched Projects: \(projects)")
                            self.dataArray = projects
                            self.reloadCollectionView()
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Failed to decode JSON: \(error)")
                    self.fetchProjects()
                }
            }
            
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.scrollView.alpha = 1
                print("Loader stopped")
            }
        }.resume()
    }
    
    func uploadProjects() {
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
            let projectsData = ["projects": dataArray]
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
    
}
