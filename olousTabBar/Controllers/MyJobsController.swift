//
//  JobsController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class MyJobsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var isSelected : String = "Recommended"
    var savedJobs = [IndexPath]()
    
    enum CollectionState {
        case recommended
        case applied
        case saved
    }
    var collectionState: CollectionState = .recommended {
        didSet {
            // Reload collection view data when collectionState changes
            jobsCollectionView.reloadData()
        }
    }
    
    var notificationBellIcon : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "bell")
        imgView.tintColor = UIColor(hex: "#000000")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    var categorySection = UIView()
    var recommendedButton : UIButton = {
        let button = UIButton()
        button.setTitle("Recommended", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(hex: "#475467"), for: .normal)
        return button
    }()
    var appliedButton : UIButton = {
        let button = UIButton()
        button.setTitle("Applied", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(hex: "#475467"), for: .normal)
        return button
    }()
    var savedButton : UIButton = {
        let button = UIButton()
        button.setTitle("Saved", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(hex: "#475467"), for: .normal)
        return button
    }()
    
    let lineView = UIView()
    var leadingConstraint: NSLayoutConstraint!
    var widthConstraint: NSLayoutConstraint!
    
    
    var jobsCountLabel : UILabel = {
        let label = UILabel()
        label.text = "26 recommended jobs"
        label.font = .systemFont(ofSize: 14)
        label.tintColor = UIColor(hex: "#344054")
        return label
    }()
    
    var jobsCollectionView : UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isSelected == "Recommended" {
            recommendedButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        }
        setupViews()
    }
    
    func setupViews() {
        setupBellIcon()
        setupCategorySection()
        setupLineView()
        setupJobsCountLabel()
        setupJobsCollectionView()
    }
    
    func setupBellIcon() {
        notificationBellIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notificationBellIcon)
        NSLayoutConstraint.activate([
            notificationBellIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            notificationBellIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            notificationBellIcon.widthAnchor.constraint(equalToConstant: 30),
            notificationBellIcon.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupCategorySection() {
        categorySection.backgroundColor = UIColor(hex: "#C7EAFF")
        categorySection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categorySection)
        
        NSLayoutConstraint.activate([
            categorySection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            categorySection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categorySection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categorySection.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        recommendedButton.addTarget(self, action: #selector(didTapRecommendedButton), for: .touchUpInside)
        recommendedButton.translatesAutoresizingMaskIntoConstraints = false
        categorySection.addSubview(recommendedButton)
        
        NSLayoutConstraint.activate([
            recommendedButton.topAnchor.constraint(equalTo: categorySection.topAnchor, constant: 15),
            recommendedButton.leadingAnchor.constraint(equalTo: categorySection.leadingAnchor, constant: 16),
            recommendedButton.widthAnchor.constraint(equalToConstant: 130),
            recommendedButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        appliedButton.addTarget(self, action: #selector(didTapAppliedButton), for: .touchUpInside)
        appliedButton.translatesAutoresizingMaskIntoConstraints = false
        categorySection.addSubview(appliedButton)
        
        NSLayoutConstraint.activate([
            appliedButton.topAnchor.constraint(equalTo: categorySection.topAnchor, constant: 15),
            appliedButton.leadingAnchor.constraint(equalTo: recommendedButton.trailingAnchor, constant: 36),
            appliedButton.widthAnchor.constraint(equalToConstant: 70),
            appliedButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        savedButton.addTarget(self, action: #selector(didTapSavedButton), for: .touchUpInside)
        savedButton.translatesAutoresizingMaskIntoConstraints = false
        categorySection.addSubview(savedButton)
        
        NSLayoutConstraint.activate([
            savedButton.topAnchor.constraint(equalTo: categorySection.topAnchor, constant: 15),
            savedButton.leadingAnchor.constraint(equalTo: appliedButton.trailingAnchor, constant: 32),
            savedButton.widthAnchor.constraint(equalToConstant: 70),
            savedButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        lineView.backgroundColor = UIColor(hex: "#0079C4")
        
        lineView.topAnchor.constraint(equalTo: categorySection.topAnchor, constant: 47).isActive = true
        leadingConstraint = lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        leadingConstraint.isActive = true
        widthConstraint = lineView.widthAnchor.constraint(equalToConstant: 130)
        widthConstraint.isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    func setupJobsCountLabel() {
        jobsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(jobsCountLabel)
        
        NSLayoutConstraint.activate([
            jobsCountLabel.topAnchor.constraint(equalTo: categorySection.bottomAnchor, constant: 20),
            jobsCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jobsCountLabel.heightAnchor.constraint(equalToConstant: 128),
            jobsCountLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setupJobsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        jobsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        jobsCollectionView.register(JobsCell.self, forCellWithReuseIdentifier: "id2")
        
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
        
        jobsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(jobsCollectionView)
        
        NSLayoutConstraint.activate([
            jobsCollectionView.topAnchor.constraint(equalTo: jobsCountLabel.bottomAnchor, constant: 20),
            jobsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jobsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            jobsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id2", for: indexPath) as! JobsCell
        cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        cell.saveButton.addTarget(self, action: #selector(didTapSaveJobButton(_:)), for: .touchUpInside)
        cell.saveButton.tag = indexPath.row
        
        if savedJobs.contains(indexPath) {
            let attributedString = getAttributedString(image: "bookmark.fill", tintColor: UIColor(hex: "#667085"))
            cell.saveButton.tintColor = UIColor(hex: "#667085")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        else {
            let attributedString = getAttributedString(image: "bookmark",tintColor: UIColor(hex: "#475467"))
            cell.saveButton.tintColor = UIColor(hex: "#475467")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionState {
        case .recommended:
            return 10
        case .applied:
            return 5
        case .saved:
            return savedJobs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 198)
    }
    
    @objc func didTapSaveJobButton(_ sender : UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        guard let cell = jobsCollectionView.cellForItem(at: indexPath) as? JobsCell else {
            return
        }
            
        if savedJobs.contains(indexPath) == false {
            savedJobs.append(indexPath)
            
            let attributedString = getAttributedString(image: "bookmark.fill", tintColor: UIColor(hex: "#667085"))
            cell.saveButton.tintColor = UIColor(hex: "#667085")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        else {
            if let indexToRemove = savedJobs.firstIndex(where: { $0 == indexPath }) {
                savedJobs.remove(at: indexToRemove)
            }
            let attributedString = getAttributedString(image: "bookmark", tintColor: UIColor(hex: "#475467"))
            cell.saveButton.tintColor = UIColor(hex: "#475467")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
            
        }
    }
    
    func getAttributedString(image: String, tintColor: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        
        let symbolAttachment = NSTextAttachment()
        symbolAttachment.image = UIImage(systemName: image)?.withTintColor(tintColor)
        
        let symbolString = NSAttributedString(attachment: symbolAttachment)
        attributedString.append(symbolString)
        
        attributedString.append(NSAttributedString(string: " "))
        
        let textString = NSAttributedString(string: "Save")
        attributedString.append(textString)
        
        return attributedString
    }
    
    @objc func didTapRecommendedButton() {
        if isSelected != "Recommended" {
            isSelected = "Recommended"
            recommendedButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            appliedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            savedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            
            UIView.animate(withDuration: 0.5) {
                self.leadingConstraint.constant = 16
                self.widthConstraint.constant = 130
                self.view.layoutIfNeeded()
            }
        }
        collectionState = .recommended
        jobsCountLabel.text = "26 recommended jobs"
    }
    
    @objc func didTapAppliedButton() {
        if isSelected != "Applied" {
            isSelected = "Applied"
            appliedButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            recommendedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            savedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            
            UIView.animate(withDuration: 0.5) {
                self.leadingConstraint.constant = 182
                self.widthConstraint.constant = 68
                self.view.layoutIfNeeded()
            }
        }
        collectionState = .applied
        jobsCountLabel.text = "10 applied jobs"
    }
    
    @objc func didTapSavedButton() {
        if isSelected != "Saved" {
            isSelected = "Saved"
            savedButton.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
            recommendedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            appliedButton.setTitleColor(UIColor(hex: "#475467"), for: .normal)
            
            UIView.animate(withDuration: 0.5) {
                self.leadingConstraint.constant = 290
                self.widthConstraint.constant = 60
                self.view.layoutIfNeeded()
            }
        }
        collectionState = .saved
        jobsCountLabel.text = "\(savedJobs.count) saved jobs"
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let jobDetailVC = JobDetailScreen()
        navigationController?.pushViewController(jobDetailVC, animated: true)
    }

}
