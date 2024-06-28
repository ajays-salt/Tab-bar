//
//  CompanyDetailScreen.swift
//  olousTabBar
//
//  Created by Salt Technologies on 09/05/24.
//

import UIKit

class CompanyDetailVC: UIViewController {
        
    var company : Company!
    var headerView = UIView()
    let nameLabel = UILabel()
    let companyTypeAndLocation = UILabel()
    
    var categorySection = UIView()
    var aboutButton : UIButton = {
        let button = UIButton()
        button.setTitle("About", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(hex: "#2563EB"), for: .normal)
        return button
    }()
    var jobsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Jobs", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(hex: "#101828"), for: .normal)
        return button
    }()
    var isSelected : String = "About"
    
    let lineView = UIView()
    var leadingConstraint: NSLayoutConstraint!
    var widthConstraint: NSLayoutConstraint!

    
    var aboutView = UIScrollView()
    var jobsCollectionView: UICollectionView!
    
    var jobs: [Job] = []
    var appliedJobs : [String] = []
    var savedJobs2 : [String] = []
    
    var noJobsImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
//        fetchData { result in
//            switch result {
//            case .success(let fetchedJobs):
//                self.jobs = fetchedJobs
//                print("jobs fetched successfully")
////                DispatchQueue.main.async {
////                    self.setupViews()
////                }
//            case .failure(let error):
//                print("Error fetching data: \(error)")
//            }
//        }
        
//        setupViews()
    }
    
    
    private func setupViews() {
        setupHeaderView()
        setupContentInHeaderView()
        
        setupAboutView()
        
        setupDescriptionView()
        
        setupInfoView()
        
        setupSocialMediaView()
        
        setupJobsCollectionView()
    }
    
    func setupHeaderView() {
        headerView.backgroundColor = UIColor(hex: "#F9FAFB")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func setupContentInHeaderView() {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(systemName: "photo.artframe") // Provide your logo image name
//        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(logoImageView)
        
        let baseURLString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/company-pic?logo="
        let companyLogoURLString = baseURLString + (company.logo ?? "")
        if let companyLogoURL = URL(string: companyLogoURLString) {
            URLSession.shared.dataTask(with: companyLogoURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        logoImageView.image = image
                    }
                }
                DispatchQueue.main.async {
                    if logoImageView.image == nil {
                        logoImageView.image = UIImage(systemName: "photo.artframe")
                    }
                }
            }.resume()
        }
        
        
        if let firstCharacter = company.name.first, !firstCharacter.isUppercase {
            nameLabel.text = company.name.prefix(1).uppercased() + company.name.dropFirst()
        } else {
            nameLabel.text = company.name
        }
        nameLabel.font = .boldSystemFont(ofSize: 22)
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(nameLabel)
        
        
        // •
        companyTypeAndLocation.text = "\(company.sector?.joined(separator: ", ") ?? "") | \(company.location ?? "No Location")"
        companyTypeAndLocation.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        companyTypeAndLocation.textColor = UIColor(hex: "#475467")
        companyTypeAndLocation.translatesAutoresizingMaskIntoConstraints = false
        companyTypeAndLocation.numberOfLines = 2
        headerView.addSubview(companyTypeAndLocation)
        
        
        let visitWebsiteButton = UIButton(type: .system)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "shareIcon") // Use your image name here

        let imageOffsetY: CGFloat = -2.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 16, height: 16)

        let imageString = NSAttributedString(attachment: imageAttachment)
        let textString = NSAttributedString(string: " Visit Website", attributes: [
            .font: UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.white
        ])

        let fullString = NSMutableAttributedString()
        fullString.append(imageString)
        fullString.append(textString)

        visitWebsiteButton.setAttributedTitle(fullString, for: .normal)
        
        visitWebsiteButton.setTitleColor(.white, for: .normal)
        visitWebsiteButton.tintColor = .white
        visitWebsiteButton.backgroundColor = UIColor(hex: "#2563EB")
        visitWebsiteButton.layer.cornerRadius = 12
        visitWebsiteButton.addTarget(self, action: #selector(visitWebsite), for: .touchUpInside)
        visitWebsiteButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(visitWebsiteButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            companyTypeAndLocation.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            companyTypeAndLocation.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            companyTypeAndLocation.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
            visitWebsiteButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            visitWebsiteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            visitWebsiteButton.widthAnchor.constraint(equalToConstant: 140),
            visitWebsiteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
    
    @objc func visitWebsite() {
        guard let url = URL(string: company.website ?? "") else {
            print("Invalid URL")
            return
        }
        UIApplication.shared.open(url)
    }
    
    
    private func setupAboutView() {
        aboutView.contentSize = CGSize(width: view.bounds.width, height: 1300)
        aboutView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 500, right: 0)
        aboutView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutView)

        NSLayoutConstraint.activate([
            aboutView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            aboutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    var descView = UIView()
    
    func setupDescriptionView() {
        descView.layer.borderWidth = 1
        descView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        descView.layer.cornerRadius = 8
        
        descView.translatesAutoresizingMaskIntoConstraints = false
        aboutView.addSubview(descView)
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor(hex: "#101828")
        titleLabel.text = "Company Description"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descView.addSubview(titleLabel)

        let contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = UIColor(hex: "#475467")
        contentLabel.numberOfLines = 0
        contentLabel.text = company.description ?? ""
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        descView.addSubview(contentLabel)

        NSLayoutConstraint.activate([
            descView.topAnchor.constraint(equalTo: aboutView.topAnchor, constant: 20),
            descView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: descView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            descView.bottomAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20)
        ])
    }
    
    
    var infoView = UIView()
    
    func setupInfoView() {
        infoView.layer.borderWidth = 1
        infoView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        infoView.layer.cornerRadius = 8
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        aboutView.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: descView.bottomAnchor, constant: 20),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        var lastBottomAnchor = infoView.topAnchor
        let sections: [(String, String)] = [
            ("Website", company.website ?? ""),
            ("Sectors", company.sector?.joined(separator: ",") ?? ""),
            ("Category", company.who ?? ""),
            ("Field", company.field ?? ""),
            ("Company Size", "\(company.size ?? "NA")")
        ]
        
        for section in sections {
            lastBottomAnchor = addSection(title: section.0, content: section.1, toView: infoView, topAnchor: lastBottomAnchor)
        }
        
        // This is critical to make the UIScrollView scrollable
        infoView.bottomAnchor.constraint(equalTo: lastBottomAnchor, constant: 20).isActive = true
        aboutView.bottomAnchor.constraint(equalTo: lastBottomAnchor, constant: 20).isActive = true
    }
    
    private func addSection(title: String, content: String, toView parentView: UIView, topAnchor: NSLayoutYAxisAnchor) -> NSLayoutYAxisAnchor {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor(hex: "#101828")
        titleLabel.text = title
        parentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])

        let contentLabel = UILabel()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        contentLabel.text = content
        contentLabel.textColor = UIColor(hex: "#475467")
        parentView.addSubview(contentLabel)

        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])

        return contentLabel.bottomAnchor
    }
    
    
    var socialMediaView = UIView()
    
    func setupSocialMediaView() {
        socialMediaView.layer.borderWidth = 1
        socialMediaView.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        socialMediaView.layer.cornerRadius = 8
        
        socialMediaView.translatesAutoresizingMaskIntoConstraints = false
        aboutView.addSubview(socialMediaView)
        NSLayoutConstraint.activate([
            socialMediaView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 20),
            socialMediaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            socialMediaView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            socialMediaView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let connectLabel = UILabel()
        connectLabel.font = UIFont.boldSystemFont(ofSize: 16)
        connectLabel.textColor = UIColor(hex: "#101828")
        connectLabel.text = "Connect with \(company.name)"
        
        let linkedinBtn = createButton(image: "Linkedin")
        let fbBtn = createButton(image: "facebook")
        let xBtn = createButton(image: "X")
        
        [connectLabel, linkedinBtn, fbBtn, xBtn].forEach { btn in
            btn.translatesAutoresizingMaskIntoConstraints = false
            socialMediaView.addSubview(btn)
        }
        
        linkedinBtn.addTarget(self, action: #selector(openLinkedin), for: .touchUpInside)
        fbBtn.addTarget(self, action: #selector(openFacebook), for: .touchUpInside)
        xBtn.addTarget(self, action: #selector(openTwitter), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            connectLabel.topAnchor.constraint(equalTo: socialMediaView.topAnchor, constant: 20),
            connectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            connectLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            linkedinBtn.topAnchor.constraint(equalTo: connectLabel.bottomAnchor, constant: 15),
            linkedinBtn.leadingAnchor.constraint(equalTo: connectLabel.leadingAnchor, constant: 3),
            linkedinBtn.heightAnchor.constraint(equalToConstant: 30),
            
            fbBtn.topAnchor.constraint(equalTo: connectLabel.bottomAnchor, constant: 15),
            fbBtn.leadingAnchor.constraint(equalTo: linkedinBtn.trailingAnchor, constant: 20),
            fbBtn.heightAnchor.constraint(equalToConstant: 30),
            
            xBtn.topAnchor.constraint(equalTo: connectLabel.bottomAnchor, constant: 15),
            xBtn.leadingAnchor.constraint(equalTo: fbBtn.trailingAnchor, constant: 20),
            xBtn.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func createButton(image: String) -> UIButton {
        let button = UIButton()
        button.tintColor = UIColor(hex: "#2563EB")
        button.setImage(UIImage(named: image), for: .normal)
        return button
    }
    
    @objc func openLinkedin() {
        if let url = URL(string: "https://www.linkedin.com") {
            UIApplication.shared.open(url)
        }
    }
    @objc func openFacebook() {
        if let url = URL(string: "https://www.facebook.com") {
            UIApplication.shared.open(url)
        }
    }
    @objc func openTwitter() {
        if let url = URL(string: "https://www.twitter.com") {
            UIApplication.shared.open(url)
        }
    }
    
    
    
    

    private func setupJobsCollectionView() {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor(hex: "#101828")
        titleLabel.text = "Job Openings(\(jobs.count))"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: socialMediaView.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        jobsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        jobsCollectionView.register(JobsCell.self, forCellWithReuseIdentifier: "cell")
        
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
        
        jobsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        aboutView.addSubview(jobsCollectionView)
        
        
        noJobsImageView = UIImageView()
        noJobsImageView.image = UIImage(named: "no-jobs")  // Ensure you have this image in your assets
        if jobs.isEmpty {
            jobsCollectionView.isHidden = true
            noJobsImageView.isHidden = false
        }
        else {
            jobsCollectionView.isHidden = false
            noJobsImageView.isHidden = true
        }
        
        noJobsImageView.translatesAutoresizingMaskIntoConstraints = false
        aboutView.addSubview(noJobsImageView)


        NSLayoutConstraint.activate([
            jobsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            jobsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jobsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),  // Adjust based on your content
            jobsCollectionView.heightAnchor.constraint(equalToConstant: 270),
            
            noJobsImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            noJobsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noJobsImageView.widthAnchor.constraint(equalToConstant: 300),
            noJobsImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    

    
    @objc func didTapSaveJob(_ sender : UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        guard let cell = jobsCollectionView.cellForItem(at: indexPath) as? JobsCell else {
            return
        }
        
        let job = jobs[indexPath.row]
        
        if savedJobs2.contains(job.id) {  // Already saved, remove it from saved jobs
            let index = savedJobs2.firstIndex(of: job.id)
            savedJobs2.remove(at: index!)
            
            saveOrUnsaveJob(id: job.id)
            
            let attributedString = getAttributedString(image: "bookmark", tintColor: UIColor(hex: "#475467"), title: "Save")
            cell.saveButton.tintColor = UIColor(hex: "#475467")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        
        else {  // Not saved, save this job
            savedJobs2.append(job.id)
            
            saveOrUnsaveJob(id: job.id)
            
            let attributedString = getAttributedString(image: "bookmark.fill", tintColor: UIColor(hex: "#667085"), title: "Saved")
            cell.saveButton.tintColor = UIColor(hex: "#667085")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    func saveOrUnsaveJob(id: String) {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/save-job/save") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("Access Token not found")
            return
        }

        let body: [String: Any] = ["jobId": id]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            print("Failed to encode jobId: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network request failed: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
        }.resume()
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
        
        fetchData { result in
            switch result {
            case .success(let fetchedJobs):
                self.jobs = fetchedJobs
                print("jobs fetched successfully, \(self.jobs.count)")
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
            DispatchQueue.main.async {
                self.setupViews()
            }
        }
        
        fetchTotalAppliedJobs()
        fetchSavedJobIDs()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
}

extension CompanyDetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! JobsCell
        let job = jobs[indexPath.row]
        
        if appliedJobs.contains(job.id) {
            cell.appliedLabel.isHidden = false
        }
        else {
            cell.appliedLabel.isHidden = true
        }
        
        if savedJobs2.contains(job.id) {
            let attributedString = getAttributedString(image: "bookmark.fill", tintColor: UIColor(hex: "#2563EB"), title: "Saved")
            cell.saveButton.tintColor = UIColor(hex: "#2563EB")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        else {
            let attributedString = getAttributedString(image: "bookmark",tintColor: UIColor(hex: "#2563EB"), title: "Save")
            cell.saveButton.tintColor = UIColor(hex: "#475467")
            cell.saveButton.setAttributedTitle(attributedString, for: .normal)
        }
        
        cell.saveButton.addTarget(self, action: #selector(didTapSaveJob(_:)), for: .touchUpInside)
        cell.saveButton.tag = indexPath.row
        
        cell.jobTitle.text = job.title
        cell.companyName.text = job.companyName ?? job.companyName
        
        if job.workPlace == "office based" {
            cell.workPlaceLabel.text = "Office Based"
            cell.workPlaceView.backgroundColor = UIColor(hex: "#FEF3F2")
            cell.workPlaceLabel.textColor = UIColor(hex: "#D92D20")
            
            if let widthConstraint = cell.workPlaceView.constraints.first(where: { $0.firstAttribute == .width }) {
                cell.workPlaceView.removeConstraint(widthConstraint)
            }
            let widthConstraint = cell.workPlaceView.widthAnchor.constraint(equalToConstant: 100)
            widthConstraint.isActive = true
        }
        else {
            cell.workPlaceLabel.text = "Hybrid(Office + Site)"
            cell.workPlaceView.backgroundColor = UIColor(hex: "#ECFDF3")
            cell.workPlaceLabel.textColor = UIColor(hex: "#067647")
            
            if let widthConstraint = cell.workPlaceView.constraints.first(where: { $0.firstAttribute == .width }) {
                cell.workPlaceView.removeConstraint(widthConstraint)
            }
            let widthConstraint = cell.workPlaceView.widthAnchor.constraint(equalToConstant: 160)
            widthConstraint.isActive = true
        }
        
        cell.jobLocationLabel.text = "\(job.location?.city ?? ""), \(job.location?.state ?? "")"
        
        var text = "\(job.salaryRangeFrom ?? "NA") - \(job.salaryRangeTo ?? "NA")"
        if text.hasSuffix("LPA") {
            cell.salaryLabel.text = text
        }
        else {
            cell.salaryLabel.text = "\(text) LPA"
        }
        
        cell.jobTypeLabel.text = job.jobType
        
        let s = getTimeAgoString(from: job.createdAt ?? "")
        cell.jobPostedTime.text = s
        
        let expText = attributedStringForExperience("\(job.minExperience ?? "")-\(job.maxExperience ?? "")")
        cell.jobExperienceLabel.attributedText = expText
        
        // Fetch company logo asynchronously
        let baseURLString = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/company-pic?logo="
        let companyLogoURLString = baseURLString + (company.logo ?? "")
        if let companyLogoURL = URL(string: companyLogoURLString) {
            URLSession.shared.dataTask(with: companyLogoURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.companyLogo.image = image
                    }
                }
            }.resume()
        }
        
        cell.layer.borderColor = UIColor(hex: "#EAECF0").cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 52, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedJob = jobs[indexPath.row]
        let jobDetailVC = JobDetailScreen()
        jobDetailVC.selectedJob = selectedJob
        navigationController?.pushViewController(jobDetailVC, animated: true)
    }
    
    
    func getAttributedString(image: String, tintColor: UIColor, title : String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        
        let symbolAttachment = NSTextAttachment()
        symbolAttachment.image = UIImage(systemName: image)?.withTintColor(tintColor)
        
        let symbolString = NSAttributedString(attachment: symbolAttachment)
        attributedString.append(symbolString)
        
//        attributedString.append(NSAttributedString(string: " "))
//        
//        let textString = NSAttributedString(string: title)
//        attributedString.append(textString)
        
        return attributedString
    }
    
    func getTimeAgoString(from createdAt: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = dateFormatter.date(from: createdAt) else {
            return "Invalid date"
        }
        
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: now)
        
        if let year = components.year, year > 0 {
            return "\(year) year\(year == 1 ? "" : "s") ago"
        } else if let month = components.month, month > 0 {
            return "\(month) month\(month == 1 ? "" : "s") ago"
        } else if let day = components.day, day > 0 {
            return "\(day) day\(day == 1 ? "" : "s") ago"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour) hour\(hour == 1 ? "" : "s") ago"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute) minute\(minute == 1 ? "" : "s") ago"
        } else {
            return "Just now"
        }
    }
    
    func attributedStringForExperience(_ experience: String) -> NSAttributedString {
        // Create a mutable attributed string
        let attributedString = NSMutableAttributedString()
        
//        attributedString.append(NSAttributedString(string: "|"))
//        attributedString.append(NSAttributedString(string: "  "))
        
        let symbolAttachment = NSTextAttachment()
        symbolAttachment.image = UIImage(systemName: "briefcase")?.withTintColor(UIColor(hex: "#667085"))
        
        let symbolString = NSAttributedString(attachment: symbolAttachment)
//        attributedString.append(symbolString)
        
//        attributedString.append(NSAttributedString(string: "      "))
        attributedString.append(NSAttributedString(string: experience))
        if !experience.hasSuffix("years") {
            attributedString.append(NSAttributedString(string: " years"))
        }
        
//        let textString = NSAttributedString(string: "1-5 years")
//        attributedString.append(textString)

        return attributedString
    }
}

extension CompanyDetailVC {
    
    func fetchData(completion: @escaping (Result<[Job], Error>) -> Void) {
        
        let urlStr = "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/company/jobs/\(company.id)"
        print("Company ID ",company.id)
        
        guard let url = URL(string: urlStr) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown Error", code: 0, userInfo: nil)))
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw response data: \(responseString)")
            }
            
            do {
                   if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                       print(jsonObject)
                   } else {
                       print("Data is not a valid JSON object")
                   }
               } catch {
                   print("Failed to convert data to JSON:", error)
               }
            
            do {
                let jobResponse = try JSONDecoder().decode(CompanyJobResponse.self, from: data)
                completion(.success(jobResponse.jobs))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchTotalAppliedJobs() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/job/appliedJobs") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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
            
            // Print the raw response data as a string
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Raw response data: \(responseString)")
//            }

            do {
                // Decode the JSON response as a dictionary with jobIds array
                let responseDict = try JSONDecoder().decode([String: [String]].self, from: data)
                
                if let jobIds = responseDict["jobIds"] {
//                    print("Job IDs: \(jobIds)")
                    
                    // Process the job IDs as needed
                    DispatchQueue.main.async {
                        self.appliedJobs = jobIds
                        if self.jobsCollectionView != nil {
                            self.jobsCollectionView.reloadData()
                        }
                    }
                } else {
                    print("Failed to find job IDs in the response")
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        task.resume()
    }
    
    func fetchSavedJobIDs() {
        guard let url = URL(string: "https://king-prawn-app-kjp7q.ondigitalocean.app/api/v1/save-job/get-saved-jobs") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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
            
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Raw response data: \(responseString)")
//            }
            
            do {
                let response = try JSONDecoder().decode(SavedJobsResponse.self, from: data)
                let jobIDs = response.savedJobs.savedJobs
                
                DispatchQueue.main.async {
                    self.savedJobs2 = jobIDs
//                    print("saved Job IDs " , self.savedJobs2)
                }
                
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        task.resume()
    }
}
