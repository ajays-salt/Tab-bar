//
//  TabBarViewController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create view controllers for each tab
        let homeController = HomeController()
        let homeNavigationController = UINavigationController(rootViewController: homeController)
        homeController.view.backgroundColor = .systemBackground
        homeController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let myJobsController = MyJobsController()
        let myJobsNavigationController = UINavigationController(rootViewController: myJobsController)
        myJobsController.tabBarItem = UITabBarItem(title: "My Jobs", image: UIImage(systemName: "briefcase.fill"), tag: 1)
        
        let companyController = CompanyController()
        let companyNavigationController = UINavigationController(rootViewController: companyController)
        companyController.tabBarItem = UITabBarItem(title: "Companies", image: UIImage(named: "appartment"), tag: 2)
        
        let profileController = ProfileController()
        let profileNavigationController = UINavigationController(rootViewController: profileController)
        profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 3)
        
        // Set view controllers for the tab bar controller
        self.viewControllers = [homeNavigationController, myJobsNavigationController, companyNavigationController, profileNavigationController]
        
          
        tabBar.frame = CGRect(x: tabBar.frame.origin.x,
                              y: tabBar.frame.origin.y - 20, // Adjusting the y-coordinate by -1
                              width: tabBar.frame.size.width,
                              height: tabBar.frame.size.height)
        tabBar.backgroundColor = UIColor(hex: "#F7F8F9")
        
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.layer.shadowColor = UIColor.clear.cgColor // Ensure no shadow is applied
    }
    
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!) // Fix here
    }
}
