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
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Set up window and root view controller
        let window = UIWindow(windowScene: windowScene)
        
        
//
        if let _ = UserDefaults.standard.string(forKey: "accessToken") {
            // Access token is present, navigate to the home screen
            
//            let viewController = ViewController()
//            viewController.modalPresentationStyle = .overFullScreen
//            
//            window.rootViewController = viewController
//            window.rootViewController?.modalPresentationStyle = .overFullScreen

            let vc = PersonalInfoVC()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            navVC.navigationBar.isHidden = true
            window.rootViewController = navVC
            window.rootViewController?.modalPresentationStyle = .overFullScreen
            
            self.window = window
            window.makeKeyAndVisible()
        }
        else {
            let registrationVC = RegistrationVC()
            let navVC = UINavigationController(rootViewController: registrationVC)
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.isHidden = true
            
            window.rootViewController = navVC
            window.overrideUserInterfaceStyle = .light
            self.window = window
            window.makeKeyAndVisible()
        }
        
        
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

