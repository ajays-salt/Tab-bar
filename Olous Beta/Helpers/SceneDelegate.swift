//
//  SceneDelegate.swift
//  olousTabBar
//
//  Created by Salt Technologies on 01/03/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        // Create the SplashScreenViewController
        let splashScreenViewController = SplashScreenViewController()
        
        // Set the completion handler to transition after the delay
        splashScreenViewController.completion = {
            self.setRootViewController(window: window)
        }
        
        // Set SplashScreenViewController as the root view controller
        window.rootViewController = splashScreenViewController
        window.makeKeyAndVisible()
    }
    
    
    private func setRootViewController(window: UIWindow) {
        
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            // Access token is present, check if the user has completed onboarding
            
            checkUserOnboardingStatus(accessToken: accessToken) { hasCompletedOnboarding in
                DispatchQueue.main.async {
                    if hasCompletedOnboarding {
                        // User has completed onboarding, navigate to the home screen
                        let viewController = ViewController()
                        viewController.modalPresentationStyle = .overFullScreen
                        window.rootViewController = viewController
                        self.checkForUpdate()
                        
//                        let vc = ProjectsVC()
//                        let navVC = UINavigationController(rootViewController: vc)
//                        navVC.modalPresentationStyle = .overFullScreen
//                        navVC.navigationBar.isHidden = true
//                        window.rootViewController = navVC
                    } else {
                        // User has not completed onboarding, navigate to the onboarding screen
                        let vc = BasicDetails1()
                        let navVC = UINavigationController(rootViewController: vc)
                        navVC.modalPresentationStyle = .overFullScreen
                        navVC.navigationBar.isHidden = true
                        window.rootViewController = navVC
                    }
                    window.makeKeyAndVisible()
                }
            }
        } else {
            // No access token, navigate to the registration screen
            let registrationVC = RegistrationVC()
            let navVC = UINavigationController(rootViewController: registrationVC)
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.isHidden = true
            
            window.rootViewController = navVC
            window.makeKeyAndVisible()
        }
        
    }
    
    
    private func checkForUpdate() {
        guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return }
        let appID = "6504863474"
        let urlString = "https://itunes.apple.com/lookup?id=\(appID)"
        
        guard let url = URL(string: urlString) else { return }
        
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = json["results"] as? [[String: Any]],
                   let appStoreVersion = results.first?["version"] as? String {
                    if currentVersion.compare(appStoreVersion, options: .numeric) == .orderedAscending {
                        DispatchQueue.main.async {
                            self.showUpdateAlert()
                        }
                    }
                }
            } catch {
                print("Error fetching App Store version: \(error)")
            }
        }
        
        task.resume()
    }

    private func showUpdateAlert() {
        let alert = UIAlertController(title: "Update Available", message: "A new version of the app is available. Please update to the latest version.", preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id6504863474"),
               UIApplication.shared.canOpenURL(url) {
                print("Update Url inside alert ", url)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let laterAction = UIAlertAction(title: "Later", style: .cancel, handler: nil)
        
        alert.addAction(updateAction)
        alert.addAction(laterAction)
        
        // Assuming the rootViewController is set and visible
        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        
//        let window = UIWindow(windowScene: windowScene)
//        self.window = window
//        window.overrideUserInterfaceStyle = .light
//
//        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
//            // Access token is present, check if the user has completed onboarding
//            checkUserOnboardingStatus(accessToken: accessToken) { hasCompletedOnboarding in
//                DispatchQueue.main.async {
//                    if hasCompletedOnboarding {
//                        // User has completed onboarding, navigate to the home screen
//                        let viewController = ViewController()
//                        viewController.modalPresentationStyle = .overFullScreen
//                        window.rootViewController = viewController
//                    } else {
//                        // User has not completed onboarding, navigate to the onboarding screen
//                        let vc = BasicDetails1()
//                        let navVC = UINavigationController(rootViewController: vc)
//                        navVC.modalPresentationStyle = .overFullScreen
//                        navVC.navigationBar.isHidden = true
//                        window.rootViewController = navVC
//                    }
//                    window.makeKeyAndVisible()
//                }
//            }
//        } else {
//            // No access token, navigate to the registration screen
//            let registrationVC = RegistrationVC()
//            let navVC = UINavigationController(rootViewController: registrationVC)
//            navVC.modalPresentationStyle = .fullScreen
//            navVC.navigationBar.isHidden = true
//            
//            window.rootViewController = navVC
//            window.makeKeyAndVisible()
//        }
//    }

    func checkUserOnboardingStatus(accessToken: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(Config.serverURL)/api/v1/user/profile") else {
            print("Invalid URL")
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching user profile: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(false)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let hasCompletedOnboarding = json["hasCompletedOnboarding"] as? Bool {
                    completion(hasCompletedOnboarding)
                } else {
                    completion(false)
                }
            } catch {
                print("Failed to parse JSON: \(error)")
                completion(false)
            }
        }.resume()
    }

    
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

