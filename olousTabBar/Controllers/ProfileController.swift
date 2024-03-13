//
//  ProfileController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class ProfileController: UIViewController {
    
    let barsButton : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(hex: "#344054")
        imageView.image = UIImage(systemName: "line.3.horizontal")
        return imageView
    }()
    let scrollView = UIScrollView()
    
    let profileCircle = UIView()
    let profileCircleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#0079C4")
        label.font = .boldSystemFont(ofSize: 48)
        return label
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        setupBarsButton()
        setupScrollView()
        setupProfileCircleView()
        setupUserNameLabel()
        setupUserJobTitleLabel()
        setupLocationLabel()
        setupOtherUI()
    }
    
    func setupBarsButton() {
        barsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(barsButton)
        
        NSLayoutConstraint.activate([
            barsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            barsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            barsButton.widthAnchor.constraint(equalToConstant: 35),
            barsButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupScrollView() {
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: barsButton.bottomAnchor),
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

    func setupProfileCircleView() {
        profileCircle.backgroundColor = UIColor(hex: "#D7F0FF")
        profileCircle.layer.cornerRadius = 60
        
        profileCircle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(profileCircle)
        NSLayoutConstraint.activate([
            profileCircle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            profileCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.width / 2 ) - 60),
            profileCircle.widthAnchor.constraint(equalToConstant: 120),
            profileCircle.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        // Calculate initials
        let arr = userNameLabel.text!.components(separatedBy: " ")
        let initials = "\(arr[0].first ?? "A")\(arr[1].first ?? "B")".uppercased()
        
        
        profileCircleLabel.text = initials
        
        profileCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileCircle.addSubview(profileCircleLabel)
        NSLayoutConstraint.activate([
            profileCircleLabel.centerXAnchor.constraint(equalTo: profileCircle.centerXAnchor),
            profileCircleLabel.centerYAnchor.constraint(equalTo: profileCircle.centerYAnchor)
        ])
    }
    
    func setupUserNameLabel() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            userNameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: profileCircle.bottomAnchor, constant: 12),
            userNameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupUserJobTitleLabel() {
        jobTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(jobTitleLabel)
        
        NSLayoutConstraint.activate([
            jobTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            jobTitleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 12)
        ])
    }
    
    func setupLocationLabel() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            locationLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 6)
        ])
    }
    
    func setupOtherUI() {
        let preferenceLabel : UILabel = {
            let label = UILabel()
            label.text = "Your carrer preferences"
            label.textColor = UIColor(hex: "#101828")
            label.font = .boldSystemFont(ofSize: 18)
            return label
        }()
        preferenceLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(preferenceLabel)
        
        NSLayoutConstraint.activate([
            preferenceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            preferenceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
}
