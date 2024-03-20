//
//  JobSearchResult.swift
//  olousTabBar
//
//  Created by Salt Technologies on 11/03/24.
//

import UIKit

class JobSearchResult: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var topSection : UIView!
    var filterScrollView : UIScrollView!
    var filterOptions = [
        "Workplace": ["All", "Office", "Remote"],
        "Job Type": ["All", "Full-time", "Part-time", "Contract"],
        "Location": ["All", "City", "Suburb", "Remote"]
    ]
    
    var jobsCountLabel : UILabel = {
        let label = UILabel()
        label.text = "267 jobs"
        label.font = .systemFont(ofSize: 14)
        label.tintColor = UIColor(hex: "#344054")
        return label
    }()
    
    var jobsCollectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        setupFilterScrollView()
        setupUI()
        
        setupJobsCountLabel()
        setupJobsCollectionView()
    }
    
    func setupFilterScrollView() {
        
        topSection = UIView()
        
        topSection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topSection)
        NSLayoutConstraint.activate([
            topSection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSection.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        filterScrollView = UIScrollView()
        filterScrollView.translatesAutoresizingMaskIntoConstraints = false
        filterScrollView.showsHorizontalScrollIndicator = false
        
        let contentWidth = (view.frame.width - 48) * CGFloat(3) - 16 // Total width of subviews including spacing
        filterScrollView.contentSize = CGSize(width: contentWidth, height: 80)
        
        filterScrollView.translatesAutoresizingMaskIntoConstraints = false
        topSection.addSubview(filterScrollView)
        NSLayoutConstraint.activate([
            filterScrollView.topAnchor.constraint(equalTo: topSection.topAnchor, constant: 20),
            filterScrollView.leadingAnchor.constraint(equalTo: topSection.leadingAnchor),
            filterScrollView.trailingAnchor.constraint(equalTo: topSection.trailingAnchor),
            filterScrollView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    func setupUI() {
        addFilterButton(title: "Date posted", at: 0)
        addFilterButton(title: "Workplace", at: 1)
        addFilterButton(title: "Job type", at: 2)
        addFilterButton(title: "Sectorrrrrrrrrrrr", at: 3)
        addFilterButton(title: "Experience", at: 4)
        addFilterButton(title: "Salary", at: 5)
        addFilterButton(title: "Profession", at: 6)
    }
    
    func addFilterButton(title: String, at index: Int) {
        let filterButton = UIButton(type: .system)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.layer.borderWidth = 1.0 // Add border
        filterButton.layer.cornerRadius = 8
        filterButton.layer.borderColor = UIColor(hex: "#EAECF0").cgColor // Set border color
        filterButton.contentHorizontalAlignment = .left // Align content to the left
        filterButton.setTitleColor(UIColor(hex: "#344054"), for: .normal)
        filterButton.backgroundColor = .systemBackground
        
        // Set title and drop-down icon
        if let dropDownImage = UIImage(systemName: "chevron.down") {
            let titleWithIcon = NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 16)]) // Customize font size as needed
            let attributedTitle = NSMutableAttributedString(string: "   ") // Add empty spaces at the start
            attributedTitle.append(titleWithIcon)
            
            // Add drop-down icon to the end of the title
            let attachment = NSTextAttachment()
            attachment.image = dropDownImage
            let attachmentString = NSAttributedString(attachment: attachment)
            attributedTitle.append(NSAttributedString(string: " "))
            attributedTitle.append(attachmentString)
            attributedTitle.append(NSAttributedString(string: "   "))
            
            filterButton.setAttributedTitle(attributedTitle, for: .normal)
            filterButton.semanticContentAttribute = .forceRightToLeft
        }
        
        filterScrollView.addSubview(filterButton)
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            filterButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        if index > 0 {
            let previousButton = filterScrollView.subviews[index - 1] // Get the previous button
            filterButton.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 10).isActive = true // Adjust spacing as needed
        } else {
            // For the first button, set its leading anchor to the scroll view's leading anchor
            filterButton.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor, constant: 20).isActive = true // Adjust spacing as needed
        }

        
        filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        filterButton.tag = index // Assign a tag to identify the filter
    }

    
    // MARK: - Filter Button Actions
    @objc func filterButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            workplaceButtonTapped()
        case 1:
            jobTypeButtonTapped()
        case 2:
            locationButtonTapped()
        default:
            break
        }
    }
    
    // Separate methods for handling taps on each button
    func workplaceButtonTapped() {
        // Implement logic for Workplace button tap
        print("Workplace button tapped")
    }
    
    func jobTypeButtonTapped() {
        // Implement logic for Job Type button tap
        print("Job Type button tapped")
    }
    
    func locationButtonTapped() {
        // Implement logic for Location button tap
        print("Location button tapped")
    }
    
    func setupJobsCountLabel() {
        jobsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(jobsCountLabel)
        
        NSLayoutConstraint.activate([
            jobsCountLabel.topAnchor.constraint(equalTo: topSection.bottomAnchor, constant: 6),
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id2", for: indexPath) as! JobsCell
        cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 198)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let jobDetailVC = JobDetailScreen()
        navigationController?.pushViewController(jobDetailVC, animated: true)
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
