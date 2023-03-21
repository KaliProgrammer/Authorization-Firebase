//
//  SceneDelegate.swift
//  UserLoginTutorial
//
//  Created by MacBook Air on 18.03.2023.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        self.setupWindow(with: scene)
        self.checkAuthentication()
        
        
        
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            //Go to sign in screen
          
            self.goToController(with: LoginViewController())
        } else {
            
            //else go to home screen
            self.goToController(with: HomeViewController())
        }
    }
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
            } completion: { [weak self] _ in
                
                
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1

                }
            }

        }
    }
}
