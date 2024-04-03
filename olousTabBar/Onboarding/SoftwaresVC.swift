//
//  SoftwaresVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 03/04/24.
//

import UIKit

class SoftwaresVC: UIViewController, UITextFieldDelegate {
    
    var headerView : UIView!
    var circleContainerView : UIView!
    
    var scrollView : UIScrollView!
    
    let softwareTextField = UITextField()
    var softwareArray = ["Java", "C", "C++", "C#", "Programming", "Tekla Structures", "Bentley Systems", "Navisworks", "Infraworks", "Open Building Designer", "Vectorworks landmark"]
    var filteredSoftwareArray : [String] = []
    let softwareTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()
    
    var addedSoftwareView : UIView!
    var addedSoftwareArray : [String] = []
    var addedSoftwareHashSet = Set<String>()
    var addedSoftwareViewHeightConstraint: NSLayoutConstraint!
    
    let suggestionsLabel : UILabel = {
        let label = UILabel()
        label.text = "Suggestions :"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(hex: "#667085")
        return label
    }()
    var suggestedSoftwareView : UIView!
    var suggestedSoftwareArray = ["Dancing", "Singing", "Swimming", "Cooking", "Painting", "Tekla Structures", "Bentley Systems", "Navisworks", "Infraworks", "Open Building Designer"]
    var suggestedSoftwareViewHeightConstraint: NSLayoutConstraint!
    
    var bottomView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        softwareTextField.delegate = self
        softwareTableView.delegate = self
        softwareTableView.dataSource = self
        
        setupViews()
        
    }
    
    func setupViews() {
        setupHeaderView()
        setupScrollView()
        
        setupUI()
        setupAddedSoftwareView()
        setupSuggestedSoftwareView()
        
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
        profileCircleLabel.text = "7/7"
        
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
        let percentage: CGFloat = 7 / 7
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
        titleLabel.text = "Software"
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
    
    func setupUI() {
        let titleLabel : UILabel =  {
            let label = UILabel()
            label.text = "SOFTWARE"
            label.font = .boldSystemFont(ofSize: 20)
            label.textColor = UIColor(hex: "#101828")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(titleLabel)
        
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
        
        softwareTextField.placeholder = "Add softwares"
        softwareTextField.borderStyle = .roundedRect
        softwareTextField.layer.borderWidth = 1
        softwareTextField.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        softwareTextField.layer.cornerRadius = 8
        softwareTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(softwareTextField)
        
        softwareTableView.layer.borderWidth = 1
        softwareTableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        softwareTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(softwareTableView)
        scrollView.bringSubviewToFront(softwareTableView)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            skillsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            skillsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            softwareTextField.topAnchor.constraint(equalTo: skillsLabel.bottomAnchor, constant: 10),
            softwareTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            softwareTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            softwareTextField.heightAnchor.constraint(equalToConstant: 50),
            
            softwareTableView.topAnchor.constraint(equalTo: softwareTextField.bottomAnchor, constant: 10),
            softwareTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            softwareTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            softwareTableView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func setupAddedSoftwareView() {
        addedSoftwareView = UIView()
        addedSoftwareView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(addedSoftwareView)
        NSLayoutConstraint.activate([
            addedSoftwareView.topAnchor.constraint(equalTo: softwareTextField.bottomAnchor, constant: 20),
            addedSoftwareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addedSoftwareView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        addedSoftwareViewHeightConstraint = addedSoftwareView.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        addedSoftwareViewHeightConstraint.isActive = true
    }
    
    func addAllSoftwares() {
        var currentLine = 0
        var currentXPosition: CGFloat = 0
        let buttonHeight: CGFloat = 30
        let buttonSpacing: CGFloat = 12
        let containerViewWidth = UIScreen.main.bounds.width - 32
        var containerViewHeight: CGFloat = 0  // Variable to track the containerView's height

        for option in addedSoftwareArray {
            let optionButton = createButton(withTitle: option)
            // optionButton.addTarget(self, action: #selector(noticeOptionButtonTapped(_:)), for: .touchUpInside)
            
            let buttonWidth = optionButton.intrinsicContentSize.width
            // Check if adding this button exceeds the width of the containerView
            if currentXPosition + buttonWidth + buttonSpacing > containerViewWidth {
                // Move to a new line
                currentLine += 1
                currentXPosition = 0
                // Update containerView's height
                containerViewHeight += buttonHeight + buttonSpacing
                print(containerViewHeight)
            }
            
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            addedSoftwareView.addSubview(optionButton)
            NSLayoutConstraint.activate([
                optionButton.topAnchor.constraint(equalTo: addedSoftwareView.topAnchor, constant: CGFloat(currentLine) * (buttonHeight + buttonSpacing)),
                optionButton.leadingAnchor.constraint(equalTo: addedSoftwareView.leadingAnchor, constant: currentXPosition),
                optionButton.heightAnchor.constraint(equalToConstant: buttonHeight)
                
            ])

            // Update current X position
            currentXPosition += buttonWidth + buttonSpacing
        }
        addedSoftwareViewHeightConstraint.constant = containerViewHeight + 30
        addedSoftwareView.layoutIfNeeded()
    }
    
    private func createButton(withTitle title: String) -> UIButton {
        let optionButton = UIButton(type: .system)
        optionButton.layer.borderWidth = 1
        optionButton.layer.borderColor = UIColor(hex: "#0079C4").cgColor
        optionButton.layer.cornerRadius = 8
        
        let plusSymbolAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 28),
            .baselineOffset: 9
        ]
        let plusSymbolString = NSMutableAttributedString(string: "  +", attributes: plusSymbolAttributes)
        
        let optionTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .baselineOffset: 12
        ]
        let optionTextString = NSMutableAttributedString(string: " \(title)  ", attributes: optionTextAttributes)
        
        let combinedString = NSMutableAttributedString()
        combinedString.append(plusSymbolString)
        combinedString.append(optionTextString)
        
        optionButton.setAttributedTitle(combinedString, for: .normal)
        optionButton.titleLabel?.font = .systemFont(ofSize: 18)
        optionButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        
        return optionButton
    }
    
    func setupSuggestedSoftwareView() {
        suggestionsLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(suggestionsLabel)
        
        suggestedSoftwareView = UIView()
        suggestedSoftwareView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(suggestedSoftwareView)
        
        NSLayoutConstraint.activate([
            suggestionsLabel.topAnchor.constraint(equalTo:addedSoftwareView.bottomAnchor, constant: 20),
            suggestionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            suggestedSoftwareView.topAnchor.constraint(equalTo: suggestionsLabel.bottomAnchor, constant: 10),
            suggestedSoftwareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            suggestedSoftwareView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        suggestedSoftwareViewHeightConstraint = suggestedSoftwareView.heightAnchor.constraint(equalToConstant: 50) // Initial height set to 10
        suggestedSoftwareViewHeightConstraint.isActive = true
        
        addSuggestedSoftware()
    }
    
    func addSuggestedSoftware() {
        var currentLine = 0
        var currentXPosition: CGFloat = 0
        let buttonHeight: CGFloat = 30
        let buttonSpacing: CGFloat = 12
        let containerViewWidth = UIScreen.main.bounds.width - 32
        var containerViewHeight: CGFloat = 0  // Variable to track the containerView's height
        var i = 0
        for option in suggestedSoftwareArray {
            let optionButton = createButton(withTitle: option)
            
            if !addedSoftwareHashSet.contains(option) { // only change color if buttons not already added in skillSet
                optionButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
                optionButton.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
            }
            optionButton.addTarget(self, action: #selector(suggestedSoftwareButtonTapped(_:)), for: .touchUpInside)
            
            let buttonWidth = optionButton.intrinsicContentSize.width
            // Check if adding this button exceeds the width of the containerView
            if currentXPosition + buttonWidth + buttonSpacing > containerViewWidth {
                // Move to a new line
                currentLine += 1
                currentXPosition = 0
                // Update containerView's height
                containerViewHeight += buttonHeight + buttonSpacing
                print(containerViewHeight)
            }
            
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            suggestedSoftwareView.addSubview(optionButton)
            NSLayoutConstraint.activate([
                optionButton.topAnchor.constraint(equalTo: suggestedSoftwareView.topAnchor, constant: CGFloat(currentLine) * (buttonHeight + buttonSpacing)),
                optionButton.leadingAnchor.constraint(equalTo: suggestedSoftwareView.leadingAnchor, constant: currentXPosition),
                optionButton.heightAnchor.constraint(equalToConstant: buttonHeight)
            ])

            // Update current X position
            currentXPosition += buttonWidth + buttonSpacing
            optionButton.tag = i;
            i = i + 1
        }
        suggestedSoftwareViewHeightConstraint.constant = containerViewHeight + 30
        suggestedSoftwareView.layoutIfNeeded()
    }
    
    @objc func suggestedSoftwareButtonTapped(_ sender : UIButton) {
        
        let title = suggestedSoftwareArray[sender.tag]
        if !addedSoftwareHashSet.contains(title) {
            
            addedSoftwareArray.append(title)
            addedSoftwareHashSet.insert(title)
            
            addAllSoftwares()
            
            sender.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            sender.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == softwareTextField {
            let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            filterSkills(with: searchText)
        }
        
        return true
    }
    func filterSkills(with searchText: String) {
        filteredSoftwareArray = softwareArray.filter { $0.lowercased().hasPrefix(searchText.lowercased()) }
        
        // If there are no matching skills, add a special row to prompt the user to add the skill
        if filteredSoftwareArray.isEmpty && !searchText.isEmpty {
            filteredSoftwareArray.append("\(searchText)")
        }
        
        // Show or hide the table view based on the filtered skills count
        softwareTableView.isHidden = filteredSoftwareArray.isEmpty
        
        if !softwareTableView.isHidden {
            scrollView.bringSubviewToFront(softwareTableView)
        }
        
        softwareTableView.reloadData()
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
//        let vc = SkillsVC()
//        navigationController?.pushViewController(vc, animated: true)
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

extension SoftwaresVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredSoftwareArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = filteredSoftwareArray[indexPath.row]
        cell.selectionStyle = .none
        if addedSoftwareHashSet.contains(filteredSoftwareArray[indexPath.row]) {
            cell.backgroundColor = UIColor(hex: "#EAECF0")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if addedSoftwareHashSet.contains(filteredSoftwareArray[indexPath.row]) == false {
            
            addedSoftwareArray.append(filteredSoftwareArray[indexPath.row])
            addedSoftwareHashSet.insert(filteredSoftwareArray[indexPath.row])
            
            addAllSoftwares()
            addSuggestedSoftware()
            
            softwareTextField.text = nil
            softwareTableView.isHidden = true
        }
    }
}
