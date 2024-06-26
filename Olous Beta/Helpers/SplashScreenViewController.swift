//
//  LaunchVideoViewController.swift
//  olousTabBar
//
//  Created by Salt Technologies on 31/05/24.
//

import UIKit

class SplashScreenViewController: UIViewController {
    var completion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the launch screen storyboard
        let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil)
        if let launchScreenVC = launchScreen.instantiateInitialViewController() {
            addChild(launchScreenVC)
            launchScreenVC.view.frame = self.view.frame
            self.view.addSubview(launchScreenVC.view)
            launchScreenVC.didMove(toParent: self)
        }
        
        // Perform transition after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Adjust the delay as needed
            self.completion?()
        }
    }
}


