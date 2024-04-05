//
//  SoftwaresVC.swift
//  olousTabBar
//
//  Created by Salt Technologies on 03/04/24.
//


// copied from skillsVC so naming will be same with that

import UIKit

class SoftwaresVC: UIViewController, UITextFieldDelegate {

    var headerView : UIView!
    var circleContainerView : UIView!
    
    var scrollView : UIScrollView!
    
    let skillsTextField = UITextField()
    var skillsArray = ["Java", "C", "C++", "C#", "Swift", "Tekla", "iOS", "UIKit", "Programming", "C-Sharp", "Programming2", "Programming3"]
    var filteredSkillsArray : [String] = []
    let skillsTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()
    
    var addedSkillsView : UICollectionView!
    var addedSkillsArray : [String] = []
    var addedSkillsHashSet = Set<String>()
    var addedSkillsViewHeightConstraint: NSLayoutConstraint!
    
    let suggestionsLabel : UILabel = {
        let label = UILabel()
        label.text = "Suggestions :"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(hex: "#667085")
        return label
    }()
    var suggestedSkillsView : UICollectionView!
    var suggestedSkillsHashSet = Set<String>()
    var suggestedSkillsArray = [ "Swimming", "Cooking", "Painting", "Tekla", "NavisWorks", "Bentley Systems", "Programming", "Infraworks"]
    var suggestedSkillsViewHeightConstraint: NSLayoutConstraint!
    
    var bottomView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
        skillsTextField.delegate = self
        skillsTableView.delegate = self
        skillsTableView.dataSource = self
        
        
        
        setupViews()
    }
    
    func setupViews() {
        setupHeaderView()
        setupScrollView()
        
        setupUI()
        setupAddedSkillsView()
        setupSuggestedSkillsView()
        
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
        let percentage: CGFloat = 6.9 / 7
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
        titleLabel.text = "Softwares"
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
        
        skillsTextField.placeholder = "Add skills"
        skillsTextField.borderStyle = .roundedRect
        skillsTextField.layer.borderWidth = 1
        skillsTextField.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        skillsTextField.layer.cornerRadius = 8
        skillsTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(skillsTextField)
        
        skillsTableView.layer.borderWidth = 1
        skillsTableView.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
        skillsTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(skillsTableView)
        scrollView.bringSubviewToFront(skillsTableView)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            skillsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            skillsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            skillsTextField.topAnchor.constraint(equalTo: skillsLabel.bottomAnchor, constant: 10),
            skillsTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skillsTextField.heightAnchor.constraint(equalToConstant: 50),
            
            skillsTableView.topAnchor.constraint(equalTo: skillsTextField.bottomAnchor, constant: 10),
            skillsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skillsTableView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func setupAddedSkillsView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        addedSkillsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addedSkillsView.register(Skill_Software_Cell.self, forCellWithReuseIdentifier: "skill1")
        addedSkillsView.delegate = self
        addedSkillsView.dataSource = self
        
        addedSkillsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(addedSkillsView)
        NSLayoutConstraint.activate([
            addedSkillsView.topAnchor.constraint(equalTo: skillsTextField.bottomAnchor, constant: 20),
            addedSkillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addedSkillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        addedSkillsViewHeightConstraint = addedSkillsView.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        addedSkillsViewHeightConstraint.isActive = true
        
        reloadAddedSkills()
    }
    
    func reloadAddedSkills() {
        addedSkillsView.reloadData()
            
        // Calculate the content size
        addedSkillsView.layoutIfNeeded()
        let contentSize = addedSkillsView.collectionViewLayout.collectionViewContentSize
        
        // Update the height constraint based on content size
        addedSkillsViewHeightConstraint.constant = contentSize.height
        
        // Update constraints
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    func setupSuggestedSkillsView() {
        suggestionsLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(suggestionsLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        suggestedSkillsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        suggestedSkillsView.register(Skill_Software_Cell.self, forCellWithReuseIdentifier: "skill1")
        suggestedSkillsView.delegate = self
        suggestedSkillsView.dataSource = self
        
        suggestedSkillsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(suggestedSkillsView)
        
        NSLayoutConstraint.activate([
            suggestionsLabel.topAnchor.constraint(equalTo:addedSkillsView.bottomAnchor, constant: 20),
            suggestionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            suggestedSkillsView.topAnchor.constraint(equalTo: suggestionsLabel.bottomAnchor, constant: 10),
            suggestedSkillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            suggestedSkillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        suggestedSkillsViewHeightConstraint = suggestedSkillsView.heightAnchor.constraint(equalToConstant: 0) // Initial height set to 10
        suggestedSkillsViewHeightConstraint.isActive = true
        
        reloadSuggestedSkills()
    }
    
    func reloadSuggestedSkills() {
        suggestedSkillsView.reloadData()
            
        // Calculate the content size
        suggestedSkillsView.layoutIfNeeded()
        let contentSize = suggestedSkillsView.collectionViewLayout.collectionViewContentSize
        
        // Update the height constraint based on content size
        suggestedSkillsViewHeightConstraint.constant = contentSize.height
        
        // Update constraints
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == skillsTextField {
            let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            filterSkills(with: searchText)
        }
        
        return true
    }
    func filterSkills(with searchText: String) {
        filteredSkillsArray = skillsArray.filter { $0.lowercased().hasPrefix(searchText.lowercased()) }
        
        // If there are no matching skills, add a special row to prompt the user to add the skill
        if filteredSkillsArray.isEmpty && !searchText.isEmpty {
            filteredSkillsArray.append("\(searchText)")
        }
        
        // Show or hide the table view based on the filtered skills count
        skillsTableView.isHidden = filteredSkillsArray.isEmpty
        
        if !skillsTableView.isHidden {
            scrollView.bringSubviewToFront(skillsTableView)
        }
        
        skillsTableView.reloadData()
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
//        let vc = SoftwaresVC()
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

extension SoftwaresVC : UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == suggestedSkillsView {
            return suggestedSkillsArray.count
        }
        return addedSkillsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skill1", for: indexPath) as! Skill_Software_Cell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        if collectionView == addedSkillsView {
            cell.textLabel.text = "  \(addedSkillsArray[indexPath.row])"
            cell.symbolLabel.text = "  X"
            cell.layer.borderColor = UIColor(hex: "#0079C4").cgColor
            cell.textLabel.textColor = UIColor(hex: "#0079C4")
            cell.symbolLabel.textColor = UIColor(hex: "#0079C4")
        }
        else {
            if addedSkillsHashSet.contains(suggestedSkillsArray[indexPath.row]) {
                cell.layer.borderColor = UIColor(hex: "#0079C4").cgColor
                cell.textLabel.textColor = UIColor(hex: "#0079C4")
                cell.symbolLabel.textColor = UIColor(hex: "#0079C4")
            }
            else {
                cell.layer.borderColor = UIColor(hex: "#D0D5DD").cgColor
                cell.textLabel.textColor = UIColor(hex: "#98A2B3")
                cell.symbolLabel.textColor = UIColor(hex: "#344054")
            }
            
            cell.textLabel.text = " +"
            cell.textLabel.font = .boldSystemFont(ofSize: 20)
            cell.symbolLabel.text =  " \(suggestedSkillsArray[indexPath.row])"
            cell.symbolLabel.font = .systemFont(ofSize: 16)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var text = ""
        var width : CGFloat
        if collectionView == addedSkillsView {
            text = addedSkillsArray[indexPath.row]
            width = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width
        }
        else {
            text = suggestedSkillsArray[indexPath.row]
            width = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width + 2
        }
        // Adjust spacing
        return CGSize(width: width + 40, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == addedSkillsView {
            let t = addedSkillsArray[indexPath.row]
            addedSkillsArray.remove(at: indexPath.row)
            addedSkillsHashSet.remove(t)
            if suggestedSkillsArray.contains(t) {
                reloadSuggestedSkills()
            }
            reloadAddedSkills()
        }
        else {
            let t = suggestedSkillsArray[indexPath.row]
            if !addedSkillsHashSet.contains(t) {
                addedSkillsArray.append(t)
                addedSkillsHashSet.insert(t)
                
                reloadAddedSkills()
                reloadSuggestedSkills()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredSkillsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = filteredSkillsArray[indexPath.row]
        cell.selectionStyle = .none
        if addedSkillsHashSet.contains(filteredSkillsArray[indexPath.row]) {
            cell.backgroundColor = UIColor(hex: "#EAECF0")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if addedSkillsHashSet.contains(filteredSkillsArray[indexPath.row]) == false {
            
            addedSkillsArray.append(filteredSkillsArray[indexPath.row])
            addedSkillsHashSet.insert(filteredSkillsArray[indexPath.row])
            
            reloadAddedSkills()
            reloadSuggestedSkills()
            
            skillsTextField.text = nil
            skillsTableView.isHidden = true
        }
    }
}

