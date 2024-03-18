//
//  HomeController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
// ************************************** Variables ***************************************
    
    
    let scrollView = UIScrollView()
    var jobsArray : [String] = ["a", "ab", "abc", "y", "yz"];
    
    var headerView : UIView = UIView()
    var olousLogo : UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "OlousLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var notificationBellIcon : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "bell")
        imgView.tintColor = UIColor(hex: "#000000")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    var jobSearchSection : UIView = UIView()
    
    var jobSearchInnerSection : UIView = UIView()
    
    let jobsTextField = UITextField()
    let locationTextField = UITextField()
    
    var recommendedJobsView = UIView()
    var recommendedJobsCollectionVC : UICollectionView!
    var viewAllJobsButton : UIButton = {
        let button = UIButton()
        button.setTitle("View all", for: .normal)
        button.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        return button
    }()
    
    let separatorLine2 = UIView()
    
    
    var topCompaniesView = UIView()
    var companiesCollectionVC : UICollectionView!
    var viewAllCompaniesButton : UIButton = {
        let button = UIButton()
        button.setTitle("View all", for: .normal)
        button.setTitleColor(UIColor(hex: "#0079C4"), for: .normal)
        return button
    }()
    
    
// *********************** View Did Load ***************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHeaderView()
        setupOlousLogo()
        setupBellIcon()
        setupScrollView()
        setupJobSearchSection()
        setupJobSearchInnerSection()
        setupSeparatorView1()
        
        setupRecommendedJobsView()
        
        
        
        setupSeparatorView2()
        setupTopCompaniesView()
        
        
        
        
        navigationController?.navigationBar.isHidden = true
    }
    
    
// ************************************ Functions *******************************************
    
    func setupHeaderView() {
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupOlousLogo() {
        olousLogo.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(olousLogo)
        
        NSLayoutConstraint.activate([
            olousLogo.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            olousLogo.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            olousLogo.widthAnchor.constraint(equalToConstant: 150),
            olousLogo.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupBellIcon() {
        notificationBellIcon.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(notificationBellIcon)
        NSLayoutConstraint.activate([
            notificationBellIcon.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 4),
            notificationBellIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            notificationBellIcon.widthAnchor.constraint(equalToConstant: 30),
            notificationBellIcon.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        let extraSpaceHeight: CGFloat = 100
        
        // Add extra space at the bottom
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: extraSpaceHeight, right: 0)
        
        // Calculate content size
        let contentHeight = view.bounds.height + extraSpaceHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }

    func setupJobSearchSection() {
        jobSearchSection.backgroundColor = UIColor(hex: "#0079C4")
        // #007AFF systemBlue
        jobSearchSection.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(jobSearchSection)
        
        NSLayoutConstraint.activate([
            jobSearchSection.topAnchor.constraint(equalTo: scrollView.topAnchor),
            jobSearchSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            jobSearchSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            jobSearchSection.heightAnchor.constraint(equalToConstant: 164)
        ])
    }
    
    func setupJobSearchInnerSection() {
        jobSearchInnerSection.backgroundColor = .systemBackground
        jobSearchInnerSection.layer.cornerRadius = 12
        jobSearchInnerSection.translatesAutoresizingMaskIntoConstraints = false
        jobSearchSection.addSubview(jobSearchInnerSection)
        
        NSLayoutConstraint.activate([
            jobSearchInnerSection.topAnchor.constraint(equalTo: jobSearchSection.topAnchor, constant: 32),
            jobSearchInnerSection.leadingAnchor.constraint(equalTo: jobSearchSection.leadingAnchor, constant: 16),
            jobSearchInnerSection.trailingAnchor.constraint(equalTo: jobSearchSection.trailingAnchor, constant: -16),
            jobSearchInnerSection.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let searchIcon : UIImageView = UIImageView()
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.tintColor = UIColor(hex: "#667085")
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(searchIcon)
        
        NSLayoutConstraint.activate([
            searchIcon.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 14),
            searchIcon.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 16),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor(hex: "#EAECF0")
        jobSearchInnerSection.addSubview(separatorLine)
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorLine.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor).isActive = true
        separatorLine.trailingAnchor.constraint(equalTo: jobSearchInnerSection.trailingAnchor).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: jobSearchInnerSection.bottomAnchor, constant: -49).isActive = true
        
        
        jobsTextField.placeholder = "Enter Job Title"
        jobsTextField.isUserInteractionEnabled = false
        jobsTextField.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(jobsTextField)
        
        NSLayoutConstraint.activate([
            jobsTextField.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 14),
            jobsTextField.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 46),
            jobsTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            jobsTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let locationIcon : UIImageView = UIImageView()
        locationIcon.image = UIImage(named: "locationLogo")
        locationIcon.tintColor = UIColor(hex: "#667085")
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(locationIcon)
        
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 63),
            locationIcon.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 18),
            locationIcon.widthAnchor.constraint(equalToConstant: 21),
            locationIcon.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        locationTextField.placeholder = "Enter Location"
        locationTextField.isUserInteractionEnabled = false
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        jobSearchInnerSection.addSubview(locationTextField)
        
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: jobSearchInnerSection.topAnchor, constant: 63),
            locationTextField.leadingAnchor.constraint(equalTo: jobSearchInnerSection.leadingAnchor, constant: 47),
            locationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 94),
            locationTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapJobSearchInnerSection))
        jobSearchInnerSection.addGestureRecognizer(tap)
    }
    
    @objc func didTapJobSearchInnerSection() {
        let jobSearchVC = JobSearchScreen()
        navigationController?.pushViewController(jobSearchVC, animated: true)
    }
    
    func setupSeparatorView1() {
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor(hex: "#F9FAFB")
//        separatorLine.backgroundColor = .systemGray4
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: jobSearchSection.bottomAnchor),
            separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 8)
        ])
        
    }
    
    
    func setupRecommendedJobsView() {
        recommendedJobsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(recommendedJobsView)
        
        NSLayoutConstraint.activate([
            recommendedJobsView.topAnchor.constraint(equalTo: jobSearchSection.bottomAnchor, constant: 16),
            recommendedJobsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recommendedJobsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recommendedJobsView.heightAnchor.constraint(equalToConstant: 278)
        ])
        
        let label = UILabel()
        label.text = "Recommended Jobs"
        label.font = .boldSystemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        recommendedJobsView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: recommendedJobsView.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: recommendedJobsView.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        viewAllJobsButton.addTarget(self, action: #selector(didTapViewAllJobs), for: .touchUpInside)
        viewAllJobsButton.translatesAutoresizingMaskIntoConstraints = false
        recommendedJobsView.addSubview(viewAllJobsButton)
        
        NSLayoutConstraint.activate([
            viewAllJobsButton.topAnchor.constraint(equalTo: recommendedJobsView.topAnchor, constant: 10),
            viewAllJobsButton.leadingAnchor.constraint(equalTo: recommendedJobsView.leadingAnchor, constant: view.frame.width - 93),
            viewAllJobsButton.widthAnchor.constraint(equalToConstant: 73),
            viewAllJobsButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        setupRecommendedJobsCollectionVC()
    }
    @objc func didTapViewAllJobs() {
        tabBarController?.selectedIndex = 1
        UIView.transition(with: tabBarController!.view!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    func setupRecommendedJobsCollectionVC() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        recommendedJobsCollectionVC = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recommendedJobsCollectionVC.register(JobsCell.self, forCellWithReuseIdentifier: "id2")
        recommendedJobsCollectionVC.showsHorizontalScrollIndicator = false
        
        recommendedJobsCollectionVC.dataSource = self
        recommendedJobsCollectionVC.delegate = self
        
        recommendedJobsCollectionVC.translatesAutoresizingMaskIntoConstraints = false
        recommendedJobsView.addSubview(recommendedJobsCollectionVC)
        
        NSLayoutConstraint.activate([
            recommendedJobsCollectionVC.topAnchor.constraint(equalTo: recommendedJobsView.topAnchor, constant: 60),
            recommendedJobsCollectionVC.leadingAnchor.constraint(equalTo: recommendedJobsView.leadingAnchor, constant: 16),
            recommendedJobsCollectionVC.trailingAnchor.constraint(equalTo: recommendedJobsView.trailingAnchor),
            recommendedJobsCollectionVC.bottomAnchor.constraint(equalTo: recommendedJobsView.bottomAnchor, constant: -19)
        ])
    }
    
    
    func setupSeparatorView2() {
        
        separatorLine2.backgroundColor = UIColor(hex: "#F9FAFB")
        
        separatorLine2.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(separatorLine2)
        
        NSLayoutConstraint.activate([
            separatorLine2.topAnchor.constraint(equalTo: recommendedJobsView.bottomAnchor),
            separatorLine2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine2.heightAnchor.constraint(equalToConstant: 8)
        ])
        
    }
    
    
    func setupTopCompaniesView() {
        
        topCompaniesView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(topCompaniesView)
        
        NSLayoutConstraint.activate([
            topCompaniesView.topAnchor.constraint(equalTo: separatorLine2.bottomAnchor, constant: 28),
            topCompaniesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topCompaniesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topCompaniesView.heightAnchor.constraint(equalToConstant: 261)
        ])
        
        let label = UILabel()
        label.text = "Top Companies"
        label.font = .boldSystemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        topCompaniesView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topCompaniesView.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: topCompaniesView.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: 170),
            label.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        viewAllCompaniesButton.addTarget(self, action: #selector(didTapViewAllCompanies), for: .touchUpInside)
        viewAllCompaniesButton.translatesAutoresizingMaskIntoConstraints = false
        topCompaniesView.addSubview(viewAllCompaniesButton)
        
        NSLayoutConstraint.activate([
            viewAllCompaniesButton.topAnchor.constraint(equalTo: topCompaniesView.topAnchor, constant: 10),
            viewAllCompaniesButton.leadingAnchor.constraint(equalTo: topCompaniesView.leadingAnchor, constant: view.frame.width - 93),
            viewAllCompaniesButton.widthAnchor.constraint(equalToConstant: 73),
            viewAllCompaniesButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        setupCompaniesCollectionVC()
    }
    @objc func didTapViewAllCompanies() {
        print(#function)
    }
    func setupCompaniesCollectionVC() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        companiesCollectionVC = UICollectionView(frame: .zero, collectionViewLayout: layout)
        companiesCollectionVC.register(CompaniesCell.self, forCellWithReuseIdentifier: "id")
        companiesCollectionVC.showsHorizontalScrollIndicator = false
        
        companiesCollectionVC.dataSource = self
        companiesCollectionVC.delegate = self
        
        companiesCollectionVC.translatesAutoresizingMaskIntoConstraints = false
        topCompaniesView.addSubview(companiesCollectionVC)
        
        NSLayoutConstraint.activate([
            companiesCollectionVC.topAnchor.constraint(equalTo: topCompaniesView.topAnchor, constant: 60),
            companiesCollectionVC.leadingAnchor.constraint(equalTo: topCompaniesView.leadingAnchor, constant: 16),
            companiesCollectionVC.trailingAnchor.constraint(equalTo: topCompaniesView.trailingAnchor),
            companiesCollectionVC.bottomAnchor.constraint(equalTo: topCompaniesView.bottomAnchor, constant: -19)
        ])
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == companiesCollectionVC {
            return 10
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == companiesCollectionVC {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! CompaniesCell
            cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 12
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id2", for: indexPath) as! JobsCell
            cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 12
            cell.saveButton.isHidden = true
            cell.jobExperienceLabel.isHidden = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == companiesCollectionVC {
            return .init(width: 228, height: 182)
        }
        return .init(width: 306, height: 198)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recommendedJobsCollectionVC {
            tabBarController?.selectedIndex = 1
            UIView.transition(with: tabBarController!.view!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
   
}



extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
